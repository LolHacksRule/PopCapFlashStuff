package com.popcap.flash.games.blitz3.game.states
{
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.games.blitz3.ui.Blitz3UI;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class GameResetState extends Sprite implements IAppState
   {
       
      
      private var mApp:Blitz3UI;
      
      public function GameResetState(app:Blitz3UI)
      {
         super();
         this.mApp = app;
      }
      
      public function update() : void
      {
         dispatchEvent(new Event(GameState.SIGNAL_GAME_START));
      }
      
      public function draw(elapsed:int) : void
      {
      }
      
      public function onEnter() : void
      {
         this.mApp.logic.Reset();
         this.mApp.ui.game.Reset();
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
      
      public function onMouseUp(x:Number, y:Number) : void
      {
      }
      
      public function onMouseDown(x:Number, y:Number) : void
      {
      }
      
      public function onMouseMove(x:Number, y:Number) : void
      {
      }
      
      public function onKeyUp(keyCode:int) : void
      {
      }
      
      public function onKeyDown(keyCode:int) : void
      {
      }
   }
}
