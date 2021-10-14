package com.popcap.flash.bejeweledblitz.game.ui.dialogs
{
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import flash.display.MovieClip;
   
   public class InsufficientFundsDialog extends Buynowpopup
   {
       
      
      private var _app:Blitz3App;
      
      private var _currencyType:String;
      
      private var _closeBtn:GenericButtonClip;
      
      private var _buyNowBtn:GenericButtonClip;
      
      private var _isOpen:Boolean = false;
      
      public function InsufficientFundsDialog(param1:Blitz3App, param2:String)
      {
         super();
         this._app = param1;
         this._currencyType = param2;
         this.setupPopup();
      }
      
      private function setupPopup() : void
      {
         this._closeBtn = new GenericButtonClip(this._app,this.close);
         this._closeBtn.setRelease(this.Hide);
         var _loc1_:CurrencyManager = this._app.sessionData.userData.currencyManager;
         this.Message1.text = "Not enough " + _loc1_.getCurrencyName(this._currencyType) + "!";
         this.message2.text = "Get " + _loc1_.getCurrencyName(this._currencyType) + " from store.";
         this._buyNowBtn = new GenericButtonClip(this._app,this.BuynowButton);
         this._buyNowBtn.setRelease(this.showCart);
         var _loc2_:MovieClip = CurrencyManager.getImageByType(this._currencyType,false,"large");
         _loc2_.smoothing = true;
         this.SeedsPlaceholder.addChild(_loc2_);
      }
      
      public function Show() : void
      {
         if(this._isOpen)
         {
            return;
         }
         this._isOpen = true;
         (this._app as Blitz3Game).metaUI.highlight.showPopUp(this,true,true,0.85);
      }
      
      private function Hide() : void
      {
         if(!this._isOpen)
         {
            return;
         }
         this._isOpen = false;
         (this._app as Blitz3Game).metaUI.highlight.hidePopUp();
      }
      
      private function showCart() : void
      {
         this.Hide();
         this._app.network.ShowCart("navBuyCoins",this._currencyType);
      }
   }
}
