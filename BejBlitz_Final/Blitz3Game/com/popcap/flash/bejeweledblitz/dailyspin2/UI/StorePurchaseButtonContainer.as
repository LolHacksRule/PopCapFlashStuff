package com.popcap.flash.bejeweledblitz.dailyspin2.UI
{
   import com.popcap.flash.bejeweledblitz.ProductInfo;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class StorePurchaseButtonContainer
   {
       
      
      private var mButton:MovieClip;
      
      private var mProductInfo:ProductInfo;
      
      private var mButtonClip:GenericButtonClip;
      
      public function StorePurchaseButtonContainer(param1:MovieClip)
      {
         super();
         this.mButton = param1;
      }
      
      public function SetInfo(param1:ProductInfo, param2:Function, param3:Event = null) : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         if(param1 != null)
         {
            this.mProductInfo = param1;
            _loc4_ = param1.IsFree();
            this.mButton.mCurrencyImage.visible = !_loc4_ && !param1.IsIAPSKU();
            this.mButton.mFreeText.visible = _loc4_;
            _loc5_ = param1.IsDiscounted();
            if(this.mButton.mPriceButtonText != null)
            {
               this.mButton.mPriceButtonText.visible = !_loc4_ && !_loc5_;
            }
            if(this.mButton.mPriceText != null)
            {
               this.mButton.mPriceText.visible = !_loc4_ && !_loc5_;
            }
            this.mButton.mStreakPricePanel.visible = !_loc4_ && _loc5_;
            if(_loc5_)
            {
               this.mButton.mStreakPricePanel.mFinalPrice.text = param1.GetDiscountedPriceString();
               this.mButton.mStreakPricePanel.mStruckoutPrice.text = param1.GetPriceString();
            }
            else
            {
               if(this.mButton.mPriceButtonText != null)
               {
                  this.mButton.mPriceButtonText.text = param1.GetDiscountedPriceString();
               }
               if(this.mButton.mPriceText != null)
               {
                  this.mButton.mPriceText.text = param1.GetDiscountedPriceString();
               }
            }
            this.mButtonClip = new GenericButtonClip(Blitz3App.app,this.mButton);
            if(param2 != null)
            {
               if(param3 != null)
               {
                  this.mButtonClip.setRelease(param2,param3);
               }
               else
               {
                  this.mButtonClip.setRelease(param2);
               }
            }
            this.mButtonClip.activate();
            this.mButtonClip.show();
         }
      }
      
      public function Deactivate() : void
      {
         this.mButtonClip.deactivate();
      }
   }
}
