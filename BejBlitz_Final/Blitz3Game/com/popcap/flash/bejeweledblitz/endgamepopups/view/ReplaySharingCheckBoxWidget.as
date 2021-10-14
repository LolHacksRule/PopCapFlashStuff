package com.popcap.flash.bejeweledblitz.endgamepopups.view
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.CheckBox;
   import com.popcap.flash.framework.anim.LinearTranslateAnim;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class ReplaySharingCheckBoxWidget extends Sprite
   {
       
      
      private var m_App:Blitz3App;
      
      private var m_OneClickShareCB:CheckBox;
      
      private var m_Anim:LinearTranslateAnim;
      
      private var m_ViewingBounds:Rectangle;
      
      public function ReplaySharingCheckBoxWidget(param1:Blitz3App)
      {
         super();
         this.m_App = param1;
         this.m_Anim = new LinearTranslateAnim();
         addChild(new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LARGE_DIALOG_POPUP)));
      }
      
      public function get replay() : Boolean
      {
         return false;
      }
      
      public function get autoPublish() : Boolean
      {
         if(!this.m_OneClickShareCB)
         {
            return false;
         }
         return this.m_OneClickShareCB.IsChecked();
      }
      
      public function setViewingBounds(param1:Rectangle) : void
      {
         this.m_ViewingBounds = param1;
      }
      
      public function Show(param1:Boolean) : void
      {
         if(param1)
         {
            this.m_Anim.Init(this,this.m_ViewingBounds.x,this.y,this.m_ViewingBounds.x,this.m_ViewingBounds.height,10);
         }
         else
         {
            this.m_Anim.Init(this,this.m_ViewingBounds.x,this.y,this.m_ViewingBounds.x,this.m_ViewingBounds.y,10);
         }
      }
      
      public function Reset(param1:Boolean) : void
      {
         if(this.m_OneClickShareCB)
         {
            removeChild(this.m_OneClickShareCB);
         }
         this.m_OneClickShareCB = null;
         if(param1)
         {
            this.m_OneClickShareCB = new CheckBox(this.m_App);
            this.m_OneClickShareCB.x = (width - this.m_OneClickShareCB.width) * 0.5;
            this.m_OneClickShareCB.addLabel("<font size=\'13\'>Enable 1-click sharing?</font>");
            this.m_OneClickShareCB.y = 22;
            this.m_OneClickShareCB.SetChecked(true);
            addChild(this.m_OneClickShareCB);
         }
      }
   }
}
