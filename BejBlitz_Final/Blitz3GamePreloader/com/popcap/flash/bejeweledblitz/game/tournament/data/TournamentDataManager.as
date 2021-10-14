package com.popcap.flash.bejeweledblitz.game.tournament.data
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.tournament.configHandler.GetAllTournamentsTask;
   
   public class TournamentDataManager
   {
       
      
      private var _allData:Vector.<SearchableTournamentData>;
      
      private var _fetchAllDataTask:GetAllTournamentsTask;
      
      private var _fetchStatus:int;
      
      private var _validityDuration:int;
      
      private var _gracePeriod:int;
      
      private var _updateCallFrequency:int;
      
      private var _canShowNewTag:Boolean;
      
      private var _canShowExclamationTag:Boolean;
      
      public function TournamentDataManager()
      {
         super();
         this._allData = new Vector.<SearchableTournamentData>();
         this._fetchAllDataTask = new GetAllTournamentsTask();
         this._fetchStatus = TournamentCommonInfo.TOUR_CATALOGUE_NOT_FETCHED;
         this._canShowNewTag = false;
         this._canShowExclamationTag = false;
      }
      
      public function clear() : void
      {
         var _loc1_:int = this._allData.length - 1;
         while(_loc1_ > 0)
         {
            delete this._allData[_loc1_];
            _loc1_--;
         }
         this._allData.splice(0,this._allData.length);
      }
      
      public function parseJSON(param1:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:SearchableTournamentData = null;
         this.clear();
         this._canShowNewTag = Utils.getBoolFromObjectKey(param1,"canvasNewTag",false);
         this._canShowExclamationTag = !!this._canShowNewTag ? false : Boolean(Blitz3App.app.network.isCookieExpired("notifyTournament"));
         this._validityDuration = Utils.getIntFromObjectKey(param1,"tournamentExpiry",604800);
         this._gracePeriod = Utils.getIntFromObjectKey(param1,"tournamentEndGracePeriod",10);
         this._updateCallFrequency = Utils.getIntFromObjectKey(param1,"tournamentProgressCallFrequency",10);
         var _loc2_:Array = Utils.getArrayFromObjectKey(param1,"tournaments");
         if(_loc2_ != null)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               (_loc4_ = new SearchableTournamentData())._tournamentInfo.setData(_loc2_[_loc3_]);
               _loc4_._id = _loc4_._tournamentInfo.Id;
               if(_loc4_._tournamentInfo.ValidateData())
               {
                  this._allData.push(_loc4_);
               }
               else
               {
                  ErrorReporting.sendError(ErrorReporting.ERROR_LEVEL_INFO,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"Invalid config. Tournament Id: " + _loc4_._id + " Reason: " + _loc4_._tournamentInfo.invalidReason);
               }
               _loc3_++;
            }
         }
         this._fetchStatus = TournamentCommonInfo.TOUR_CATALOGUE_FETCHED;
      }
      
      public function get AllData() : Vector.<SearchableTournamentData>
      {
         return this._allData;
      }
      
      public function IsAvailable() : Boolean
      {
         return this._fetchStatus == TournamentCommonInfo.TOUR_CATALOGUE_FETCHED;
      }
      
      public function getValidityDuration() : int
      {
         return this._validityDuration;
      }
      
      public function getCoolDownPeriod() : int
      {
         return this._gracePeriod;
      }
      
      public function getProgressCallFrequency() : int
      {
         return this._updateCallFrequency;
      }
      
      public function getTournamentInfoById(param1:String) : TournamentConfigData
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._allData.length)
         {
            if(this._allData[_loc2_]._id == param1)
            {
               return this._allData[_loc2_]._tournamentInfo;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getTournamentInfoByIndex(param1:int) : TournamentConfigData
      {
         return this._allData[param1]._tournamentInfo;
      }
      
      public function get FetchStatus() : int
      {
         return this._fetchStatus;
      }
      
      public function set FetchStatus(param1:int) : void
      {
         this._fetchStatus = param1;
      }
      
      public function get canShowNewTag() : Boolean
      {
         return this._canShowNewTag;
      }
      
      public function get canShowExclamationTag() : Boolean
      {
         return this._canShowExclamationTag;
      }
      
      public function set canShowExclamationTag(param1:Boolean) : void
      {
         this._canShowExclamationTag = param1;
      }
      
      public function set canShowNewTag(param1:Boolean) : void
      {
         this._canShowNewTag = param1;
      }
   }
}
