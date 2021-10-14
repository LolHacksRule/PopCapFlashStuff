package com.popcap.flash.games.blitz3.game.states
{
   import com.popcap.flash.framework.IAppState;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class GamePlayStartState extends Sprite implements IAppState
   {
      
      public static const START_TIME:int = 250;
       
      
      private var mApp:Blitz3Game;
      
      private var mTimer:int = 0;
      
      private var mInitPos:Point;
      
      private var mFinalPos:Point;
      
      public function GamePlayStartState(app:Blitz3Game)
      {
         this.mInitPos = new Point();
         this.mFinalPos = new Point();
         super();
         this.mApp = app;
      }
      
      public function Reset() : void
      {
         this.mApp.ui.game.Reset();
         this.mApp.ui.game.board.clock.alpha = 0;
         this.mTimer = START_TIME;
         this.mApp.network.StartGame();
      }
      
      public function update() : void
      {
         if(this.mApp.ui.game.board.clock.alpha < 1)
         {
            this.mApp.ui.game.board.clock.alpha += 0.05;
         }
         this.mApp.logic.isActive = false;
         this.mApp.logic.update();
         --this.mTimer;
         var time:int = Math.min(100,this.mTimer);
         var percent:Number = 1 - time / 100;
         var board:Sprite = this.mApp.ui.game.board;
         var timer:Sprite = this.mApp.ui.game.board.clock;
         timer.scaleX = (1 - percent) * 3 + 1;
         timer.scaleY = (1 - percent) * 3 + 1;
         timer.x = 160;
         timer.y = 160 + 169.5 * percent;
         if(this.mTimer == 0)
         {
            dispatchEvent(new Event(GamePlayState.SIGNAL_GAME_PLAY_START));
         }
      }
      
      public function draw(elapsed:int) : void
      {
      }
      
      public function onEnter() : void
      {
      }
      
      public function onExit() : void
      {
      }
      
      public function onPush() : void
      {
      }
      
      public function onPop() : void
      {
      }
      
      public function onMouseUp(x:Number, y:Number) : void
      {
      }
      
      public function onMouseDown(x:Number, y:Number) : void
      {
      }
      
      public function onMouseMove(x:Number, y:Number) : void
      {
      }
      
      public function onKeyUp(keyCode:int) : void
      {
      }
      
      public function onKeyDown(keyCode:int) : void
      {
      }
      
      public function onButtonPress(id:String) : void
      {
      }
      
      public function onButtonRelease(id:String) : void
      {
      }
   }
}
