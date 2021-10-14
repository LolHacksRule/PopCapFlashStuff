package com.popcap.flash.bejeweledblitz.game.ui.raregems
{
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   
   public class RareGemPrizeData
   {
      
      private static const _PRIZE_TYPE_OTHER:String = "";
      
      private static const _PRIZE_TYPE_COINS:String = "coins";
       
      
      public var prizeType:String = "coins";
      
      public var prizeAmount:int = 0;
      
      public var prizeAmountArray:Object;
      
      public function RareGemPrizeData(param1:Object)
      {
         this.prizeAmountArray = new Object();
         super();
         if(param1 != null)
         {
            if(param1.type != null)
            {
               if(String(param1.type).toLowerCase() == "coins")
               {
                  this.prizeType = _PRIZE_TYPE_COINS;
               }
               else
               {
                  this.prizeType = _PRIZE_TYPE_OTHER;
               }
            }
            if(param1.payout != null)
            {
               this.prizeAmountArray[CurrencyManager.TYPE_COINS] = int(param1.payout);
               this.prizeAmount = int(param1.payout);
               this.prizeAmountArray[CurrencyManager.TYPE_SHARDS] = param1[CurrencyManager.TYPE_SHARDS] != null ? int(param1[CurrencyManager.TYPE_SHARDS]) : 0;
            }
         }
      }
      
      public function isCoinType() : Boolean
      {
         return this.prizeType == _PRIZE_TYPE_COINS;
      }
   }
}
