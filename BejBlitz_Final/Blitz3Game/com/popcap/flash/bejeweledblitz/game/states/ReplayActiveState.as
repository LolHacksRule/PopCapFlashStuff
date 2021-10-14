package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.framework.IAppState;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class ReplayActiveState extends Sprite implements IAppState
   {
      
      public static const IDLE_TIME:int = 175;
       
      
      private var _app:Blitz3Game;
      
      private var _mainWidget:MainWidgetGame;
      
      private var mTimer:int = 0;
      
      private var mTimerStarted:Boolean = false;
      
      private var mIsTimeUp:Boolean = false;
      
      private var mIsActive:Boolean = false;
      
      public function ReplayActiveState(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._mainWidget = this._app.ui as MainWidgetGame;
      }
      
      public function update() : void
      {
         this._app.logic.isActive = true;
         this._app.logic.Update();
         if(this._app.logic.timerLogic.GetTimeRemaining() == 0 && this.mIsTimeUp == false)
         {
            if(!this._app.logic.ShouldDelayTimeUp())
            {
               this.mIsTimeUp = true;
               if(!this._app.sessionData.finisherSessionData.IsFinisherSurfaced())
               {
                  (this._app.ui as MainWidgetGame).game.board.compliments.showTimeUp();
               }
            }
         }
         if(this._app.logic.timerLogic.GetTimeRemaining() == 0)
         {
            if(this.mTimer > 0)
            {
               --this.mTimer;
            }
         }
         if(this._app.logic.IsGameOver() && this.mTimer == 0)
         {
            dispatchEvent(new Event(ReplayPlayState.SIGNAL_GAME_REPLAY_END));
            this.mTimerStarted = false;
         }
         this._mainWidget.game.Update();
         this._mainWidget.game.board.frame.Update();
         this._mainWidget.game.board.clock.Update();
      }
      
      public function draw(param1:int) : void
      {
         this._mainWidget.game.board.frame.Draw();
      }
      
      public function onEnter() : void
      {
         this.mIsActive = true;
         if(!this.mTimerStarted)
         {
            this.mTimer = IDLE_TIME;
            this.mTimerStarted = true;
         }
         this._app.logic.Resume();
      }
      
      public function onExit() : void
      {
         this.mIsActive = false;
      }
      
      public function Reset() : void
      {
         this.mTimerStarted = false;
         this.mIsTimeUp = false;
      }
   }
}
