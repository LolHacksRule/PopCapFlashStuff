package com.popcap.flash.bejeweledblitz.dailyspin2
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.dailyspin2.UI.SpinBoardUIController;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.IHandleNetworkBuySkuCallback;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.InsufficientFundsDialog;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.TwoButtonDialog;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class SpinBoardPurchaseHandler implements IHandleNetworkBuySkuCallback
   {
       
      
      private var mNoBalanceDialog:InsufficientFundsDialog;
      
      private var mErrorPopup:TwoButtonDialog;
      
      private var mCurrentlyPurchasingBoardId:String;
      
      private var mFromDraper:Boolean;
      
      public function SpinBoardPurchaseHandler()
      {
         super();
         this.mCurrentlyPurchasingBoardId = "";
         this.mNoBalanceDialog = null;
         this.mFromDraper = false;
      }
      
      public function InitiateInGamePurchaseForBoard(param1:SpinBoardInfo) : void
      {
         var _loc2_:Object = null;
         if(param1 != null && param1.GetType() == SpinBoardType.PremiumBoard)
         {
            _loc2_ = new Object();
            _loc2_["sku"] = param1.GetProductInfo().GetSKUId();
            _loc2_["requestType"] = !!param1.IsFTUEBoard() ? "claim" : "currency";
            _loc2_["featureId"] = param1.GetId();
            _loc2_["cart"] = "spinboard";
            Blitz3App.app.network.HandleInGamePurchase(_loc2_,this.OnPurchaseSuccessful,this.OnPurchaseFailed);
         }
      }
      
      public function InitiateIAPPurchaseForBoard(param1:SpinBoardInfo) : void
      {
         if(param1 != null && param1.GetType() == SpinBoardType.PremiumBoard)
         {
            Blitz3App.app.network.AddNetworkBuySkuCallbackHandler(this);
            Blitz3App.app.network.PurchaseSku(param1.GetProductInfo().GetSKUId(),param1.GetId());
         }
      }
      
      public function PurchaseBoard(param1:String, param2:Boolean = false) : void
      {
         this.mFromDraper = param2;
         var _loc3_:SpinBoardInfo = SpinBoardController.GetInstance().GetCatalogue().GetSpinBoardInfo(param1);
         SpinBoardController.GetInstance().GetStateHandler().SetState(SpinBoardState.PremiumBoardPurchase);
         this.mCurrentlyPurchasingBoardId = _loc3_.GetId();
         if(_loc3_ != null && _loc3_.GetProductInfo().IsIAPSKU())
         {
            this.InitiateIAPPurchaseForBoard(_loc3_);
         }
         else
         {
            this.InitiateInGamePurchaseForBoard(_loc3_);
         }
      }
      
      public function OnBoardPurchaseFlowComplete() : void
      {
         this.mCurrentlyPurchasingBoardId = "";
         Blitz3App.app.network.getUserInfo();
         SpinBoardController.GetInstance().GetStateHandler().SetState(SpinBoardState.BoardRunning);
      }
      
      public function SendBoardPurchaseTelemetry() : void
      {
         var _loc5_:Object = null;
         var _loc1_:SpinBoardController = SpinBoardController.GetInstance();
         var _loc2_:SpinBoardInfo = _loc1_.GetCatalogue().GetSpinBoardInfo(this.mCurrentlyPurchasingBoardId);
         var _loc3_:SpinBoardPlayerProgress = _loc1_.GetPlayerDataHandler().GetBoardProgressByType(SpinBoardType.PremiumBoard);
         var _loc4_:String = "";
         if(_loc2_.IsFTUEBoard())
         {
            _loc4_ = "FTUE";
         }
         else if(_loc2_.GetProductInfo().IsIAPSKU())
         {
            _loc4_ = "MTX";
         }
         else
         {
            _loc4_ = "Goldbars";
         }
         if(_loc2_ != null && _loc3_ != null)
         {
            _loc5_ = {
               "PurchaseType":_loc4_,
               "AmountSpent":(!!_loc2_.IsFTUEBoard() ? 0 : _loc2_.GetProductInfo().GetDiscountedPrice()),
               "BoardId":this.mCurrentlyPurchasingBoardId,
               "BoardType":_loc2_.GetType(),
               "FreeSpinBalance":(!!_loc1_.GetPlayerDataHandler().HasFreeSpinAvailable() ? 1 : 0),
               "PurchasedSpinBalance":_loc1_.GetPlayerDataHandler().GetPaidSpinBalance(),
               "ResetTime":_loc3_.GetBoardResetTime()
            };
            _loc1_.GetTelemetryTracker().TrackEvent(SpinBoardTelemetryEventType.BoardPurchase,_loc5_);
         }
      }
      
      private function OnPremiumBoardPurchaseSuccessful() : void
      {
         Blitz3App.app.network.LogOnBrowser("[SpinBoardPurchaseHandler] HandleBuySkuCallback : OnPremiumBoardPurchaseSuccessful");
         this.SendBoardPurchaseTelemetry();
         SpinBoardController.GetInstance().GetStateHandler().SetState(SpinBoardState.PremiumBoardPurchaseSucceeded);
         SpinBoardController.GetInstance().SetupSpinBoards();
         if(this.mFromDraper)
         {
            SpinBoardUIController.GetInstance().OpenSpinBoard();
         }
         this.mFromDraper = false;
         this.OnBoardPurchaseFlowComplete();
      }
      
      public function OnPurchaseSuccessful(param1:Event) : void
      {
         var _loc3_:String = null;
         var _loc4_:SpinBoardController = null;
         var _loc2_:Object = JSON.parse(param1.target.data);
         if(_loc2_ != null)
         {
            _loc3_ = Utils.getStringFromObjectKey(_loc2_,"status");
            _loc4_ = SpinBoardController.GetInstance();
            if(_loc3_ == "successfull" && _loc2_.spinBoard != null)
            {
               if(SpinBoardController.GetInstance().GetPlayerDataHandler().GetSpinBoardPlayerDataContainer().SetInfo(_loc2_.spinBoard,false))
               {
                  this.OnPremiumBoardPurchaseSuccessful();
               }
               else
               {
                  this.OnFailureResponse(_loc2_);
               }
            }
            else
            {
               this.OnFailureResponse(_loc2_);
            }
         }
         else
         {
            this.OnPurchaseFailed(param1);
         }
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
         var _loc2_:String = this.mCurrentlyPurchasingBoardId;
         this.mCurrentlyPurchasingBoardId = "";
         this.PurchaseBoard(_loc2_);
      }
      
      public function OnCancelButtonClicked(param1:MouseEvent) : void
      {
         (Blitz3App.app as Blitz3Game).metaUI.highlight.hidePopUp();
         this.OnBoardPurchaseFlowComplete();
      }
      
      public function OnFailureResponse(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc3_:InsufficientFundsDialog = null;
         if(param1 != null)
         {
            _loc2_ = Utils.getStringFromObjectKey(param1,"reason");
            if(_loc2_ == "INVALID_BOARD")
            {
               this.ShowErrorPopup("Oops!","The board you tried to purchase is not available anymore.\n Please check back later.");
            }
            else if(_loc2_ == "Insufficient balance")
            {
               _loc3_ = new InsufficientFundsDialog(Blitz3App.app,CurrencyManager.TYPE_GOLDBARS);
               _loc3_.Show();
               this.OnBoardPurchaseFlowComplete();
            }
            else
            {
               this.ShowErrorPopup("Oops!","An Error Occurred!");
            }
         }
         SpinBoardController.GetInstance().GetStateHandler().SetState(SpinBoardState.PremiumBoardPurchaseFailed);
      }
      
      private function OnPurchaseCanceled() : void
      {
         SpinBoardController.GetInstance().GetStateHandler().SetState(SpinBoardState.SpinsPurchaseFailed);
         this.ShowErrorPopup("Oops","Your purchase has been canceled");
      }
      
      public function OnPurchaseFailed(param1:Event) : void
      {
         Blitz3App.app.network.LogOnBrowser("[SpinBoardPurchaseHandler] HandleBuySkuCallback : OnPurchaseFailed");
         this.ShowErrorPopup("Oops!","An Error Occurred!");
         SpinBoardController.GetInstance().GetStateHandler().SetState(SpinBoardState.PremiumBoardPurchaseFailed);
      }
      
      public function HandleBuySkuCallback(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc3_:Boolean = false;
         var _loc4_:Object = null;
         var _loc5_:Boolean = false;
         if(param1 != null)
         {
            _loc2_ = param1.skuID;
            _loc3_ = param1.success;
            _loc4_ = param1.rewards;
            _loc5_ = param1.userCancelled;
            Blitz3App.app.network.LogOnBrowser("[SpinBoardPurchaseHandler] HandleBuySkuCallback");
            if(_loc3_)
            {
               Blitz3App.app.network.LogOnBrowser("[SpinBoardPurchaseHandler] HandleBuySkuCallback : success");
               if(SpinBoardController.GetInstance().GetPlayerDataHandler().GetSpinBoardPlayerDataContainer().SetInfoFromProgressObject(_loc4_,false))
               {
                  this.OnPremiumBoardPurchaseSuccessful();
               }
               else
               {
                  this.OnPurchaseFailed(null);
               }
            }
            else if(_loc5_)
            {
               this.OnPurchaseCanceled();
            }
            else
            {
               this.OnPurchaseFailed(null);
            }
         }
         Blitz3App.app.network.RemoveBuySkuCallbackHandler(this);
      }
   }
}
