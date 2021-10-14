package com.popcap.flash.bejeweledblitz.game.quests.reward
{
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   
   public class NullRewardStrategy implements IQuestRewardStrategy
   {
       
      
      private var m_RewardString:String;
      
      public function NullRewardStrategy(param1:String)
      {
         super();
         this.m_RewardString = param1;
      }
      
      public function SetQuest(param1:Quest) : void
      {
      }
      
      public function DoQuestComplete(param1:Boolean) : void
      {
      }
      
      public function GetRewardString() : String
      {
         return this.m_RewardString;
      }
      
      public function getRewardType() : String
      {
         return QuestConstants.QUEST_REWARD_TYPE_NULL;
      }
   }
}
