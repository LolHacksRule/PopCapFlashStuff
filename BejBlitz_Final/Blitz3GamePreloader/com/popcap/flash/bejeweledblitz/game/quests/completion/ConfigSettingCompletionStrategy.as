package com.popcap.flash.bejeweledblitz.game.quests.completion
{
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   
   public class ConfigSettingCompletionStrategy implements IQuestCompletionStrategy
   {
       
      
      private var m_ConfigManager:ConfigManager;
      
      private var m_SettingId:String;
      
      private var m_IsComplete:Boolean;
      
      private var m_AllowForceComplete:Boolean;
      
      private var m_IsForceCompleted:Boolean;
      
      public function ConfigSettingCompletionStrategy(param1:ConfigManager, param2:String, param3:Boolean = true)
      {
         super();
         this.m_ConfigManager = param1;
         this.m_SettingId = param2;
         this.m_AllowForceComplete = param3;
         this.m_IsComplete = false;
         this.m_IsForceCompleted = false;
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
         if(this.m_AllowForceComplete)
         {
            this.m_ConfigManager.SetFlag(this.m_SettingId,true);
         }
         else
         {
            this.m_IsForceCompleted = true;
         }
      }
      
      public function clearCompletion() : void
      {
      }
      
      public function forceReset() : void
      {
      }
      
      public function UpdateCompletionState() : void
      {
         if(this.m_ConfigManager.GetFlag(this.m_SettingId) || this.m_IsForceCompleted)
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
