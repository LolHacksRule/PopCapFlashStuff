package com.popcap.flash.bejeweledblitz.dailychallenge
{
   import com.popcap.flash.bejeweledblitz.logic.IDailyChallengeReward;
   import com.popcap.flash.bejeweledblitz.logic.IDailyChallengeRewardDisplayFactory;
   
   public class DailyChallengeCoinReward implements IDailyChallengeReward
   {
       
      
      private var _amount:int = 0;
      
      public function DailyChallengeCoinReward(param1:Object)
      {
         super();
         this._amount = param1["value"];
      }
      
      public function SetDisplay(param1:IDailyChallengeRewardDisplayFactory) : void
      {
         param1.CreateCoinRewardDisplay(this._amount).Set();
      }
      
      public function GetCoinsEarned() : int
      {
         return this._amount;
      }
      
      public function GetMyRewardName() : String
      {
         return "coins";
      }
      
      public function RefreshRewardText() : void
      {
      }
   }
}
