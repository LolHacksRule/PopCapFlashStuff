package com.popcap.flash.bejeweledblitz.dailyspin.app.config
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.slotlogic.SlotConfig;
   
   public class DSParamLoader
   {
       
      
      private var m_DSConfig:Object;
      
      private var m_SlotConfig:SlotConfig;
      
      private var m_ShouldReload:Boolean;
      
      public function DSParamLoader(jsObj:Object)
      {
         super();
         this.m_DSConfig = jsObj;
         this.init();
      }
      
      public function loadData(jsObj:Object) : void
      {
         if(this.m_ShouldReload)
         {
            this.m_DSConfig = jsObj;
            this.init();
         }
      }
      
      public function markForReload() : void
      {
         this.m_ShouldReload = true;
      }
      
      public function addParams(params:Object) : void
      {
         var key:* = null;
         for(key in params)
         {
            this.m_DSConfig[key] = params[key];
         }
      }
      
      public function hasParam(id:String) : Boolean
      {
         return this.m_DSConfig[id] != null;
      }
      
      public function getArrayParam(id:String) : Array
      {
         return this.m_DSConfig[id];
      }
      
      public function getStringParam(id:String) : String
      {
         return this.m_DSConfig[id] as String;
      }
      
      public function getBoolParam(id:String) : Boolean
      {
         return this.m_DSConfig[id] as Boolean;
      }
      
      public function getIntParam(id:String) : int
      {
         return int(this.m_DSConfig[id]);
      }
      
      public function getSlotConfig() : SlotConfig
      {
         return this.m_SlotConfig;
      }
      
      public function getSymbolImageMap() : Object
      {
         return this.m_DSConfig["slotsConfig"].symbolImageMap;
      }
      
      public function getTitleAds() : Array
      {
         return this.m_DSConfig["slotsConfig"].title.ads;
      }
      
      private function getFriendBonusData() : Object
      {
         var bonus:Object = null;
         var bonuses:Array = this.m_DSConfig["slotsConfig"].bonuses as Array;
         for each(bonus in bonuses)
         {
            if(bonus.id == "friends")
            {
               return bonus;
            }
         }
         return null;
      }
      
      public function getFriendBonus() : int
      {
         var bonus:int = this.getIntParam("payoutFriends");
         var max:int = this.getFriendBonusMax();
         return Math.min(max,bonus);
      }
      
      public function getFriendCount() : int
      {
         return this.getIntParam("numFriends");
      }
      
      public function getFriendBonusMax() : int
      {
         var friendBonus:Object = this.getFriendBonusData();
         if(friendBonus)
         {
            return friendBonus.max as int;
         }
         return 100;
      }
      
      private function getDailyBonusData() : Object
      {
         var bonus:Object = null;
         var bonuses:Array = this.m_DSConfig["slotsConfig"].bonuses as Array;
         for each(bonus in bonuses)
         {
            if(bonus.id == "daily")
            {
               return bonus;
            }
         }
         return null;
      }
      
      public function getDailyBonus() : int
      {
         var bonus:int = this.getIntParam("payoutStreak");
         var max:int = this.getDailyBonusMax();
         return Math.min(bonus,max);
      }
      
      public function getDayCount() : int
      {
         return this.getIntParam("streak");
      }
      
      public function getDailyBonusMax() : int
      {
         var friendBonus:Object = this.getDailyBonusData();
         return friendBonus.max as int;
      }
      
      public function getSpinCredits() : int
      {
         return this.m_DSConfig["credits"];
      }
      
      public function getSocialNetworkSpinPrice(sn:String) : int
      {
         var network:* = null;
         var socialNetworks:Object = this.m_DSConfig["slotsConfig"].prices;
         for(network in socialNetworks)
         {
            if(network == sn)
            {
               return socialNetworks[network];
            }
         }
         return -1;
      }
      
      public function getMysteryShareAmount() : int
      {
         return this.m_DSConfig["slotsConfig"].config.mysteryShareAmount;
      }
      
      public function getShareAmount() : int
      {
         var data:Object = this.m_DSConfig["share"];
         if(data == null || !("amount" in data))
         {
            return 0;
         }
         return data["amount"];
      }
      
      public function getMinimalMode() : Boolean
      {
         return Boolean(this.m_DSConfig["minimalMode"]);
      }
      
      private function init() : void
      {
         var slotConfig:Object = new Object();
         slotConfig["config"] = this.m_DSConfig["slotsConfig"].config;
         slotConfig["prizes"] = this.m_DSConfig["slotsConfig"].prizes;
         this.m_SlotConfig = new SlotConfig(slotConfig);
         this.m_DSConfig["minimalMode"] = this.m_DSConfig["slotsConfig"].config["minimalMode"];
         this.m_ShouldReload = false;
      }
      
      public function dumpParams() : void
      {
         var key:* = null;
         for(key in this.m_DSConfig)
         {
            trace("key = " + key + ", val = " + this.m_DSConfig[key]);
         }
      }
   }
}
