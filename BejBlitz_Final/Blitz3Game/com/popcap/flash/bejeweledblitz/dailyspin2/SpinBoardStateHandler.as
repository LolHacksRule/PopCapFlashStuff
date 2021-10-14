package com.popcap.flash.bejeweledblitz.dailyspin2
{
   import com.popcap.flash.bejeweledblitz.dailyspin2.UI.SpinBoardUIController;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ftue.impl.FTUEEvents;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   
   public class SpinBoardStateHandler
   {
       
      
      private var mState:int;
      
      private var mPreviousState:int;
      
      private var mUICallback:Function;
      
      private var mController:SpinBoardController;
      
      public function SpinBoardStateHandler(param1:SpinBoardController)
      {
         super();
         this.mController = param1;
         this.Reset();
      }
      
      public function GetState() : int
      {
         return this.mState;
      }
      
      public function GetPreviousState() : int
      {
         return this.mPreviousState;
      }
      
      public function OnCatalogueAvailable() : void
      {
         if(this.mPreviousState != SpinBoardState.NotOpen)
         {
            if(this.mState == SpinBoardState.Loading)
            {
               this.SetState(SpinBoardState.BoardReset);
            }
         }
      }
      
      public function SetState(param1:int) : void
      {
         var _loc2_:SpinBoardInfo = null;
         var _loc3_:SpinBoardInfo = null;
         var _loc4_:SpinBoardInfo = null;
         var _loc5_:SpinBoardPlayerProgress = null;
         var _loc6_:SpinBoardInfo = null;
         if(this.mState != param1)
         {
            this.mPreviousState = this.mState;
            this.mState = param1;
            if(this.mUICallback != null)
            {
               this.mUICallback();
            }
            if(param1 != this.mState)
            {
               return;
            }
            switch(this.mState)
            {
               case SpinBoardState.NoSpinBoard:
                  this.mController.GetHighlightController().StopHighlightRunner();
                  break;
               case SpinBoardState.BoardRunning:
                  this.mController.GetHighlightController().ResumeHighlighter();
                  this.ValidateExpiredUserProgress();
                  break;
               case SpinBoardState.RewardClaim:
                  this.mController.GetHighlightController().StopHighlightRunner();
                  break;
               case SpinBoardState.WholeSpinBoardCleared:
                  SpinBoardUIController.GetInstance().InitiateWholeSpinBoardClaimedSequence();
                  break;
               case SpinBoardState.RewardShareSequenceComplete:
                  if(this.mController.SetupSpinBoards())
                  {
                     if(SpinBoardUIController.GetInstance().IsSpinBoardOpen())
                     {
                        this.SetState(SpinBoardState.BoardRunning);
                     }
                     else
                     {
                        this.SetState(SpinBoardState.NotOpen);
                     }
                     _loc2_ = this.mController.GetActiveSpinBoardInfo();
                     if(_loc2_ != null && _loc2_.IsFTUEBoard())
                     {
                        if(_loc2_.GetType() == SpinBoardType.RegularBoard)
                        {
                           Blitz3App.app.bjbEventDispatcher.SendEvent(FTUEEvents.FTUE_REGULAR_SPINBOARD_AVAILABLE,null);
                        }
                        else
                        {
                           _loc3_ = this.mController.GetPremiumBoardForPreview();
                           if(_loc3_ != null)
                           {
                              Blitz3App.app.bjbEventDispatcher.SendEvent(FTUEEvents.FTUE_PREMIUM_SPINBOARD_AVAILABLE,null);
                           }
                        }
                     }
                  }
                  else
                  {
                     this.SetState(SpinBoardState.NoSpinBoard);
                  }
                  break;
               case SpinBoardState.RewardShare:
                  this.mController.GetHighlightController().StopHighlightRunner();
                  SpinBoardController.GetInstance().GetSpinsShareHandler().InitiateSpinsShareSequence();
                  break;
               case SpinBoardState.PremiumBoardPurchase:
                  this.mController.GetHighlightController().StopHighlightRunner();
               case SpinBoardState.SpinsPurchase:
                  (Blitz3App.app.ui as MainWidgetGame).networkWait.Show(this);
                  break;
               case SpinBoardState.PremiumBoardPurchaseSucceeded:
               case SpinBoardState.PremiumBoardPurchaseFailed:
               case SpinBoardState.SpinsPurchaseComplete:
               case SpinBoardState.SpinsPurchaseFailed:
                  (Blitz3App.app.ui as MainWidgetGame).networkWait.Hide(this);
                  break;
               case SpinBoardState.BoardReset:
                  this.mController.GetHighlightController().StopHighlightRunner();
                  break;
               case SpinBoardState.BoardExpired:
                  this.mController.GetHighlightController().StopHighlightRunner();
                  _loc4_ = null;
                  _loc5_ = null;
                  if((_loc6_ = this.mController.GetActiveSpinBoardInfo()) != null && _loc6_.GetEndTime() < new Date().time / 1000)
                  {
                     _loc4_ = _loc6_;
                  }
                  else if((_loc5_ = this.mController.GetPlayerDataHandler().GetProgressOfExpiredSpinBoard()) != null)
                  {
                     _loc4_ = this.mController.GetCatalogue().GetSpinBoardInfo(_loc5_.GetBoardId());
                  }
                  if(_loc4_ != null && _loc4_.GetType() == SpinBoardType.PremiumBoard)
                  {
                     this.mController.GetFTUEHelper().ShowPremiumBoardExpiredStep();
                  }
                  else
                  {
                     this.SetState(SpinBoardState.RewardShare);
                  }
                  break;
               default:
                  this.mController.GetHighlightController().StopHighlightRunner();
            }
         }
      }
      
      public function ValidateExpiredUserProgress() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:SpinBoardPlayerProgress = this.mController.GetPlayerDataHandler().GetProgressOfExpiredSpinBoard();
         if(_loc2_ != null)
         {
            _loc1_ = true;
            this.SetState(SpinBoardState.BoardExpired);
         }
         return _loc1_;
      }
      
      public function SetUICallback(param1:Function) : void
      {
         this.mUICallback = param1;
      }
      
      public function Reset() : void
      {
         this.mState = SpinBoardState.NotOpen;
         this.mPreviousState = SpinBoardState.NotOpen;
      }
   }
}
