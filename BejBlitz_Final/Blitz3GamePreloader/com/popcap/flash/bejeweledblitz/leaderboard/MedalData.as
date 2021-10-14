package com.popcap.flash.bejeweledblitz.leaderboard
{
   public class MedalData
   {
      
      public static const TIER_CUTOFFS:Vector.<int> = new Vector.<int>(6);
      
      public static const NUM_TIERS:int = TIER_CUTOFFS.length;
      
      {
         TIER_CUTOFFS[0] = 10;
         TIER_CUTOFFS[1] = 25;
         TIER_CUTOFFS[2] = 50;
         TIER_CUTOFFS[3] = 100;
         TIER_CUTOFFS[4] = 250;
         TIER_CUTOFFS[5] = int.MAX_VALUE;
      }
      
      public var name:String;
      
      public var count:int;
      
      public var earnedDate:Date;
      
      public var tierIndex:int;
      
      public function MedalData(param1:String = "temp medal", param2:int = 0, param3:Date = null)
      {
         super();
         this.name = param1;
         this.count = param2;
         this.earnedDate = param3;
         if(this.earnedDate == null)
         {
            this.earnedDate = new Date();
         }
         this.CalculateTier();
      }
      
      public function getCurrentTierCutoff() : int
      {
         var _loc1_:int = Math.min(this.tierIndex,4);
         return TIER_CUTOFFS[_loc1_];
      }
      
      public function CalculateTier() : void
      {
         this.tierIndex = 0;
         var _loc1_:int = 0;
         while(_loc1_ < NUM_TIERS)
         {
            this.tierIndex = _loc1_;
            if(this.count < TIER_CUTOFFS[_loc1_])
            {
               break;
            }
            _loc1_++;
         }
      }
   }
}
