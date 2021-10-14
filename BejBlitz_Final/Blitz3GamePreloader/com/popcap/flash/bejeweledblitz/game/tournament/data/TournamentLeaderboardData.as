package com.popcap.flash.bejeweledblitz.game.tournament.data
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.leaderboard.BlitzChampionshipData;
   import com.popcap.flash.bejeweledblitz.leaderboard.PlayerData;
   
   public class TournamentLeaderboardData
   {
       
      
      private var _userList:Vector.<PlayerData>;
      
      private var _lastRefreshTime:Number;
      
      private var _lastFetchedTournamentStatus:int;
      
      private var _tournamentId:String;
      
      private var _status:int;
      
      private var _lastScorePostStatus:int;
      
      private var _lastScorePostStatusReason:String;
      
      private var _autoUpdate:Boolean;
      
      private var _onUserListUpdated:Function;
      
      public function TournamentLeaderboardData(param1:String)
      {
         super();
         this._userList = new Vector.<PlayerData>();
         this._tournamentId = param1;
         this._lastRefreshTime = 0;
         this._lastFetchedTournamentStatus = TournamentCommonInfo.TOUR_STATUS_RUNNING;
         this._status = TournamentCommonInfo.TOUR_LEADERBOARD_STATUS_NOT_AVAILABLE;
         this._lastScorePostStatus = TournamentCommonInfo.LAST_SCORE_SERVER_STATUS_ACCEPTED;
         this._autoUpdate = false;
         this._lastScorePostStatusReason = "";
      }
      
      public function setOnUserListChanged(param1:Function) : void
      {
         this._onUserListUpdated = param1;
      }
      
      public function Clear() : void
      {
         this._status = TournamentCommonInfo.TOUR_LEADERBOARD_STATUS_NOT_AVAILABLE;
         var _loc1_:int = this._userList.length - 1;
         while(_loc1_ > 0)
         {
            delete this._userList[_loc1_];
            _loc1_--;
         }
         this._userList.splice(0,this._userList.length);
      }
      
      public function SetInfo(param1:Object) : void
      {
         var _loc4_:PlayerData = null;
         this.Clear();
         var _loc2_:int = 0;
         var _loc3_:Array = Utils.getArrayFromObjectKey(param1,"leaderboard");
         if(_loc3_ != null)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc3_.length)
            {
               (_loc4_ = new PlayerData(Blitz3App.app)).parseTournamentJSON(_loc3_[_loc2_],this._tournamentId);
               this._userList.push(_loc4_);
               _loc2_++;
            }
         }
         this._userList.sort(this.SortUserList);
         _loc2_ = 0;
         while(_loc2_ < this._userList.length)
         {
            this._userList[_loc2_].rank = _loc2_ + 1;
            _loc2_++;
         }
         if(this._onUserListUpdated != null)
         {
            this._onUserListUpdated();
         }
         this._status = TournamentCommonInfo.TOUR_LEADERBOARD_STATUS_AVAILABLE;
      }
      
      public function SortUserList(param1:PlayerData, param2:PlayerData) : int
      {
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:int = 0;
         var _loc3_:BlitzChampionshipData = param1.currentChampionshipData;
         var _loc4_:BlitzChampionshipData = param2.currentChampionshipData;
         var _loc5_:Number = _loc3_.score;
         var _loc6_:Number = _loc4_.score;
         if(_loc5_ == _loc6_)
         {
            _loc5_ = _loc3_.secondary_score;
            _loc6_ = _loc4_.secondary_score;
            _loc3_.isTie = true;
            _loc4_.isTie = true;
            if(_loc5_ == _loc6_)
            {
               _loc7_ = param1.playerFuid;
               _loc8_ = param2.playerFuid;
               _loc9_ = 1;
               if(_loc7_.indexOf("S") >= 0 || _loc8_.indexOf("S") >= 0)
               {
                  _loc9_ = -1;
               }
               if(_loc7_ > _loc8_)
               {
                  return _loc9_ * -1;
               }
               if(_loc7_ < _loc8_)
               {
                  return _loc9_ * 1;
               }
            }
         }
         if(_loc5_ > _loc6_)
         {
            return -1;
         }
         if(_loc5_ < _loc6_)
         {
            return 1;
         }
         return 0;
      }
      
      public function get TournamentId() : String
      {
         return this._tournamentId;
      }
      
      public function get UserList() : Vector.<PlayerData>
      {
         return this._userList;
      }
      
      public function get CurrentUser() : PlayerData
      {
         var _loc1_:String = Blitz3App.app.sessionData.userData.GetFUID();
         var _loc2_:int = 0;
         while(_loc2_ < this._userList.length)
         {
            if(this._userList[_loc2_].playerFuid == _loc1_)
            {
               return this._userList[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getCurrentPlayerIndex() : int
      {
         var _loc1_:String = Blitz3App.app.sessionData.userData.GetFUID();
         var _loc2_:int = 0;
         while(_loc2_ < this._userList.length)
         {
            if(this._userList[_loc2_].playerFuid == _loc1_)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function getPlayerByRank(param1:int) : PlayerData
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._userList.length)
         {
            if(this._userList[_loc2_].rank == param1)
            {
               return this._userList[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
   }
}
