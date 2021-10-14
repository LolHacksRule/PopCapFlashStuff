package com.popcap.flash.games.blitz3.ui.widgets
{
   import caurina.transitions.Tweener;
   import com.popcap.flash.games.blitz3.ui.widgets.game.BackgroundWidget;
   import com.popcap.flash.games.blitz3.ui.widgets.game.BoardWidget;
   import com.popcap.flash.games.blitz3.ui.widgets.game.SidebarWidget;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class GameWidget extends Sprite
   {
       
      
      public var background:BackgroundWidget;
      
      public var sidebar:SidebarWidget;
      
      public var board:BoardWidget;
      
      private var mApp:Blitz3Game;
      
      private var mIsInited:Boolean = false;
      
      private var mCrystal:Sprite;
      
      private var mCrystalDone:Boolean;
      
      public function GameWidget(app:Blitz3Game)
      {
         super();
         this.mApp = app;
         this.background = new BackgroundWidget(app);
         this.sidebar = new SidebarWidget(app);
         this.board = new BoardWidget(app);
      }
      
      public function Init() : void
      {
         this.board.x = 510 - 32 - 8 * 40 + 10;
         this.board.y = 49;
         addChild(this.background);
         addChild(this.board);
         addChild(this.sidebar);
         this.background.Init();
         this.sidebar.Init();
         this.board.Init();
         this.mCrystal = new Sprite();
         this.mCrystal = new Sprite();
         this.mCrystal.x = 270;
         this.mCrystal.y = 202.5;
         this.mCrystal.alpha = 0;
         var bitmap:Bitmap = new Bitmap(this.mApp.imageManager.getBitmapData(Blitz3Images.IMAGE_MENU_GEM));
         bitmap.smoothing = true;
         bitmap.x = -bitmap.width / 2;
         bitmap.y = -bitmap.height / 2;
         this.mCrystal.addChild(bitmap);
         this.mIsInited = true;
      }
      
      public function SetOffCrystal() : void
      {
         addChild(this.mCrystal);
         Tweener.addTween(this.mCrystal,{
            "scaleX":6,
            "scaleY":6,
            "alpha":0.5,
            "time":1,
            "transition":"easeOutQuad",
            "onComplete":this.CrystalComplete
         });
      }
      
      public function IsCrystalDone() : Boolean
      {
         return this.mCrystalDone;
      }
      
      public function ResetCrystal() : void
      {
         this.mCrystalDone = false;
         this.mCrystal.scaleX = 1;
         this.mCrystal.scaleY = 1;
         this.mCrystal.alpha = 0;
      }
      
      public function Reset() : void
      {
         this.background.Reset();
         this.sidebar.Reset();
         this.board.Reset();
      }
      
      public function Update() : void
      {
         this.sidebar.Update();
      }
      
      public function Draw() : void
      {
      }
      
      private function CrystalComplete() : void
      {
         this.mCrystalDone = true;
         this.mCrystal.alpha = 0;
         removeChild(this.mCrystal);
      }
   }
}
