package com.popcap.flash.bejeweledblitz.dailyspin2
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.ProductInfo;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.IHandleNetworkBuySkuCallback;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.InsufficientFundsDialog;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.TwoButtonDialog;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class SpinPackPurchaseHandler implements IHandleNetworkBuySkuCallback
   {
       
      
      private var mErrorPopup:TwoButtonDialog;
      
      private var mCurrentlyPurchasingProductInfo:ProductInfo;
      
      public function SpinPackPurchaseHandler()
      {
         super();
      }
      
      public function InitiatePurchase(param1:ProductInfo) : void
      {
         if(param1 != null)
         {
            this.mCurrentlyPurchasingProductInfo = param1;
            if(param1.IsIAPSKU())
            {
               SpinBoardController.GetInstance().GetStateHandler().SetState(SpinBoardState.SpinsPurchase);
               Blitz3App.app.network.AddNetworkBuySkuCallbackHandler(this);
               Blitz3App.app.network.PurchaseSku(param1.GetSKUId(),"");
            }
            else
            {
               this.InitiateInGamePurchase(param1);
            }
         }
      }
      
      private function InitiateInGamePurchase(param1:ProductInfo) : void
      {
         var _loc2_:Object = null;
         if(param1 != null)
         {
            SpinBoardController.GetInstance().GetStateHandler().SetState(SpinBoardState.SpinsPurchase);
            _loc2_ = new Object();
            _loc2_["sku"] = param1.GetSKUId();
            _loc2_["requestType"] = "currency";
            _loc2_["cart"] = "spinboard";
            Blitz3App.app.network.HandleInGamePurchase(_loc2_,this.OnPurchaseSuccessful,this.OnPurchaseFailed);
         }
      }
      
      private function OnPurchaseSuccessful(param1:Event) : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc2_:Object = JSON.parse(param1.target.data);
         if(_loc2_ != null)
         {
            _loc3_ = Utils.getStringFromObjectKey(_loc2_,"status");
            if(_loc3_ == "successfull" && _loc2_.rewards != null)
            {
               SpinBoardController.GetInstance().GetStateHandler().SetState(SpinBoardState.SpinsPurchaseComplete);
               _loc4_ = Number(_loc2_.rewards.spins_bought);
               SpinBoardController.GetInstance().GetPlayerDataHandler().SetPaidSpinBalance(_loc4_);
               this.OnPurchaseSequenceCompleted();
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
      
      private function ShowErrorPopup(param1:String, param2:String) : void
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
      
      private function OnRetryButtonClicked(param1:MouseEvent) : void
      {
         (Blitz3App.app as Blitz3Game).metaUI.highlight.hidePopUp();
         this.mErrorPopup.Reset();
         this.mErrorPopup = null;
         this.InitiatePurchase(this.mCurrentlyPurchasingProductInfo);
      }
      
      private function OnCancelButtonClicked(param1:MouseEvent) : void
      {
         (Blitz3App.app as Blitz3Game).metaUI.highlight.hidePopUp();
         this.OnPurchaseSequenceCompleted();
      }
      
      private function OnFailureResponse(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc3_:InsufficientFundsDialog = null;
         if(param1 != null)
         {
            _loc2_ = Utils.getStringFromObjectKey(param1,"reason");
            if(_loc2_ == "Insufficient balance")
            {
               _loc3_ = new InsufficientFundsDialog(Blitz3App.app,CurrencyManager.TYPE_GOLDBARS);
               _loc3_.Show();
               SpinBoardController.GetInstance().GetStateHandler().SetState(SpinBoardState.SpinsPurchaseFailed);
               this.OnPurchaseSequenceCompleted();
            }
            else
            {
               this.ShowErrorPopup("Oops!","An Error Occurred!");
               SpinBoardController.GetInstance().GetStateHandler().SetState(SpinBoardState.SpinsPurchaseFailed);
            }
         }
      }
      
      private function OnPurchaseCanceled() : void
      {
         SpinBoardController.GetInstance().GetStateHandler().SetState(SpinBoardState.SpinsPurchaseFailed);
         this.ShowErrorPopup("Oops","Your purchase has been canceled");
      }
      
      private function OnPurchaseFailed(param1:Event) : void
      {
         SpinBoardController.GetInstance().GetStateHandler().SetState(SpinBoardState.SpinsPurchaseFailed);
         this.ShowErrorPopup("Oops","An Error Occurred!");
      }
      
      private function OnPurchaseSequenceCompleted() : void
      {
         this.mCurrentlyPurchasingProductInfo = null;
         Blitz3App.app.network.getUserInfo();
         if(this.mErrorPopup != null)
         {
            this.mErrorPopup.Reset();
            this.mErrorPopup = null;
         }
         SpinBoardController.GetInstance().GetStateHandler().SetState(SpinBoardState.BoardRunning);
      }
      
      public function HandleBuySkuCallback(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         if(param1 != null)
         {
            _loc2_ = param1.skuID;
            _loc3_ = param1.success;
            _loc4_ = param1.userCancelled;
            if(_loc3_)
            {
               SpinBoardController.GetInstance().GetStateHandler().SetState(SpinBoardState.SpinsPurchaseComplete);
               this.OnPurchaseSequenceCompleted();
            }
            else if(_loc4_)
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
