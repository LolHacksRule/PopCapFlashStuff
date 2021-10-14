package com.popcap.flash.bejeweledblitz.replay.states
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.BaseAppStateMachine;
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.framework.IAppStateMachine;
   import com.popcap.flash.framework.keyboard.KeyCode;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class GamePlayState extends Sprite implements IAppState
   {
      
      public static const STATE_GAME_PLAY_START:String = "State:Game:Play:Start";
      
      public static const STATE_GAME_PLAY_ACTIVE:String = "State:Game:Play:Active";
      
      public static const STATE_GAME_PLAY_PAUSED:String = "State:Game:Play:Paused";
      
      public static const STATE_GAME_PLAY_STOP:String = "State:Game:Play:Stop";
      
      public static const SIGNAL_GAME_PLAY_START:String = "Signal:GamePlayStart";
      
      public static const SIGNAL_GAME_PLAY_PAUSE:String = "Signal:GamePlayPause";
      
      public static const SIGNAL_GAME_PLAY_RESUME:String = "Signal:GamePlayResume";
      
      public static const SIGNAL_GAME_PLAY_END:String = "Signal:GamePlayEnd";
      
      public static const SIGNAL_GAME_PLAY_QUIT:String = "Signal:GamePlayQuit";
      
      public static const SIGNAL_GAME_PLAY_STOP:String = "Signal:GamePlayStop";
      
      public static const SIGNAL_GAME_PLAY_ERROR:String = "Signal:GamePlayError";
       
      
      public var start:GamePlayStartState;
      
      public var active:GamePlayActiveState;
      
      public var paused:GamePlayPausedState;
      
      public var stop:GamePlayStopState;
      
      private var m_App:Blitz3App;
      
      private var mStateMachine:IAppStateMachine;
      
      private var mIsActive:Boolean = false;
      
      private var mUnpauseState:String;
      
      public function GamePlayState(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.mUnpauseState = STATE_GAME_PLAY_ACTIVE;
         this.mStateMachine = new BaseAppStateMachine();
         this.start = new GamePlayStartState(app);
         this.active = new GamePlayActiveState(app);
         this.paused = new GamePlayPausedState(app);
         this.stop = new GamePlayStopState(app);
         this.start.addEventListener(SIGNAL_GAME_PLAY_START,this.handleStart);
         this.active.addEventListener(SIGNAL_GAME_PLAY_STOP,this.handleStop);
         this.active.addEventListener(SIGNAL_GAME_PLAY_ERROR,this.handleError);
         this.paused.addEventListener(SIGNAL_GAME_PLAY_RESUME,this.handleResume);
         this.paused.addEventListener(SIGNAL_GAME_PLAY_QUIT,this.handleQuit);
         this.stop.addEventListener(SIGNAL_GAME_PLAY_END,this.handleEnd);
         this.mStateMachine.bindState(STATE_GAME_PLAY_START,this.start);
         this.mStateMachine.bindState(STATE_GAME_PLAY_ACTIVE,this.active);
         this.mStateMachine.bindState(STATE_GAME_PLAY_PAUSED,this.paused);
         this.mStateMachine.bindState(STATE_GAME_PLAY_STOP,this.stop);
      }
      
      public function TogglePause() : void
      {
         if(!this.mIsActive)
         {
            return;
         }
         var current:IAppState = this.mStateMachine.getCurrentState();
         if(current != this.paused)
         {
            this.Pause();
         }
         else if(current == this.paused)
         {
            this.Unpause();
         }
      }
      
      public function Pause() : void
      {
         this.mStateMachine.switchState(STATE_GAME_PLAY_PAUSED);
      }
      
      public function Unpause() : void
      {
         this.mStateMachine.switchState(this.mUnpauseState);
      }
      
      public function update() : void
      {
         this.mStateMachine.getCurrentState().update();
         this.m_App.ui.game.board.Update();
         this.m_App.ui.game.board.gemLayer.Update();
         this.m_App.ui.game.laserCat.Update();
         this.m_App.ui.game.phoenixPrism.Update();
         this.m_App.ui.game.sidebar.speed.Update();
         this.m_App.ui.game.sidebar.score.Update();
      }
      
      public function draw(elapsed:int) : void
      {
         this.mStateMachine.getCurrentState().draw(elapsed);
         this.m_App.ui.game.board.gemLayer.Draw();
         this.m_App.ui.game.sidebar.speed.Draw();
      }
      
      public function onEnter() : void
      {
         this.start.Reset();
         this.active.Reset();
         this.stop.Reset();
         this.mUnpauseState = STATE_GAME_PLAY_START;
         this.mIsActive = true;
         this.mStateMachine.switchState(STATE_GAME_PLAY_START);
         this.m_App.ui.game.board.visible = true;
         this.m_App.ui.game.sidebar.visible = true;
      }
      
      public function onExit() : void
      {
         this.mStateMachine.getCurrentState().onExit();
         this.mIsActive = false;
      }
      
      public function onKeyUp(keyCode:int) : void
      {
         if(keyCode == KeyCode.SPACE)
         {
            this.TogglePause();
            return;
         }
         this.mStateMachine.getCurrentState().onKeyUp(keyCode);
      }
      
      public function onKeyDown(keyCode:int) : void
      {
         this.mStateMachine.getCurrentState().onKeyDown(keyCode);
      }
      
      private function handleStart(e:Event) : void
      {
         this.mUnpauseState = STATE_GAME_PLAY_ACTIVE;
         this.mStateMachine.switchState(STATE_GAME_PLAY_ACTIVE);
      }
      
      private function handleStop(e:Event) : void
      {
         this.mUnpauseState = STATE_GAME_PLAY_STOP;
         this.mStateMachine.switchState(STATE_GAME_PLAY_STOP);
      }
      
      private function handleError(e:Event) : void
      {
         dispatchEvent(new Event(GameState.SIGNAL_GAME_ERROR));
      }
      
      private function handleEnd(e:Event) : void
      {
         dispatchEvent(new Event(GameState.SIGNAL_GAME_END));
      }
      
      private function handleResume(e:Event) : void
      {
         this.Unpause();
      }
      
      private function handleQuit(e:Event) : void
      {
         this.mStateMachine.switchState(STATE_GAME_PLAY_ACTIVE);
         this.m_App.logic.Quit();
         dispatchEvent(new Event(GameState.SIGNAL_GAME_QUIT));
      }
   }
}
