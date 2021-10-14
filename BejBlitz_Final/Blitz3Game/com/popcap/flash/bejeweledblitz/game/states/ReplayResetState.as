package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.IAppState;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class ReplayResetState extends Sprite implements IAppState
   {
       
      
      private var _mainWidget:MainWidgetGame;
      
      private var _app:Blitz3App;
      
      public function ReplayResetState(param1:Blitz3App)
      {
         super();
         this._app = param1;
         this._mainWidget = this._app.ui as MainWidgetGame;
      }
      
      public function update() : void
      {
         dispatchEvent(new Event(ReplayState.SIGNAL_REPLAY_START));
      }
      
      public function draw(param1:int) : void
      {
      }
      
      public function onEnter() : void
      {
         var _loc1_:String = this._app.sessionData.replayManager.tournamentId;
         if(_loc1_ != "")
         {
            this._app.sessionData.tournamentController.updateGameLogicParameters(_loc1_);
         }
         else
         {
            this._app.logic.SetConfig(BlitzLogic.DEFAULT_CONFIG);
         }
         this._app.logic.timerLogic.Reset();
         this._app.logic.QueueConfigCommands(true);
         this._app.sessionData.userData.currencyManager.AnimArrayReset();
         this._mainWidget.game.reset();
         this._mainWidget.game.ShowInReplayMode();
      }
      
      public function onExit() : void
      {
      }
   }
}
