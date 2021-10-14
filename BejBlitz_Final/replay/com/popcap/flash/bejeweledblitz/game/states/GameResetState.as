package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.IAppState;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class GameResetState extends Sprite implements IAppState
   {
       
      
      private var m_App:Blitz3App;
      
      public function GameResetState(app:Blitz3App)
      {
         super();
         this.m_App = app;
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
         this.m_App.logic.Reset(new Date().time);
         this.m_App.ui.background.Reset();
         this.m_App.ui.game.Reset();
      }
      
      public function onExit() : void
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
