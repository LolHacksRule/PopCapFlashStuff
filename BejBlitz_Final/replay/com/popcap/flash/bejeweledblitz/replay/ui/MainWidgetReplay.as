package com.popcap.flash.bejeweledblitz.replay.ui
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.game.GameFrame;
   import com.popcap.flash.bejeweledblitz.replay.ui.game.MuteWidget;
   import com.popcap.flash.bejeweledblitz.replay.ui.game.ReplayControlWidget;
   import com.popcap.flash.bejeweledblitz.replay.ui.game.ReplayErrorWidget;
   import com.popcap.flash.bejeweledblitz.replay.ui.game.ReplayOverWidget;
   import flash.geom.Rectangle;
   
   public class MainWidgetReplay extends MainWidget
   {
       
      
      public var replayControl:ReplayControlWidget;
      
      public var mute:MuteWidget;
      
      public var gameOver:ReplayOverWidget;
      
      public var gameError:ReplayErrorWidget;
      
      public var frame:GameFrame;
      
      public function MainWidgetReplay(app:Blitz3App)
      {
         super(app);
         this.replayControl = app.uiFactory.GetReplayControlWidget();
         this.mute = new MuteWidget(app);
         this.gameOver = new ReplayOverWidget(app);
         this.gameError = new ReplayErrorWidget(app);
         this.frame = new GameFrame(app);
         scrollRect = new Rectangle(0,0,Dimensions.REPLAYER_WIDTH,Dimensions.REPLAYER_HEIGHT);
      }
      
      override protected function AddChildren() : void
      {
         super.AddChildren();
         addChild(this.replayControl);
         addChild(this.mute);
         addChild(this.gameOver);
         addChild(this.gameError);
         addChild(this.frame);
      }
      
      override protected function InitChildren() : void
      {
         game.board.x = 25;
         game.board.y = 69;
         super.InitChildren();
         this.replayControl.Init();
         this.mute.Init();
         this.gameOver.Init();
         this.gameError.Init();
         this.frame.Init(Dimensions.REPLAYER_WIDTH,Dimensions.REPLAYER_HEIGHT);
         game.laserCat.x = 60;
         game.phoenixPrism.x = game.board.x;
         game.phoenixPrism.y = game.board.y;
         this.replayControl.x = 83;
         this.replayControl.y = 410;
         this.mute.x = 310;
         this.mute.y = 420;
      }
   }
}
