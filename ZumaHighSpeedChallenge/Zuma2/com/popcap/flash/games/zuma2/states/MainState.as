package com.popcap.flash.games.zuma2.states
{
   import com.popcap.flash.framework.BaseAppStateMachine;
   import com.popcap.flash.framework.IAppState;
   import flash.display.Sprite;
   
   public class MainState extends Sprite implements IAppState
   {
      
      public static const STATE_TITLE_SCREEN:String = "TitleScreen";
      
      public static const STATE_LEVEL_INTRO:String = "LevelIntro";
      
      public static const STATE_MAIN_MENU:String = "MainMenu";
      
      public static const STATE_LOADING:String = "Loading";
      
      public static const STATE_PLAY_LEVEL:String = "PlayLevel";
       
      
      private var mStateMachine:BaseAppStateMachine;
      
      private var mPlayState:PlayLevelState;
      
      private var mApp:Zuma2App;
      
      public function MainState(param1:Zuma2App)
      {
         super();
         this.mApp = param1;
         this.mPlayState = new PlayLevelState(param1);
         this.mStateMachine = new BaseAppStateMachine();
      }
      
      public function onMouseUp(param1:Number, param2:Number) : void
      {
         this.mApp.widgets.onMouseUp(param1,param2);
      }
      
      public function draw(param1:int) : void
      {
         this.mApp.widgets.draw(this.mApp.canvas);
      }
      
      public function onMouseDown(param1:Number, param2:Number) : void
      {
         this.mApp.widgets.onMouseDown(param1,param2);
      }
      
      public function onEnter() : void
      {
      }
      
      public function update() : void
      {
         this.mApp.widgets.update();
      }
      
      public function onKeyDown(param1:int) : void
      {
         this.mApp.widgets.onKeyDown(param1);
      }
      
      public function onExit() : void
      {
      }
      
      public function onPush() : void
      {
      }
      
      public function onPop() : void
      {
      }
      
      public function onKeyUp(param1:int) : void
      {
         this.mApp.widgets.onKeyUp(param1);
      }
      
      public function onMouseMove(param1:Number, param2:Number) : void
      {
         this.mApp.widgets.onMouseMove(param1,param2);
      }
   }
}
