package com.popcap.flash.bejeweledblitz.game.quests.reward
{
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   
   public class QuestSettingsRewardStrategy implements IQuestRewardStrategy
   {
       
      
      private var m_ConfigManager:ConfigManager;
      
      private var m_SettingId:String;
      
      private var m_TargetCounter:Number;
      
      public function QuestSettingsRewardStrategy(param1:ConfigManager, param2:String, param3:Number = NaN)
      {
         super();
         this.m_ConfigManager = param1;
         this.m_SettingId = param2;
         this.m_TargetCounter = param3;
      }
      
      public function SetQuest(param1:Quest) : void
      {
      }
      
      public function DoQuestComplete(param1:Boolean) : void
      {
         var _loc2_:Object = QuestConstants.SanitizeQuestObject(this.m_ConfigManager.GetObj(this.m_SettingId));
         _loc2_[QuestConstants.KEY_IS_COMPLETE] = true;
         if(!isNaN(this.m_TargetCounter))
         {
            _loc2_[QuestConstants.KEY_PROGRESS] = int(this.m_TargetCounter);
         }
         this.m_ConfigManager.SetObj(this.m_SettingId,_loc2_);
      }
      
      public function GetRewardString() : String
      {
         return "";
      }
      
      public function getRewardType() : String
      {
         return QuestConstants.QUEST_REWARD_TYPE_SETTINGS;
      }
   }
}
