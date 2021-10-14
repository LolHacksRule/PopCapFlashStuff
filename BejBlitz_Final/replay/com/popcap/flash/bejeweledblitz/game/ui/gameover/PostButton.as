package com.popcap.flash.bejeweledblitz.game.ui.gameover
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.SkinButton;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   
   public class PostButton extends Sprite
   {
       
      
      private var m_App:Blitz3App;
      
      private var m_Button:SkinButton;
      
      private var m_Medal:Bitmap;
      
      public function PostButton(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_Button = new SkinButton(this.m_App);
         this.m_Button.addEventListener(MouseEvent.CLICK,this.HandleClick);
         this.m_Button.up.addChild(new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_POST_BUTTON_UP)));
         this.m_Button.over.addChild(new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_POST_BUTTON_OVER)));
         this.m_Button.x = 42;
         this.m_Button.y = 16;
         addChild(this.m_Button);
         this.m_Medal = new Bitmap(this.m_App.starMedalTable.GetStampedMedal(25000));
         this.m_Medal.smoothing = true;
         this.m_Medal.width = 60;
         this.m_Medal.height = 60;
         addChild(this.m_Medal);
         this.m_Medal.filters = [new GlowFilter(0,1,4,4,2)];
      }
      
      public function SetScore(score:int) : void
      {
         var bd:BitmapData = null;
         bd = this.m_App.starMedalTable.GetStampedMedal(score);
         if(bd == null)
         {
            visible = false;
            return;
         }
         visible = true;
         this.m_Medal.bitmapData = bd;
      }
      
      private function HandleClick(e:MouseEvent) : void
      {
         this.m_App.network.PostMedal();
      }
   }
}
