package com.popcap.flash.games.zuma2.states
{
   import com.popcap.flash.framework.BaseAppStateMachine;
   import com.popcap.flash.framework.IAppState;
   import flash.display.Sprite;
   
   public class PlayLevelState extends Sprite implements IAppState
   {
       
      
      private var mStateMachine:BaseAppStateMachine;
      
      private var mApp:Zuma2App;
      
      public function PlayLevelState(param1:Zuma2App)
      {
         super();
         this.mApp = param1;
         this.mStateMachine = new BaseAppStateMachine();
      }
      
      public function onEnter() : void
      {
      }
      
      public function onMouseUp(param1:Number, param2:Number) : void
      {
      }
      
      public function draw(param1:int) : void
      {
      }
      
      public function onMouseDown(param1:Number, param2:Number) : void
      {
      }
      
      public function onPop() : void
      {
      }
      
      public function update() : void
      {
      }
      
      public function onKeyDown(param1:int) : void
      {
      }
      
      public function onPush() : void
      {
      }
      
      public function onExit() : void
      {
      }
      
      public function onKeyUp(param1:int) : void
      {
      }
      
      public function onMouseMove(param1:Number, param2:Number) : void
      {
      }
   }
}
