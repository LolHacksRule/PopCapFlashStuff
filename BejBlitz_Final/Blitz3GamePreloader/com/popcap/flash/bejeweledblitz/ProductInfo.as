package com.popcap.flash.bejeweledblitz
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   
   public class ProductInfo
   {
       
      
      private var mId:String;
      
      private var mProductType:String;
      
      private var mAmount:Number;
      
      private var mCurrency1Price:Number;
      
      private var mCurrency1DiscountedPrice:Number;
      
      private var mIAPPrice:Number;
      
      private var mIAPDiscountedPrice:Number;
      
      private var mIAPPriceString:String;
      
      private var mIAPDiscountedPriceString:String;
      
      private var mFullPriceString:String;
      
      private var mDiscountPriceString:String;
      
      private var mDiscountPrice:Number;
      
      private var mImageURL:String;
      
      public function ProductInfo()
      {
         super();
         this.mImageURL = "";
      }
      
      public function SetInfo(param1:Object) : void
      {
         this.mId = Utils.getStringFromObjectKey(param1,"sku");
         this.mProductType = Utils.getStringFromObjectKey(param1,"type");
         this.mCurrency1DiscountedPrice = Number(Utils.getStringFromObjectKey(param1,"currency1_cost"));
         var _loc2_:Number = Number(Utils.getStringFromObjectKey(param1,"currency1_mobile_disc_cost"));
         if(_loc2_ < 100 && _loc2_ > 0)
         {
            this.mCurrency1Price = this.mCurrency1DiscountedPrice * 100 / (100 - _loc2_);
         }
         else
         {
            this.mCurrency1Price = this.mCurrency1DiscountedPrice;
         }
         this.mCurrency1Price = Utils.round(this.mCurrency1Price);
         this.mIAPPrice = Number(Utils.getStringFromObjectKey(param1,"fullPrice"));
         if(this.mIAPPrice != 0)
         {
            this.mIAPPriceString = Blitz3App.app.network.GetLocalizedPrice(this.mIAPPrice);
         }
         else
         {
            this.mIAPPriceString = "0";
         }
         this.mIAPDiscountedPrice = Number(Utils.getStringFromObjectKey(param1,"discountPrice"));
         if(this.mIAPDiscountedPrice != 0)
         {
            this.mIAPDiscountedPriceString = Blitz3App.app.network.GetLocalizedPrice(this.mIAPDiscountedPrice);
         }
         else
         {
            this.mIAPDiscountedPriceString = "0";
         }
         this.mAmount = Number(Utils.getStringFromObjectKey(param1,"quantity"));
         this.mImageURL = Utils.getStringFromObjectKey(param1,"image");
      }
      
      public function GetImageURL() : String
      {
         return this.mImageURL;
      }
      
      public function GetSKUId() : String
      {
         return this.mId;
      }
      
      public function GetProductType() : String
      {
         return this.mProductType;
      }
      
      public function GetAmount() : Number
      {
         return this.mAmount;
      }
      
      public function GetPrice() : Number
      {
         if(this.IsIAPSKU())
         {
            return this.mIAPPrice;
         }
         return this.mCurrency1Price;
      }
      
      public function GetPriceString() : String
      {
         if(this.IsIAPSKU())
         {
            return this.mIAPPriceString;
         }
         return Utils.formatNumberToBJBNumberString(this.mCurrency1Price);
      }
      
      public function GetDiscountedPrice() : Number
      {
         if(this.IsIAPSKU())
         {
            return this.mIAPDiscountedPrice;
         }
         return this.mCurrency1DiscountedPrice;
      }
      
      public function GetDiscountedPriceString() : String
      {
         if(this.IsIAPSKU())
         {
            return this.mIAPDiscountedPriceString;
         }
         return Utils.formatNumberToBJBNumberString(this.mCurrency1DiscountedPrice);
      }
      
      public function IsFree() : Boolean
      {
         return this.mIAPDiscountedPrice == 0 && this.mCurrency1DiscountedPrice == 0;
      }
      
      public function IsIAPSKU() : Boolean
      {
         if(this.IsFree())
         {
            return false;
         }
         return this.mIAPDiscountedPrice != 0;
      }
      
      public function IsDiscounted() : Boolean
      {
         var _loc1_:* = false;
         if(!this.IsFree())
         {
            if(this.IsIAPSKU())
            {
               _loc1_ = this.mIAPDiscountedPrice != this.mIAPPrice;
            }
            else
            {
               _loc1_ = this.mCurrency1Price != this.mCurrency1DiscountedPrice;
            }
         }
         return _loc1_;
      }
   }
}
