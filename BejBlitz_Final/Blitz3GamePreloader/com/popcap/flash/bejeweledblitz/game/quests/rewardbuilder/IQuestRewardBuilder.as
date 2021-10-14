package com.popcap.flash.bejeweledblitz.game.quests.rewardbuilder
{
   import com.popcap.flash.bejeweledblitz.game.quests.reward.IQuestRewardStrategy;
   
   public interface IQuestRewardBuilder
   {
       
      
      function BuildQuestRewardStrategy(param1:Object, param2:String) : IQuestRewardStrategy;
   }
}
