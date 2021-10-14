package com.popcap.flash.bejeweledblitz.logic
{
   public interface IDailyChallengeReward
   {
       
      
      function SetDisplay(param1:IDailyChallengeRewardDisplayFactory) : void;
      
      function GetCoinsEarned() : int;
      
      function GetMyRewardName() : String;
   }
}
