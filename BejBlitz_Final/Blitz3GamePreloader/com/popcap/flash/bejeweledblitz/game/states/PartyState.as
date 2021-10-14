package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.framework.IAppState;
   import flash.events.EventDispatcher;
   
   public class PartyState extends EventDispatcher implements IAppState
   {
       
      
      private var _app:Blitz3Game;
      
      private var _showPartyID:String = "";
      
      public function PartyState(param1:Blitz3Game)
      {
         super();
         this._app = param1;
      }
      
      public function update() : void
      {
         this._app.metaUI.Update();
         (this._app.ui as MainWidgetGame).game.dailyChallengeLeaderboardAndQuestsCoverView.UpdateScore(this._app.logic.GetScoreKeeper().GetScore());
      }
      
      public function draw(param1:int) : void
      {
      }
      
      public function setShowPartyID(param1:String) : void
      {
         this._showPartyID = param1;
      }
      
      public function onEnter() : void
      {
         this._app.party.showMe(this._showPartyID);
         this._showPartyID = "";
      }
      
      public function onExit() : void
      {
      }
      
      public function returnToMain() : Boolean
      {
         this._showPartyID = "";
         if(this._app.party.visible)
         {
            return this._app.party.returnToMain();
         }
         return false;
      }
   }
}
