package com.popcap.flash.bejeweledblitz.dailyspin2.UI
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardController;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardFTUEHelper;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardInfo;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardPlayerProgress;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardType;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class SpinBoardViewContainer
   {
      
      private static var animation_Intro:String = "intro";
      
      private static var animation_SpinBoardRegularToPremium_part1:String = "regularoutro1";
      
      private static var animation_SpinBoardRegularToPremium_part2:String = "regularoutro2";
      
      private static var animation_SpinBoardPremiumToRegular_part1:String = "premiumoutro1";
      
      private static var animation_SpinBoardPremiumToRegular_part2:String = "premiumoutro2";
       
      
      private var mSpinBoardView:SpinBoardView;
      
      private var mSpinBoardUIState:uint;
      
      private var mPreviousSpinBoardUIState:uint;
      
      private var mGameWidget:Blitz3Game;
      
      private var mFrenzyBarContainers:Vector.<SpinBoardFrenzyBarContainer>;
      
      private var mFrenzyBarUpdateCount:int = 0;
      
      private var mFrenzyBarFullCount:int = 0;
      
      private var mCurrentBoardPanel:MovieClip;
      
      private var mPremiumBoardPurchaseButton:StorePurchaseButtonContainer;
      
      public function SpinBoardViewContainer()
      {
         super();
         this.mGameWidget = Blitz3App.app as Blitz3Game;
         this.mFrenzyBarUpdateCount = 0;
      }
      
      public function OpenSpinBoard() : SpinBoardView
      {
         var _loc1_:Blitz3App = null;
         var _loc2_:GenericButtonClip = null;
         var _loc3_:GenericButtonClip = null;
         var _loc4_:GenericButtonClip = null;
         if(this.mGameWidget != null)
         {
            this.GetOrCreateSpinBoardView();
            this.mFrenzyBarUpdateCount = 0;
            this.mGameWidget.mDSPlaceholder.addChild(this.mSpinBoardView);
            this.mSpinBoardView.visible = true;
            this.mSpinBoardView.gotoAndStop(0);
            this.mSpinBoardView.mRewardUpgradedPanel.gotoAndStop(0);
            this.mSpinBoardView.mRewardUpgradedPanel.visible = false;
            this.mFrenzyBarContainers = new Vector.<SpinBoardFrenzyBarContainer>();
            this.mFrenzyBarContainers.push(new SpinBoardFrenzyBarContainer());
            this.mFrenzyBarContainers.push(new SpinBoardFrenzyBarContainer());
            this.mFrenzyBarContainers[0].Init(this.mSpinBoardView.mFrenzyBarPanelLeft);
            this.mFrenzyBarContainers[1].Init(this.mSpinBoardView.mFrenzyBarPanelRight);
            _loc1_ = Blitz3App.app;
            _loc2_ = new GenericButtonClip(_loc1_,this.mSpinBoardView.mCloseButton);
            _loc2_.setRelease(this.OnCloseButtonClicked);
            _loc2_.activate();
            _loc2_.show();
            _loc3_ = new GenericButtonClip(_loc1_,this.mSpinBoardView.mWhatsNewButton);
            _loc3_.setRelease(this.OnHowToPlayButtonClicked);
            _loc3_.activate();
            _loc3_.show();
            (_loc4_ = new GenericButtonClip(_loc1_,this.mSpinBoardView.mWatchAdPanel.mSpinWatchAdBtn)).setRelease(this.OnWatchAdButtonClicked);
            _loc4_.activate();
            _loc4_.show();
            (Blitz3App.app.ui as MainWidgetGame).menu.visible = false;
            return this.mSpinBoardView;
         }
         return null;
      }
      
      public function OnHowToPlayButtonClicked() : void
      {
         var howToPlayPopup:DailySpinHowToPlay = null;
         var closeButtonClip:GenericButtonClip = null;
         if(SpinBoardUIController.GetInstance().AreUserActionsAllowed())
         {
            howToPlayPopup = new DailySpinHowToPlay();
            if(howToPlayPopup != null)
            {
               this.mGameWidget.mDSPlaceholder.addChild(howToPlayPopup);
            }
            closeButtonClip = new GenericButtonClip(Blitz3App.app,howToPlayPopup.WhatsNewCloseButton);
            closeButtonClip.setRelease(function():void
            {
               howToPlayPopup.visible = false;
               mGameWidget.mDSPlaceholder.removeChild(howToPlayPopup);
               howToPlayPopup = null;
            });
            closeButtonClip.activate();
            closeButtonClip.show();
         }
      }
      
      public function OnCloseButtonClicked() : void
      {
         if(SpinBoardUIController.GetInstance().AreUserActionsAllowed())
         {
            SpinBoardController.GetInstance().CloseSpinBoard();
         }
      }
      
      public function OnWatchAdButtonClicked() : void
      {
         if(SpinBoardUIController.GetInstance().AreUserActionsAllowed())
         {
            SpinBoardController.GetInstance().GetNetHandler().HandleWatchAdBtnClicked();
         }
      }
      
      public function GetOrCreateSpinBoardView() : SpinBoardView
      {
         if(this.mSpinBoardView == null)
         {
            this.mSpinBoardView = new SpinBoardView();
            this.mSpinBoardView.visible = false;
         }
         return this.mSpinBoardView;
      }
      
      public function CloseSpinBoardView() : void
      {
         this.mFrenzyBarContainers[0] = null;
         this.mFrenzyBarContainers[1] = null;
         this.mFrenzyBarContainers = null;
         if(this.mSpinBoardView != null)
         {
            this.mGameWidget.mDSPlaceholder.removeChild(this.mSpinBoardView);
            this.mSpinBoardView.visible = false;
            (Blitz3App.app.ui as MainWidgetGame).menu.visible = true;
         }
         this.mSpinBoardView = null;
      }
      
      public function GetCurrentUIState() : uint
      {
         return this.mSpinBoardUIState;
      }
      
      public function SetSpinBoardUIState(param1:uint) : void
      {
         var _loc2_:SpinBoardUIController = null;
         var _loc3_:String = null;
         if(param1 == SpinBoardUIState.Invalid)
         {
            this.mSpinBoardUIState = SpinBoardUIState.Invalid;
            this.mPreviousSpinBoardUIState = this.mSpinBoardUIState;
         }
         else
         {
            this.mPreviousSpinBoardUIState = this.mSpinBoardUIState;
            this.mSpinBoardUIState = param1;
            _loc2_ = SpinBoardUIController.GetInstance();
            _loc2_.GetTilesHandler().StopListeningHighlighterUpdates();
            this.mSpinBoardView.mGlowEffects.visible = false;
            _loc2_.SetAllowUserActions(false);
            _loc2_.CloseStoreAndWatchAdPanel();
            _loc3_ = "";
            switch(this.mSpinBoardUIState)
            {
               case SpinBoardUIState.RegularBoard:
                  if(this.mPreviousSpinBoardUIState == SpinBoardUIState.Invalid || this.mPreviousSpinBoardUIState == this.mSpinBoardUIState)
                  {
                     _loc3_ = animation_Intro;
                     this.mSpinBoardView.mRegularBoardPanel.visible = true;
                     this.mSpinBoardView.mRegularHeaderPanel.visible = true;
                     this.mSpinBoardView.mPremiumBoardPanel.visible = false;
                     this.mSpinBoardView.mPremiumHeaderPanel.visible = false;
                     SpinBoardUIController.GetInstance().RefreshView(false);
                  }
                  else
                  {
                     _loc3_ = animation_SpinBoardPremiumToRegular_part1;
                  }
                  this.mCurrentBoardPanel = this.mSpinBoardView.mRegularBoardPanel;
                  break;
               case SpinBoardUIState.PremiumBoard:
                  if(this.mPreviousSpinBoardUIState == SpinBoardUIState.Invalid || this.mPreviousSpinBoardUIState == SpinBoardUIState.PremiumBoardPreview || this.mPreviousSpinBoardUIState == this.mSpinBoardUIState)
                  {
                     _loc3_ = animation_Intro;
                     this.mSpinBoardView.mRegularBoardPanel.visible = false;
                     this.mSpinBoardView.mRegularHeaderPanel.visible = false;
                     this.mSpinBoardView.mPremiumBoardPanel.visible = true;
                     this.mSpinBoardView.mPremiumHeaderPanel.visible = true;
                     SpinBoardUIController.GetInstance().RefreshView(false);
                  }
                  else
                  {
                     _loc3_ = animation_SpinBoardRegularToPremium_part1;
                  }
                  this.mCurrentBoardPanel = this.mSpinBoardView.mPremiumBoardPanel;
                  this.ValidatePremiumBoardBottomPanel();
                  break;
               case SpinBoardUIState.PremiumBoardPreview:
                  this.ValidatePremiumBoardBottomPanel();
                  if(this.mPreviousSpinBoardUIState == SpinBoardUIState.PremiumBoard || this.mPreviousSpinBoardUIState == SpinBoardUIState.PremiumBoardPreview)
                  {
                     _loc3_ = animation_Intro;
                     SpinBoardUIController.GetInstance().RefreshView(false);
                  }
                  else
                  {
                     _loc3_ = animation_SpinBoardRegularToPremium_part1;
                  }
                  this.mCurrentBoardPanel = this.mSpinBoardView.mPremiumBoardPanel;
                  this.mSpinBoardView.mPremiumBoardPanel.mPremiumBoardBottomPanel.visible = true;
            }
            if(_loc3_ != "")
            {
               if(_loc3_ == animation_SpinBoardPremiumToRegular_part1)
               {
                  this.mSpinBoardView.addEventListener(Event.ENTER_FRAME,this.OnPremiumOutroEnterFrame);
               }
               else if(_loc3_ == animation_SpinBoardRegularToPremium_part1)
               {
                  this.mSpinBoardView.addEventListener(Event.ENTER_FRAME,this.OnRegularOutroEnterFrame);
               }
               else
               {
                  Utils.logWithStackTrace(this,"OnIntroEnterFrame : ADDED");
                  this.mSpinBoardView.addEventListener(Event.ENTER_FRAME,this.OnIntroEnterFrame);
               }
               this.mSpinBoardView.gotoAndPlay(_loc3_);
            }
         }
      }
      
      public function OnIntroEnterFrame(param1:Event) : void
      {
         if(this.mSpinBoardView == null)
         {
            param1.currentTarget.removeEventListener(Event.ENTER_FRAME,this.OnIntroEnterFrame);
            return;
         }
         Utils.logWithStackTrace(this,"OnIntroEnterFrame : CALLED");
         var _loc2_:int = Utils.GetAnimationLastFrame(this.mSpinBoardView,animation_Intro);
         if(_loc2_ == this.mSpinBoardView.currentFrame)
         {
            Utils.logWithStackTrace(this,"OnIntroEnterFrame : REMOVED");
            this.mSpinBoardView.removeEventListener(Event.ENTER_FRAME,this.OnIntroEnterFrame);
            this.mSpinBoardView.mGlowEffects.visible = !Blitz3App.app.isLQMode;
            if(!Blitz3App.app.isLQMode)
            {
               if(this.mSpinBoardUIState == SpinBoardUIState.PremiumBoardPreview)
               {
                  this.mSpinBoardView.mGlowEffects.gotoAndPlay("behind");
               }
               else
               {
                  this.mSpinBoardView.mGlowEffects.gotoAndPlay("normal");
               }
            }
            SpinBoardController.GetInstance().GetHighlightController().ResumeHighlighter();
            SpinBoardUIController.GetInstance().SetAllowUserActions(true);
         }
      }
      
      public function ValidatePremiumBoardBottomPanel() : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:* = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc1_:MovieClip = this.mSpinBoardView.mPremiumBoardPanel.mPremiumBoardBottomPanel;
         _loc1_.visible = this.mSpinBoardUIState == SpinBoardUIState.PremiumBoardPreview;
         var _loc2_:int = 0;
         var _loc3_:SpinBoardInfo = SpinBoardUIController.GetInstance().GetCurrentlyShowingSpinBoard();
         if(_loc3_ != null)
         {
            if(_loc3_.GetProductInfo() != null)
            {
               _loc2_ = _loc3_.GetProductInfo().GetAmount();
            }
            _loc1_.mExtraSpinsPanel.visible = _loc2_ > 0;
            if(_loc2_ > 0)
            {
               _loc1_.mExtraSpinsPanel.FreeSpinCount_TXT.text = _loc2_.toString();
            }
            _loc4_ = _loc3_.GetPremiumBoardDurationTime();
            _loc4_ = uint(_loc4_ / 3600);
            _loc5_ = String(_loc4_) + " Hours";
            if(1 == _loc4_)
            {
               _loc5_ = "1 Hour";
            }
            if(_loc1_.PRMBoard_Timer.text != _loc5_)
            {
               _loc1_.PRMBoard_Timer.text = _loc5_;
            }
            _loc6_ = _loc3_.GetOfferTextLarge();
            if(_loc1_.mMarkettingBannerPanel.MLT_TXT.text != _loc6_)
            {
               _loc1_.mMarkettingBannerPanel.MLT_TXT.text = _loc6_;
            }
            _loc7_ = _loc3_.GetOfferTextSmall();
            if(_loc1_.mMarkettingBannerPanel.MLT_DIS_TXT.text != _loc7_)
            {
               _loc1_.mMarkettingBannerPanel.MLT_DIS_TXT.text = _loc7_;
            }
            if(this.mPremiumBoardPurchaseButton != null)
            {
               this.mPremiumBoardPurchaseButton.Deactivate();
            }
            this.mPremiumBoardPurchaseButton = new StorePurchaseButtonContainer(_loc1_.mPremiumBoardPurchaseButton);
            this.mPremiumBoardPurchaseButton.SetInfo(SpinBoardUIController.GetInstance().GetCurrentlyShowingSpinBoard().GetProductInfo(),this.OnBoardPurchaseRequested);
         }
      }
      
      public function OnBoardPurchaseRequested() : void
      {
         var spinBoard:SpinBoardInfo = null;
         var dialog:DeluxeBoardPurchasePopup = null;
         var purchaseCallback:Function = null;
         var spinBoardInfo:SpinBoardInfo = null;
         spinBoard = SpinBoardUIController.GetInstance().GetCurrentlyShowingSpinBoard();
         if(spinBoard != null)
         {
            if(spinBoard.IsFTUEBoard())
            {
               Blitz3App.app.bjbEventDispatcher.SendEvent(SpinBoardFTUEHelper.SPINBOARD_FREE_PREMIUMBOARD_PURCHASE_REQUESTED,null);
               SpinBoardController.GetInstance().GetBoardPurchaseHandler().PurchaseBoard(spinBoard.GetId());
            }
            else if(spinBoard.GetProductInfo() != null && spinBoard.GetProductInfo().IsFree())
            {
               SpinBoardController.GetInstance().GetBoardPurchaseHandler().PurchaseBoard(spinBoard.GetId());
            }
            else
            {
               dialog = new DeluxeBoardPurchasePopup();
               purchaseCallback = function():void
               {
                  dialog.Close();
                  SpinBoardController.GetInstance().GetBoardPurchaseHandler().PurchaseBoard(spinBoard.GetId());
               };
               spinBoardInfo = SpinBoardController.GetInstance().GetCatalogue().GetSpinBoardInfo(spinBoard.GetId());
               dialog.Init("Spins Purchase","Are you sure you want to purchase this product?",spinBoardInfo.GetProductInfo(),purchaseCallback);
               dialog.Open();
            }
         }
      }
      
      public function OnPremiumOutroEnterFrame(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:SpinBoardUIController = null;
         if(this.mSpinBoardView != null)
         {
            _loc2_ = Utils.GetAnimationLastFrame(this.mSpinBoardView,animation_SpinBoardPremiumToRegular_part1);
            _loc3_ = Utils.GetAnimationLastFrame(this.mSpinBoardView,animation_SpinBoardPremiumToRegular_part2);
            if(_loc2_ == this.mSpinBoardView.currentFrame)
            {
               this.mSpinBoardView.mRegularBoardPanel.visible = true;
               this.mSpinBoardView.mRegularHeaderPanel.visible = true;
               this.mSpinBoardView.mPremiumBoardPanel.visible = false;
               this.mSpinBoardView.mPremiumHeaderPanel.visible = false;
               (_loc4_ = SpinBoardUIController.GetInstance()).ValidateClaimButtonState();
               _loc4_.RefreshView(false);
               this.mSpinBoardView.gotoAndPlay(animation_SpinBoardPremiumToRegular_part2);
            }
            else if(_loc3_ == this.mSpinBoardView.currentFrame)
            {
               this.mSpinBoardView.removeEventListener(Event.ENTER_FRAME,this.OnPremiumOutroEnterFrame);
               this.mSpinBoardView.mGlowEffects.visible = !Blitz3App.app.isLQMode;
               SpinBoardUIController.GetInstance().SetAllowUserActions(true);
               if(!Blitz3App.app.isLQMode)
               {
                  this.mSpinBoardView.mGlowEffects.gotoAndPlay("normal");
               }
            }
         }
      }
      
      public function OnRegularOutroEnterFrame(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this.mSpinBoardView != null)
         {
            _loc2_ = Utils.GetAnimationLastFrame(this.mSpinBoardView,animation_SpinBoardRegularToPremium_part1);
            _loc3_ = Utils.GetAnimationLastFrame(this.mSpinBoardView,animation_SpinBoardRegularToPremium_part2);
            if(_loc2_ == this.mSpinBoardView.currentFrame)
            {
               this.mSpinBoardView.mPremiumBoardPanel.visible = true;
               this.mSpinBoardView.mPremiumHeaderPanel.visible = true;
               this.mSpinBoardView.mRegularBoardPanel.visible = false;
               this.mSpinBoardView.mRegularHeaderPanel.visible = false;
               SpinBoardUIController.GetInstance().RefreshView(false);
               this.mSpinBoardView.gotoAndPlay(animation_SpinBoardRegularToPremium_part2);
            }
            else if(_loc3_ == this.mSpinBoardView.currentFrame)
            {
               this.mSpinBoardView.removeEventListener(Event.ENTER_FRAME,this.OnRegularOutroEnterFrame);
               this.mSpinBoardView.mGlowEffects.visible = !Blitz3App.app.isLQMode;
               SpinBoardUIController.GetInstance().SetAllowUserActions(true);
               if(!Blitz3App.app.isLQMode)
               {
                  if(this.mSpinBoardUIState == SpinBoardUIState.PremiumBoardPreview)
                  {
                     this.mSpinBoardView.mGlowEffects.gotoAndPlay("behind");
                  }
                  else
                  {
                     this.mSpinBoardView.mGlowEffects.gotoAndPlay("normal");
                  }
               }
            }
         }
      }
      
      public function ValidateFrenzyBarStatus(param1:Boolean) : Boolean
      {
         var _loc7_:SpinBoardPlayerProgress = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:SpinBoardInfo = SpinBoardUIController.GetInstance().GetCurrentlyShowingSpinBoard();
         var _loc5_:* = false;
         if(this.mSpinBoardUIState != SpinBoardUIState.PremiumBoardPreview)
         {
            _loc2_ = SpinBoardController.GetInstance().GetFrenzyBarTotalStepsForCurrentBoard();
            _loc3_ = SpinBoardController.GetInstance().GetFrenzyBarCurrentStepsForCurrentBoard();
            if(_loc4_ != null)
            {
               _loc5_ = (_loc7_ = SpinBoardController.GetInstance().GetPlayerDataHandler().GetBoardProgressByType(_loc4_.GetType())).GetClaimedBitField() != 0;
            }
         }
         this.mFrenzyBarUpdateCount = 0;
         var _loc6_:Boolean = this.mFrenzyBarContainers[0].SetInfo(this.mSpinBoardUIState != SpinBoardUIState.RegularBoard,_loc2_,_loc3_,_loc5_,param1,this.OnFrenzyBarUpdated,this.OnFrenzyBarFull);
         this.mFrenzyBarContainers[1].SetInfo(this.mSpinBoardUIState != SpinBoardUIState.RegularBoard,_loc2_,_loc3_,_loc5_,param1,this.OnFrenzyBarUpdated,this.OnFrenzyBarFull);
         return _loc6_;
      }
      
      public function OnFrenzyBarFull(param1:Boolean) : void
      {
         ++this.mFrenzyBarFullCount;
         if(this.mFrenzyBarFullCount == 2)
         {
            SpinBoardUIController.GetInstance().OnFrenzyBarsFull(param1);
         }
      }
      
      public function OnFrenzyBarUpdated(param1:Boolean) : void
      {
         ++this.mFrenzyBarUpdateCount;
         if(this.mFrenzyBarUpdateCount == 2)
         {
            SpinBoardUIController.GetInstance().OnFrenzyBarsUpdated(param1);
         }
      }
      
      public function ValidateTimers() : void
      {
         var _loc9_:SpinBoardPlayerProgress = null;
         var _loc10_:* = false;
         var _loc11_:String = null;
         if(this.mCurrentBoardPanel == null)
         {
            return;
         }
         var _loc1_:* = this.mSpinBoardUIState == SpinBoardUIState.PremiumBoardPreview;
         var _loc2_:Boolean = SpinBoardController.GetInstance().GetPlayerDataHandler().HasFreeSpinAvailable();
         var _loc3_:Number = SpinBoardController.GetInstance().GetPlayerDataHandler().GetNextFreeSpinAvailableTime();
         var _loc4_:Number = new Date().time / 1000;
         var _loc5_:Number = _loc3_ - _loc4_;
         var _loc6_:String = "";
         if(_loc2_ || _loc1_)
         {
            this.mCurrentBoardPanel.mNextFreeSpinPanel.mUseFreeSpin.visible = !_loc1_;
            this.mCurrentBoardPanel.mNextFreeSpinPanel.mNextSpinStatic.visible = false;
            this.mCurrentBoardPanel.mNextFreeSpinPanel.mNextFreeSpinTimerText.visible = false;
         }
         else if(!_loc2_ && _loc5_ > 0)
         {
            this.mCurrentBoardPanel.mNextFreeSpinPanel.mUseFreeSpin.visible = false;
            this.mCurrentBoardPanel.mNextFreeSpinPanel.mNextSpinStatic.visible = true;
            this.mCurrentBoardPanel.mNextFreeSpinPanel.mNextFreeSpinTimerText.visible = true;
            _loc6_ = Utils.getHourStringFromSeconds(_loc5_).toString();
            if(this.mCurrentBoardPanel.mNextFreeSpinPanel.mNextFreeSpinTimerText.text != _loc6_)
            {
               this.mCurrentBoardPanel.mNextFreeSpinPanel.mNextFreeSpinTimerText.text = _loc6_;
            }
         }
         _loc6_ = "";
         var _loc7_:SpinBoardInfo = SpinBoardUIController.GetInstance().GetCurrentlyShowingSpinBoard();
         var _loc8_:Boolean = true;
         if(_loc7_ != null)
         {
            _loc9_ = SpinBoardController.GetInstance().GetPlayerDataHandler().GetBoardProgressByType(_loc7_.GetType());
            if(_loc7_.GetType() == SpinBoardType.PremiumBoard && this.mSpinBoardUIState == SpinBoardUIState.PremiumBoardPreview)
            {
               _loc6_ = _loc7_.GetPreviewText();
            }
            else
            {
               if(_loc9_ != null && _loc9_.GetBoardResetTime() > 0)
               {
                  _loc5_ = _loc9_.GetBoardResetTime() - _loc4_;
               }
               else if(_loc7_.GetType() != SpinBoardType.PremiumBoard)
               {
                  if(_loc7_.IsFTUEBoard())
                  {
                     _loc8_ = false;
                  }
                  else
                  {
                     _loc5_ = _loc7_.GetEndTime() - _loc4_;
                  }
               }
               else
               {
                  _loc8_ = false;
               }
               if(_loc5_ < 0)
               {
                  _loc5_ = 0;
               }
            }
         }
         if(!_loc8_)
         {
            this.mCurrentBoardPanel.mBoardResetTimer.mTimerText.visible = false;
            this.mCurrentBoardPanel.mBoardResetTimer.mExpiryTextStatic.visible = false;
            this.mCurrentBoardPanel.mBoardResetTimer.mPreviewText.visible = false;
         }
         else
         {
            _loc10_ = _loc5_ / 60 < 60;
            _loc11_ = Utils.getHourStringFromSeconds(_loc5_).toString();
            if(this.mCurrentBoardPanel.mBoardResetTimer.mTimerText.text != _loc11_)
            {
               this.mCurrentBoardPanel.mBoardResetTimer.mTimerText.text = _loc11_;
            }
            if(_loc10_)
            {
               this.mCurrentBoardPanel.mBoardResetTimer.mTimerText.textColor = 16723968;
            }
            else
            {
               this.mCurrentBoardPanel.mBoardResetTimer.mTimerText.textColor = 16777215;
            }
            this.mCurrentBoardPanel.mBoardResetTimer.mTimerText.visible = !_loc1_;
            this.mCurrentBoardPanel.mBoardResetTimer.mExpiryTextStatic.visible = !_loc1_;
            this.mCurrentBoardPanel.mBoardResetTimer.mPreviewText.visible = _loc1_;
            if(_loc1_)
            {
               if(this.mCurrentBoardPanel.mBoardResetTimer.mPreviewText.text != _loc6_)
               {
                  this.mCurrentBoardPanel.mBoardResetTimer.mPreviewText.text = _loc6_;
               }
            }
         }
      }
      
      public function ValidateSpinCount() : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:* = null;
         var _loc1_:SpinBoardController = SpinBoardController.GetInstance();
         var _loc2_:Boolean = _loc1_.GetPlayerDataHandler().HasFreeSpinAvailable();
         _loc2_ = _loc2_ || _loc1_.GetPlayerDataHandler().AdRewardSpinAvailable();
         var _loc3_:int = SpinBoardController.GetInstance().GetPlayerDataHandler().GetPaidSpinBalance();
         if(this.mCurrentBoardPanel != null)
         {
            if(_loc2_ && _loc3_ == 0)
            {
               _loc4_ = "FREE SPIN AVAILABLE!";
               if(this.mCurrentBoardPanel.mSpinBalanceText.text != _loc4_)
               {
                  this.mCurrentBoardPanel.mSpinBalanceText.text = _loc4_;
               }
            }
            else if(_loc3_ < 1)
            {
               _loc5_ = "YOU HAVE NO SPINS LEFT";
               if(this.mCurrentBoardPanel.mSpinBalanceText.text != _loc5_)
               {
                  this.mCurrentBoardPanel.mSpinBalanceText.text = _loc5_;
               }
            }
            else if(_loc3_ == 1)
            {
               _loc6_ = "YOU HAVE 1 SPIN LEFT";
               if(this.mCurrentBoardPanel.mSpinBalanceText.text != _loc6_)
               {
                  this.mCurrentBoardPanel.mSpinBalanceText.text = _loc6_;
               }
            }
            else
            {
               _loc7_ = "YOU HAVE " + _loc3_ + " SPINS LEFT";
               if(this.mCurrentBoardPanel.mSpinBalanceText.text != _loc7_)
               {
                  this.mCurrentBoardPanel.mSpinBalanceText.text = _loc7_;
               }
            }
         }
      }
   }
}
