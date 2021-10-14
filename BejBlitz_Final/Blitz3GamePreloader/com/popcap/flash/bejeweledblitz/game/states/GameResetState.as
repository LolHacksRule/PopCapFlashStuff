package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.framework.IAppState;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class GameResetState extends Sprite implements IAppState
   {
       
      
      private var _app:Blitz3App;
      
      public function GameResetState(param1:Blitz3App)
      {
         super();
         this._app = param1;
      }
      
      public function update() : void
      {
         dispatchEvent(new Event(GameState.SIGNAL_GAME_START));
      }
      
      public function draw(param1:int) : void
      {
      }
      
      public function onEnter() : void
      {
         this._app.logic.ResetMoveObjectPools();
         this._app.logic.QueueConfigCommands(false);
         this._app.sessionData.userData.currencyManager.AnimArrayReset();
         (this._app.ui as MainWidgetGame).game.reset();
      }
      
      public function onExit() : void
      {
      }
   }
}
