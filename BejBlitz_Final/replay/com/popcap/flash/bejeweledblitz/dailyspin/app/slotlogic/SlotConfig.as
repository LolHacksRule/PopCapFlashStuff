package com.popcap.flash.bejeweledblitz.dailyspin.app.slotlogic
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.prize.PrizeData;
   
   public class SlotConfig
   {
       
      
      private var m_Cfg:Object;
      
      private var m_PrizeData:Vector.<PrizeData>;
      
      public function SlotConfig(slotConfig:Object)
      {
         super();
         this.m_Cfg = slotConfig;
         this.init();
      }
      
      public function getPrizeDataSet() : Vector.<PrizeData>
      {
         return this.m_PrizeData;
      }
      
      public function getPrizeData(prizeId:String) : PrizeData
      {
         var prizeData:PrizeData = null;
         for each(prizeData in this.m_PrizeData)
         {
            if(prizeData.prizeID == prizeId)
            {
               return prizeData;
            }
         }
         return null;
      }
      
      public function getConfigObj() : Object
      {
         return this.m_Cfg;
      }
      
      private function init() : void
      {
         var prize:* = undefined;
         var prizeData:PrizeData = null;
         this.m_PrizeData = new Vector.<PrizeData>();
         var prizes:Array = this.m_Cfg["prizes"];
         for each(prize in prizes)
         {
            prizeData = new PrizeData();
            prizeData.prizeID = prize["id"] as String;
            prizeData.prizeValue = prize["count"] as int;
            prizeData.prizeSymbols = prize["symbols"] as Array;
            prizeData.prizeWeight = prize["pct"] as Number;
            prizeData.prizeSound = prize["sound"] as String;
            prizeData.shareAmount = prize["shareAmount"] as int;
            prizeData.shouldShare = prize["share"] as Boolean;
            this.m_PrizeData.push(prizeData);
         }
      }
   }
}
