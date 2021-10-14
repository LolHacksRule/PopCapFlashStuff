package com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.session.raregem.RareGemManager;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentCommonInfo;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentConfigData;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentDataManager;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentRGCriterion;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentRewardTierInfo;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.UserTournamentProgress;
   
   public class TournamentRuntimeEntity
   {
       
      
      private var _id:String;
      
      private var _data:TournamentConfigData;
      
      private var _status:int;
      
      private var _previousStatus:int;
      
      private var _isDirty:Boolean;
      
      private var _remainingTime:Number;
      
      private var _expectedCoolDownPeriod:Number;
      
      private var _randomSeed:Number;
      
      private var _app:Blitz3Game;
      
      private var _onStatusChangeEvents:Vector.<ITournamentEvent>;
      
      private var _userUpdateFetched:Boolean;
      
      private var _serverValidateEndState:Boolean;
      
      private var _sortKey:int;
      
      private var _prevRank:int;
      
      public function TournamentRuntimeEntity(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._data = null;
         this._isDirty = false;
         this._previousStatus = this._status = TournamentCommonInfo.TOUR_STATUS_NOT_STARTED;
         this._onStatusChangeEvents = new Vector.<ITournamentEvent>();
         this._userUpdateFetched = false;
         this._serverValidateEndState = false;
         this.sortKey = 0;
         this._prevRank = 0;
      }
      
      private function updateStatus() : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc1_:Date = new Date();
         var _loc2_:Number = _loc1_.getTime().valueOf() / 1000;
         this._remainingTime = this._data.EndTime - _loc2_;
         if(this._remainingTime < 0)
         {
            this._remainingTime = 0;
         }
         if(this._remainingTime > 0)
         {
            this._status = TournamentCommonInfo.TOUR_STATUS_RUNNING;
         }
         else if(this.IsComputingResults())
         {
            this._status = TournamentCommonInfo.TOUR_STATUS_COMPUTING_RESULTS;
         }
         else if(!this.HasExpired())
         {
            this._status = TournamentCommonInfo.TOUR_STATUS_ENDED;
            if(!this._userUpdateFetched && this._previousStatus == TournamentCommonInfo.TOUR_STATUS_COMPUTING_RESULTS)
            {
               this._serverValidateEndState = false;
               this._userUpdateFetched = true;
               this._app.sessionData.tournamentController.UserProgressManager.FetchUserTournamentProgress();
            }
         }
         else
         {
            this._status = TournamentCommonInfo.TOUR_STATUS_EXPIRED;
         }
         if(this._previousStatus != this._status)
         {
            if(!(_loc4_ = false) && this._status == TournamentCommonInfo.TOUR_STATUS_ENDED && this._previousStatus == TournamentCommonInfo.TOUR_STATUS_COMPUTING_RESULTS)
            {
               _loc4_ = true;
               this._app.network.syncBoostLevels();
            }
            _loc5_ = this._onStatusChangeEvents.length;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               this._onStatusChangeEvents[_loc6_].onStatusChanged(this._previousStatus,this._status);
               _loc6_++;
            }
            this._previousStatus = this._status;
         }
         var _loc3_:UserTournamentProgress = this._app.sessionData.tournamentController.UserProgressManager.getUserProgress(this.Data.Id);
         if(_loc3_ != null)
         {
            _loc7_ = _loc3_.getUserRank();
            if(this._prevRank != _loc7_)
            {
               _loc5_ = this._onStatusChangeEvents.length;
               _loc8_ = 0;
               while(_loc8_ < _loc5_)
               {
                  this._onStatusChangeEvents[_loc8_].onRankChanged(this._prevRank,_loc7_);
                  _loc8_++;
               }
               this._prevRank = _loc7_;
            }
         }
      }
      
      public function getExpectedResultsAvailableTime() : Number
      {
         var _loc1_:Number = this._data.EndTime + this._randomSeed;
         var _loc2_:TournamentDataManager = this._app.sessionData.tournamentController.DataManager;
         if(this._expectedCoolDownPeriod > 0)
         {
            _loc1_ = this._data.EndTime + this._expectedCoolDownPeriod;
         }
         else if(this._data.RuleSet != null)
         {
            _loc1_ = this._data.EndTime + this._data.RuleSet.GameDurationSeconds + _loc2_.getCoolDownPeriod() + this._randomSeed;
         }
         return _loc1_;
      }
      
      private function setExpectedCoolDownPeriod(param1:int) : void
      {
         var _loc2_:Date = new Date();
         var _loc3_:Number = _loc2_.getTime().valueOf() / 1000;
         this._expectedCoolDownPeriod = _loc3_ - this._data.EndTime + param1 + this._randomSeed;
         if(this._expectedCoolDownPeriod < 0)
         {
            this._expectedCoolDownPeriod = 0;
         }
      }
      
      public function getExpectedCoolDownPeriod() : Number
      {
         if(this._expectedCoolDownPeriod == 0)
         {
            if(this._data.RuleSet != null)
            {
               this._expectedCoolDownPeriod = this._data.RuleSet.GameDurationSeconds + this._app.sessionData.tournamentController.DataManager.getCoolDownPeriod() + this._randomSeed;
            }
         }
         return this._expectedCoolDownPeriod;
      }
      
      public function addEventListener(param1:ITournamentEvent) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = this._onStatusChangeEvents.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(this._onStatusChangeEvents[_loc4_] == param1)
            {
               _loc2_ = true;
               break;
            }
            _loc4_++;
         }
         if(!_loc2_)
         {
            this._onStatusChangeEvents.push(param1);
         }
      }
      
      public function removeEventListener(param1:ITournamentEvent) : void
      {
      }
      
      public function get Data() : TournamentConfigData
      {
         return this._data;
      }
      
      public function set Data(param1:TournamentConfigData) : void
      {
         this._data = param1;
         this._id = this._data.Id;
         this._isDirty = true;
         this._expectedCoolDownPeriod = 0;
         this._randomSeed = Utils.randomRange(0,30);
      }
      
      public function get Id() : String
      {
         return this._id;
      }
      
      public function get Status() : int
      {
         return this._status;
      }
      
      public function get IsDirty() : Boolean
      {
         return this._isDirty;
      }
      
      public function set IsDirty(param1:Boolean) : void
      {
         this._isDirty = param1;
      }
      
      public function get RemainingTime() : Number
      {
         return this._remainingTime;
      }
      
      public function IsRunning() : Boolean
      {
         return this._status <= TournamentCommonInfo.TOUR_STATUS_RUNNING;
      }
      
      public function HasEndedWithResult() : Boolean
      {
         return this._status > TournamentCommonInfo.TOUR_STATUS_COMPUTING_RESULTS;
      }
      
      public function IsUserEligibleForReward() : Boolean
      {
         var _loc5_:int = 0;
         var _loc6_:Boolean = false;
         var _loc1_:Boolean = this.HasExpired();
         var _loc2_:Boolean = this.HasEnded();
         var _loc3_:Boolean = false;
         var _loc4_:UserTournamentProgress;
         if((_loc4_ = this._app.sessionData.tournamentController.UserProgressManager.getUserProgress(this.Data.Id)) != null)
         {
            _loc5_ = _loc4_.getUserRank();
            if(_loc6_ = this.Data.rankHasReward(_loc5_))
            {
               _loc3_ = true;
            }
            return _loc2_ && _loc3_ && !_loc1_;
         }
         return false;
      }
      
      public function HasEnded() : Boolean
      {
         return this._status == TournamentCommonInfo.TOUR_STATUS_ENDED;
      }
      
      public function IsComputingResults() : Boolean
      {
         var _loc1_:Date = new Date();
         var _loc2_:int = _loc1_.getTime().valueOf() / 1000;
         var _loc3_:Number = this.getExpectedResultsAvailableTime();
         return this._data.EndTime <= _loc2_ && _loc2_ <= _loc3_;
      }
      
      public function HasExpired() : Boolean
      {
         var _loc1_:Date = new Date();
         var _loc2_:Number = _loc1_.getTime().valueOf() / 1000;
         return this._data.EndTime + this._app.sessionData.tournamentController.DataManager.getValidityDuration() < _loc2_;
      }
      
      public function update(param1:int) : void
      {
         this.updateStatus();
      }
      
      public function shouldShowInHistoryPanel() : Boolean
      {
         if(this.HasExpired())
         {
            return false;
         }
         var _loc1_:UserTournamentProgress = this._app.sessionData.tournamentController.UserProgressManager.getUserProgress(this._data.Id);
         if(_loc1_ == null || this._status <= TournamentCommonInfo.TOUR_STATUS_COMPUTING_RESULTS)
         {
            return false;
         }
         var _loc2_:Boolean = false;
         var _loc3_:int = _loc1_.getUserRank();
         var _loc4_:Boolean;
         if(_loc4_ = this._data.rankHasReward(_loc3_))
         {
            _loc2_ = true;
         }
         return _loc1_.hasClaimed || !_loc2_;
      }
      
      public function updateRareGemAndItsStreakPriceForHarvestScreen() : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc7_:int = 0;
         var _loc1_:TournamentRGCriterion = this._data.TourCriteria.RgCriterion;
         var _loc2_:RareGemManager = this._app.sessionData.rareGemManager;
         if(_loc1_ != null)
         {
            if(_loc1_.State == TournamentCommonInfo.TOUR_RG_CRITERION_ANY_RG || _loc1_.State == TournamentCommonInfo.TOUR_RG_CRITERION_DOES_NOT_MATTER)
            {
               if(!_loc1_.ShouldUpsellDefaultRareGem)
               {
                  _loc3_ = _loc2_.GetCurrentOffer().GetID();
                  _loc4_ = 0;
                  _loc5_ = false;
                  _loc6_ = false;
                  _loc7_ = -1;
                  if(_loc3_ == _loc1_.PreferredRg)
                  {
                     _loc4_ = _loc2_.GetStreakNum();
                     _loc5_ = _loc2_.isFree;
                     _loc6_ = _loc2_.isDiscounted;
                  }
                  _loc2_.ForceOffer(_loc1_.PreferredRg,_loc7_,_loc4_,_loc6_,_loc5_);
               }
            }
            else if(_loc1_.State == TournamentCommonInfo.TOUR_RG_CRITERION_NO_RG)
            {
               this._app.sessionData.rareGemManager.GetCurrentOffer().Consume();
               this._app.network.dispatchNavigateToBoostScreen();
            }
            else if(_loc1_.State == TournamentCommonInfo.TOUR_RG_CRITERION_SPECIFIC_RG)
            {
               _loc3_ = _loc2_.GetCurrentOffer().GetID();
               _loc4_ = 0;
               _loc5_ = false;
               _loc6_ = false;
               _loc7_ = -1;
               if(_loc3_ == _loc1_.PreferredRg)
               {
                  _loc4_ = _loc2_.GetStreakNum();
                  _loc5_ = _loc2_.isFree;
                  _loc6_ = _loc2_.isDiscounted;
               }
               _loc2_.ForceOffer(_loc1_.PreferredRg,_loc7_,_loc4_,_loc6_,_loc5_);
            }
         }
      }
      
      public function onUserFetchCompleted(param1:UserTournamentProgress) : void
      {
         if(param1.getTimeRemainingForNextState() <= 0)
         {
            this._serverValidateEndState = true;
         }
         var _loc2_:int = this._onStatusChangeEvents.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this._onStatusChangeEvents[_loc3_].onStatusChanged(this._previousStatus,this._status);
            _loc3_++;
         }
      }
      
      public function get serverHasValidatedEndState() : Boolean
      {
         return this._serverValidateEndState;
      }
      
      public function rankBelongsToRewardTier(param1:int) : int
      {
         var _loc6_:TournamentRewardTierInfo = null;
         var _loc2_:int = -1;
         var _loc3_:Vector.<TournamentRewardTierInfo> = this._data.tournamentRewards;
         var _loc4_:int = _loc3_.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = _loc3_[_loc5_];
            if(param1 >= _loc6_.minRank && param1 <= _loc6_.maxRank)
            {
               _loc2_ = _loc5_ + 1;
               break;
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      public function get sortKey() : int
      {
         return this._sortKey;
      }
      
      public function set sortKey(param1:int) : void
      {
         this._sortKey = param1;
      }
   }
}
