package com.popcap.flash.bejeweledblitz.game.quests.reward
{
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.session.feature.FeatureManager;
   
   public class FeatureUnlockRewardStrategy implements IQuestRewardStrategy
   {
       
      
      private var m_FeatureManager:FeatureManager;
      
      private var m_FeatureToUnlock:String;
      
      private var m_RewardString:String;
      
      public function FeatureUnlockRewardStrategy(param1:FeatureManager, param2:String, param3:String)
      {
         super();
         this.m_FeatureManager = param1;
         this.m_FeatureToUnlock = param2;
         this.m_RewardString = param3;
      }
      
      public function SetQuest(param1:Quest) : void
      {
      }
      
      public function DoQuestComplete(param1:Boolean) : void
      {
         this.m_FeatureManager.enableFeature(this.m_FeatureToUnlock);
      }
      
      public function GetRewardString() : String
      {
         return this.m_RewardString;
      }
      
      public function getRewardType() : String
      {
         return QuestConstants.QUEST_REWARD_TYPE_FEATURE;
      }
   }
}
