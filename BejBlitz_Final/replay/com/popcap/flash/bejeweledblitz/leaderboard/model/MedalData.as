package com.popcap.flash.bejeweledblitz.leaderboard.model
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
      
      public var tier:int;
      
      public function MedalData(mName:String = "temp medal", mCount:int = 0, mEarnedDate:Date = null)
      {
         super();
         this.name = mName;
         this.count = mCount;
         this.earnedDate = mEarnedDate;
         if(this.earnedDate == null)
         {
            this.earnedDate = new Date();
         }
         this.CalculateTier();
      }
      
      public function CalculateTier() : void
      {
         this.tier = 0;
         for(var i:int = 0; i < NUM_TIERS; i++)
         {
            this.tier = i;
            if(this.count < TIER_CUTOFFS[i])
            {
               break;
            }
         }
      }
   }
}
