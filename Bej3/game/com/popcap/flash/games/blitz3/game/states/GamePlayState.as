package com.popcap.flash.games.blitz3.game.states
{
   import com.popcap.flash.framework.BaseAppStateMachine;
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.framework.IAppStateMachine;
   import com.popcap.flash.framework.input.keyboard.KeyCode;
   import com.popcap.flash.games.blitz3.ui.widgets.game.SidebarWidget;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class GamePlayState extends Sprite implements IAppState
   {
      
      public static const STATE_GAME_PLAY_START:String = "State:Game:Play:Start";
      
      public static const STATE_GAME_PLAY_ACTIVE:String = "State:Game:Play:Active";
      
      public static const STATE_GAME_PLAY_PAUSED:String = "State:Game:Play:Paused";
      
      public static const STATE_GAME_PLAY_STOP:String = "State:Game:Play:Stop";
      
      public static const STATE_GAME_PLAY_LEVELUP:String = "State:Game:Play:LevelUp";
      
      public static const SIGNAL_GAME_PLAY_START:String = "Signal:GamePlayStart";
      
      public static const SIGNAL_GAME_PLAY_PAUSE:String = "Signal:GamePlayPause";
      
      public static const SIGNAL_GAME_PLAY_RESUME:String = "Signal:GamePlayResume";
      
      public static const SIGNAL_GAME_PLAY_END:String = "Signal:GamePlayEnd";
      
      public static const SIGNAL_GAME_PLAY_QUIT:String = "Signal:GamePlayQuit";
      
      public static const SIGNAL_GAME_PLAY_STOP:String = "Signal:GamePlayStop";
      
      public static const SIGNAL_GAME_PLAY_LEVELUP:String = "Signal:GamePlayLevelUp";
      
      public static const SIGNAL_GAME_PLAY_NOMOVES:String = "Signal:GamePlayNoMoves";
       
      
      public var start:GamePlayStartState;
      
      public var active:GamePlayActiveState;
      
      public var paused:GamePlayPausedState;
      
      public var stop:GamePlayStopState;
      
      public var levelup:GamePlayLevelUpState;
      
      private var mApp:Blitz3Game;
      
      private var mStateMachine:IAppStateMachine;
      
      private var mIsActive:Boolean = false;
      
      private var mUnpauseState:String;
      
      public function GamePlayState(app:Blitz3Game)
      {
         super();
         this.mApp = app;
         this.mUnpauseState = STATE_GAME_PLAY_ACTIVE;
         this.mStateMachine = new BaseAppStateMachine();
         this.start = new GamePlayStartState(app);
         this.active = new GamePlayActiveState(app);
         this.paused = new GamePlayPausedState(app);
         this.stop = new GamePlayStopState(app);
         this.levelup = new GamePlayLevelUpState(app);
         this.mApp.ui.game.sidebar.buttons.menuButton.addEventListener(MouseEvent.CLICK,this.handlePause);
         this.start.addEventListener(SIGNAL_GAME_PLAY_START,this.handleStart);
         this.active.addEventListener(SIGNAL_GAME_PLAY_LEVELUP,this.handleLevelUp);
         this.active.addEventListener(SIGNAL_GAME_PLAY_PAUSE,this.handlePause);
         this.active.addEventListener(SIGNAL_GAME_PLAY_STOP,this.handleStop);
         this.active.addEventListener(SIGNAL_GAME_PLAY_RESUME,this.handleResume);
         this.levelup.addEventListener(SIGNAL_GAME_PLAY_START,this.handleStart);
         this.paused.addEventListener(SIGNAL_GAME_PLAY_RESUME,this.handleResume);
         this.paused.addEventListener(SIGNAL_GAME_PLAY_QUIT,this.handleQuit);
         this.stop.addEventListener(SIGNAL_GAME_PLAY_END,this.handleEnd);
         this.mStateMachine.bindState(STATE_GAME_PLAY_START,this.start);
         this.mStateMachine.bindState(STATE_GAME_PLAY_ACTIVE,this.active);
         this.mStateMachine.bindState(STATE_GAME_PLAY_PAUSED,this.paused);
         this.mStateMachine.bindState(STATE_GAME_PLAY_STOP,this.stop);
         this.mStateMachine.bindState(STATE_GAME_PLAY_LEVELUP,this.levelup);
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
         trace("Unpausing, switching to: " + this.mUnpauseState);
      }
      
      public function update() : void
      {
         this.mApp.ui.game.board.Update();
         this.mStateMachine.getCurrentState().update();
         this.mApp.ui.game.board.gemLayer.Update();
         var sidebar:SidebarWidget = this.mApp.ui.game.sidebar;
         sidebar.speed.Update();
         sidebar.score.Update();
         sidebar.starMedal.Update();
         sidebar.highScore.Update();
         sidebar.coinBank.Update();
         sidebar.laserCat.Update();
      }
      
      public function draw(elapsed:int) : void
      {
         this.mStateMachine.getCurrentState().draw(elapsed);
         this.mApp.ui.game.board.gemLayer.Draw();
         this.mApp.ui.game.sidebar.speed.Draw();
         this.mApp.ui.game.sidebar.score.Draw();
         this.mApp.ui.game.sidebar.starMedal.Draw();
         this.mApp.ui.game.sidebar.highScore.Draw();
      }
      
      public function onEnter() : void
      {
         this.start.Reset();
         this.active.Reset();
         this.stop.Reset();
         this.mApp.ui.optionsButton.visible = false;
         this.mUnpauseState = STATE_GAME_PLAY_START;
         this.mIsActive = true;
         this.mStateMachine.switchState(STATE_GAME_PLAY_START);
      }
      
      public function onExit() : void
      {
         this.mStateMachine.getCurrentState().onExit();
         this.mIsActive = false;
      }
      
      public function onPush() : void
      {
      }
      
      public function onPop() : void
      {
      }
      
      public function onMouseUp(x:Number, y:Number) : void
      {
         this.mStateMachine.getCurrentState().onMouseUp(x,y);
      }
      
      public function onMouseDown(x:Number, y:Number) : void
      {
         this.mStateMachine.getCurrentState().onMouseDown(x,y);
      }
      
      public function onMouseMove(x:Number, y:Number) : void
      {
         this.mStateMachine.getCurrentState().onMouseMove(x,y);
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
      
      private function handlePause(e:Event) : void
      {
         this.Pause();
      }
      
      private function handleStop(e:Event) : void
      {
         trace("Handling stop");
         this.active.ResetTime();
         this.active.ResetBestMove();
         this.mUnpauseState = STATE_GAME_PLAY_STOP;
         this.mStateMachine.switchState(STATE_GAME_PLAY_STOP);
      }
      
      private function handleEnd(e:Event) : void
      {
         dispatchEvent(new Event(GameState.SIGNAL_GAME_END));
      }
      
      private function handleResume(e:Event) : void
      {
         this.Unpause();
         trace("Resuming");
      }
      
      private function handleQuit(e:Event) : void
      {
         this.mStateMachine.switchState(STATE_GAME_PLAY_ACTIVE);
         dispatchEvent(new Event(GameState.SIGNAL_GAME_QUIT));
      }
      
      private function handleLevelUp(e:Event) : void
      {
         this.active.Reset();
         this.mStateMachine.switchState(STATE_GAME_PLAY_LEVELUP);
      }
   }
}
