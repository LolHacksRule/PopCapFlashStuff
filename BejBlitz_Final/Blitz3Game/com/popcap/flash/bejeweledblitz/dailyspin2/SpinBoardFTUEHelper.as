package com.popcap.flash.bejeweledblitz.dailyspin2
{
   import com.popcap.flash.bejeweledblitz.Globals;
   import com.popcap.flash.bejeweledblitz.UrlParameters;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.dailyspin2.UI.SpinBoardUIController;
   import com.popcap.flash.bejeweledblitz.dailyspin2.UI.SpinBoardUIState;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ftue.FTUEManager;
   import com.popcap.flash.bejeweledblitz.game.ftue.impl.FTUEEvents;
   import com.popcap.flash.bejeweledblitz.game.ftue.impl.FTUEFlow;
   import com.popcap.flash.bejeweledblitz.game.ftue.impl.FTUEStep;
   import com.popcap.flash.bejeweledblitz.game.ftue.impl.FtueFlowName;
   import com.popcap.flash.bejeweledblitz.game.session.ThrottleManager;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   
   public class SpinBoardFTUEHelper
   {
      
      public static const SPINBOARD_START_FTUE:String = "/facebook/bj2/startSpinFtue.php";
      
      public static const SPINBOARD_BUTTON_CLICKED:String = "DSButtonClicked";
      
      public static const PLAYER_GOT_MORE_SPINS:String = "DSGotSpins";
      
      public static const PLAYER_DIDNT_GET_MORE_SPINS:String = "DSDidntGetSpins";
      
      public static const SPIN_BALANCE_ACKNOWLEDGED_BY_USER:String = "DSBalanceAcknowledged";
      
      public static const SPINBOARD_REGULAR_CLAIM_REQUESTED:String = "DSClaimRequested";
      
      public static const SPINBOARD_REGULAR_CLAIM_COMPLETE:String = "DSClaimComplete";
      
      public static const SPINBOARD_FRENZYBAR_UPDATED:String = "DSFrenzyBarUpdated";
      
      public static const SPINBOARD_FREE_PREMIUMBOARD_ACCESS_REQUESTED:String = "DSFreePremiumBoardAccessRequested";
      
      public static const SPINBOARD_FREE_PREMIUMBOARD_PURCHASE_REQUESTED:String = "DSFreePremiumBoardPurchaseRequested";
      
      public static const SPINBOARD_PREMIUMBOARD_EXPIRED:String = "DSFreePremiumBoardExpired";
      
      public static const SPINBOARD_PREMIUMBOARD_EXPIRED_ACKNOWLEDGED:String = "DSFreePremiumBoardExpiryAcknowledged";
       
      
      private var mController:SpinBoardController;
      
      private var mFTUEView:FtueDailySpin;
      
      private var mWhatsNewPopup:DailySpinWhatsNew;
      
      private var mStartFTUEURLLoader:URLLoader;
      
      private var mClaimIntroAnimToCall:String;
      
      private var mClaimOutroAnimToCall:String;
      
      private var mSkipFrenzyBarUpdate:Boolean;
      
      public function SpinBoardFTUEHelper(param1:SpinBoardController)
      {
         super();
         this.mController = param1;
         this.mSkipFrenzyBarUpdate = false;
      }
      
      public function InitFTUEStepsForFlow(param1:FTUEFlow, param2:String) : void
      {
         switch(param2)
         {
            case FtueFlowName.SPINBOARD_INTRO_EXISTING:
               this.AddSpinBoardIntroExistingSteps(param1);
               break;
            case FtueFlowName.REGULAR_SPINBOARD_INTRO_EXISTING:
               this.AddRegularBoardIntro(param1);
               break;
            case FtueFlowName.PREMIUM_SPINBOARD_INTRO_EXISTING:
               this.AddPremiumBoardIntro(param1);
         }
      }
      
      private function AddSpinBoardIntroExistingSteps(param1:FTUEFlow) : void
      {
         var spinBoardIntroExistingFTUEFlow:FTUEFlow = param1;
         spinBoardIntroExistingFTUEFlow.AddStepHelper(null,null,FTUEEvents.FTUE_SPINBOARD_AVAILABLE,function():void
         {
            (Blitz3App.app.ui as MainWidgetGame).menu.leftPanel.ValidateSpinBoardStatus();
            SpinBoardController.GetInstance().GetFTUEHelper().ShowLandingPageFTUE();
            if(!Blitz3App.app.sessionData.ftueManager.serverIsFTUENewUSer)
            {
               SpinBoardController.GetInstance().SetFTUEIntroOngoing(true);
            }
         },"",null,FTUEStep.BLOCK_ON_BJB_MESSAGE,SpinBoardFTUEHelper.SPINBOARD_BUTTON_CLICKED,function():void
         {
            SpinBoardController.GetInstance().GetFTUEHelper().OnSpinBoardButtonClickedPostFTUE();
            if(!Blitz3App.app.sessionData.ftueManager.serverIsFTUENewUSer)
            {
               SpinBoardController.GetInstance().GetFTUEHelper().ShowFTUEWhatsNewPopup();
            }
         });
      }
      
      private function AddPremiumBoardIntro(param1:FTUEFlow) : void
      {
         var ftueFlow:FTUEFlow = param1;
         ftueFlow.AddStepHelper(null,null,FTUEEvents.FTUE_PREMIUM_SPINBOARD_AVAILABLE,function():void
         {
            if(!HasPurchasedAPremiumBoard() && Blitz3App.app.sessionData.throttleManager.IsEnabled(ThrottleManager.THROTTLE_ENABLE_PREMIUMBOARD))
            {
               if(!SpinBoardUIController.GetInstance().IsSpinBoardOpen())
               {
                  SpinBoardController.GetInstance().OpenSpinBoard();
               }
               SpinBoardUIController.GetInstance().ActivatePremiumBoardAccessButton();
            }
         },"",null,FTUEStep.FTUE_STEP_BLOCK_ON_NONE,"",null);
         ftueFlow.AddStepHelper(null,null,"",null,"",function():void
         {
            if(!HasPurchasedAPremiumBoard() && SpinBoardUIController.GetInstance().GetSpinBoardContainer().GetCurrentUIState() == SpinBoardUIState.RegularBoard)
            {
               ShowAccessPremiumBoardPreviewStep();
            }
            else
            {
               Blitz3App.app.bjbEventDispatcher.SendEvent(SpinBoardFTUEHelper.SPINBOARD_FREE_PREMIUMBOARD_ACCESS_REQUESTED,null);
            }
         },FTUEStep.BLOCK_ON_BJB_MESSAGE,SpinBoardFTUEHelper.SPINBOARD_FREE_PREMIUMBOARD_ACCESS_REQUESTED,function():void
         {
            if(!HasPurchasedAPremiumBoard())
            {
               HideAccessPremiumBoardPreviewStep();
            }
         });
         ftueFlow.AddStepHelper(null,null,"",null,"",function():void
         {
            if(!HasPurchasedAPremiumBoard())
            {
               ShowPremiumBoardPurchaseStep();
            }
            else
            {
               Blitz3App.app.bjbEventDispatcher.SendEvent(SpinBoardFTUEHelper.SPINBOARD_FREE_PREMIUMBOARD_PURCHASE_REQUESTED,null);
            }
         },FTUEStep.BLOCK_ON_BJB_MESSAGE,SpinBoardFTUEHelper.SPINBOARD_FREE_PREMIUMBOARD_PURCHASE_REQUESTED,function():void
         {
            if(!HasPurchasedAPremiumBoard())
            {
               HidePremiumBoardPurchaseStep();
            }
         });
      }
      
      public function ShowPremiumBoardExpiredStep() : void
      {
         var okButton:GenericButtonClip = null;
         this.GetOrCreateFTUEView();
         this.mFTUEView.visible = true;
         this.mFTUEView.gotoAndPlay("DSFTUEPremiumBoardExpiredIntro");
         okButton = new GenericButtonClip(Blitz3App.app,this.mFTUEView.DSFTUEOkBtn);
         okButton.setRelease(function():void
         {
            HidePremiumBoardExpiredStep();
            SpinBoardController.GetInstance().GetStateHandler().SetState(SpinBoardState.RewardShare);
            okButton.setRelease(null);
            okButton = null;
         });
         okButton.activate();
      }
      
      private function HidePremiumBoardExpiredStep() : void
      {
         this.mFTUEView.gotoAndPlay("DSFTUEPremiumBoardExpiredOutro");
      }
      
      private function ShowPremiumBoardPurchaseStep() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:* = null;
         this.GetOrCreateFTUEView();
         this.mFTUEView.visible = true;
         var _loc1_:SpinBoardInfo = SpinBoardController.GetInstance().GetPremiumBoardForPreview();
         if(_loc1_ != null)
         {
            _loc2_ = _loc1_.GetPremiumBoardDurationTime();
            _loc2_ /= 3600;
            if(_loc2_ >= 1)
            {
               this.mFTUEView.AccessPremiumBoardPanel.visible = true;
               _loc3_ = String(_loc2_) + " HOURS";
               if(_loc2_ == 1)
               {
                  _loc3_ = "1 HOUR";
               }
               this.mFTUEView.AccessPremiumBoardPanel.mAccessPremiumBoardText.text = "Enjoy a free " + _loc3_ + " TRIAL of the Deluxe Spin. Use the same Spins on this Board.";
            }
            else
            {
               this.mFTUEView.AccessPremiumBoardPanel.visible = false;
            }
         }
         this.mFTUEView.gotoAndPlay("DSFTUEPremiumBoardPurchasedIntro");
      }
      
      private function HidePremiumBoardPurchaseStep() : void
      {
         this.mFTUEView.gotoAndPlay("DSFTUEPremiumBoardPurchasedOutro");
      }
      
      private function ShowAccessPremiumBoardPreviewStep() : void
      {
         this.GetOrCreateFTUEView();
         this.mFTUEView.visible = true;
         this.mFTUEView.gotoAndPlay("DSFTUEPremiumBoardUnlockedIntro");
      }
      
      private function HideAccessPremiumBoardPreviewStep() : void
      {
         if(this.mFTUEView != null)
         {
            this.mFTUEView.gotoAndPlay("DSFTUEPremiumBoardUnlockedOutro");
         }
      }
      
      private function AddRegularBoardIntro(param1:FTUEFlow) : void
      {
         var ftueFlow:FTUEFlow = param1;
         ftueFlow.AddStepHelper(function():void
         {
            ftueFlow.SetPreRequisiteConditionMet(SpinBoardUIController.GetInstance().IsSpinBoardOpen());
         },this.GetOurFriendSomeMoreSpins,FTUEEvents.FTUE_REGULAR_SPINBOARD_AVAILABLE,this.GetOurFriendSomeMoreSpins,"",null,FTUEStep.FTUE_STEP_BLOCK_ON_NONE,"",null);
         ftueFlow.AddStepHelper(null,null,"",null,"",function():void
         {
            var _loc1_:FTUEManager = Blitz3App.app.sessionData.ftueManager;
            var _loc2_:SpinBoardPlayerProgress = SpinBoardController.GetInstance().GetPlayerDataHandler().GetBoardProgressByType(SpinBoardType.RegularBoard);
            if(_loc2_.GetProgressiveSpinCount() >= 3)
            {
               _loc1_.markCurrentFlowAsDone();
            }
            else if(IsOurFriendWorthyOfMoreSpins())
            {
               ShowBalanceIncreasePopup();
            }
            else
            {
               Blitz3App.app.bjbEventDispatcher.SendEvent(SpinBoardFTUEHelper.SPIN_BALANCE_ACKNOWLEDGED_BY_USER,null);
            }
         },FTUEStep.BLOCK_ON_BJB_MESSAGE,SpinBoardFTUEHelper.SPIN_BALANCE_ACKNOWLEDGED_BY_USER,null);
         this.AddClaimStep(ftueFlow,1,false);
         this.AddClaimStep(ftueFlow,2,true);
         this.AddClaimStep(ftueFlow,3,false);
         ftueFlow.AddStepHelper(null,null,"",null,"",function():void
         {
            CloseFTUEView();
         },FTUEStep.FTUE_STEP_BLOCK_ON_NONE,"",null);
      }
      
      private function IsOurFriendWorthyOfMoreSpins() : Boolean
      {
         var _loc1_:Boolean = true;
         var _loc2_:* = this.GetNumberOfClaimsDone(SpinBoardType.RegularBoard) != 0;
         var _loc3_:SpinBoardPlayerProgress = this.mController.GetPlayerDataHandler().GetBoardProgressByType(SpinBoardType.RegularBoard);
         var _loc4_:SpinBoardPlayerProgress = this.mController.GetPlayerDataHandler().GetBoardProgressByType(SpinBoardType.PremiumBoard);
         var _loc5_:Boolean = _loc3_ != null && _loc3_.GetBoardResetTime() != 0;
         var _loc6_:Boolean = _loc4_ != null && _loc4_.GetBoardResetTime() != 0;
         if(_loc2_ || _loc6_ || _loc5_)
         {
            _loc1_ = false;
         }
         return _loc1_;
      }
      
      public function AddClaimStep(param1:FTUEFlow, param2:int, param3:Boolean) : void
      {
         var ftueFlow:FTUEFlow = param1;
         var claimStep:int = param2;
         var showFrenzyBarUpdate:Boolean = param3;
         ftueFlow.AddStepHelper(null,null,"",null,"",function():void
         {
            if(GetNumberOfClaimsDone(SpinBoardType.RegularBoard) < claimStep)
            {
               ShowClaimStep(claimStep);
            }
            else
            {
               Blitz3App.app.bjbEventDispatcher.SendEvent(SpinBoardFTUEHelper.SPINBOARD_REGULAR_CLAIM_REQUESTED,null);
            }
         },FTUEStep.BLOCK_ON_BJB_MESSAGE,SpinBoardFTUEHelper.SPINBOARD_REGULAR_CLAIM_REQUESTED,function():void
         {
            if(GetNumberOfClaimsDone(SpinBoardType.RegularBoard) < claimStep)
            {
               OnClaimButtonClicked();
            }
         });
         ftueFlow.AddStepHelper(null,null,"",null,"",function():void
         {
            if(GetNumberOfClaimsDone(SpinBoardType.RegularBoard) >= claimStep)
            {
               SetSkipFrenzyBarUpdate(true);
               Blitz3App.app.bjbEventDispatcher.SendEvent(SpinBoardFTUEHelper.SPINBOARD_REGULAR_CLAIM_COMPLETE,null);
            }
         },FTUEStep.BLOCK_ON_BJB_MESSAGE,SpinBoardFTUEHelper.SPINBOARD_REGULAR_CLAIM_COMPLETE,null);
         if(showFrenzyBarUpdate)
         {
            ftueFlow.AddStepHelper(null,null,"",null,"",function():void
            {
               if(!ShouldSkipFrenzyBarUpdate() && GetNumberOfClaimsDone(SpinBoardType.RegularBoard) <= claimStep)
               {
                  ShowFrenzyBarScrim();
               }
            },FTUEStep.BLOCK_ON_BJB_MESSAGE,SpinBoardFTUEHelper.SPINBOARD_FRENZYBAR_UPDATED,function():void
            {
               if(!ShouldSkipFrenzyBarUpdate() && GetNumberOfClaimsDone(SpinBoardType.RegularBoard) <= claimStep)
               {
                  HideFrenzyBarScrim();
               }
               SetSkipFrenzyBarUpdate(false);
            });
         }
      }
      
      private function SetSkipFrenzyBarUpdate(param1:Boolean) : void
      {
         this.mSkipFrenzyBarUpdate = param1;
      }
      
      private function ShouldSkipFrenzyBarUpdate() : Boolean
      {
         return this.mSkipFrenzyBarUpdate;
      }
      
      private function ShowClaimStep(param1:int) : void
      {
         this.GetOrCreateFTUEView();
         this.mFTUEView.visible = true;
         this.mClaimIntroAnimToCall = "DSFTUEClaim" + param1 + "Intro";
         this.mClaimOutroAnimToCall = "DSFTUEClaim" + param1 + "Outro";
         this.mFTUEView.gotoAndPlay(this.mClaimIntroAnimToCall);
      }
      
      private function ShowFrenzyBarScrim() : void
      {
         this.GetOrCreateFTUEView();
         this.mFTUEView.visible = true;
         this.mFTUEView.gotoAndPlay("DSFTUEFrenzyBarFilling");
      }
      
      private function HideFrenzyBarScrim() : void
      {
         this.CloseFTUEView();
      }
      
      private function OnClaimButtonClicked() : void
      {
         if(this.mClaimOutroAnimToCall != "")
         {
            this.mFTUEView.gotoAndPlay(this.mClaimOutroAnimToCall);
         }
      }
      
      private function GetOrCreateFTUEView() : FtueDailySpin
      {
         if(this.mFTUEView == null)
         {
            this.mFTUEView = new FtueDailySpin();
            (Blitz3App.app as Blitz3Game).mDSPlaceholder.addChild(this.mFTUEView);
            this.mFTUEView.addEventListener(Event.ENTER_FRAME,this.OnFTUEViewEnterFrame);
         }
         return this.mFTUEView;
      }
      
      private function CloseFTUEView() : void
      {
         if(this.mFTUEView != null)
         {
            this.mFTUEView.removeEventListener(Event.ENTER_FRAME,this.OnFTUEViewEnterFrame);
            this.mFTUEView.visible = false;
            (Blitz3App.app as Blitz3Game).mDSPlaceholder.removeChild(this.mFTUEView);
            this.mFTUEView = null;
         }
      }
      
      public function OnFTUEViewEnterFrame(param1:Event) : void
      {
         if(this.mFTUEView != null)
         {
            if(this.mFTUEView.currentFrame == Utils.GetAnimationLastFrame(this.mFTUEView,"DSFTUESpinsGrantedOutro"))
            {
               Blitz3App.app.bjbEventDispatcher.SendEvent(SpinBoardFTUEHelper.SPIN_BALANCE_ACKNOWLEDGED_BY_USER,null);
            }
            else if(this.mFTUEView.currentFrame == Utils.GetAnimationLastFrame(this.mFTUEView,"DSFTUEPremiumBoardPurchasedOutro"))
            {
               this.CloseFTUEView();
            }
            else if(this.mFTUEView.currentFrame == Utils.GetAnimationLastFrame(this.mFTUEView,"DSFTUEPremiumBoardExpiredOutro"))
            {
               this.CloseFTUEView();
            }
         }
      }
      
      public function ShowLandingPageFTUE() : void
      {
         this.GetOrCreateFTUEView();
         this.mFTUEView.visible = true;
         var _loc1_:Boolean = this.mController.GetPlayerDataHandler().HasFreeSpinAvailable();
         var _loc2_:Boolean = this.mController.GetPlayerDataHandler().AdRewardSpinAvailable();
         var _loc3_:* = this.mController.GetPlayerDataHandler().GetPaidSpinBalance() > 0;
         if(_loc1_ || _loc2_ || _loc3_)
         {
            this.mFTUEView.gotoAndPlay("DSFTUEMainMenuIntro2");
         }
         else
         {
            this.mFTUEView.gotoAndPlay("DSFTUEMainMenuIntro1");
         }
      }
      
      public function OnSpinBoardButtonClickedPostFTUE() : void
      {
         var _loc1_:Boolean = this.mController.GetPlayerDataHandler().HasFreeSpinAvailable();
         var _loc2_:Boolean = this.mController.GetPlayerDataHandler().AdRewardSpinAvailable();
         var _loc3_:* = this.mController.GetPlayerDataHandler().GetPaidSpinBalance() > 0;
         if(_loc1_ || _loc2_ || _loc3_)
         {
            this.mFTUEView.gotoAndPlay("DSFTUEMainMenuOutro2");
         }
         else
         {
            this.mFTUEView.gotoAndPlay("DSFTUEMainMenuOutro1");
         }
         this.mFTUEView.visible = false;
         this.CloseFTUEView();
      }
      
      public function GetNumberOfClaimsDone(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:SpinBoardPlayerProgress = this.mController.GetPlayerDataHandler().GetBoardProgressByType(param1);
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.GetProgressiveSpinCount();
         }
         return _loc2_;
      }
      
      private function ShowBalanceIncreasePopup() : void
      {
         var okButton:GenericButtonClip = null;
         this.GetOrCreateFTUEView();
         this.mFTUEView.visible = true;
         this.mFTUEView.gotoAndPlay("DSFTUESpinsGrantedInto");
         var spinCount:int = this.mController.GetPlayerDataHandler().GetPaidSpinBalance();
         this.mFTUEView.DSSpinsLeft.TextSpinsLeft.text = "YOU HAVE " + spinCount + " SPINS LEFT";
         okButton = new GenericButtonClip(Blitz3App.app,this.mFTUEView.DSFTUEOkBtn);
         okButton.setRelease(function():void
         {
            HideBalanceIncreasePopup();
            okButton.setRelease(null);
            okButton = null;
         });
         okButton.activate();
      }
      
      private function HideBalanceIncreasePopup() : void
      {
         this.mFTUEView.gotoAndPlay("DSFTUESpinsGrantedOutro");
      }
      
      private function ShowFTUEWhatsNewPopup() : void
      {
         if(this.mWhatsNewPopup == null)
         {
            this.mWhatsNewPopup = new DailySpinWhatsNew();
         }
         (Blitz3App.app as Blitz3Game).mDSPlaceholder.addChild(this.mWhatsNewPopup);
         this.mWhatsNewPopup.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void
         {
            SpinBoardController.GetInstance().GetFTUEHelper().HideFTUEWhatsNewPopup();
            SpinBoardController.GetInstance().SetFTUEIntroOngoing(false);
            SpinBoardController.GetInstance().OpenSpinBoard();
         });
      }
      
      private function HideFTUEWhatsNewPopup() : void
      {
         if(this.mWhatsNewPopup != null)
         {
            this.mWhatsNewPopup.visible = false;
            (Blitz3App.app as Blitz3Game).mDSPlaceholder.removeChild(this.mWhatsNewPopup);
            this.mWhatsNewPopup = null;
         }
      }
      
      public function GetOurFriendSomeMoreSpins() : void
      {
         var _loc1_:URLRequest = null;
         var _loc2_:URLVariables = null;
         if(this.IsOurFriendWorthyOfMoreSpins())
         {
            _loc1_ = new URLRequest(Globals.labsPath + SPINBOARD_START_FTUE);
            _loc1_.method = URLRequestMethod.POST;
            _loc2_ = Blitz3App.app.network.GetSecureVariables();
            if(this.mController.GetActiveSpinBoardInfo() != null && this.mController.GetActiveSpinBoardInfo().IsFTUEBoard())
            {
               _loc2_["boardId"] = this.mController.GetActiveSpinBoardInfo().GetId();
            }
            UrlParameters.Get().InjectParams(_loc2_);
            _loc1_.data = _loc2_;
            this.mStartFTUEURLLoader = new URLLoader();
            this.mStartFTUEURLLoader.addEventListener(Event.COMPLETE,this.OurFriendIsSpinRich);
            this.mStartFTUEURLLoader.addEventListener(IOErrorEvent.IO_ERROR,this.OurFriendDidNotGetMoreSpins);
            this.mStartFTUEURLLoader.load(_loc1_);
            SpinBoardController.GetInstance().GetPlayerDataHandler().IncreaseAnticipatedSpinCountThroughFTUE();
         }
      }
      
      public function OurFriendDidNotGetMoreSpins(param1:Event) : void
      {
         if(this.mStartFTUEURLLoader != null)
         {
            this.mStartFTUEURLLoader.removeEventListener(Event.COMPLETE,this.OurFriendIsSpinRich);
            this.mStartFTUEURLLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.OurFriendDidNotGetMoreSpins);
            Blitz3App.app.bjbEventDispatcher.SendEvent(SpinBoardFTUEHelper.PLAYER_DIDNT_GET_MORE_SPINS,null);
            this.mStartFTUEURLLoader = null;
         }
      }
      
      public function OurFriendIsSpinRich(param1:Event) : void
      {
         if(this.mStartFTUEURLLoader != null)
         {
            this.mStartFTUEURLLoader.removeEventListener(Event.COMPLETE,this.OurFriendIsSpinRich);
            this.mStartFTUEURLLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.OurFriendDidNotGetMoreSpins);
            Blitz3App.app.bjbEventDispatcher.SendEvent(SpinBoardFTUEHelper.PLAYER_GOT_MORE_SPINS,null);
            this.mStartFTUEURLLoader = null;
         }
      }
      
      public function OnFTUERegularBoardSpinClaimCompleted() : void
      {
         var _loc2_:SpinBoardPlayerProgress = null;
         var _loc3_:int = 0;
         var _loc4_:* = false;
         var _loc5_:SpinBoardInfo = null;
         var _loc1_:SpinBoardInfo = this.mController.GetActiveSpinBoardInfo();
         if(_loc1_ != null)
         {
            _loc2_ = this.mController.GetPlayerDataHandler().GetBoardProgressByType(SpinBoardType.RegularBoard);
            _loc3_ = Math.min(this.mController.GetCatalogue().GetFTUESpinReward(),7);
            if(_loc2_ != null && _loc1_.GetType() == SpinBoardType.RegularBoard)
            {
               if(_loc4_ = _loc3_ <= _loc2_.GetProgressiveSpinCount())
               {
                  if((_loc5_ = this.mController.GetPremiumBoardForPreview()) != null)
                  {
                     Blitz3App.app.bjbEventDispatcher.SendEvent(FTUEEvents.FTUE_PREMIUM_SPINBOARD_AVAILABLE,null);
                  }
               }
            }
         }
      }
      
      public function HasPremiumBoardExpired() : Boolean
      {
         var _loc1_:SpinBoardPlayerProgress = SpinBoardController.GetInstance().GetPlayerDataHandler().GetBoardProgressByType(SpinBoardType.PremiumBoard);
         return _loc1_ && _loc1_.HasTimerExpired();
      }
      
      public function HasPurchasedAPremiumBoard() : Boolean
      {
         var _loc1_:SpinBoardPlayerProgress = SpinBoardController.GetInstance().GetPlayerDataHandler().GetBoardProgressByType(SpinBoardType.PremiumBoard);
         return _loc1_ && _loc1_.GetBoardResetTime() != 0;
      }
   }
}
