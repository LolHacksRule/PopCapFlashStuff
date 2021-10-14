package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.framework.BaseAppStateMachine;
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.framework.IAppStateMachine;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class ReplayState extends Sprite implements IAppState
   {
      
      public static const STATE_REPLAY_RESET:String = "State:Replay:Reset";
      
      public static const STATE_REPLAY_PLAY:String = "State:Replay:Play";
      
      public static const STATE_REPLAY_OVER:String = "State:Replay:Over";
      
      public static const SIGNAL_REPLAY_START:String = "Signal:ReplayStart";
      
      public static const SIGNAL_REPLAY_END:String = "Signal:ReplayEnd";
      
      public static const SIGNAL_REPLAY_QUIT:String = "Signal:ReplayQuit";
      
      public static const SIGNAL_REPLAY_OVER_CONTINUE:String = "Signal:ReplayOverContinue";
       
      
      public var reset:ReplayResetState;
      
      public var play:ReplayPlayState;
      
      public var over:ReplayOverState;
      
      private var _app:Blitz3Game;
      
      private var mStateMachine:IAppStateMachine;
      
      private var _mainWidget:MainWidgetGame;
      
      private var mLastDisplayed:DisplayObject;
      
      public function ReplayState(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this.mStateMachine = new BaseAppStateMachine();
         this._mainWidget = this._app.ui as MainWidgetGame;
         this.reset = new ReplayResetState(param1);
         this.play = new ReplayPlayState(param1);
         this.over = new ReplayOverState(param1);
         this.mStateMachine.bindState(STATE_REPLAY_RESET,this.reset);
         this.mStateMachine.bindState(STATE_REPLAY_PLAY,this.play);
         this.mStateMachine.bindState(STATE_REPLAY_OVER,this.over);
      }
      
      public function update() : void
      {
         this.mStateMachine.getCurrentState().update();
         if(!this._app.isLQMode)
         {
            this._mainWidget.game.board.compliments.Update();
            this._mainWidget.game.board.checkerboard.Update();
         }
         this._mainWidget.game.board.blipLayer.Update();
         this._mainWidget.game.blazingSpeedWidget.Update();
      }
      
      public function draw(param1:int) : void
      {
         this.mStateMachine.getCurrentState().draw(param1);
      }
      
      public function onEnter() : void
      {
         this.reset.addEventListener(SIGNAL_REPLAY_START,this.handleStart);
         this.play.addEventListener(SIGNAL_REPLAY_END,this.handleEnd);
         this.play.addEventListener(SIGNAL_REPLAY_QUIT,this.handleQuit);
         this.over.addEventListener(SIGNAL_REPLAY_OVER_CONTINUE,this.HandleGameOverContinue);
         this.resetAndStartReplay(null);
      }
      
      public function resetAndStartReplay(param1:Event) : void
      {
         this._mainWidget.OnReplayStateEnter();
         this._mainWidget.game.ResetReplayEncoreData();
         this._app.logic.CleanUpPostGameplay();
         this._app.sessionData.finisherManager.SetReplayFinisherId("");
         this._app.sessionData.finisherManager.Reset();
         this._mainWidget.PlayMode(true);
         this._mainWidget.game.reset();
         this._mainWidget.menu.leftPanel.visible = false;
         this.switchAndDisplayState(STATE_REPLAY_RESET,this.reset);
      }
      
      public function onExit() : void
      {
         this._mainWidget.menu.leftPanel.visible = true;
         (this._app.ui as MainWidgetGame).OnReplayStateExit();
         this.reset.removeEventListener(SIGNAL_REPLAY_START,this.handleStart);
         this.play.removeEventListener(SIGNAL_REPLAY_END,this.handleEnd);
         this.play.removeEventListener(SIGNAL_REPLAY_QUIT,this.handleQuit);
         this.over.removeEventListener(SIGNAL_REPLAY_OVER_CONTINUE,this.HandleGameOverContinue);
      }
      
      private function handleStart(param1:Event) : void
      {
         this.switchAndDisplayState(STATE_REPLAY_PLAY,this.play);
      }
      
      private function handleEnd(param1:Event) : void
      {
         this.switchAndDisplayState(STATE_REPLAY_OVER,this.over);
      }
      
      private function handleQuit(param1:Event) : void
      {
         this.switchAndDisplayState(STATE_REPLAY_OVER,this.over);
      }
      
      private function HandleGameOverContinue(param1:Event) : void
      {
         this._app.mainState.GotoMainMenuFromReplay(this._app.sessionData.replayManager.tournamentId != "");
      }
      
      private function switchAndDisplayState(param1:String, param2:DisplayObject) : void
      {
         if(this.mLastDisplayed != null)
         {
            removeChild(this.mLastDisplayed);
         }
         this.mLastDisplayed = param2;
         addChild(this.mLastDisplayed);
         this.mStateMachine.switchState(param1);
      }
   }
}
