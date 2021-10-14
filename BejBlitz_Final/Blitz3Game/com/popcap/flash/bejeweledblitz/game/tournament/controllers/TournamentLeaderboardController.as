package com.popcap.flash.bejeweledblitz.game.tournament.controllers
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.tournament.configHandler.GetTournamentLeaderboardTask;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentCommonInfo;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentLeaderboardData;
   import com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity.ITournamentEvent;
   import com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity.TournamentRuntimeEntity;
   
   public class TournamentLeaderboardController implements ITournamentEvent
   {
       
      
      private var _leaderboardList:Vector.<TournamentLeaderboardData>;
      
      private var _app:Blitz3App;
      
      private var _fetchLeaderboardTask:GetTournamentLeaderboardTask;
      
      private var _tournament:TournamentRuntimeEntity;
      
      private var _onFinished:Function;
      
      public function TournamentLeaderboardController(param1:Blitz3Game)
      {
         super();
         this._leaderboardList = new Vector.<TournamentLeaderboardData>();
         this._app = param1;
         this._fetchLeaderboardTask = new GetTournamentLeaderboardTask();
         this._tournament = null;
         this._onFinished = null;
      }
      
      public function setOnFinished(param1:Function) : void
      {
         this._fetchLeaderboardTask.setOnFinished(param1);
      }
      
      public function getLeaderboard(param1:String) : TournamentLeaderboardData
      {
         var _loc2_:TournamentLeaderboardData = this.getData(param1);
         if(_loc2_ == null)
         {
            _loc2_ = new TournamentLeaderboardData(param1);
            this._leaderboardList.push(_loc2_);
         }
         return _loc2_;
      }
      
      public function fetchLeaderboard(param1:TournamentRuntimeEntity) : void
      {
         var _loc2_:String = null;
         if(param1 != null)
         {
            this._tournament = param1;
            _loc2_ = this._tournament.Data.Id;
            this._fetchLeaderboardTask.fetchConfig(this._app.sessionData.userData.GetFUID(),_loc2_);
            this._tournament.addEventListener(this);
         }
      }
      
      public function onStatusChanged(param1:int, param2:int) : void
      {
         var _loc3_:String = null;
         if(param2 == TournamentCommonInfo.TOUR_STATUS_ENDED)
         {
            _loc3_ = this._tournament.Data.Id;
            this._fetchLeaderboardTask.fetchConfig(this._app.sessionData.userData.GetFUID(),_loc3_);
         }
      }
      
      public function onRankChanged(param1:int, param2:int) : void
      {
      }
      
      public function reset() : void
      {
         if(this._tournament != null)
         {
            this._tournament.removeEventListener(this);
         }
      }
      
      public function getAllData() : Vector.<TournamentLeaderboardData>
      {
         return this._leaderboardList;
      }
      
      public function getData(param1:String) : TournamentLeaderboardData
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._leaderboardList.length)
         {
            if(this._leaderboardList[_loc2_].TournamentId == param1)
            {
               return this._leaderboardList[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
   }
}
