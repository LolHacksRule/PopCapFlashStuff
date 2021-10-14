package com.popcap.flash.bejeweledblitz.game.tournament.controllers
{
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.game.boostV2.BoostV2EventDispatcher;
   import com.popcap.flash.bejeweledblitz.game.session.ThrottleManager;
   import com.popcap.flash.bejeweledblitz.game.tournament.TournamentErrorMessageHandler;
   import com.popcap.flash.bejeweledblitz.game.tournament.configHandler.GetAllTournamentsTask;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.RuleSetData;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentCommonInfo;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentCost;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentDataManager;
   import com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity.TournamentRuntimeEntity;
   import com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity.UserEquippedState;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import flash.events.Event;
   
   public class TournamentController
   {
       
      
      private var _dataManager:TournamentDataManager;
      
      private var _runtimeEntityManager:TournamentRuntimeEntityManager;
      
      private var _fetchAllTournamentTask:GetAllTournamentsTask;
      
      private var _taskPending:Boolean;
      
      private var _app:Blitz3Game;
      
      private var _leaderboardController:TournamentLeaderboardController;
      
      private var _userTournamentsProgressManager:UserTournamentProgressManager = null;
      
      private var _currentTournamentId:String;
      
      private var _fetchStatus:int;
      
      private var _errorMessageHandler:TournamentErrorMessageHandler;
      
      private var _deductedCost:TournamentCost;
      
      private var _userEquippedState:UserEquippedState;
      
      private var _networkStatus:int;
      
      public function TournamentController(param1:Blitz3Game)
      {
         super();
         this._dataManager = new TournamentDataManager();
         this._runtimeEntityManager = new TournamentRuntimeEntityManager(param1);
         this._userTournamentsProgressManager = new UserTournamentProgressManager(param1);
         this._errorMessageHandler = new TournamentErrorMessageHandler(param1);
         this._leaderboardController = new TournamentLeaderboardController(param1);
         this._fetchAllTournamentTask = new GetAllTournamentsTask();
         this._taskPending = false;
         this._app = param1;
         this._fetchStatus = TournamentCommonInfo.TOUR_CATALOGUE_NOT_FETCHED;
         this._networkStatus = TournamentCommonInfo.NETWORK_ERROR_NONE;
         this._deductedCost = null;
         this._userEquippedState = new UserEquippedState();
         this._currentTournamentId = "";
      }
      
      public function addConfigFetchListener() : void
      {
         this._app.sessionData.boostV2Manager.boostEventDispatcher.addEventListener(BoostV2EventDispatcher.BOOST_CONFIG_FETCH_COMPLETE,this.Init);
      }
      
      public function get LeaderboardController() : TournamentLeaderboardController
      {
         return this._leaderboardController;
      }
      
      public function get DataManager() : TournamentDataManager
      {
         return this._dataManager;
      }
      
      public function get RuntimeEntityManger() : TournamentRuntimeEntityManager
      {
         return this._runtimeEntityManager;
      }
      
      public function get UserProgressManager() : UserTournamentProgressManager
      {
         return this._userTournamentsProgressManager;
      }
      
      public function get ErrorMessageHandler() : TournamentErrorMessageHandler
      {
         return this._errorMessageHandler;
      }
      
      public function Init(param1:Event) : void
      {
         if(this._app.sessionData.throttleManager.IsEnabled(ThrottleManager.THROTTLE_ENABLE_TOURNAMENT))
         {
            this.fetchConfig();
            this._userTournamentsProgressManager.Init();
            this._userEquippedState.addEventListenersForBoost();
         }
      }
      
      public function fetchConfig() : void
      {
         if(this._app.sessionData.throttleManager.IsEnabled(ThrottleManager.THROTTLE_ENABLE_TOURNAMENT))
         {
            this._taskPending = true;
            this._fetchStatus = TournamentCommonInfo.TOUR_CATALOGUE_FETCHING;
            this._fetchAllTournamentTask.setOnFinished(this.onFetchAllTournamentFinished);
            this._fetchAllTournamentTask.fetchConfig();
         }
      }
      
      private function onFetchAllTournamentFinished(param1:Boolean) : void
      {
         this._taskPending = false;
         this._userTournamentsProgressManager.refreshTimeDuration = this._dataManager.getProgressCallFrequency();
         if(param1)
         {
            this._userTournamentsProgressManager.FetchUserTournamentProgress();
            this._userTournamentsProgressManager.setOnComplete(this.onInitialProgressFetched);
         }
         else
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"Unable to parse all tournaments");
            this._fetchStatus = TournamentCommonInfo.TOUR_CATALOGUE_FETCH_FAILED;
         }
      }
      
      public function onInitialProgressFetched(param1:Boolean) : void
      {
         if(param1)
         {
            this._runtimeEntityManager.init(this._dataManager);
            this._fetchStatus = TournamentCommonInfo.TOUR_CATALOGUE_FETCHED;
            this._runtimeEntityManager.onUserProgressUpdated(param1);
            this._app.tournamentInfoView.Init();
         }
      }
      
      public function update(param1:int) : void
      {
         this._runtimeEntityManager.update(param1);
      }
      
      public function get TaskPending() : Boolean
      {
         return this._taskPending;
      }
      
      public function setCurrentTournamentId(param1:String) : void
      {
         this._currentTournamentId = param1;
      }
      
      public function getCurrentTournamentId() : String
      {
         return this._currentTournamentId;
      }
      
      public function IsAvailable() : Boolean
      {
         return this._fetchStatus == TournamentCommonInfo.TOUR_CATALOGUE_FETCHED;
      }
      
      public function get FetchStatus() : int
      {
         return this._fetchStatus;
      }
      
      public function set FetchStatus(param1:int) : void
      {
         this._fetchStatus = param1;
      }
      
      public function get NetworkStatus() : int
      {
         return this._networkStatus;
      }
      
      public function set NetworkStatus(param1:int) : void
      {
         this._networkStatus = param1;
      }
      
      public function getCurrentTournament() : TournamentRuntimeEntity
      {
         if(this._currentTournamentId != "")
         {
            return this._runtimeEntityManager.getTournamentById(this._currentTournamentId);
         }
         return null;
      }
      
      public function updateGameLogicParameters(param1:String = "") : Boolean
      {
         var _loc3_:RuleSetData = null;
         var _loc4_:int = 0;
         var _loc2_:TournamentRuntimeEntity = this.getCurrentTournament();
         if(param1 != "")
         {
            _loc2_ = this._runtimeEntityManager.getTournamentById(param1);
         }
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.Data.RuleSet;
            _loc4_ = _loc3_.GameDurationSeconds * 100;
            this._app.logic.configTournament.timerLogicBaseGameDuration = _loc4_;
            if(_loc3_.ColorIndexes.length > 0)
            {
               this._app.logic.configTournament.gemColors.splice(0,this._app.logic.config.gemColors.length);
               this._app.logic.configTournament.gemColors = _loc2_.Data.RuleSet.ColorIndexes;
            }
            if(_loc3_.BoardSeed != null)
            {
               this._app.logic.configTournament.startingGameBoardPattern = _loc2_.Data.RuleSet.BoardSeed;
            }
            this._app.logic.configTournament.blitzLogicBaseSpeed = 1.2;
            this._app.logic.configTournament.eternalBlazingSpeed = false;
            if(_loc3_.fastGemDropEnabled)
            {
               this._app.logic.configTournament.blitzLogicBaseSpeed = this._app.logic.configTournament.blitzLogicIncreasedSpeed;
            }
            if(_loc3_.EternalBlazingSpeedEnabled)
            {
               this._app.logic.configTournament.eternalBlazingSpeed = true;
               this._app.logic.configTournament.blitzLogicBaseSpeed += this._app.logic.configTournament.blazingSpeedLogicSpeedBonus;
               if(this._app.logic.configTournament.blitzLogicBaseSpeed > 2.4)
               {
                  this._app.logic.configTournament.blitzLogicBaseSpeed = 2.4;
               }
            }
            this._app.logic.SetConfig(BlitzLogic.TOURNAMENT_CONFIG);
            return true;
         }
         return false;
      }
      
      public function setRareGemForHarvestScreen() : void
      {
         var _loc1_:TournamentRuntimeEntity = this.getCurrentTournament();
         if(_loc1_ != null)
         {
            _loc1_.updateRareGemAndItsStreakPriceForHarvestScreen();
         }
      }
      
      public function HandleJoinRetryCost(param1:Boolean) : void
      {
         var _loc3_:CurrencyManager = null;
         var _loc2_:TournamentRuntimeEntity = this.getCurrentTournament();
         if(_loc2_ != null)
         {
            this._deductedCost = !!param1 ? _loc2_.Data.JoiningCost : _loc2_.Data.RetryCost;
            _loc3_ = this._app.sessionData.userData.currencyManager;
            _loc3_.AddCurrencyByType(-this._deductedCost.mAmount,this._deductedCost.mCurrencyType);
         }
      }
      
      public function ValidateJoinAndRetryCost(param1:Boolean) : Boolean
      {
         var _loc3_:CurrencyManager = null;
         var _loc2_:TournamentRuntimeEntity = this.getCurrentTournament();
         if(_loc2_ != null)
         {
            this._deductedCost = !!param1 ? _loc2_.Data.JoiningCost : _loc2_.Data.RetryCost;
            _loc3_ = this._app.sessionData.userData.currencyManager;
            return _loc3_.hasEnoughCurrency(this._deductedCost.mAmount,this._deductedCost.mCurrencyType);
         }
         return false;
      }
      
      public function ClearJoinRetryCost() : void
      {
         this._deductedCost = null;
      }
      
      public function RevertJoinRetryCost() : void
      {
         var _loc1_:CurrencyManager = null;
         if(this._deductedCost != null)
         {
            _loc1_ = this._app.sessionData.userData.currencyManager;
            _loc1_.AddCurrencyByType(this._deductedCost.mAmount,this._deductedCost.mCurrencyType);
         }
         this.ClearJoinRetryCost();
      }
      
      public function get userBoostAndRgEquippedState() : UserEquippedState
      {
         return this._userEquippedState;
      }
      
      public function onTournamentClicked() : void
      {
         if(this._dataManager.canShowExclamationTag)
         {
            this._app.network.setCookie("notifyTournament",1);
         }
         this._dataManager.canShowExclamationTag = false;
         this._dataManager.canShowNewTag = false;
      }
   }
}
