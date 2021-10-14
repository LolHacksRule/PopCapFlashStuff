package com.popcap.flash.bejeweledblitz.dailychallenge
{
   import com.popcap.flash.bejeweledblitz.logic.DailyChallengeLogicConfig;
   
   public class DailyChallengeConfigList
   {
       
      
      private var _list:Vector.<DailyChallengeLogicConfig>;
      
      public function DailyChallengeConfigList()
      {
         super();
         this._list = new Vector.<DailyChallengeLogicConfig>(0);
      }
      
      public function get length() : int
      {
         return this._list.length;
      }
      
      public function has(param1:DailyChallengeLogicConfig) : Boolean
      {
         return this._list.indexOf(param1) != -1;
      }
      
      public function add(param1:DailyChallengeLogicConfig) : void
      {
         this._list.push(param1);
      }
      
      public function getActive() : DailyChallengeLogicConfig
      {
         return this._list[0];
      }
      
      public function clear() : void
      {
         this._list.length = 0;
      }
      
      public function clearExpiredElements() : void
      {
         this._list = this._list.filter(function(param1:DailyChallengeLogicConfig, param2:int, param3:Vector.<DailyChallengeLogicConfig>):Boolean
         {
            return !param1.hasExpired();
         });
      }
      
      public function incrementConfigs() : void
      {
         var _loc1_:DailyChallengeLogicConfig = null;
         for each(_loc1_ in this._list)
         {
            _loc1_.incrementTimeHasLived();
         }
      }
      
      public function incrementActiveGamesPlayed() : void
      {
         ++this.getActive().numGamesPlayed;
      }
   }
}
