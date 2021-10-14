package com.popcap.flash.bejeweledblitz.replay.states
{
   import com.popcap.flash.framework.BaseAppStateMachine;
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.framework.IAppStateMachine;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class GameState extends Sprite implements IAppState
   {
      
      public static const STATE_GAME_HELP:String = "State:Game:Help";
      
      public static const STATE_GAME_RESET:String = "State:Game:Reset";
      
      public static const STATE_GAME_PLAY:String = "State:Game:Play";
      
      public static const STATE_GAME_OVER:String = "State:Game:Over";
      
      public static const STATE_GAME_ERROR:String = "State:Game:Error";
      
      public static const SIGNAL_GAME_RESET:String = "Signal:GameReset";
      
      public static const SIGNAL_GAME_START:String = "Signal:GameStart";
      
      public static const SIGNAL_GAME_END:String = "Signal:GameEnd";
      
      public static const SIGNAL_GAME_QUIT:String = "Signal:GameQuit";
      
      public static const SIGNAL_GAME_ERROR:String = "Signal:GameError";
       
      
      public var reset:GameResetState;
      
      public var over:GameOverState;
      
      public var play:GamePlayState;
      
      public var error:GameErrorState;
      
      private var m_App:Blitz3Replay;
      
      private var mStateMachine:IAppStateMachine;
      
      private var mLastDisplayed:DisplayObject;
      
      public function GameState(app:Blitz3Replay)
      {
         super();
         this.m_App = app;
         this.mStateMachine = new BaseAppStateMachine();
         this.reset = new GameResetState(app);
         this.over = new GameOverState(app);
         this.play = new GamePlayState(app);
         this.error = new GameErrorState(app);
         this.reset.addEventListener(SIGNAL_GAME_START,this.handleStart);
         this.play.addEventListener(SIGNAL_GAME_END,this.handleEnd);
         this.play.addEventListener(SIGNAL_GAME_RESET,this.handleReset);
         this.play.addEventListener(SIGNAL_GAME_QUIT,this.handleQuit);
         this.play.addEventListener(SIGNAL_GAME_ERROR,this.handleError);
         this.reset.addEventListener(SIGNAL_GAME_ERROR,this.handleError);
         this.mStateMachine.bindState(STATE_GAME_RESET,this.reset);
         this.mStateMachine.bindState(STATE_GAME_OVER,this.over);
         this.mStateMachine.bindState(STATE_GAME_PLAY,this.play);
         this.mStateMachine.bindState(STATE_GAME_ERROR,this.error);
      }
      
      public function update() : void
      {
         this.mStateMachine.getCurrentState().update();
         this.m_App.ui.background.Update();
         this.m_App.ui.game.board.checkerboard.Update();
         this.m_App.ui.game.board.blipLayer.Update();
         this.m_App.ui.game.board.clock.Update();
         this.m_App.ui.game.board.compliments.Update();
         this.m_App.ui.game.board.broadcast.Update();
         this.m_App.ui.game.sidebar.speed.Update();
      }
      
      public function draw(elapsed:int) : void
      {
         this.mStateMachine.getCurrentState().draw(elapsed);
         this.m_App.ui.background.Draw();
         this.m_App.ui.game.sidebar.speed.Draw();
      }
      
      public function onEnter() : void
      {
         this.switchAndDisplayState(STATE_GAME_RESET,this.reset);
      }
      
      public function onExit() : void
      {
      }
      
      public function onKeyUp(keyCode:int) : void
      {
         this.mStateMachine.getCurrentState().onKeyUp(keyCode);
      }
      
      public function onKeyDown(keyCode:int) : void
      {
         this.mStateMachine.getCurrentState().onKeyDown(keyCode);
      }
      
      private function switchAndDisplayState(id:String, state:DisplayObject) : void
      {
         if(this.mLastDisplayed != null)
         {
            removeChild(this.mLastDisplayed);
         }
         this.mLastDisplayed = state;
         addChild(this.mLastDisplayed);
         this.mStateMachine.switchState(id);
      }
      
      private function handleReset(e:Event) : void
      {
         this.switchAndDisplayState(STATE_GAME_RESET,this.reset);
      }
      
      private function handleStart(e:Event) : void
      {
         this.m_App.fpsMonitor.ResetStats();
         this.switchAndDisplayState(STATE_GAME_PLAY,this.play);
      }
      
      private function handleEnd(e:Event) : void
      {
         this.switchAndDisplayState(STATE_GAME_OVER,this.over);
      }
      
      private function handleError(e:Event) : void
      {
         this.switchAndDisplayState(STATE_GAME_ERROR,this.error);
      }
      
      private function handleQuit(e:Event) : void
      {
         dispatchEvent(new Event(MainState.SIGNAL_QUIT));
      }
   }
}
