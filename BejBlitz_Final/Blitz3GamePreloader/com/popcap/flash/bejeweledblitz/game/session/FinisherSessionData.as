package com.popcap.flash.bejeweledblitz.game.session
{
   public class FinisherSessionData
   {
      
      public static var CURRENCY_TYPE_FREE:int = 0;
      
      public static var CURRENCY_TYPE_INGAME_CURRENCY:int = 1;
      
      public static var CURRENCY_TYPE_IAP:int = 2;
      
      public static var CURRENCY_TYPE_NONE:int = 3;
       
      
      private var finisherHarvestedCurrency:int;
      
      private var finisherHarvestedCurrencyString:String;
      
      private var finisherPrice:int;
      
      private var scoreBeforeFinisher:int;
      
      private var finisherName:String;
      
      private var finisherIsSurfaced:Boolean = false;
      
      private var finisherIsPurchased:Boolean = false;
      
      public function FinisherSessionData()
      {
         super();
      }
      
      public function SetCurrentFinisher(param1:String) : void
      {
         this.finisherName = param1;
      }
      
      public function SetScoreBeforeFinisher(param1:int) : void
      {
         this.scoreBeforeFinisher = param1;
      }
      
      public function SetFinisherHarvestedCurrency(param1:int, param2:String) : void
      {
         this.finisherHarvestedCurrency = param1;
         this.finisherHarvestedCurrencyString = param2;
      }
      
      public function SetFinisherPrice(param1:int) : void
      {
         this.finisherPrice = param1;
      }
      
      public function IsFinisherSurfaced() : Boolean
      {
         return this.finisherIsSurfaced;
      }
      
      public function IsFinisherPurchased() : Boolean
      {
         return this.finisherIsPurchased;
      }
      
      public function FinisherIsSurfaced() : void
      {
         this.finisherIsSurfaced = true;
      }
      
      public function FinisherIsPurchased() : void
      {
         this.finisherIsPurchased = true;
      }
      
      public function GetFinisherName() : String
      {
         return this.finisherName;
      }
      
      public function GetScoreBeforeFinisher() : int
      {
         return this.scoreBeforeFinisher;
      }
      
      public function GetFinisherHarvestCurrency() : int
      {
         return this.finisherHarvestedCurrency;
      }
      
      public function GetFinisherPrice() : int
      {
         return this.finisherPrice;
      }
      
      public function GetFinisherHarvestCurrencyString() : String
      {
         return this.finisherHarvestedCurrencyString;
      }
      
      public function Reset() : void
      {
         this.finisherHarvestedCurrency = CURRENCY_TYPE_NONE;
         this.finisherHarvestedCurrencyString = "";
         this.scoreBeforeFinisher = 0;
         this.finisherName = "";
         this.finisherIsSurfaced = false;
         this.finisherIsPurchased = false;
      }
   }
}
