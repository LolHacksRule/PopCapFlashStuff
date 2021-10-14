package com.popcap.flash.games.blitz3.ui.widgets.game.sidebar
{
   import com.popcap.flash.games.bej3.boosts.IBoost;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class BoostIconBarWidget extends Sprite
   {
      
      private static const BUFFER:Number = 2;
       
      
      private var m_App:Blitz3App;
      
      private var m_Icons:Vector.<Bitmap>;
      
      private var m_Container:Sprite;
      
      public function BoostIconBarWidget(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_Container = new Sprite();
         addChild(this.m_Container);
         this.m_Icons = new Vector.<Bitmap>(5);
      }
      
      public function Init() : void
      {
      }
      
      public function Clear() : void
      {
         while(this.m_Container.numChildren > 0)
         {
            this.m_Container.removeChildAt(0);
         }
      }
      
      public function Reset() : void
      {
         var i:int = 0;
         var boost:IBoost = null;
         var id:int = 0;
         var icon:Bitmap = null;
         this.Clear();
         var boosts:Vector.<IBoost> = this.m_App.logic.boostLogic.currentBoosts;
         var numBoosts:int = boosts.length;
         var numIcons:int = this.m_Icons.length;
         var activeBoosts:Vector.<Boolean> = new Vector.<Boolean>(numBoosts);
         for(i = 0; i < numIcons; i++)
         {
            activeBoosts[i] = false;
         }
         var prevIcon:Bitmap = null;
         for(i = 0; i < numBoosts; i++)
         {
            boost = boosts[i];
            id = boost.GetOrderingID();
            activeBoosts[id] = true;
         }
         for(i = 0; i < numIcons; i++)
         {
            if(activeBoosts[i])
            {
               icon = this.m_Icons[i];
               if(icon != null)
               {
                  this.m_Container.addChild(icon);
                  if(!prevIcon)
                  {
                     icon.x = 0;
                     prevIcon = icon;
                  }
                  else
                  {
                     icon.x = prevIcon.x + prevIcon.width + BUFFER;
                     prevIcon = icon;
                  }
               }
            }
         }
         this.m_Container.x = -(this.m_Container.width / 2);
      }
   }
}
