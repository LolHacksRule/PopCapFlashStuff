package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.game.tutorial.ITutorialWatcherHandler;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.quest.IQuestRewardWidgetHandler;
   import com.popcap.flash.framework.BaseAppStateMachine;
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.framework.IAppStateMachine;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class GamePlayState extends Sprite implements IAppState, ITutorialWatcherHandler, IQuestRewardWidgetHandler
   {
      
      public static const STATE_GAME_PLAY_START:String = "State:Game:Play:Start";
      
      public static const STATE_GAME_PLAY_ACTIVE:String = "State:Game:Play:Active";
      
      public static const STATE_GAME_PLAY_PAUSED:String = "State:Game:Play:Paused";
      
      public static const STATE_GAME_PLAY_STOP:String = "State:Game:Play:Stop";
      
      public static const SIGNAL_GAME_PLAY_START:String = "Signal:GamePlayStart";
      
      public static const SIGNAL_GAME_PLAY_LOAD:String = "Signal:GamePlayLoad";
      
      public static const SIGNAL_GAME_PLAY_END:String = "Signal:GamePlayEnd";
      
      public static const SIGNAL_GAME_PLAY_QUIT:String = "Signal:GamePlayQuit";
      
      public static const SIGNAL_GAME_PLAY_GOTO_MAIN:String = "Signal:GamePlayGotoMain";
      
      public static const SIGNAL_GAME_PLAY_STOP:String = "Signal:GamePlayStop";
       
      
      public var start:GamePlayStartState;
      
      public var active:GamePlayActiveState;
      
      public var paused:GamePlayPausedState;
      
      public var stop:GamePlayStopState;
      
      private var _app:Blitz3Game;
      
      private var _stateMachine:IAppStateMachine;
      
      private var _isActive:Boolean = false;
      
      private var _unpauseState:String;
      
      private var _mainWidget:MainWidgetGame;
      
      public function GamePlayState(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._unpauseState = STATE_GAME_PLAY_ACTIVE;
         this._stateMachine = new BaseAppStateMachine();
         this._mainWidget = this._app.ui as MainWidgetGame;
         this.start = new GamePlayStartState(param1);
         this.active = new GamePlayActiveState(param1);
         this.paused = new GamePlayPausedState(param1);
         this.stop = new GamePlayStopState(param1);
         this._app.tutorial.AddHandler(this);
         this._app.metaUI.questReward.AddHandler(this);
         this.start.addEventListener(SIGNAL_GAME_PLAY_LOAD,this.handleLoad);
         this.start.addEventListener(SIGNAL_GAME_PLAY_START,this.handleStart,false,0,true);
         this.active.addEventListener(SIGNAL_GAME_PLAY_STOP,this.handleStop,false,0,true);
         this.paused.addEventListener(SIGNAL_GAME_PLAY_QUIT,this.handleQuit,false,0,true);
         this.paused.addEventListener(SIGNAL_GAME_PLAY_GOTO_MAIN,this.handleAbortAndGotoMain,false,0,true);
         this.stop.addEventListener(SIGNAL_GAME_PLAY_END,this.handleEnd,false,0,true);
         this._stateMachine.bindState(STATE_GAME_PLAY_START,this.start);
         this._stateMachine.bindState(STATE_GAME_PLAY_ACTIVE,this.active);
         this._stateMachine.bindState(STATE_GAME_PLAY_PAUSED,this.paused);
         this._stateMachine.bindState(STATE_GAME_PLAY_STOP,this.stop);
      }
      
      public function forcePause() : Boolean
      {
         var _loc1_:IAppState = this._stateMachine.getCurrentState();
         if((_loc1_ == this.active && (_loc1_ as GamePlayActiveState).IsActive() || _loc1_ == this.start) && !(this._app.ui as MainWidgetGame).boostDialog.visible && !this._app.metaUI.tutorial.isVisible() || (this._app.ui as MainWidgetGame).game.kangaRuby.isRunning())
         {
            this.Pause();
            return true;
         }
         return false;
      }
      
      public function Pause() : void
      {
         this._stateMachine.switchState(STATE_GAME_PLAY_PAUSED);
      }
      
      public function forceResume() : void
      {
         this._stateMachine.switchState(this._unpauseState);
      }
      
      public function update() : void
      {
         this._stateMachine.getCurrentState().update();
         this._mainWidget.game.board.Update();
         this._mainWidget.game.board.gemLayer.Update();
         this._mainWidget.game.dailyChallengeLeaderboardAndQuestsCoverView.UpdateScore(this._app.logic.GetScoreKeeper().GetScore());
         this._app.metaUI.Update();
      }
      
      public function draw(param1:int) : void
      {
         this._stateMachine.getCurrentState().draw(param1);
         this._mainWidget.game.board.gemLayer.Draw();
         this._mainWidget.game.blazingSpeedWidget.Draw();
      }
      
      public function onEnter() : void
      {
         this._app.sessionData.configManager.CommitChanges();
         this.start.Reset();
         this.active.Reset();
         this.stop.Reset();
         this._unpauseState = STATE_GAME_PLAY_START;
         this._stateMachine.switchState(STATE_GAME_PLAY_START);
         this._isActive = true;
      }
      
      public function onExit() : void
      {
         this._stateMachine.getCurrentState().onExit();
         this._isActive = false;
      }
      
      public function HandleTutorialComplete(param1:Boolean) : void
      {
         dispatchEvent(new Event(GameState.SIGNAL_TUTORIAL_END));
      }
      
      public function HandleTutorialRestarted() : void
      {
      }
      
      public function CanShowQuestReward() : Boolean
      {
         return !this._isActive;
      }
      
      public function HandleQuestRewardClosed(param1:String) : void
      {
      }
      
      public function HandleQuestRewardOpened() : void
      {
      }
      
      public function handleLoad(param1:Event) : void
      {
         this._app.logic.DoDispatchGameLoad();
      }
      
      private function handleStart(param1:Event) : void
      {
         this._app.logic.DoDispatchGameBegin();
         this._unpauseState = STATE_GAME_PLAY_ACTIVE;
         this._stateMachine.switchState(STATE_GAME_PLAY_ACTIVE);
      }
      
      private function menuPress(param1:Event) : void
      {
         this.Pause();
      }
      
      private function handleStop(param1:Event) : void
      {
         this._stateMachine.switchState(STATE_GAME_PLAY_STOP);
      }
      
      private function handleEnd(param1:Event) : void
      {
         dispatchEvent(new Event(GameState.SIGNAL_GAME_END));
      }
      
      private function handleQuit(param1:Event) : void
      {
         this._stateMachine.switchState(STATE_GAME_PLAY_ACTIVE);
         dispatchEvent(new Event(GameState.SIGNAL_GAME_QUIT));
      }
      
      private function handleAbortAndGotoMain(param1:Event) : void
      {
         dispatchEvent(new Event(GameState.SIGNAL_GAME_GOTO_MAIN));
      }
   }
}
