package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.framework.BaseAppStateMachine;
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.framework.IAppStateMachine;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class GameOverState extends Sprite implements IAppState
   {
      
      public static const STATE_GAME_OVER_INFO:String = "State:Game:Over:Info";
      
      public static const SIGNAL_GAME_OVER_INFO_CONTINUE:String = "Signal:GameOverInfoContinue";
       
      
      protected var m_App:Blitz3Game;
      
      protected var m_StateMachine:IAppStateMachine;
      
      protected var m_IsActive:Boolean;
      
      public var info:GameOverInfoState;
      
      public var boost:PreGameMenuBoostState;
      
      public var postCheck:PreGameMenuCheckState;
      
      public function GameOverState(app:Blitz3Game)
      {
         super();
         this.m_App = app;
         this.m_StateMachine = new BaseAppStateMachine();
         this.info = new GameOverInfoState(app);
         this.info.addEventListener(SIGNAL_GAME_OVER_INFO_CONTINUE,this.HandleInfoContinue);
         this.m_StateMachine.bindState(STATE_GAME_OVER_INFO,this.info);
      }
      
      public function Reset() : void
      {
      }
      
      public function update() : void
      {
         this.m_StateMachine.getCurrentState().update();
      }
      
      public function draw(elapsed:int) : void
      {
         this.m_StateMachine.getCurrentState().draw(elapsed);
      }
      
      public function onEnter() : void
      {
         this.m_IsActive = true;
         this.m_StateMachine.switchState(STATE_GAME_OVER_INFO);
      }
      
      public function onExit() : void
      {
         this.m_StateMachine.getCurrentState().onExit();
         this.m_IsActive = false;
      }
      
      public function onKeyUp(keyCode:int) : void
      {
         this.m_StateMachine.getCurrentState().onKeyUp(keyCode);
      }
      
      public function onKeyDown(keyCode:int) : void
      {
         this.m_StateMachine.getCurrentState().onKeyDown(keyCode);
      }
      
      protected function HandleInfoContinue(event:Event) : void
      {
         dispatchEvent(new Event(GameState.SIGNAL_GAME_OVER_CONTINUE));
      }
   }
}
