package com.popcap.flash.bejeweledblitz.dailyspin2.UI
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardController;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardFTUEHelper;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardInfo;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardPlayerProgress;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardState;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardType;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ftue.FTUEManager;
   import com.popcap.flash.bejeweledblitz.game.ftue.impl.FTUEEvents;
   import com.popcap.flash.bejeweledblitz.game.ftue.impl.FTUEFlow;
   import com.popcap.flash.bejeweledblitz.game.ftue.impl.FtueFlowName;
   import com.popcap.flash.bejeweledblitz.game.session.Blitz3Network;
   import com.popcap.flash.bejeweledblitz.game.session.ThrottleManager;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.SingleButtonDialog;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class SpinBoardUIController extends MovieClip
   {
      
      private static var sInstance:SpinBoardUIController;
       
      
      private var mSpinBoardController:SpinBoardController;
      
      private var mSpinBoardViewContainer:SpinBoardViewContainer;
      
      private var mCurrentlyShowingSpinBoard:SpinBoardInfo;
      
      private var mTilesHandler:SpinBoardTilesHandler;
      
      private var mSpinBoardRewardClaimPopupContainer:SpinBoardRewardClaimPopupContainer;
      
      private var mSpinBoardClearedViewContainer:SpinBoardClearedViewContainer;
      
      private var mInitiatePremiumFreeSpinButton:GenericButtonClip;
      
      private var mInitiatePremiumPaidSpinButton:GenericButtonClip;
      
      private var mInitiateRegularFreeSpinButton:GenericButtonClip;
      
      private var mInitiateRegularPaidSpinButton:GenericButtonClip;
      
      private var mAccessPremiumSpinBoardButton:GenericButtonClip;
      
      private var mAccessRegularSpinBoardButton:GenericButtonClip;
      
      private var mCurentlyActiveClaimButon:GenericButtonClip;
      
      private var mTimer:Timer;
      
      private var mSpinShareInfoViewContainer:SpinShareInfoViewContainer;
      
      private var mUserActionBlocker:int = 0;
      
      private var mSpinBoardOpenedCallback:Function;
      
      private var mSpinBoardClosedCallback:Function;
      
      private var mSpinPacksPanel:SpinPacksPanel;
      
      private var mWatchAdPanel:MovieClip;
      
      private var mAreUserActionsAllowed:Boolean;
      
      private var mSpinBoardOpen:Boolean;
      
      public function SpinBoardUIController()
      {
         super();
         this.mSpinBoardController = SpinBoardController.GetInstance();
         this.Init();
      }
      
      public static function GetInstance() : SpinBoardUIController
      {
         if(sInstance == null)
         {
            sInstance = new SpinBoardUIController();
         }
         return sInstance;
      }
      
      public function Init() : void
      {
         this.mSpinBoardOpen = false;
         this.mAreUserActionsAllowed = true;
         this.mUserActionBlocker = 0;
         this.GetSpinBoardContainer();
         this.mSpinBoardViewContainer.SetSpinBoardUIState(SpinBoardUIState.Invalid);
      }
      
      public function GetSpinBoardRewardClaimPopupContainer() : SpinBoardRewardClaimPopupContainer
      {
         if(this.mSpinBoardRewardClaimPopupContainer == null)
         {
            this.mSpinBoardRewardClaimPopupContainer = new SpinBoardRewardClaimPopupContainer();
         }
         return this.mSpinBoardRewardClaimPopupContainer;
      }
      
      public function GetSpinBoardContainer() : SpinBoardViewContainer
      {
         if(this.mSpinBoardViewContainer == null)
         {
            this.mSpinBoardViewContainer = new SpinBoardViewContainer();
         }
         return this.mSpinBoardViewContainer;
      }
      
      public function GetOrCreateSpinShareInfoViewContainer() : SpinShareInfoViewContainer
      {
         if(this.mSpinShareInfoViewContainer == null)
         {
            this.mSpinShareInfoViewContainer = new SpinShareInfoViewContainer();
         }
         return this.mSpinShareInfoViewContainer;
      }
      
      public function OpenSpinBoard() : SpinBoardView
      {
         var _loc1_:SpinBoardView = null;
         this.GetSpinBoardContainer();
         if(this.mTilesHandler == null)
         {
            this.mTilesHandler = new SpinBoardTilesHandler(this.mSpinBoardViewContainer);
         }
         this.GetSpinBoardContainer();
         var _loc2_:MainWidgetGame = Blitz3App.app.ui as MainWidgetGame;
         if(_loc2_ != null)
         {
            this.mUserActionBlocker = 0;
            this.mSpinBoardOpen = true;
            _loc1_ = this.mSpinBoardViewContainer.OpenSpinBoard();
            this.mWatchAdPanel = this.mSpinBoardViewContainer.GetOrCreateSpinBoardView().mWatchAdPanel;
            this.mAreUserActionsAllowed = true;
            this.mSpinBoardController.GetRewardClaimHandler().SetStateChangedCallback(this.OnClaimStateChanged);
            this.mSpinBoardController.GetStateHandler().SetUICallback(this.OnSpinBoardStateChanged);
         }
         this.mSpinBoardController.GetUpdateHandler().RegisterFreeSpinAvailableEventHandler(this.OnFreeSpinAvailable);
         this.mSpinBoardController.GetPlayerDataHandler().AddListener(this.ValidateSpinCountStoreAndWatchAdState);
         this.mTimer = new Timer(1000);
         this.mTimer.addEventListener(TimerEvent.TIMER,this.OnTimerTick);
         this.mTimer.start();
         if(this.mSpinBoardOpenedCallback != null)
         {
            this.mSpinBoardOpenedCallback();
         }
         this.mSpinBoardController.GetStateHandler().SetState(SpinBoardState.BoardRunning);
         return _loc1_;
      }
      
      public function ShowSpinBoardErrorPopup(param1:String, param2:String) : void
      {
         var noSpinsPopup:SingleButtonDialog = null;
         var title:String = param1;
         var message:String = param2;
         SpinBoardController.GetInstance().CloseSpinBoard();
         noSpinsPopup = new SingleButtonDialog(Blitz3App.app,16);
         noSpinsPopup.Init();
         noSpinsPopup.SetDimensions(420,216);
         noSpinsPopup.SetContent(title,message,"OK");
         noSpinsPopup.x = Dimensions.LEFT_BORDER_WIDTH + Dimensions.GAME_WIDTH / 2 - noSpinsPopup.width / 2;
         noSpinsPopup.y = Dimensions.TOP_BORDER_WIDTH + Dimensions.GAME_HEIGHT / 2 - noSpinsPopup.height / 2;
         noSpinsPopup.AddContinueButtonHandler(function(param1:MouseEvent):void
         {
            noSpinsPopup.Reset();
            (Blitz3App.app as Blitz3Game).metaUI.highlight.hidePopUp();
            noSpinsPopup = null;
            mSpinBoardController.CloseSpinBoard();
         });
         (Blitz3App.app as Blitz3Game).metaUI.highlight.showPopUp(noSpinsPopup,true,true,0.55);
      }
      
      private function SetEmbeddedLoaderVisibility(param1:Boolean) : void
      {
         var _loc2_:SpinBoardView = null;
         _loc2_ = this.mSpinBoardViewContainer.GetOrCreateSpinBoardView();
         _loc2_.mSpinBoardLoaderEmbedded.visible = param1;
         _loc2_.mSpinBoardTilesContainer.visible = !param1;
         this.ValidateSpinCountStoreAndWatchAdState();
      }
      
      public function OnSpinBoardStateChanged() : void
      {
         var _loc1_:int = this.mSpinBoardController.GetStateHandler().GetState();
         var _loc2_:int = this.mSpinBoardController.GetStateHandler().GetPreviousState();
         if(_loc1_ != SpinBoardState.Loading)
         {
            this.SetEmbeddedLoaderVisibility(false);
         }
         switch(_loc1_)
         {
            case SpinBoardState.NotOpen:
               break;
            case SpinBoardState.NoSpinBoard:
               this.ShowSpinBoardErrorPopup("Oops!","Daily Spins are currently unavailable. Please check later.");
               break;
            case SpinBoardState.Loading:
               this.SetEmbeddedLoaderVisibility(true);
               break;
            case SpinBoardState.BoardRunning:
               this.OnBoardRunningState(_loc2_);
               break;
            case SpinBoardState.RewardClaim:
               this.mTilesHandler.DoCollectionAnimationForSelectedTile();
               break;
            case SpinBoardState.RewardShareSequenceComplete:
               this.mUserActionBlocker = 0;
               break;
            case SpinBoardState.BoardReset:
               this.RefreshView(false);
         }
      }
      
      private function OnBoardRunningState(param1:uint) : void
      {
         if(param1 == SpinBoardState.NotOpen || param1 == SpinBoardState.BoardReset || param1 == SpinBoardState.PremiumBoardPurchaseSucceeded || param1 == SpinBoardState.RewardShareSequenceComplete || param1 == SpinBoardState.NoSpinBoard)
         {
            this.SetupSpinBoardView();
         }
         else if(param1 == SpinBoardState.SpinsPurchaseFailed || param1 == SpinBoardState.SpinsPurchaseComplete)
         {
            this.RefreshView(false);
         }
         else
         {
            this.RefreshView(true);
         }
      }
      
      public function OnClaimStateChanged() : void
      {
         if(this.mSpinBoardRewardClaimPopupContainer != null)
         {
            this.mSpinBoardRewardClaimPopupContainer.OnClaimStateChanged();
         }
      }
      
      private function OnTimerTick(param1:TimerEvent) : void
      {
         this.mSpinBoardViewContainer.ValidateTimers();
      }
      
      public function OnBoardExpiryCloseClicked() : void
      {
         SpinBoardController.GetInstance().CloseSpinBoard();
      }
      
      public function OnFreeSpinAvailable() : void
      {
         this.ValidateSpinCountStoreAndWatchAdState();
      }
      
      public function CloseSpinBoard() : void
      {
         if(this.mSpinBoardViewContainer != null && this.IsSpinBoardOpen())
         {
            this.mSpinBoardOpen = false;
            if(this.mSpinPacksPanel != null)
            {
               this.mSpinPacksPanel.Close();
            }
            this.mWatchAdPanel.visible = false;
            this.mSpinPacksPanel = null;
            this.mWatchAdPanel = null;
            this.mSpinBoardController.GetStateHandler().SetUICallback(null);
            this.mSpinBoardController.GetPlayerDataHandler().RemoveListener(this.ValidateSpinCountStoreAndWatchAdState);
            this.mSpinBoardController.GetUpdateHandler().DeregisterFreeSpinAvailableEventHandler(this.OnFreeSpinAvailable);
            this.mSpinBoardController.GetRewardClaimHandler().SetStateChangedCallback(null);
            this.mTilesHandler.StopListeningHighlighterUpdates();
            this.mSpinBoardViewContainer.CloseSpinBoardView();
            this.mTilesHandler.Reset();
            this.mTilesHandler = null;
            this.mCurrentlyShowingSpinBoard = null;
            this.mSpinBoardViewContainer = null;
            this.mInitiatePremiumFreeSpinButton = null;
            this.mInitiatePremiumPaidSpinButton = null;
            this.mInitiateRegularFreeSpinButton = null;
            this.mInitiateRegularPaidSpinButton = null;
            this.mAccessPremiumSpinBoardButton = null;
            this.mAccessRegularSpinBoardButton = null;
            this.mCurentlyActiveClaimButon = null;
            if(this.mTimer != null)
            {
               this.mTimer.removeEventListener(TimerEvent.TIMER,this.OnTimerTick);
               this.mTimer.stop();
               this.mTimer = null;
            }
            if(this.mSpinBoardClosedCallback != null)
            {
               this.mSpinBoardClosedCallback();
            }
         }
      }
      
      public function GetTilesHandler() : SpinBoardTilesHandler
      {
         return this.mTilesHandler;
      }
      
      public function SetupSpinBoardView() : void
      {
         var _loc1_:SpinBoardInfo = null;
         var _loc2_:SpinBoardPlayerProgress = null;
         var _loc3_:* = false;
         var _loc4_:SpinBoardPlayerProgress = null;
         var _loc5_:* = false;
         if(!this.mSpinBoardController.GetStateHandler().ValidateExpiredUserProgress())
         {
            if(this.mCurrentlyShowingSpinBoard != null)
            {
               _loc2_ = this.mSpinBoardController.GetPlayerDataHandler().GetBoardProgressById(this.mCurrentlyShowingSpinBoard.GetId());
               if(_loc2_ != null && (_loc2_.HasTimerExpired() || _loc2_.HasBeenReset()))
               {
                  if(this.mCurrentlyShowingSpinBoard != null && this.mCurrentlyShowingSpinBoard.GetType() != SpinBoardType.PremiumBoard)
                  {
                     this.mCurrentlyShowingSpinBoard = null;
                  }
               }
            }
            _loc1_ = SpinBoardController.GetInstance().GetActiveSpinBoardInfo();
            if(_loc1_ != null)
            {
               if(this.mCurrentlyShowingSpinBoard != null && this.mCurrentlyShowingSpinBoard.GetEndTime() > new Date().time / 1000)
               {
                  _loc3_ = _loc1_.GetType() == this.mCurrentlyShowingSpinBoard.GetType();
                  if(_loc3_)
                  {
                     if(_loc1_.GetPriority() > this.mCurrentlyShowingSpinBoard.GetPriority())
                     {
                        this.mCurrentlyShowingSpinBoard = _loc1_;
                     }
                  }
                  else if(this.mCurrentlyShowingSpinBoard.GetType() != SpinBoardType.PremiumBoard)
                  {
                     if(!(_loc4_ = this.mSpinBoardController.GetPlayerDataHandler().GetBoardProgressByType(_loc1_.GetType())).HasTimerExpired() && !_loc4_.HasBeenReset())
                     {
                        this.mCurrentlyShowingSpinBoard = _loc1_;
                     }
                  }
               }
               else
               {
                  this.mCurrentlyShowingSpinBoard = _loc1_;
               }
            }
            if(this.mCurrentlyShowingSpinBoard == null)
            {
               Utils.logWithStackTrace(this,"[SpinBoardUIController] mActiveSpinBoard null");
               this.mSpinBoardController.GetStateHandler().SetState(SpinBoardState.NoSpinBoard);
            }
            else
            {
               this.SetupGenericButtonClips();
               if(_loc5_ = this.mCurrentlyShowingSpinBoard.GetType() == SpinBoardType.PremiumBoard)
               {
                  this.SurfacePremiumBoard();
               }
               else
               {
                  this.SurfaceRegularBoard();
               }
               if(this.mCurrentlyShowingSpinBoard != null && this.mCurrentlyShowingSpinBoard.IsFTUEBoard())
               {
                  if(this.mCurrentlyShowingSpinBoard.GetType() == SpinBoardType.RegularBoard)
                  {
                     Blitz3App.app.bjbEventDispatcher.SendEvent(FTUEEvents.FTUE_REGULAR_SPINBOARD_AVAILABLE,null);
                  }
                  else
                  {
                     Blitz3App.app.bjbEventDispatcher.SendEvent(FTUEEvents.FTUE_PREMIUM_SPINBOARD_AVAILABLE,null);
                  }
               }
               this.ValidateSpinCountStoreAndWatchAdState();
               this.mSpinBoardViewContainer.ValidateTimers();
            }
         }
      }
      
      private function SetupGenericButtonClips() : void
      {
         var _loc1_:Blitz3App = Blitz3App.app;
         if(this.mAccessPremiumSpinBoardButton == null)
         {
            this.mAccessPremiumSpinBoardButton = new GenericButtonClip(_loc1_,this.mSpinBoardViewContainer.GetOrCreateSpinBoardView().mAccessPremiumSpinBoardButton);
            this.mAccessPremiumSpinBoardButton.setRelease(this.OnAccessPremiumBoardRequested);
            this.mAccessPremiumSpinBoardButton.deactivate();
            this.mAccessPremiumSpinBoardButton.hide();
         }
         if(this.mAccessRegularSpinBoardButton == null)
         {
            this.mAccessRegularSpinBoardButton = new GenericButtonClip(_loc1_,this.mSpinBoardViewContainer.GetOrCreateSpinBoardView().mAccessRegularSpinBoardButton);
            this.mAccessRegularSpinBoardButton.setRelease(this.OnAccessRegularBoardRequested);
            this.mAccessRegularSpinBoardButton.deactivate();
            this.mAccessRegularSpinBoardButton.hide();
         }
         if(this.mInitiateRegularFreeSpinButton == null)
         {
            this.mInitiateRegularFreeSpinButton = new GenericButtonClip(_loc1_,this.mSpinBoardViewContainer.GetOrCreateSpinBoardView().mRegularBoardPanel.mInitiateFreeSpinButton);
            this.mInitiateRegularFreeSpinButton.setRelease(this.OnSpinBoardRewardClaimButtonClicked);
         }
         if(this.mInitiateRegularPaidSpinButton == null)
         {
            this.mInitiateRegularPaidSpinButton = new GenericButtonClip(_loc1_,this.mSpinBoardViewContainer.GetOrCreateSpinBoardView().mRegularBoardPanel.mInitiatePaidSpinButton);
            this.mInitiateRegularPaidSpinButton.setRelease(this.OnSpinBoardRewardClaimButtonClicked);
         }
         if(this.mInitiatePremiumFreeSpinButton == null)
         {
            this.mInitiatePremiumFreeSpinButton = new GenericButtonClip(_loc1_,this.mSpinBoardViewContainer.GetOrCreateSpinBoardView().mPremiumBoardPanel.mInitiateFreeSpinButton);
            this.mInitiatePremiumFreeSpinButton.setRelease(this.OnSpinBoardRewardClaimButtonClicked);
         }
         if(this.mInitiatePremiumPaidSpinButton == null)
         {
            this.mInitiatePremiumPaidSpinButton = new GenericButtonClip(_loc1_,this.mSpinBoardViewContainer.GetOrCreateSpinBoardView().mPremiumBoardPanel.mInitiatePaidSpinButton);
            this.mInitiatePremiumPaidSpinButton.setRelease(this.OnSpinBoardRewardClaimButtonClicked);
         }
         this.mInitiateRegularFreeSpinButton.deactivate();
         this.mInitiateRegularPaidSpinButton.deactivate();
         this.mInitiatePremiumFreeSpinButton.deactivate();
         this.mInitiatePremiumPaidSpinButton.deactivate();
      }
      
      public function OnSpinBoardRewardClaimButtonClicked() : void
      {
         if(this.mAreUserActionsAllowed)
         {
            if(this.mSpinBoardController.GetRewardClaimHandler().OnRewardClaimRequested())
            {
               Blitz3App.app.SoundManager.playSound(Blitz3GameSounds.SOUND_SPINBOARD_TAP_CLAIM);
               this.SetAllowUserActions(false);
               if(this.mSpinBoardController.GetActiveSpinBoardInfo().IsFTUEBoard())
               {
                  Blitz3App.app.bjbEventDispatcher.SendEvent(SpinBoardFTUEHelper.SPINBOARD_REGULAR_CLAIM_REQUESTED,null);
               }
            }
         }
      }
      
      public function OnAccessPremiumBoardRequested() : void
      {
         var _loc1_:SpinBoardInfo = null;
         if(this.mAreUserActionsAllowed)
         {
            _loc1_ = this.mSpinBoardController.GetPremiumBoardForPreview();
            if(_loc1_ != null && _loc1_.IsFTUEBoard())
            {
               Blitz3App.app.bjbEventDispatcher.SendEvent(SpinBoardFTUEHelper.SPINBOARD_FREE_PREMIUMBOARD_ACCESS_REQUESTED,null);
            }
            Blitz3App.app.SoundManager.playSound(Blitz3GameSounds.SOUND_SPINBOARD_ACCESS_DAILY_OR_DELUXE);
            this.SurfacePremiumBoard();
         }
      }
      
      public function OnAccessRegularBoardRequested() : void
      {
         if(this.mAreUserActionsAllowed)
         {
            Blitz3App.app.SoundManager.playSound(Blitz3GameSounds.SOUND_SPINBOARD_ACCESS_DAILY_OR_DELUXE);
            this.SurfaceRegularBoard();
         }
      }
      
      public function SurfaceRegularBoard() : void
      {
         var _loc1_:SpinBoardInfo = null;
         var _loc2_:FTUEManager = null;
         var _loc3_:Boolean = false;
         var _loc4_:FTUEFlow = null;
         var _loc5_:Boolean = false;
         if(this.mCurrentlyShowingSpinBoard.GetType() != SpinBoardType.RegularBoard)
         {
            _loc1_ = this.mSpinBoardController.GetRegularBoardToShow();
            if(_loc1_ != null)
            {
               this.mCurrentlyShowingSpinBoard = _loc1_;
            }
         }
         if(this.mCurrentlyShowingSpinBoard != null)
         {
            this.mSpinBoardViewContainer.SetSpinBoardUIState(SpinBoardUIState.RegularBoard);
            this.mAccessRegularSpinBoardButton.deactivate();
            this.mAccessRegularSpinBoardButton.hide();
            _loc2_ = Blitz3App.app.sessionData.ftueManager;
            _loc3_ = _loc2_.IsFlowCompleted(_loc2_.GetFlowId(FtueFlowName.PREMIUM_SPINBOARD_INTRO_EXISTING));
            _loc5_ = (_loc4_ = _loc2_.getCurrentFlow()) != null && _loc4_.GetFlowId() == _loc2_.GetFlowId(FtueFlowName.PREMIUM_SPINBOARD_INTRO_EXISTING);
            if(!Blitz3App.app.sessionData.throttleManager.IsEnabled(ThrottleManager.THROTTLE_ENABLE_PREMIUMBOARD) || !_loc3_ && !_loc5_)
            {
               this.mAccessPremiumSpinBoardButton.hide();
            }
            else
            {
               this.mAccessPremiumSpinBoardButton.activate();
               this.mAccessPremiumSpinBoardButton.show();
               this.mAccessPremiumSpinBoardButton.SetDisabled(SpinBoardController.GetInstance().GetPremiumBoardForPreview() == null);
            }
         }
      }
      
      public function SurfacePremiumBoard() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:SpinBoardInfo = null;
         var _loc3_:SpinBoardController = null;
         var _loc4_:SpinBoardInfo = null;
         var _loc5_:Boolean = false;
         var _loc6_:SpinBoardPlayerProgress = null;
         var _loc7_:Boolean = false;
         _loc1_ = SpinBoardController.GetInstance().GetPlayerDataHandler().HasPurchasedPremiumBoard(this.mCurrentlyShowingSpinBoard.GetId());
         if(this.mCurrentlyShowingSpinBoard.GetType() != SpinBoardType.PremiumBoard || !_loc1_)
         {
            _loc2_ = SpinBoardController.GetInstance().GetPremiumBoardForPreview();
            if(_loc2_ != null)
            {
               this.mCurrentlyShowingSpinBoard = _loc2_;
            }
         }
         if(this.mCurrentlyShowingSpinBoard != null && this.mCurrentlyShowingSpinBoard.GetType() == SpinBoardType.PremiumBoard)
         {
            _loc3_ = SpinBoardController.GetInstance();
            _loc1_ = _loc3_.GetPlayerDataHandler().HasPurchasedPremiumBoard(this.mCurrentlyShowingSpinBoard.GetId());
            if(!_loc1_)
            {
               this.mSpinBoardViewContainer.SetSpinBoardUIState(SpinBoardUIState.PremiumBoardPreview);
               _loc5_ = (_loc4_ = _loc3_.GetActiveSpinBoardInfo()) != null && _loc4_.GetType() == SpinBoardType.RegularBoard;
               if(_loc4_ != null)
               {
                  _loc7_ = (_loc6_ = _loc3_.GetPlayerDataHandler().GetBoardProgressById(_loc4_.GetId())) != null && (_loc6_.HasTimerExpired() || _loc6_.HasBeenReset());
                  _loc5_ = _loc5_ && !_loc7_;
               }
               if(_loc5_ || SpinBoardController.GetInstance().GetLatestSpinBoardOfType(SpinBoardType.RegularBoard) != null)
               {
                  this.mAccessRegularSpinBoardButton.activate();
                  this.mAccessRegularSpinBoardButton.show();
               }
            }
            else
            {
               this.mSpinBoardViewContainer.SetSpinBoardUIState(SpinBoardUIState.PremiumBoard);
               Blitz3App.app.SoundManager.playSound(Blitz3GameSounds.SOUND_SPINBOARD_PURCHASE_DELUXE);
               this.mAccessRegularSpinBoardButton.deactivate();
               this.mAccessRegularSpinBoardButton.hide();
            }
            this.mAccessPremiumSpinBoardButton.deactivate();
            this.mAccessPremiumSpinBoardButton.hide();
         }
      }
      
      public function GetCurrentlyShowingSpinBoard() : SpinBoardInfo
      {
         return this.mCurrentlyShowingSpinBoard;
      }
      
      public function IsSpinBoardOpen() : Boolean
      {
         return this.mSpinBoardOpen;
      }
      
      public function SetAllowUserActions(param1:Boolean) : void
      {
         Utils.logWithStackTrace(this,"[SetAllowUserActions] : " + param1);
         if(param1)
         {
            --this.mUserActionBlocker;
         }
         else
         {
            ++this.mUserActionBlocker;
         }
         this.mAreUserActionsAllowed = this.mUserActionBlocker <= 0;
         this.ValidateClaimButtonState();
      }
      
      public function RefreshView(param1:Boolean) : void
      {
         Utils.logWithStackTrace(this,"[RefreshView] : ");
         this.SetAllowUserActions(false);
         if(this.mSpinPacksPanel != null && this.mSpinPacksPanel.HasLostParent())
         {
            this.mSpinPacksPanel.ResetPanel();
         }
         this.ValidateSpinCountStoreAndWatchAdState(true);
         this.mSpinBoardViewContainer.ValidateTimers();
         this.InitiateRefreshViewSequence(param1);
      }
      
      public function RefreshFrenzyBarStatus(param1:Boolean) : void
      {
         Utils.logWithStackTrace(this,"[RefreshFrenzyBarStatus]");
         if(this.mSpinBoardViewContainer.ValidateFrenzyBarStatus(param1))
         {
            if(param1)
            {
               Blitz3App.app.SoundManager.playSound(Blitz3GameSounds.SOUND_SPINBOARD_FRENZYBAR_FILLS);
            }
         }
         else if(param1)
         {
            Blitz3App.app.SoundManager.playSound(Blitz3GameSounds.SOUND_SPINBOARD_FRENZYBAR_EMPTIES);
         }
      }
      
      private function InitiateRefreshViewSequence(param1:Boolean) : void
      {
         Utils.logWithStackTrace(this,"[InitiateRefreshViewSequence] : RefreshClaimedTiles STARTING ");
         this.mTilesHandler.RefreshClaimedTiles(this.RefreshFrenzyBarStatus,!param1);
      }
      
      public function OnFrenzyBarsFull(param1:Boolean) : void
      {
      }
      
      public function OnFrenzyBarsUpdated(param1:Boolean) : void
      {
         var progressExpected:Boolean = param1;
         Utils.logWithStackTrace(this,"[RefreshUpgradedTiles] : STARTING ");
         this.mTilesHandler.RefreshUpgradedTiles(function(param1:Boolean):void
         {
            Utils.logWithStackTrace(this,"[RefreshUpgradedTiles] : DONE ");
            SpinBoardUIController.GetInstance().GetTilesHandler().StartListeningHighlighterUpdates();
            SetAllowUserActions(true);
            if(mCurrentlyShowingSpinBoard.IsFTUEBoard())
            {
               Blitz3App.app.bjbEventDispatcher.SendEvent(SpinBoardFTUEHelper.SPINBOARD_FRENZYBAR_UPDATED,null);
            }
         },!progressExpected);
      }
      
      public function ShouldShowAdButton() : Boolean
      {
         var _loc6_:* = false;
         var _loc7_:SpinBoardInfo = null;
         var _loc1_:* = this.mSpinBoardController.GetStateHandler().GetState() == SpinBoardState.Loading;
         var _loc2_:Boolean = this.mSpinBoardController.IsAdThrottleOpen();
         var _loc3_:* = this.mSpinBoardViewContainer.GetCurrentUIState() == SpinBoardUIState.RegularBoard;
         var _loc4_:SpinBoardInfo = SpinBoardUIController.GetInstance().GetCurrentlyShowingSpinBoard();
         var _loc5_:Boolean = false;
         if(_loc4_ != null)
         {
            _loc6_ = !_loc4_.IsFTUEBoard();
            if((_loc7_ = SpinBoardController.GetInstance().GetActiveSpinBoardInfo()) != null)
            {
               _loc5_ = _loc2_ && !_loc1_ && _loc6_ && Blitz3App.app.adFrequencyManager.canShowRetry(Blitz3Network.DS_PLACEMENT,0,_loc7_.GetId()) && _loc3_;
            }
         }
         return _loc5_;
      }
      
      public function RanOutOfSpinBalance() : Boolean
      {
         var _loc1_:int = this.mSpinBoardController.GetPlayerDataHandler().GetPaidSpinBalance();
         var _loc2_:Boolean = this.mSpinBoardController.GetPlayerDataHandler().HasFreeSpinAvailable();
         var _loc3_:Boolean = this.mSpinBoardController.GetPlayerDataHandler().AdRewardSpinAvailable();
         return Boolean(!_loc2_ && !_loc3_ && _loc1_ <= 0);
      }
      
      public function CanShowSpinStore() : Boolean
      {
         var _loc4_:* = false;
         var _loc1_:* = SpinBoardController.GetInstance().GetStateHandler().GetState() != SpinBoardState.Loading;
         var _loc2_:SpinBoardInfo = SpinBoardUIController.GetInstance().GetCurrentlyShowingSpinBoard();
         var _loc3_:Boolean = false;
         if(_loc2_ != null)
         {
            _loc4_ = this.mSpinBoardViewContainer.GetCurrentUIState() != SpinBoardUIState.PremiumBoardPreview;
            _loc3_ = _loc1_ && _loc4_;
         }
         return _loc3_;
      }
      
      public function CloseStoreAndWatchAdPanel() : void
      {
         if(this.mSpinPacksPanel != null)
         {
            this.mSpinPacksPanel.Close(true);
         }
         if(this.mWatchAdPanel != null)
         {
            this.mWatchAdPanel.visible = false;
         }
      }
      
      public function ValidateSpinCountStoreAndWatchAdState(param1:Boolean = false) : void
      {
         if(this.mSpinPacksPanel == null)
         {
            this.mSpinPacksPanel = new SpinPacksPanel(this.mSpinBoardViewContainer);
         }
         if(this.mSpinPacksPanel.HasLostParent())
         {
            this.mSpinPacksPanel.ResetPanel();
         }
         var _loc2_:Boolean = this.CanShowSpinStore();
         var _loc3_:Boolean = this.RanOutOfSpinBalance();
         if(_loc2_ && _loc3_)
         {
            this.mSpinPacksPanel.Open();
         }
         else
         {
            this.mSpinPacksPanel.Close(true);
         }
         if(this.ShouldShowAdButton() && _loc3_)
         {
            this.mWatchAdPanel.visible = true;
         }
         else
         {
            this.mWatchAdPanel.visible = false;
            if(_loc3_ && param1)
            {
               if(!this.ShouldShowAdButton())
               {
                  Blitz3App.app.network.SendAdAvailabilityMetrics(Blitz3Network.DS_PLACEMENT);
               }
            }
         }
         if(this.mSpinBoardViewContainer != null)
         {
            this.mSpinBoardViewContainer.ValidateSpinCount();
         }
         this.ValidateClaimButtonState();
      }
      
      public function ValidateClaimButtonState() : void
      {
         var _loc1_:SpinBoardInfo = null;
         var _loc2_:int = 0;
         var _loc3_:* = false;
         var _loc4_:Boolean = false;
         var _loc5_:GenericButtonClip = null;
         var _loc6_:GenericButtonClip = null;
         var _loc7_:Boolean = false;
         if(this.mSpinBoardController.GetStateHandler().GetState() == SpinBoardState.Loading)
         {
            this.mSpinBoardViewContainer.GetOrCreateSpinBoardView().mSpinStorePanel.visible = false;
         }
         else
         {
            this.mSpinBoardViewContainer.GetOrCreateSpinBoardView().mSpinStorePanel.visible = true;
            _loc1_ = SpinBoardUIController.GetInstance().GetCurrentlyShowingSpinBoard();
            _loc2_ = this.mSpinBoardController.GetPlayerDataHandler().GetPaidSpinBalance();
            _loc3_ = _loc2_ > 0;
            _loc4_ = (_loc4_ = this.mSpinBoardController.GetPlayerDataHandler().HasFreeSpinAvailable()) || this.mSpinBoardController.GetPlayerDataHandler().AdRewardSpinAvailable();
            if(_loc1_ != null)
            {
               if(this.mSpinBoardViewContainer.GetCurrentUIState() == SpinBoardUIState.RegularBoard)
               {
                  _loc5_ = this.mInitiateRegularFreeSpinButton;
                  _loc6_ = this.mInitiateRegularPaidSpinButton;
                  if(this.mInitiatePremiumFreeSpinButton.IsVisible())
                  {
                     this.mInitiatePremiumFreeSpinButton.hide();
                  }
                  if(this.mInitiatePremiumPaidSpinButton.IsVisible())
                  {
                     this.mInitiatePremiumPaidSpinButton.hide();
                  }
               }
               else if(this.mSpinBoardViewContainer.GetCurrentUIState() != SpinBoardUIState.PremiumBoardPreview)
               {
                  _loc5_ = this.mInitiatePremiumFreeSpinButton;
                  _loc6_ = this.mInitiatePremiumPaidSpinButton;
                  if(this.mInitiateRegularFreeSpinButton.IsVisible())
                  {
                     this.mInitiateRegularFreeSpinButton.hide();
                  }
                  if(this.mInitiateRegularPaidSpinButton.IsVisible())
                  {
                     this.mInitiateRegularPaidSpinButton.hide();
                  }
               }
               else
               {
                  _loc5_ = this.mInitiatePremiumFreeSpinButton;
                  _loc6_ = this.mInitiatePremiumPaidSpinButton;
               }
               if(!_loc5_.IsVisible())
               {
                  _loc5_.show();
               }
               if(!_loc6_.IsVisible())
               {
                  _loc6_.show();
               }
               if(!this.mAreUserActionsAllowed)
               {
                  this.mInitiateRegularFreeSpinButton.SetDisabled(true);
                  this.mInitiateRegularFreeSpinButton.deactivate();
                  this.mInitiateRegularPaidSpinButton.SetDisabled(true);
                  this.mInitiateRegularPaidSpinButton.deactivate();
                  this.mInitiatePremiumFreeSpinButton.SetDisabled(true);
                  this.mInitiatePremiumFreeSpinButton.deactivate();
                  this.mInitiatePremiumPaidSpinButton.SetDisabled(true);
                  this.mInitiatePremiumPaidSpinButton.deactivate();
               }
               else if(_loc4_)
               {
                  this.mCurentlyActiveClaimButon = _loc5_;
                  _loc6_.hide();
                  _loc5_.show();
                  _loc5_.SetDisabled(false);
                  if(!_loc5_.isActive())
                  {
                     _loc5_.activate();
                  }
               }
               else
               {
                  this.mCurentlyActiveClaimButon = _loc6_;
                  _loc5_.hide();
                  _loc6_.show();
                  if(_loc7_ = _loc3_)
                  {
                     _loc6_.SetDisabled(false);
                     if(!_loc6_.isActive())
                     {
                        _loc6_.activate();
                     }
                  }
                  else
                  {
                     _loc6_.SetDisabled(true);
                     if(_loc6_.isActive())
                     {
                        _loc6_.deactivate();
                     }
                  }
               }
            }
         }
      }
      
      public function ShowSharePopup() : void
      {
         this.GetOrCreateSpinShareInfoViewContainer();
         this.mSpinShareInfoViewContainer.OpenSharePopup();
      }
      
      public function InitiateWholeSpinBoardClaimedSequence() : void
      {
         this.mSpinBoardClearedViewContainer = new SpinBoardClearedViewContainer();
         this.mSpinBoardClearedViewContainer.OpenSpinBoardClearedPopup();
      }
      
      public function SetSpinBoardOpenedCallback(param1:Function) : void
      {
         this.mSpinBoardOpenedCallback = param1;
      }
      
      public function SetSpinBoardClosedCallback(param1:Function) : void
      {
         this.mSpinBoardClosedCallback = param1;
      }
      
      public function OnSharePopupClosed() : void
      {
         this.mSpinShareInfoViewContainer.Reset();
         this.mSpinShareInfoViewContainer = null;
      }
      
      public function ActivatePremiumBoardAccessButton() : void
      {
         if(Blitz3App.app.sessionData.throttleManager.IsEnabled(ThrottleManager.THROTTLE_ENABLE_PREMIUMBOARD))
         {
            if(this.mAccessPremiumSpinBoardButton != null)
            {
               this.mAccessPremiumSpinBoardButton.activate();
               this.mAccessPremiumSpinBoardButton.show();
            }
         }
      }
      
      public function AreUserActionsAllowed() : Boolean
      {
         return this.mAreUserActionsAllowed;
      }
   }
}
