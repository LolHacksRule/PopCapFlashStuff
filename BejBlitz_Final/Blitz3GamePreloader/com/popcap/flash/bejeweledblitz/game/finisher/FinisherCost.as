package com.popcap.flash.bejeweledblitz.game.finisher
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.s7.core.Utility;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.finisher.config.ICost;
   
   public class FinisherCost implements ICost
   {
       
      
      private var value:int;
      
      private var type:String;
      
      private var displayCost:String;
      
      public function FinisherCost(param1:Object)
      {
         super();
         this.Parse(param1);
      }
      
      public function GetValue() : int
      {
         return this.value;
      }
      
      public function IsCurrencyPurchase() : Boolean
      {
         return this.type == CurrencyManager.TYPE_COINS || CurrencyManager.TYPE_SHARDS || CurrencyManager.TYPE_DIAMONDS || CurrencyManager.TYPE_GOLDBARS;
      }
      
      public function GetType() : String
      {
         return this.type;
      }
      
      public function GetDisplayCost() : String
      {
         return this.displayCost;
      }
      
      private function Parse(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Number = NaN;
         this.type = Utils.getStringFromObjectKey(param1,"type");
         this.value = Utils.getIntFromObjectKey(param1,"value");
         this.displayCost = "" + Utility.commaize(this.value);
         if(!this.IsCurrencyPurchase())
         {
            _loc2_ = Blitz3App.app.network.GetSkuInformation("" + this.value);
            _loc3_ = _loc2_.fullPrice;
            this.displayCost = Blitz3App.app.network.GetLocalizedPrice(_loc3_);
         }
         else if(this.value == 0)
         {
            this.displayCost = "Free";
         }
      }
   }
}
