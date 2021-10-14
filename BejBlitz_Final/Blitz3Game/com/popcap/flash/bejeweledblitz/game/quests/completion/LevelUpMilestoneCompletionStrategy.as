package com.popcap.flash.bejeweledblitz.game.quests.completion
{
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   
   public class LevelUpMilestoneCompletionStrategy implements IQuestCompletionStrategy
   {
       
      
      private var m_Quest:Quest;
      
      private var _isComplete:Boolean;
      
      private var m_QuestConfigId:String;
      
      private var _configManager:ConfigManager;
      
      public function LevelUpMilestoneCompletionStrategy(param1:Object, param2:ConfigManager, param3:String)
      {
         super();
         this._isComplete = false;
         this._configManager = param2;
         this.m_QuestConfigId = param3;
      }
      
      public function SetQuest(param1:Quest) : void
      {
         this.m_Quest = param1;
      }
      
      public function IsQuestComplete() : Boolean
      {
         return this._isComplete;
      }
      
      public function ForceCompletion() : void
      {
         this._isComplete = true;
         this.UpdateCompletionState();
      }
      
      public function clearCompletion() : void
      {
         this._isComplete = false;
         var _loc1_:Object = QuestConstants.SanitizeQuestObject(this._configManager.GetObj(this.m_QuestConfigId));
         _loc1_[QuestConstants.KEY_IS_COMPLETE] = false;
         this._configManager.SetObj(this.m_QuestConfigId,_loc1_);
      }
      
      public function forceReset() : void
      {
         var _loc1_:Object = QuestConstants.SanitizeQuestObject(this._configManager.GetObj(this.m_QuestConfigId));
         _loc1_[QuestConstants.KEY_IS_COMPLETE] = "reset";
         _loc1_[QuestConstants.KEY_PROGRESS] = "" + 0;
         this._configManager.SetObj(this.m_QuestConfigId,_loc1_);
      }
      
      public function UpdateCompletionState() : void
      {
         var _loc1_:Object = QuestConstants.SanitizeQuestObject(this._configManager.GetObj(this.m_QuestConfigId));
         _loc1_[QuestConstants.KEY_IS_COMPLETE] = this._isComplete;
         this._configManager.SetObj(this.m_QuestConfigId,_loc1_);
      }
      
      public function GetProgress() : int
      {
         return int(this._isComplete);
      }
      
      public function GetGoalString() : String
      {
         return "";
      }
      
      public function GetGoal() : int
      {
         return 0;
      }
      
      public function GetProgressString() : String
      {
         return "";
      }
      
      public function CleanUpConfigData() : void
      {
      }
   }
}
