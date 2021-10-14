package com.popcap.flash.bejeweledblitz.game.ui.game.sidebar
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class ButtonPanelWidget extends Sprite
   {
       
      
      public var hintButton:HintButtonWidget;
      
      public var menuButton:MenuButtonWidget;
      
      private var mBackdrop:Bitmap;
      
      private var m_App:Blitz3App;
      
      public function ButtonPanelWidget(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.hintButton = new HintButtonWidget(app);
         this.menuButton = new MenuButtonWidget(app);
      }
      
      public function Init() : void
      {
         this.mBackdrop = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_UI_BOTTOM));
         addChild(this.mBackdrop);
         addChild(this.hintButton);
         addChild(this.menuButton);
         this.hintButton.Init();
         this.menuButton.Init();
         this.hintButton.x = 41.5;
         this.hintButton.y = 41;
         this.menuButton.x = 41;
         this.menuButton.y = 88;
      }
   }
}
