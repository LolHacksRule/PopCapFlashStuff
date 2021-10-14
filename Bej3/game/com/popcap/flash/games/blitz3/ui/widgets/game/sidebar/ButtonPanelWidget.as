package com.popcap.flash.games.blitz3.ui.widgets.game.sidebar
{
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class ButtonPanelWidget extends Sprite
   {
       
      
      public var hintButton:HintButtonWidget;
      
      public var menuButton:MenuButtonWidget;
      
      private var mBackdrop:Bitmap;
      
      private var mApp:Blitz3App;
      
      private var mIsInited:Boolean = false;
      
      public function ButtonPanelWidget(app:Blitz3App)
      {
         super();
         this.mApp = app;
         this.hintButton = new HintButtonWidget(app);
         this.menuButton = new MenuButtonWidget(app);
      }
      
      public function Init() : void
      {
         this.mBackdrop = new Bitmap(this.mApp.imageManager.getBitmapData(Blitz3Images.IMAGE_UI_BOTTOM));
         this.mBackdrop.smoothing = true;
         addChild(this.mBackdrop);
         addChild(this.hintButton);
         addChild(this.menuButton);
         this.hintButton.Init();
         this.menuButton.Init();
         this.hintButton.x = 48;
         this.hintButton.y = 51;
         this.menuButton.x = 48;
         this.menuButton.y = 99;
         this.mIsInited = true;
      }
      
      public function Reset() : void
      {
         this.hintButton.Reset();
         this.menuButton.Reset();
      }
      
      public function Update() : void
      {
      }
      
      public function Draw() : void
      {
      }
   }
}
