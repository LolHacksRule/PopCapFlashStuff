package com.popcap.flash.bejeweledblitz.replay.states
{
   import com.popcap.flash.framework.BaseAppStateMachine;
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.framework.IAppStateMachine;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class MainState extends Sprite implements IAppState
   {
      
      public static const STATE_MENU:String = "State:Main";
      
      public static const STATE_GAME:String = "State:Game";
      
      public static const SIGNAL_PLAY:String = "Event:Play";
      
      public static const SIGNAL_QUIT:String = "Event:Quit";
       
      
      private var mStateMachine:IAppStateMachine;
      
      public var game:GameState;
      
      private var m_App:Blitz3Replay;
      
      public function MainState(app:Blitz3Replay)
      {
         super();
         this.m_App = app;
         this.mStateMachine = new BaseAppStateMachine();
         this.game = new GameState(app);
         this.game.addEventListener(SIGNAL_QUIT,this.HandleQuit);
         this.mStateMachine.bindState(STATE_GAME,this.game);
         addChild(this.game);
      }
      
      public function Start() : void
      {
         this.mStateMachine.switchState(STATE_GAME);
      }
      
      public function update() : void
      {
         var state:IAppState = this.mStateMachine.getCurrentState();
         if(state != null)
         {
            state.update();
         }
      }
      
      public function draw(elapsed:int) : void
      {
         var state:IAppState = this.mStateMachine.getCurrentState();
         if(state != null)
         {
            state.draw(elapsed);
         }
      }
      
      public function onEnter() : void
      {
      }
      
      public function onExit() : void
      {
      }
      
      public function onKeyUp(keyCode:int) : void
      {
         var state:IAppState = this.mStateMachine.getCurrentState();
         if(state != null)
         {
            this.mStateMachine.getCurrentState().onKeyUp(keyCode);
         }
      }
      
      public function onKeyDown(keyCode:int) : void
      {
         var state:IAppState = this.mStateMachine.getCurrentState();
         if(state != null)
         {
            this.mStateMachine.getCurrentState().onKeyDown(keyCode);
         }
      }
      
      private function HandlePlay(e:Event) : void
      {
         this.mStateMachine.switchState(STATE_GAME);
      }
      
      private function HandleQuit(e:Event) : void
      {
         this.mStateMachine.switchState(STATE_MENU);
      }
   }
}
