package com.popcap.flash.bejeweledblitz.dailyspin2
{
   import com.popcap.flash.bejeweledblitz.ProductInfo;
   import com.popcap.flash.bejeweledblitz.dailyspin2.UI.SpinBoardUIController;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ftue.FTUEManager;
   import com.popcap.flash.bejeweledblitz.game.ftue.impl.FTUEEvents;
   import com.popcap.flash.bejeweledblitz.game.ftue.impl.FTUEFlow;
   import com.popcap.flash.bejeweledblitz.game.ftue.impl.FtueFlowName;
   import com.popcap.flash.bejeweledblitz.game.session.ThrottleManager;
   import com.popcap.flash.bejeweledblitz.game.session.feature.FeatureManager;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.utils.Dictionary;
   
   public class SpinBoardController
   {
      
      private static var mInstance:SpinBoardController;
      
      private static var sHasBeenSurfacedOnce:Boolean;
       
      
      private var mCatalogue:SpinBoardCatalogue;
      
      private var mStateHandler:SpinBoardStateHandler;
      
      private var mHighlightController:SpinBoardHighlightController;
      
      private var mSpinBoardUpdateHandler:SpinBoardUpdateHandler;
      
      private var mSpinBoardFTUEHelper:SpinBoardFTUEHelper;
      
      private var mBoardPurchaseHandler:SpinBoardPurchaseHandler;
      
      private var mSpinPackPurchaseHandler:SpinPackPurchaseHandler;
      
      private var mSpinsShareHandler:SpinsShareHandler;
      
      private var mRewardClaimHandler:SpinBoardRewardClaimHandler;
      
      private var mPlayerDataHandler:SpinBoardPlayerDataHandler;
      
      private var mTelemetryTracker:SpinBoardTelemetryEventTracker;
      
      private var mActiveSpinBoardInfo:SpinBoardInfo;
      
      private var mNetHandler:SpinBoardNetworkHandler;
      
      private var mSpinPacksInfo:Vector.<ProductInfo>;
      
      private var mFTUEIntroOngoing:Boolean;
      
      public function SpinBoardController()
      {
         super();
         this.mNetHandler = new SpinBoardNetworkHandler(Blitz3App.app,this);
         this.mCatalogue = new SpinBoardCatalogue();
         this.mCatalogue.RegisterCallbackForStateChanges(this.OnCatalogueFetchStateChanged);
         this.mHighlightController = new SpinBoardHighlightController(this);
         this.mPlayerDataHandler = new SpinBoardPlayerDataHandler();
         this.mRewardClaimHandler = new SpinBoardRewardClaimHandler();
         this.mSpinBoardUpdateHandler = new SpinBoardUpdateHandler(this);
         this.mSpinsShareHandler = new SpinsShareHandler(this);
         this.mStateHandler = new SpinBoardStateHandler(this);
         this.mBoardPurchaseHandler = new SpinBoardPurchaseHandler();
         this.mSpinPackPurchaseHandler = new SpinPackPurchaseHandler();
         this.mSpinBoardFTUEHelper = new SpinBoardFTUEHelper(this);
         this.mTelemetryTracker = new SpinBoardTelemetryEventTracker();
         this.mFTUEIntroOngoing = false;
      }
      
      public static function GetInstance() : SpinBoardController
      {
         if(mInstance == null)
         {
            mInstance = new SpinBoardController();
         }
         return mInstance;
      }
      
      public function GetTelemetryTracker() : SpinBoardTelemetryEventTracker
      {
         return this.mTelemetryTracker;
      }
      
      public function SetFTUEIntroOngoing(param1:Boolean) : void
      {
         this.mFTUEIntroOngoing = param1;
      }
      
      public function GetFTUEHelper() : SpinBoardFTUEHelper
      {
         return this.mSpinBoardFTUEHelper;
      }
      
      public function GetNetHandler() : SpinBoardNetworkHandler
      {
         return this.mNetHandler;
      }
      
      public function GetBoardPurchaseHandler() : SpinBoardPurchaseHandler
      {
         return this.mBoardPurchaseHandler;
      }
      
      public function GetSpinPackPurchaseHandler() : SpinPackPurchaseHandler
      {
         return this.mSpinPackPurchaseHandler;
      }
      
      public function IsCatalogueFetched() : Boolean
      {
         return this.GetCatalogue().GetCatalogueState() == SpinBoardCatalogueState.CatalogueFetched;
      }
      
      public function IsAdThrottleOpen() : Boolean
      {
         return this.mNetHandler.IsAdThrottleOpen();
      }
      
      public function GetHighlightController() : SpinBoardHighlightController
      {
         return this.mHighlightController;
      }
      
      public function GetPlayerDataHandler() : SpinBoardPlayerDataHandler
      {
         return this.mPlayerDataHandler;
      }
      
      public function GetCatalogue() : SpinBoardCatalogue
      {
         return this.mCatalogue;
      }
      
      public function GetStateHandler() : SpinBoardStateHandler
      {
         return this.mStateHandler;
      }
      
      public function GetUpdateHandler() : SpinBoardUpdateHandler
      {
         return this.mSpinBoardUpdateHandler;
      }
      
      public function GetActiveSpinBoardInfo() : SpinBoardInfo
      {
         return this.mActiveSpinBoardInfo;
      }
      
      public function GetSpinsShareHandler() : SpinsShareHandler
      {
         return this.mSpinsShareHandler;
      }
      
      public function GetRewardClaimHandler() : SpinBoardRewardClaimHandler
      {
         return this.mRewardClaimHandler;
      }
      
      public function OpenSpinBoard(param1:Boolean = false) : void
      {
         var _loc2_:Object = null;
         if(this.mCatalogue.GetCatalogueState() == SpinBoardCatalogueState.CatalogueFetchFailed)
         {
            if(!param1)
            {
               SpinBoardUIController.GetInstance().ShowSpinBoardErrorPopup("Uh Oh!","We couldn\'t access the Daily Spin. Please check your network connection and try again.");
            }
         }
         else if(this.mStateHandler.GetState() == SpinBoardState.NoSpinBoard)
         {
            if(!this.SetupSpinBoards())
            {
               if(!param1)
               {
                  SpinBoardUIController.GetInstance().ShowSpinBoardErrorPopup("Oops!","Daily Spin is currently unavailable. Please check back later.");
               }
               _loc2_ = {
                  "ErrorType":"NoSpinBoard",
                  "ErrorLocation":"SpinBoard"
               };
               this.mTelemetryTracker.TrackEvent(SpinBoardTelemetryEventType.Error,_loc2_);
            }
         }
         else if(!this.mFTUEIntroOngoing)
         {
            SpinBoardUIController.GetInstance().OpenSpinBoard();
         }
      }
      
      public function CloseSpinBoard() : void
      {
         if(SpinBoardUIController.GetInstance().IsSpinBoardOpen())
         {
            Blitz3App.app.SoundManager.playSound(Blitz3GameSounds.SOUND_SPINBOARD_EXIT);
            this.mStateHandler.SetState(SpinBoardState.NotOpen);
            SpinBoardUIController.GetInstance().CloseSpinBoard();
         }
      }
      
      public function CanInitiateSpinBoardFTUE(param1:String) : Boolean
      {
         var _loc2_:Boolean = true;
         var _loc3_:* = this.mCatalogue.GetCatalogueState() == SpinBoardCatalogueState.CatalogueFetched;
         if(param1 != FtueFlowName.PREMIUM_SPINBOARD_INTRO_EXISTING)
         {
            _loc2_ = this.mActiveSpinBoardInfo != null && this.mActiveSpinBoardInfo.GetType() == SpinBoardType.PremiumBoard && this.mActiveSpinBoardInfo.IsFTUEBoard();
         }
         else
         {
            _loc2_ = this.mActiveSpinBoardInfo != null && this.mActiveSpinBoardInfo.GetType() == SpinBoardType.RegularBoard && this.mActiveSpinBoardInfo.IsFTUEBoard();
         }
         return Boolean(_loc2_ && _loc3_);
      }
      
      public function SetupSpinBoardsForFTUE() : Boolean
      {
         var _loc8_:SpinBoardInfo = null;
         var _loc9_:SpinBoardInfo = null;
         var _loc10_:SpinBoardInfo = null;
         var _loc11_:SpinBoardInfo = null;
         var _loc1_:Boolean = false;
         var _loc2_:FTUEManager = Blitz3App.app.sessionData.ftueManager;
         var _loc3_:Boolean = _loc2_.IsFlowCompleted(_loc2_.GetFlowId(FtueFlowName.SPINBOARD_INTRO_EXISTING));
         var _loc4_:Boolean = _loc2_.IsFlowCompleted(_loc2_.GetFlowId(FtueFlowName.REGULAR_SPINBOARD_INTRO_EXISTING));
         var _loc5_:Boolean = _loc2_.IsFlowCompleted(_loc2_.GetFlowId(FtueFlowName.PREMIUM_SPINBOARD_INTRO_EXISTING));
         var _loc6_:SpinBoardPlayerProgress = this.mPlayerDataHandler.GetBoardProgressByType(SpinBoardType.RegularBoard);
         var _loc7_:SpinBoardPlayerProgress = this.mPlayerDataHandler.GetBoardProgressByType(SpinBoardType.PremiumBoard);
         if(!(_loc3_ && _loc4_))
         {
            if((_loc8_ = this.mCatalogue.GetSpinBoardInfo(_loc6_.GetBoardId())) != null && _loc8_.IsFTUEBoard())
            {
               this.mActiveSpinBoardInfo = _loc8_;
               if(_loc6_.GetProgressiveSpinCount() >= 3 || _loc6_.HasTimerExpired() || _loc6_.HasBeenReset())
               {
                  this.MarkRegularBoardRelatedFTUEStepsDone();
               }
            }
            else if((_loc9_ = this.GetLatestSpinBoardOfType(SpinBoardType.RegularBoard,true)) != null)
            {
               this.mActiveSpinBoardInfo = _loc9_;
            }
            else
            {
               this.MarkRegularBoardRelatedFTUEStepsDone();
               this.MarkPremiumBoardRelatedFTUEStepsDone();
            }
         }
         else if(!_loc5_)
         {
            if((_loc10_ = this.mCatalogue.GetSpinBoardInfo(_loc7_.GetBoardId())) != null && _loc10_.IsFTUEBoard())
            {
               this.mActiveSpinBoardInfo = _loc10_;
            }
            else if((_loc11_ = this.GetLatestSpinBoardOfType(SpinBoardType.PremiumBoard,true)) != null)
            {
               this.mActiveSpinBoardInfo = _loc11_;
            }
            else
            {
               this.MarkPremiumBoardRelatedFTUEStepsDone();
            }
         }
         if(!_loc5_ && _loc7_.GetBoardResetTime() > 0)
         {
            if(_loc2_.getCurrentFlow() && _loc2_.getCurrentFlow().GetFlowId() == _loc2_.GetFlowId(FtueFlowName.PREMIUM_SPINBOARD_INTRO_EXISTING))
            {
               _loc2_.markCurrentFlowAsDone();
            }
         }
         return this.mActiveSpinBoardInfo != null;
      }
      
      private function MarkPremiumBoardRelatedFTUEStepsDone() : void
      {
         var _loc1_:FTUEManager = Blitz3App.app.sessionData.ftueManager;
         if(_loc1_.getCurrentFlow() && _loc1_.getCurrentFlow().GetFlowId() == _loc1_.GetFlowId(FtueFlowName.PREMIUM_SPINBOARD_INTRO_EXISTING))
         {
            _loc1_.markCurrentFlowAsDone();
         }
         else
         {
            _loc1_.markFlowAsDoneForId(_loc1_.GetFlowId(FtueFlowName.PREMIUM_SPINBOARD_INTRO_EXISTING));
         }
      }
      
      private function MarkRegularBoardRelatedFTUEStepsDone() : void
      {
         var _loc1_:FTUEManager = Blitz3App.app.sessionData.ftueManager;
         if(_loc1_.getCurrentFlow() && _loc1_.getCurrentFlow().GetFlowId() == _loc1_.GetFlowId(FtueFlowName.SPINBOARD_INTRO_EXISTING))
         {
            _loc1_.markCurrentFlowAsDone();
         }
         else
         {
            _loc1_.markFlowAsDoneForId(_loc1_.GetFlowId(FtueFlowName.SPINBOARD_INTRO_EXISTING));
         }
         if(_loc1_.getCurrentFlow() && _loc1_.getCurrentFlow().GetFlowId() == _loc1_.GetFlowId(FtueFlowName.REGULAR_SPINBOARD_INTRO_EXISTING))
         {
            _loc1_.markCurrentFlowAsDone();
         }
         else
         {
            _loc1_.markFlowAsDoneForId(_loc1_.GetFlowId(FtueFlowName.REGULAR_SPINBOARD_INTRO_EXISTING));
         }
      }
      
      public function SetupSpinBoards() : Boolean
      {
         var _loc3_:int = 0;
         var _loc1_:Boolean = false;
         this.mActiveSpinBoardInfo = null;
         var _loc2_:int = this.mCatalogue.GetCatalogueState();
         if(_loc2_ == SpinBoardCatalogueState.CatalogueFetched)
         {
            _loc1_ = this.SetupSpinBoardsForFTUE();
            if(!_loc1_)
            {
               _loc3_ = SpinBoardType.Count - 1;
               while(_loc3_ >= 0)
               {
                  if(!(_loc3_ == SpinBoardType.PremiumBoard && !Blitz3App.app.sessionData.throttleManager.IsEnabled(ThrottleManager.THROTTLE_ENABLE_PREMIUMBOARD)))
                  {
                     this.mActiveSpinBoardInfo = this.ValidateActiveBoardInfo(_loc3_);
                     if(this.mActiveSpinBoardInfo != null)
                     {
                        break;
                     }
                  }
                  _loc3_--;
               }
               if(this.mActiveSpinBoardInfo == null)
               {
                  this.mActiveSpinBoardInfo = this.GetLatestSpinBoardOfType(SpinBoardType.RegularBoard);
               }
               if(this.mActiveSpinBoardInfo != null)
               {
                  _loc1_ = true;
               }
               this.setDraperParamForsSpinPremBoardPurchase();
            }
         }
         return _loc1_;
      }
      
      public function GetPremiumBoardForPreview() : SpinBoardInfo
      {
         var _loc1_:FTUEManager = Blitz3App.app.sessionData.ftueManager;
         var _loc2_:Boolean = _loc1_.IsFlowCompleted(_loc1_.GetFlowId(FtueFlowName.PREMIUM_SPINBOARD_INTRO_EXISTING));
         return this.GetLatestSpinBoardOfType(SpinBoardType.PremiumBoard,!_loc2_);
      }
      
      public function GetRegularBoardToShow() : SpinBoardInfo
      {
         var _loc1_:SpinBoardInfo = null;
         _loc1_ = this.ValidateActiveBoardInfo(SpinBoardType.RegularBoard);
         if(_loc1_ == null)
         {
            _loc1_ = this.GetLatestSpinBoardOfType(SpinBoardType.RegularBoard);
         }
         return _loc1_;
      }
      
      public function GetLatestSpinBoardOfType(param1:int, param2:Boolean = false) : SpinBoardInfo
      {
         var _loc8_:* = null;
         var _loc9_:SpinBoardInfo = null;
         var _loc10_:Number = NaN;
         if(param1 == SpinBoardType.PremiumBoard && !Blitz3App.app.sessionData.throttleManager.IsEnabled(ThrottleManager.THROTTLE_ENABLE_PREMIUMBOARD))
         {
            return null;
         }
         var _loc3_:Dictionary = this.mCatalogue.GetAllBoards();
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:SpinBoardInfo = null;
         var _loc7_:Number = new Date().time / 1000;
         for(_loc8_ in _loc3_)
         {
            if((_loc9_ = _loc3_[_loc8_]) != null && _loc9_.GetType() == param1 && _loc9_.IsFTUEBoard() == param2)
            {
               if((_loc10_ = _loc9_.GetStartTime()) <= _loc7_ && _loc9_.GetEndTime() > _loc7_)
               {
                  if(_loc9_.GetPriority() > _loc5_)
                  {
                     _loc5_ = _loc9_.GetPriority();
                     _loc4_ = _loc10_;
                     _loc6_ = _loc9_;
                  }
                  else if(_loc9_.GetPriority() == _loc5_)
                  {
                     if(_loc10_ >= _loc4_)
                     {
                        _loc5_ = _loc9_.GetPriority();
                        _loc4_ = _loc10_;
                        _loc6_ = _loc9_;
                     }
                  }
               }
            }
         }
         return _loc6_;
      }
      
      public function ShouldEnableAccess() : Boolean
      {
         var _loc4_:Boolean = false;
         var _loc1_:FTUEManager = Blitz3App.app.sessionData.ftueManager;
         var _loc2_:Boolean = _loc1_.IsFlowCompleted(_loc1_.GetFlowId(FtueFlowName.SPINBOARD_INTRO_EXISTING));
         var _loc3_:FTUEFlow = _loc1_.getCurrentFlow();
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.GetFlowId() == _loc1_.GetFlowId(FtueFlowName.SPINBOARD_INTRO_EXISTING) || _loc3_.GetFlowId() == _loc1_.GetFlowId(FtueFlowName.REGULAR_SPINBOARD_INTRO_EXISTING) || _loc3_.GetFlowId() == _loc1_.GetFlowId(FtueFlowName.PREMIUM_SPINBOARD_INTRO_EXISTING);
            return _loc2_ || _loc4_;
         }
         return _loc2_;
      }
      
      public function Init() : void
      {
         if(Blitz3App.app.sessionData.featureManager.isFeatureEnabled(FeatureManager.FEATURE_DAILY_SPIN))
         {
            this.mPlayerDataHandler.Init();
            this.mCatalogue.FetchSpinBoardConfig();
         }
      }
      
      private function OnCatalogueFetchStateChanged() : void
      {
         if(this.mCatalogue.GetCatalogueState() == SpinBoardCatalogueState.CatalogueFetched)
         {
            if(!this.SetupSpinBoards())
            {
               this.mStateHandler.SetState(SpinBoardState.NoSpinBoard);
            }
            else
            {
               this.mStateHandler.OnCatalogueAvailable();
               this.mSpinBoardUpdateHandler.Init();
               if(this.mActiveSpinBoardInfo != null && this.mActiveSpinBoardInfo.IsFTUEBoard() && (Blitz3App.app as Blitz3Game).mainState.isMenuState())
               {
                  Blitz3App.app.bjbEventDispatcher.SendEvent(FTUEEvents.FTUE_SPINBOARD_AVAILABLE,null);
               }
               else
               {
                  this.TryAutoShow();
               }
            }
         }
      }
      
      public function TryAutoShow() : void
      {
         var _loc1_:FTUEManager = null;
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:MainWidgetGame = null;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc7_:Blitz3Game = null;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         if(!sHasBeenSurfacedOnce)
         {
            _loc1_ = Blitz3App.app.sessionData.ftueManager;
            _loc2_ = false;
            _loc3_ = _loc1_.DoesDailySpinBlockFTUE();
            _loc4_ = Blitz3App.app.ui as MainWidgetGame;
            _loc5_ = this.mPlayerDataHandler.HasFreeSpinAvailable() || this.mPlayerDataHandler.AdRewardSpinAvailable();
            _loc6_ = (Blitz3App.app as Blitz3Game).mainState.isMenuState();
            if(_loc4_.menu != null && _loc4_.menu.leftPanel != null)
            {
               _loc2_ = _loc4_.menu.leftPanel.isDailySpinEnabled();
            }
            _loc7_ = Blitz3App.app as Blitz3Game;
            _loc8_ = Blitz3App.app.sessionData.featureManager.isFeatureEnabled(FeatureManager.FEATURE_DAILY_SPIN);
            _loc9_ = !_loc7_.tutorial.IsComplete() || _loc7_.tutorial.IsActive() || !_loc7_.questManager.IsFeatureUnlockComplete() || _loc7_.whatsNewWidget.isWhatsNewAvailable();
            if(_loc6_ && _loc8_ && _loc5_ && _loc2_ && !_loc3_ && !_loc9_)
            {
               this.OpenSpinBoard(true);
               sHasBeenSurfacedOnce = true;
            }
         }
      }
      
      private function ValidateActiveBoardInfo(param1:int) : SpinBoardInfo
      {
         var _loc2_:SpinBoardInfo = null;
         var _loc3_:SpinBoardPlayerProgress = this.mPlayerDataHandler.GetBoardProgressByType(param1);
         if(_loc3_ != null && _loc3_.GetBoardId() != "")
         {
            if(!_loc3_.HasTimerExpired() && !_loc3_.HasBeenReset())
            {
               _loc2_ = this.mCatalogue.GetSpinBoardInfo(_loc3_.GetBoardId());
            }
         }
         return _loc2_;
      }
      
      public function GetFrenzyBarTotalStepsForCurrentBoard() : uint
      {
         var _loc1_:SpinBoardPlayerProgress = SpinBoardController.GetInstance().GetPlayerDataHandler().GetBoardProgressByType(this.mActiveSpinBoardInfo.GetType());
         var _loc2_:Vector.<UpgradeLevelInfo> = this.mActiveSpinBoardInfo.GetUpgradeLevels();
         var _loc3_:uint = _loc1_.GetProgressiveSpinCount();
         var _loc4_:uint = 0;
         var _loc5_:int = _loc2_.length;
         var _loc6_:uint = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = _loc6_;
            if(_loc3_ < _loc2_[_loc6_].GetNextUpgradeSpinThreshold())
            {
               break;
            }
            _loc6_++;
         }
         var _loc7_:uint = 0;
         if(_loc2_ != null && _loc2_.length > 0)
         {
            if(_loc4_ == 0)
            {
               _loc7_ = _loc2_[_loc4_].GetNextUpgradeSpinThreshold();
            }
            else
            {
               _loc7_ = _loc2_[_loc4_].GetNextUpgradeSpinThreshold() - _loc2_[_loc4_ - 1].GetNextUpgradeSpinThreshold();
            }
         }
         else
         {
            _loc7_ = 0;
         }
         return _loc7_;
      }
      
      public function GetFrenzyBarCurrentStepsForCurrentBoard() : uint
      {
         var _loc1_:SpinBoardPlayerProgress = SpinBoardController.GetInstance().GetPlayerDataHandler().GetBoardProgressByType(this.mActiveSpinBoardInfo.GetType());
         var _loc2_:Vector.<UpgradeLevelInfo> = this.mActiveSpinBoardInfo.GetUpgradeLevels();
         var _loc3_:uint = _loc1_.GetProgressiveSpinCount();
         var _loc4_:uint = _loc3_;
         var _loc5_:uint = 0;
         var _loc6_:int = _loc2_.length;
         var _loc7_:uint = 0;
         while(_loc7_ < _loc6_)
         {
            _loc5_ = _loc7_;
            if(_loc4_ < _loc2_[_loc7_].GetNextUpgradeSpinThreshold())
            {
               break;
            }
            _loc7_++;
         }
         if(_loc5_ > 0)
         {
            _loc4_ -= _loc2_[_loc5_ - 1].GetNextUpgradeSpinThreshold();
         }
         return _loc4_;
      }
      
      public function setDraperParamForsSpinPremBoardPurchase() : void
      {
         var _loc2_:FTUEManager = null;
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc6_:SpinBoardInfo = null;
         var _loc1_:Boolean = false;
         if(Blitz3App.app.sessionData.throttleManager.IsEnabled(ThrottleManager.THROTTLE_ENABLE_PREMIUMBOARD))
         {
            _loc2_ = Blitz3App.app.sessionData.ftueManager;
            _loc3_ = _loc2_.IsFlowCompleted(_loc2_.GetFlowId(FtueFlowName.SPINBOARD_INTRO_EXISTING));
            _loc4_ = _loc2_.IsFlowCompleted(_loc2_.GetFlowId(FtueFlowName.REGULAR_SPINBOARD_INTRO_EXISTING));
            _loc5_ = _loc2_.IsFlowCompleted(_loc2_.GetFlowId(FtueFlowName.PREMIUM_SPINBOARD_INTRO_EXISTING));
            _loc6_ = null;
            _loc1_ = _loc3_ && _loc4_ && _loc5_;
            if(_loc1_)
            {
               _loc1_ = false;
               if(this.mActiveSpinBoardInfo != null && !this.mActiveSpinBoardInfo.IsFTUEBoard())
               {
                  if(this.mActiveSpinBoardInfo.GetType() != SpinBoardType.PremiumBoard)
                  {
                     if((_loc6_ = this.GetLatestSpinBoardOfType(SpinBoardType.PremiumBoard)) != null && _loc6_.GetProductInfo() != null)
                     {
                        _loc1_ = true;
                     }
                  }
               }
            }
         }
         Blitz3App.app.network.sendDraperParamForsSpinPremBoardPurchase(_loc1_);
      }
   }
}
