package com.popcap.flash.bejeweledblitz.game.quests.completion
{
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   
   public class QuestSettingsCompletionStrategy implements IQuestCompletionStrategy
   {
       
      
      private var m_ConfigManager:ConfigManager;
      
      private var m_QuestConfigId:String;
      
      private var m_IsComplete:Boolean;
      
      public function QuestSettingsCompletionStrategy(param1:ConfigManager, param2:String)
      {
         super();
         this.m_ConfigManager = param1;
         this.m_QuestConfigId = param2;
         this.m_IsComplete = false;
      }
      
      public function SetQuest(param1:Quest) : void
      {
      }
      
      public function IsQuestComplete() : Boolean
      {
         return this.m_IsComplete;
      }
      
      public function ForceCompletion() : void
      {
         var _loc1_:Object = QuestConstants.SanitizeQuestObject(this.m_ConfigManager.GetObj(this.m_QuestConfigId));
         _loc1_[QuestConstants.KEY_IS_COMPLETE] = true;
         this.m_ConfigManager.SetObj(this.m_QuestConfigId,_loc1_);
      }
      
      public function clearCompletion() : void
      {
      }
      
      public function forceReset() : void
      {
         var _loc1_:Object = QuestConstants.SanitizeQuestObject(this.m_ConfigManager.GetObj(this.m_QuestConfigId));
         _loc1_[QuestConstants.KEY_IS_COMPLETE] = "reset";
         _loc1_[QuestConstants.KEY_PROGRESS] = "" + 0;
         this.m_ConfigManager.SetObj(this.m_QuestConfigId,_loc1_);
      }
      
      public function UpdateCompletionState() : void
      {
         var _loc1_:Object = QuestConstants.SanitizeQuestObject(this.m_ConfigManager.GetObj(this.m_QuestConfigId));
         if(_loc1_[QuestConstants.KEY_IS_COMPLETE])
         {
            this.m_IsComplete = true;
         }
      }
      
      public function GetProgressString() : String
      {
         return "";
      }
      
      public function GetProgress() : int
      {
         return int(this.m_IsComplete);
      }
      
      public function GetGoalString() : String
      {
         return "";
      }
      
      public function GetGoal() : int
      {
         return 0;
      }
      
      public function CleanUpConfigData() : void
      {
      }
   }
}
