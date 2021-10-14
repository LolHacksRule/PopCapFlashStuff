package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import com.popcap.flash.games.bej3.boosts.IBoost;
   import com.popcap.flash.games.bej3.raregems.IRareGem;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class StatsBoostIconBar extends Sprite
   {
      
      protected static var BUFFER:Number = 2;
       
      
      protected var m_App:Blitz3App;
      
      protected var m_Icons:Vector.<Bitmap>;
      
      protected var m_RareGems:Vector.<Bitmap>;
      
      public function StatsBoostIconBar(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_Icons = new Vector.<Bitmap>(5);
         this.m_RareGems = new Vector.<Bitmap>(1);
      }
      
      public function Init() : void
      {
      }
      
      public function Clear() : void
      {
         while(numChildren > 0)
         {
            removeChildAt(0);
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
         var activeBoosts:Vector.<Boolean> = new Vector.<Boolean>(numIcons);
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
                  addChild(icon);
                  if(!prevIcon)
                  {
                     icon.x = 0;
                     icon.y = 0;
                     prevIcon = icon;
                  }
                  else
                  {
                     icon.x = prevIcon.x + prevIcon.width * 0.5 - icon.width * 0.5;
                     icon.y = prevIcon.y + prevIcon.height + BUFFER;
                     prevIcon = icon;
                  }
               }
            }
         }
         var rareGem:IRareGem = this.m_App.logic.rareGemLogic.currentRareGem;
         if(rareGem != null)
         {
            id = rareGem.GetOrderingID();
            icon = this.m_RareGems[id];
            if(icon)
            {
               addChild(icon);
               if(!prevIcon)
               {
                  icon.x = 0;
                  icon.y = 0;
                  prevIcon = icon;
               }
               icon.x = prevIcon.x + prevIcon.width * 0.5 - icon.width * 0.5 - 1;
               icon.y = prevIcon.y + prevIcon.height + BUFFER;
               prevIcon = icon;
            }
         }
      }
   }
}
