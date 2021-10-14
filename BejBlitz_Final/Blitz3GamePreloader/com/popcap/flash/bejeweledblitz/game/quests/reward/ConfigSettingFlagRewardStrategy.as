package com.popcap.flash.bejeweledblitz.game.quests.reward
{
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   
   public class ConfigSettingFlagRewardStrategy implements IQuestRewardStrategy
   {
       
      
      private var m_ConfigManager:ConfigManager;
      
      private var m_SettingId:String;
      
      private var m_TargetValue:Boolean;
      
      public function ConfigSettingFlagRewardStrategy(param1:ConfigManager, param2:String, param3:Boolean = true)
      {
         super();
         this.m_ConfigManager = param1;
         this.m_SettingId = param2;
         this.m_TargetValue = param3;
      }
      
      public function SetQuest(param1:Quest) : void
      {
      }
      
      public function DoQuestComplete(param1:Boolean) : void
      {
         this.m_ConfigManager.SetFlag(this.m_SettingId,this.m_TargetValue);
      }
      
      public function GetRewardString() : String
      {
         return "";
      }
      
      public function getRewardType() : String
      {
         return QuestConstants.QUEST_REWARD_TYPE_CONFIG;
      }
   }
}
