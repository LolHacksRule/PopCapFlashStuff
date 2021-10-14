package com.popcap.flash.bejeweledblitz.logic
{
   public class DailyChallengeLogicConfig extends Config
   {
      
      public static const TIMER_UPDATE_INTERVAL_MILLISECONDS:int = 1000;
      
      private static const DEFAULT_RETRY_COIN_COST:int = 10000;
       
      
      public var gemBoardColors:Array;
      
      public var starCatType:String;
      
      public var starCatGoals:Vector.<int>;
      
      public var challengeTitle:String = "TITLE NOT SET";
      
      public var id:String = "ID NOT SET";
      
      public var challengeBody:String = "BODY NOT SET\nABCDEFGHIJKLMNOPQRSTUVWXYZ";
      
      public var rareGem:String = "";
      
      public var boosts:Array;
      
      public var retryCost:int = 10000;
      
      public var dailyChallengeStartTime:int = 0;
      
      public var dailyChallengeEndTime:int = 0;
      
      public var timeToLiveMilliseconds:uint = 0;
      
      public var timeHasLivedMilliseconds:uint = 0;
      
      public var numGamesPlayed:uint = 0;
      
      public var starCatRewards:Vector.<IDailyChallengeReward>;
      
      public function DailyChallengeLogicConfig()
      {
         super();
      }
      
      public function timeUntilNextChallenge() : int
      {
         return this.timeToLiveMilliseconds - this.timeHasLivedMilliseconds;
      }
      
      public function secondsUntilNextChallenge() : int
      {
         return this.timeUntilNextChallenge() / 1000;
      }
      
      public function incrementTimeHasLived() : void
      {
         this.timeHasLivedMilliseconds += TIMER_UPDATE_INTERVAL_MILLISECONDS;
      }
      
      public function hasExpired() : Boolean
      {
         return this.timeUntilNextChallenge() <= 0;
      }
      
      public function hasBeenPlayed() : Boolean
      {
         return this.numGamesPlayed > 0;
      }
      
      public function hasBeenPlayedOnce() : Boolean
      {
         return this.numGamesPlayed == 1;
      }
      
      public function starCatsEarned(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         for each(_loc3_ in this.starCatGoals)
         {
            if(param1 >= _loc3_)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
   }
}
