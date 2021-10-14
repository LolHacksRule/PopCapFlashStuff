package com.popcap.flash.bejeweledblitz.dailyspin2.UI
{
   import com.popcap.flash.bejeweledblitz.ProductInfo;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import flash.display.Bitmap;
   import flash.events.Event;
   
   public class GenericPurchasePopup
   {
       
      
      private var mPopupView:SpinBoardPurchasePopup;
      
      private var mPurchaseButton:StorePurchaseButtonContainer;
      
      private var mCloseButton:GenericButtonClip;
      
      private var mGameWidget:Blitz3Game;
      
      private var mImage:Bitmap;
      
      public function GenericPurchasePopup()
      {
         super();
         this.mGameWidget = Blitz3App.app as Blitz3Game;
         this.mPopupView = new SpinBoardPurchasePopup();
         this.mGameWidget.mDSPlaceholder.addChild(this.mPopupView);
         this.mPopupView.visible = false;
         this.mImage = null;
      }
      
      public function Init(param1:String, param2:String, param3:ProductInfo, param4:Function, param5:Event = null) : void
      {
         if(this.mPopupView != null && param3 != null)
         {
            this.mPopupView.SpinBoardPurchaseHeader.text = param1;
            this.mPopupView.ContextText.text = param2;
            this.mPurchaseButton = new StorePurchaseButtonContainer(this.mPopupView.SpinBoardPurchaseButton);
            this.mPurchaseButton.SetInfo(param3,param4);
            this.mCloseButton = new GenericButtonClip(Blitz3App.app,this.mPopupView.CloseButton);
            this.mCloseButton.setRelease(this.Close);
            this.mCloseButton.activate();
            this.mCloseButton.show();
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
            if(this.mImage != null && this.mImage.parent != null)
            {
               this.mPopupView.SpinBoardpurchaseplaceholder.removeChild(this.mImage);
            }
         }
      }
   }
}
