package com.popcap.flash.bejeweledblitz.game.tournament.data
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   
   public class UserTournamentProgress
   {
       
      
      private var _tournamentID:String;
      
      private var _rank:int;
      
      private var _hasClaimed:Boolean;
      
      private var _state:String;
      
      private var _expectedDuration:int;
      
      public function UserTournamentProgress()
      {
         super();
         this._tournamentID = "";
         this._rank = -1;
         this._hasClaimed = false;
         this._state = "";
         this._expectedDuration = 0;
      }
      
      public function setInfo(param1:Object) : void
      {
         var config:Object = param1;
         try
         {
            this._tournamentID = Utils.getStringFromObjectKey(config,"id","");
            this._rank = Utils.getIntFromObjectKey(config,"standing",0);
            this._hasClaimed = Utils.getBoolFromObjectKey(config,"claimed",false);
            this._state = Utils.getStringFromObjectKey(config,"status","");
            this._expectedDuration = Utils.getIntFromObjectKey(config,"expectedDuration",0);
         }
         catch(e:Error)
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"Could not parse progress of Tournament ID : " + _tournamentID);
         }
      }
      
      public function getTournamentId() : String
      {
         return this._tournamentID;
      }
      
      public function getUserRank() : int
      {
         return this._rank;
      }
      
      public function getState() : String
      {
         return this._state;
      }
      
      public function get hasClaimed() : Boolean
      {
         return this._hasClaimed;
      }
      
      public function set hasClaimed(param1:Boolean) : void
      {
         this._hasClaimed = param1;
      }
      
      public function getTimeRemainingForNextState() : int
      {
         return this._expectedDuration;
      }
   }
}
