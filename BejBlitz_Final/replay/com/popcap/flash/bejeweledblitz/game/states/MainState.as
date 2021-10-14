package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.game.tutorial.ITutorialWatcherHandler;
   import com.popcap.flash.framework.BaseAppStateMachine;
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.framework.IAppStateMachine;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class MainState extends Sprite implements IAppState, ITutorialWatcherHandler
   {
      
      public static const STATE_MENU:String = "State:Main";
      
      public static const STATE_GAME:String = "State:Game";
      
      public static const STATE_PRE_GAME_MENU:String = "State:PreGameMenu";
      
      public static const SIGNAL_PLAY:String = "Event:Play";
      
      public static const SIGNAL_PLAY_TUTORIAL:String = "Event:PlayTutorial";
      
      public static const SIGNAL_QUIT:String = "Event:Quit";
      
      public static const SIGNAL_LEAVE_MAIN_MENU:String = "Event:LeaveMainMenu";
       
      
      private var mStateMachine:IAppStateMachine;
      
      public var menu:MenuState;
      
      public var game:GameState;
      
      public var preGameMenu:PreGameMenuState;
      
      private var m_App:Blitz3Game;
      
      public function MainState(app:Blitz3Game)
      {
         super();
         this.m_App = app;
         this.mStateMachine = new BaseAppStateMachine();
         this.menu = new MenuState(app);
         this.game = new GameState(app);
         this.preGameMenu = new PreGameMenuState(app);
         this.menu.addEventListener(SIGNAL_LEAVE_MAIN_MENU,this.HandleLeaveMainMenu);
         this.menu.addEventListener(SIGNAL_PLAY_TUTORIAL,this.HandlePlayTutorial);
         this.game.addEventListener(SIGNAL_QUIT,this.HandleQuit);
         this.preGameMenu.addEventListener(SIGNAL_PLAY,this.HandlePlay);
         this.mStateMachine.bindState(STATE_MENU,this.menu);
         this.mStateMachine.bindState(STATE_GAME,this.game);
         this.mStateMachine.bindState(STATE_PRE_GAME_MENU,this.preGameMenu);
         addChild(this.game);
         this.m_App.tutorial.AddHandler(this);
      }
      
      public function StartFromAbort() : void
      {
         this.mStateMachine.switchState(STATE_PRE_GAME_MENU);
      }
      
      public function update() : void
      {
         this.mStateMachine.getCurrentState().update();
         if(this.m_App.navigation)
         {
            this.m_App.navigation.Update();
         }
      }
      
      public function draw(elapsed:int) : void
      {
         this.mStateMachine.getCurrentState().draw(elapsed);
      }
      
      public function onEnter() : void
      {
         this.mStateMachine.switchState(STATE_MENU);
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
      
      public function HandleTutorialComplete(wasSkipped:Boolean) : void
      {
         this.m_App.navigation.Reset();
      }
      
      public function HandleTutorialRestarted() : void
      {
         this.mStateMachine.switchState(STATE_GAME);
      }
      
      private function HandlePlay(e:Event) : void
      {
         this.mStateMachine.switchState(STATE_GAME);
      }
      
      private function HandlePlayTutorial(e:Event) : void
      {
         this.mStateMachine.switchState(STATE_GAME);
      }
      
      private function HandleQuit(e:Event) : void
      {
         this.mStateMachine.switchState(STATE_PRE_GAME_MENU);
      }
      
      private function HandleLeaveMainMenu(e:Event) : void
      {
         this.mStateMachine.switchState(STATE_PRE_GAME_MENU);
      }
   }
}
