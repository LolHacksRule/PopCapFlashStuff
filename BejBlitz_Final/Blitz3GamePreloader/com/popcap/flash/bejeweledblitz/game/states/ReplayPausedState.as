package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.framework.IAppState;
   import flash.display.Sprite;
   
   public class ReplayPausedState extends Sprite implements IAppState
   {
       
      
      private var _app:Blitz3Game;
      
      private var _mainWidget:MainWidgetGame;
      
      public function ReplayPausedState(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._mainWidget = this._app.ui as MainWidgetGame;
      }
      
      public function update() : void
      {
      }
      
      public function draw(param1:int) : void
      {
      }
      
      public function onEnter() : void
      {
         this._app.logic.Pause();
      }
      
      public function onExit() : void
      {
         this._app.logic.Resume();
      }
   }
}
