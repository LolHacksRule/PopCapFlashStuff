package com.popcap.flash.bejeweledblitz.dailyspin2.UI
{
   import com.popcap.flash.bejeweledblitz.ProductInfo;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardController;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardInfo;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import flash.events.Event;
   
   public class DeluxeBoardPurchasePopup
   {
       
      
      private var mPopupView:SpinBoardPurchaseConfirmPopup;
      
      private var mPurchaseButton:StorePurchaseButtonContainer;
      
      private var mCloseButton:GenericButtonClip;
      
      private var mGameWidget:Blitz3Game;
      
      public function DeluxeBoardPurchasePopup()
      {
         super();
         this.mGameWidget = Blitz3App.app as Blitz3Game;
         this.mPopupView = new SpinBoardPurchaseConfirmPopup();
         this.mGameWidget.mDSPlaceholder.addChild(this.mPopupView);
         this.mPopupView.visible = false;
      }
      
      public function Init(param1:String, param2:String, param3:ProductInfo, param4:Function, param5:Event = null) : void
      {
         var _loc6_:SpinBoardInfo = null;
         var _loc7_:uint = 0;
         var _loc8_:* = null;
         if(this.mPopupView != null)
         {
            this.mPurchaseButton = new StorePurchaseButtonContainer(this.mPopupView.SpinBoardconfirmationbutton);
            this.mPurchaseButton.SetInfo(param3,param4);
            this.mCloseButton = new GenericButtonClip(Blitz3App.app,this.mPopupView.CloseButton);
            this.mCloseButton.setRelease(this.Close);
            this.mCloseButton.activate();
            this.mCloseButton.show();
            if((_loc6_ = SpinBoardController.GetInstance().GetPremiumBoardForPreview()) != null)
            {
               _loc7_ = _loc6_.GetPremiumBoardDurationTime();
               if((_loc7_ = uint(_loc7_ / 3600)) >= 1)
               {
                  this.mPopupView.TxtValidityTimePeriod.visible = true;
                  _loc8_ = String(_loc7_) + " HOURS";
                  if(_loc7_ == 1)
                  {
                     _loc8_ = "1 HOUR";
                  }
                  this.mPopupView.TxtValidityTimePeriod.text = _loc8_;
               }
               else
               {
                  this.mPopupView.TxtValidityTimePeriod.visible = false;
               }
            }
         }
      }
      
      public function Open() : void
      {
         if(this.mPopupView != null)
         {
            this.mPopupView.visible = true;
         }
      }
      
      public function Close() : void
      {
         if(this.mPopupView != null)
         {
            this.mPopupView.visible = false;
            this.mGameWidget.mDSPlaceholder.removeChild(this.mPopupView);
         }
      }
   }
}
