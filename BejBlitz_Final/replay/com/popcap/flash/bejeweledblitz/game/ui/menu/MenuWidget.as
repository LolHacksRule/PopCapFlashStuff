package com.popcap.flash.bejeweledblitz.game.ui.menu
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class MenuWidget extends Sprite
   {
       
      
      private var m_App:Blitz3App;
      
      private var m_Background:Bitmap;
      
      private var m_Tips:TipsWidget;
      
      public var playButton:PlayButtonWidget;
      
      public function MenuWidget(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_Background = new Bitmap();
         this.m_Tips = new TipsWidget(app);
         this.playButton = new PlayButtonWidget(app);
      }
      
      public function Init() : void
      {
         this.m_Background.bitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_MENU_BACKGROUND);
         addChild(this.m_Background);
         addChild(this.m_Tips);
         addChild(this.playButton);
         this.m_Tips.Init();
         this.playButton.Init();
         this.m_Tips.x = this.m_Background.width * 0.5 - this.m_Tips.width * 0.5;
         this.m_Tips.y = this.m_Background.height * 0.87 - this.m_Tips.height * 0.5;
         this.playButton.x = this.m_Background.width * 0.5;
         this.playButton.y = this.m_Background.height * 0.55;
      }
      
      public function Update() : void
      {
         this.playButton.Update();
         this.m_Tips.Update();
      }
   }
}
