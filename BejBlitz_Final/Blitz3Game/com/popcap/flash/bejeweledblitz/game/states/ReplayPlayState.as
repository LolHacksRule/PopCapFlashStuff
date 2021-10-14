package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.framework.BaseAppStateMachine;
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.framework.IAppStateMachine;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class ReplayPlayState extends Sprite implements IAppState
   {
      
      public static const STATE_GAME_REPLAY_START:String = "State:Game:Replay:Start";
      
      public static const STATE_GAME_REPLAY_ACTIVE:String = "State:Game:Replay:Active";
      
      public static const STATE_GAME_REPLAY_PAUSED:String = "State:Game:Replay:Paused";
      
      public static const SIGNAL_GAME_REPLAY_START:String = "Signal:GameReplayStart";
      
      public static const SIGNAL_GAME_REPLAY_LOAD:String = "Signal:GameReplayLoad";
      
      public static const SIGNAL_GAME_REPLAY_END:String = "Signal:GameReplayEnd";
       
      
      public var replayStart:ReplayStartState;
      
      public var replayActive:ReplayActiveState;
      
      public var replayPaused:ReplayPausedState;
      
      private var _app:Blitz3Game;
      
      private var _stateMachine:IAppStateMachine;
      
      private var _isActive:Boolean = false;
      
      private var _unpauseState:String;
      
      private var _mainWidget:MainWidgetGame;
      
      public function ReplayPlayState(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._unpauseState = STATE_GAME_REPLAY_ACTIVE;
         this._stateMachine = new BaseAppStateMachine();
         this._mainWidget = this._app.ui as MainWidgetGame;
         this.replayStart = new ReplayStartState(param1);
         this.replayActive = new ReplayActiveState(param1);
         this.replayPaused = new ReplayPausedState(param1);
         this._stateMachine.bindState(STATE_GAME_REPLAY_START,this.replayStart);
         this._stateMachine.bindState(STATE_GAME_REPLAY_ACTIVE,this.replayActive);
         this._stateMachine.bindState(STATE_GAME_REPLAY_PAUSED,this.replayPaused);
      }
      
      public function update() : void
      {
         this._stateMachine.getCurrentState().update();
         this._mainWidget.game.board.Update();
         this._mainWidget.game.board.gemLayer.Update();
      }
      
      public function draw(param1:int) : void
      {
         this._stateMachine.getCurrentState().draw(param1);
         this._mainWidget.game.board.gemLayer.Draw();
         this._mainWidget.game.blazingSpeedWidget.Draw();
      }
      
      public function onEnter() : void
      {
         this.replayStart.addEventListener(SIGNAL_GAME_REPLAY_START,this.handleStart,false,0,true);
         this.replayStart.addEventListener(SIGNAL_GAME_REPLAY_END,this.handleEnd,false,0,true);
         this.replayActive.addEventListener(SIGNAL_GAME_REPLAY_END,this.handleEnd,false,0,true);
         this._app.sessionData.configManager.CommitChanges();
         this.replayStart.Reset();
         this.replayActive.Reset();
         this._unpauseState = STATE_GAME_REPLAY_START;
         this._stateMachine.switchState(STATE_GAME_REPLAY_START);
         this._isActive = true;
      }
      
      public function onExit() : void
      {
         this.replayStart.removeEventListener(SIGNAL_GAME_REPLAY_START,this.handleStart);
         this.replayStart.removeEventListener(SIGNAL_GAME_REPLAY_END,this.handleEnd);
         this.replayActive.removeEventListener(SIGNAL_GAME_REPLAY_END,this.handleEnd);
         this._isActive = false;
      }
      
      public function Pause() : void
      {
         this._app.sessionData.replayManager.SendReplayTAPIEvent("WR-Pause",false);
         this._stateMachine.switchState(STATE_GAME_REPLAY_PAUSED);
      }
      
      public function Resume() : void
      {
         this._app.sessionData.replayManager.SendReplayTAPIEvent("WR-Resume",false);
         this._stateMachine.switchState(this._unpauseState);
      }
      
      public function Quit() : void
      {
         dispatchEvent(new Event(ReplayState.SIGNAL_REPLAY_QUIT));
      }
      
      private function handleStart(param1:Event) : void
      {
         this._app.logic.DoDispatchGameBegin();
         this._unpauseState = STATE_GAME_REPLAY_ACTIVE;
         this._stateMachine.switchState(STATE_GAME_REPLAY_ACTIVE);
      }
      
      private function handleEnd(param1:Event) : void
      {
         dispatchEvent(new Event(ReplayState.SIGNAL_REPLAY_END));
      }
   }
}
