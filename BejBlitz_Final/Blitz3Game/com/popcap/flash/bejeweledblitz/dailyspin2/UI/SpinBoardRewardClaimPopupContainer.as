package com.popcap.flash.bejeweledblitz.dailyspin2.UI
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardController;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardFTUEHelper;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardInfo;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardPlayerDataHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardPlayerProgress;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardRewardClaimHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardRewardClaimState;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardRewardInfo;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardRewardType;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardState;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardTileInfo;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardType;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.TwoButtonDialog;
   import com.popcap.flash.bejeweledblitz.game.ui.game.sidebar.RareGemImageWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemImageLoader;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class SpinBoardRewardClaimPopupContainer
   {
       
      
      private var mSpinBoardRewardClaimPopup:SpinBoardRewardPopup;
      
      private var mGameWidget:Blitz3Game;
      
      private var mClaimState:uint;
      
      private var mSpinBoardInfo:SpinBoardInfo;
      
      private var mTileId:uint;
      
      private var mTileInfo:SpinBoardTileInfo;
      
      private var mErrorPopup:TwoButtonDialog;
      
      private var mClaimRewardButton:GenericButtonClip;
      
      private var mSelectedTrail:MovieClip;
      
      private var mCurrency1Trail:SpinRewardGoldbarTrailAnimation;
      
      private var mCurrency2Trail:SpinRewardDiamondTrailAnimation;
      
      private var mCurrency3Trail:SpinRewardShardsTrailAnimation;
      
      private var mCoinsTrail:SpinRewardCoinTrailAnimation;
      
      private var mSucceeded:Boolean;
      
      private var mRewardWidget:Sprite;
      
      public function SpinBoardRewardClaimPopupContainer()
      {
         super();
         this.Reset();
      }
      
      private function Reset() : void
      {
         this.mGameWidget = Blitz3App.app as Blitz3Game;
         this.mCurrency1Trail = null;
         this.mCurrency2Trail = null;
         this.mCurrency3Trail = null;
         this.mCoinsTrail = null;
         this.mSelectedTrail = null;
         this.mSucceeded = false;
         this.mSpinBoardInfo = null;
         this.mTileInfo = null;
         this.mTileId = 0;
         this.mClaimState = SpinBoardRewardClaimState.ClaimStateNotInitiated;
      }
      
      public function OpenSpinBoardRewardClaimPopup() : void
      {
         var _loc1_:SpinBoardRewardClaimHandler = SpinBoardController.GetInstance().GetRewardClaimHandler();
         this.mSpinBoardInfo = _loc1_.GetSpinBoard();
         this.mTileInfo = _loc1_.GetCurrentTileInfo();
         this.mTileId = _loc1_.GetCurrentTileId();
         if(this.mTileInfo == null || this.mSpinBoardInfo == null)
         {
            this.mTileInfo = _loc1_.GetLastTileInfo();
            this.mTileId = _loc1_.GetLastTileId();
            this.mSpinBoardInfo = _loc1_.GetLastSpinBoard();
            this.mClaimState = _loc1_.GetLastClaimState();
            _loc1_.OnRemainingClaimActionAcknowledged();
         }
         if(this.mTileInfo != null && this.mSpinBoardInfo != null)
         {
            if(this.mSpinBoardRewardClaimPopup == null)
            {
               this.mSpinBoardRewardClaimPopup = new SpinBoardRewardPopup();
               this.mGameWidget.mDSPlaceholder.addChild(this.mSpinBoardRewardClaimPopup);
            }
            SpinBoardUIController.GetInstance().GetSpinBoardContainer().GetOrCreateSpinBoardView().visible = false;
            this.mCurrency1Trail = this.mSpinBoardRewardClaimPopup.mSpinRewardGoldbartrail;
            this.mCurrency2Trail = this.mSpinBoardRewardClaimPopup.mSpinRewardDiamondtrail;
            this.mCurrency3Trail = this.mSpinBoardRewardClaimPopup.mSpinRewardShardstrail;
            this.mCoinsTrail = this.mSpinBoardRewardClaimPopup.mSpinRewardCointrail;
            if(this.mSpinBoardRewardClaimPopup.mSpinRewardTokentrail != null)
            {
               this.mSpinBoardRewardClaimPopup.mSpinRewardTokentrail.visible = false;
            }
            this.mCurrency1Trail.visible = false;
            this.mCurrency2Trail.visible = false;
            this.mCurrency3Trail.visible = false;
            this.mCoinsTrail.visible = false;
            this.mClaimRewardButton = new GenericButtonClip(Blitz3App.app,this.mSpinBoardRewardClaimPopup.mClaimRewardButton);
            this.mClaimRewardButton.setRelease(this.OnClaimButtonClicked);
            this.mClaimRewardButton.hide();
            this.mSpinBoardRewardClaimPopup.mLoaderText.visible = true;
            this.mSpinBoardRewardClaimPopup.mLoaderText.text = "Unpacking your rewards. Please wait.";
            this.SetupRewards();
            this.mSpinBoardRewardClaimPopup.visible = true;
            Blitz3App.app.SoundManager.playSound(Blitz3GameSounds.SOUND_SPINBOARD_REWARD_POPUP);
            if(_loc1_.GetCurrentState() != SpinBoardRewardClaimState.ClaimStateInitiated)
            {
               this.OnClaimStateChanged();
            }
         }
      }
      
      public function ShowTrailAndClose() : void
      {
         this.mClaimRewardButton.hide();
         var _loc1_:SpinBoardRewardInfo = this.mTileInfo.GetRewards()[0];
         var _loc2_:int = _loc1_.GetRewardType();
         var _loc3_:String = _loc1_.GetRewardTypeString();
         if(_loc2_ == SpinBoardRewardType.RewardTypeCurrency)
         {
            if(_loc3_ == CurrencyManager.TYPE_COINS)
            {
               this.mSelectedTrail = this.mCoinsTrail;
            }
            else if(_loc3_ == CurrencyManager.TYPE_GOLDBARS)
            {
               this.mSelectedTrail = this.mCurrency1Trail;
            }
            else if(_loc3_ == CurrencyManager.TYPE_DIAMONDS)
            {
               this.mSelectedTrail = this.mCurrency2Trail;
            }
            else
            {
               this.mSelectedTrail = this.mCurrency3Trail;
            }
            if(this.mSelectedTrail.currentFrame != 0)
            {
               this.mSelectedTrail.addEventListener(Event.ENTER_FRAME,this.OnTrailUpdate);
               this.mSelectedTrail.visible = true;
               this.mSelectedTrail.gotoAndPlay(0);
            }
         }
         else
         {
            this.CloseSpinBoardRewardClaimPopup();
         }
      }
      
      public function OnTrailUpdate(param1:Event) : void
      {
         if(this.mSelectedTrail != null && this.mSelectedTrail.currentFrame == this.mSelectedTrail.totalFrames - 1)
         {
            this.mSelectedTrail.removeEventListener(Event.ENTER_FRAME,this.OnTrailUpdate);
            this.CloseSpinBoardRewardClaimPopup();
         }
      }
      
      public function OnClaimButtonClicked() : void
      {
         Blitz3App.app.SoundManager.playSound(Blitz3GameSounds.SOUND_SPINBOARD_REWARD_TAP_CLAIM);
         this.ShowTrailAndClose();
      }
      
      private function SetupRewards() : void
      {
         var _loc1_:SpinBoardRewardInfo = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:* = false;
         var _loc5_:SpinBoardPlayerDataHandler = null;
         var _loc6_:SpinBoardInfo = null;
         var _loc7_:SpinBoardPlayerProgress = null;
         var _loc8_:Boolean = false;
         var _loc9_:MovieClip = null;
         var _loc10_:Blitz3App = null;
         var _loc11_:RareGemImageWidget = null;
         var _loc12_:Image_Spins = null;
         if(this.mSpinBoardRewardClaimPopup != null)
         {
            _loc1_ = this.mTileInfo.GetRewards()[0];
            _loc2_ = _loc1_.GetName();
            _loc3_ = _loc1_.GetRewardTypeString();
            this.mSpinBoardRewardClaimPopup.mRewardCountClip.mRewardCountText.text = Utils.formatNumberToBJBNumberString(_loc1_.GetAmount());
            this.mSpinBoardRewardClaimPopup.mRewardNameClip.mRewardNameText.text = _loc1_.GetDisplayName();
            _loc4_ = this.mSpinBoardInfo.GetType() == SpinBoardType.RegularBoard;
            this.mSpinBoardRewardClaimPopup.mRegularglow.visible = _loc4_;
            this.mSpinBoardRewardClaimPopup.mPremiumglow.visible = !_loc4_;
            _loc5_ = SpinBoardController.GetInstance().GetPlayerDataHandler();
            _loc6_ = SpinBoardController.GetInstance().GetActiveSpinBoardInfo();
            if(_loc8_ = (_loc7_ = _loc5_.GetBoardProgressByType(_loc6_.GetType())).GetUpgradeStatus(this.mTileId))
            {
               if(this.mSpinBoardRewardClaimPopup.mCelebrationPanel.CelebrationText != null)
               {
                  this.mSpinBoardRewardClaimPopup.mCelebrationPanel.CelebrationText.text = "YOU WON A SPECIAL REWARD!";
               }
               this.mSpinBoardRewardClaimPopup.mRewardCountClip.mRewardCountText.textColor = 65280;
            }
            else
            {
               if(this.mSpinBoardRewardClaimPopup.mCelebrationPanel.CelebrationText != null)
               {
                  this.mSpinBoardRewardClaimPopup.mCelebrationPanel.CelebrationText.text = "YOU\'VE WON!";
               }
               this.mSpinBoardRewardClaimPopup.mRewardCountClip.mRewardCountText.textColor = 16777215;
            }
            if(this.mRewardWidget != null && this.mRewardWidget.parent != null)
            {
               this.mSpinBoardRewardClaimPopup.mRewardIcon.removeChild(this.mRewardWidget);
               this.mRewardWidget = null;
            }
            switch(_loc1_.GetRewardType())
            {
               case SpinBoardRewardType.RewardTypeCurrency:
                  _loc9_ = CurrencyManager.getImageByType(_loc3_,false,"");
                  this.mSpinBoardRewardClaimPopup.mRewardIcon.addChild(_loc9_);
                  _loc9_.x += 10;
                  break;
               case SpinBoardRewardType.RewardTypeGems:
                  _loc10_ = Blitz3App.app;
                  (_loc11_ = new RareGemImageWidget(_loc10_,new DynamicRareGemImageLoader(_loc10_),"small",0,0,0.7,0.7,false)).reset(_loc10_.logic.rareGemsLogic.GetRareGemByStringID(_loc2_));
                  this.mSpinBoardRewardClaimPopup.mRewardIcon.addChild(_loc11_);
                  break;
               case SpinBoardRewardType.RewardTypeSpins:
                  _loc12_ = new Image_Spins();
                  this.mSpinBoardRewardClaimPopup.mRewardIcon.addChild(_loc12_);
                  _loc12_.scaleX *= 1.2;
                  _loc12_.scaleY *= 1.2;
            }
         }
      }
      
      public function OnClaimRequested() : void
      {
         SpinBoardController.GetInstance().GetRewardClaimHandler().ReInitiateClaim();
      }
      
      public function OnClaimSucceeded() : void
      {
         if(this.mSpinBoardRewardClaimPopup != null)
         {
            this.mSpinBoardRewardClaimPopup.mLoadingClip.visible = false;
            this.mSpinBoardRewardClaimPopup.mLoaderText.visible = false;
            this.mClaimRewardButton.activate();
            this.mClaimRewardButton.show();
            this.mSucceeded = true;
         }
      }
      
      public function OnClaimStateChanged() : void
      {
         var _loc1_:SpinBoardRewardClaimHandler = null;
         var _loc2_:uint = 0;
         if(this.mSpinBoardRewardClaimPopup != null)
         {
            _loc1_ = SpinBoardController.GetInstance().GetRewardClaimHandler();
            _loc2_ = SpinBoardRewardClaimState.ClaimStateNotInitiated;
            if(_loc1_.GetSpinBoard() != null)
            {
               _loc2_ = SpinBoardController.GetInstance().GetRewardClaimHandler().GetCurrentState();
            }
            else if(this.mSpinBoardInfo != null)
            {
               _loc2_ = this.mClaimState;
            }
            switch(_loc2_)
            {
               case SpinBoardRewardClaimState.ClaimStateSuccess:
                  this.OnClaimSucceeded();
                  break;
               case SpinBoardRewardClaimState.ClaimStateFailed:
                  this.ShowErrorPopup("Oops!","We couldn\'t retrieve your reward. Please check your network connection and try again. Your Spin balance was not deducted.");
                  break;
               case SpinBoardRewardClaimState.ClaimStateFreeSpinAlreadyRedeemed:
                  this.ShowErrorPopup("Oops!","You are out of FREE SPINS.");
                  break;
               case SpinBoardRewardClaimState.ClaimStateOutOfSpins:
                  this.ShowErrorPopup("No Spins Available!","You can always purchase more Spins from the store.");
                  break;
               case SpinBoardRewardClaimState.ClaimAlreadyProcessed:
                  this.ShowErrorPopup("Oops!","You have already claimed this reward.");
                  break;
               case SpinBoardRewardClaimState.ClaimStateSpinBoardExpired:
                  this.ShowErrorPopup("Relaunch Spins!","The current board has expired. Please relaunch to access the new Spin board.");
                  break;
               case SpinBoardRewardClaimState.ClaimSpinBoardNotActive:
                  this.ShowErrorPopup("Relaunch Spins!","The Spin board is not active. Please relaunch to access the new Spin board.");
                  break;
               case SpinBoardRewardClaimState.ClaimSpinBoardInvalidClaimTimeStamp:
                  this.ShowErrorPopup("Oops!","We couldn\'t retrieve your reward. Please check your network connection and try again. Your Spin balance was not deducted.");
                  break;
               case SpinBoardRewardClaimState.ClaimSpinBoardInvalidRequest:
                  this.ShowErrorPopup("Oops!","We couldn\'t retrieve your reward. Please check your network connection and try again. Your Spin balance was not deducted.");
            }
         }
      }
      
      public function CloseSpinBoardRewardClaimPopup() : void
      {
         this.mSelectedTrail = null;
         SpinBoardUIController.GetInstance().GetSpinBoardContainer().GetOrCreateSpinBoardView().visible = true;
         if(this.mSpinBoardRewardClaimPopup != null)
         {
            this.mSpinBoardRewardClaimPopup.visible = false;
            this.mGameWidget.mDSPlaceholder.removeChild(this.mSpinBoardRewardClaimPopup);
            this.mSpinBoardRewardClaimPopup = null;
         }
         SpinBoardController.GetInstance().GetStateHandler().SetState(SpinBoardState.BoardRunning);
         (Blitz3App.app.ui as MainWidgetGame).menu.leftPanel.ValidateSpinBoardStatus();
         var _loc1_:SpinBoardInfo = SpinBoardController.GetInstance().GetActiveSpinBoardInfo();
         if(_loc1_ != null && _loc1_.IsFTUEBoard() && this.mSucceeded)
         {
            Blitz3App.app.bjbEventDispatcher.SendEvent(SpinBoardFTUEHelper.SPINBOARD_REGULAR_CLAIM_COMPLETE,null);
            SpinBoardController.GetInstance().GetFTUEHelper().OnFTUERegularBoardSpinClaimCompleted();
            this.mSucceeded = false;
         }
         this.Reset();
      }
      
      public function ShowErrorPopup(param1:String, param2:String) : void
      {
         this.mErrorPopup = new TwoButtonDialog(Blitz3App.app,16);
         this.mErrorPopup.Init();
         this.mErrorPopup.SetDimensions(420,216);
         this.mErrorPopup.SetContent(param1,param2,"RETRY","CANCEL");
         this.mErrorPopup.x = Dimensions.LEFT_BORDER_WIDTH + Dimensions.GAME_WIDTH / 2 - this.mErrorPopup.width / 2;
         this.mErrorPopup.y = Dimensions.TOP_BORDER_WIDTH + Dimensions.GAME_HEIGHT / 2 - this.mErrorPopup.height / 2;
         this.mErrorPopup.AddAcceptButtonHandler(this.OnRetryButtonClicked);
         this.mErrorPopup.AddDeclineButtonHandler(this.OnCancelButtonClicked);
         (Blitz3App.app as Blitz3Game).metaUI.highlight.showPopUp(this.mErrorPopup,true,true,0.55);
      }
      
      public function OnRetryButtonClicked(param1:MouseEvent) : void
      {
         (Blitz3App.app as Blitz3Game).metaUI.highlight.hidePopUp();
         this.OnClaimRequested();
      }
      
      public function OnCancelButtonClicked(param1:MouseEvent) : void
      {
         (Blitz3App.app as Blitz3Game).metaUI.highlight.hidePopUp();
         this.mSucceeded = false;
         SpinBoardController.GetInstance().GetRewardClaimHandler().OnClaimRetryCanceled();
         this.CloseSpinBoardRewardClaimPopup();
      }
   }
}
