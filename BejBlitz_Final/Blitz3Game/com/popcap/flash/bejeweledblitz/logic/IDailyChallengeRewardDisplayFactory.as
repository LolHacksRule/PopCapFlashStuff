package com.popcap.flash.bejeweledblitz.logic
{
   public interface IDailyChallengeRewardDisplayFactory
   {
       
      
      function CreateCoinRewardDisplay(param1:int) : IDailyChallengeRewardDisplay;
      
      function CreateRareGemRewardDisplay(param1:String) : IDailyChallengeRewardDisplay;
   }
}
