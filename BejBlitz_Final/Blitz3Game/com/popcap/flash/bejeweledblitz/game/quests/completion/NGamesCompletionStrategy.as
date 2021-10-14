package com.popcap.flash.bejeweledblitz.game.quests.completion
{
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   
   public class NGamesCompletionStrategy implements IQuestCompletionStrategy, IBlitzLogicHandler
   {
       
      
      protected var m_Quest:Quest;
      
      protected var m_Logic:BlitzLogic;
      
      protected var m_ConfigManager:ConfigManager;
      
      protected var m_GamesNeeded:int;
      
      protected var m_GamesComplete:int;
      
      protected var m_QuestConfigId:String;
      
      protected var m_IsComplete:Boolean;
      
      protected var m_ProgressText:String;
      
      protected var m_GoalText:String;
      
      protected var m_App:Blitz3Game;
      
      public function NGamesCompletionStrategy(param1:Blitz3Game, param2:int, param3:String, param4:String, param5:String)
      {
         super();
         this.m_App = param1;
         this.m_Logic = this.m_App.logic;
         this.m_ConfigManager = this.m_App.sessionData.configManager;
         this.m_Logic.AddHandler(this);
         this.m_QuestConfigId = param3;
         this.m_GamesNeeded = param2;
         var _loc6_:Object = QuestConstants.SanitizeQuestObject(this.m_ConfigManager.GetObj(this.m_QuestConfigId));
         this.m_GamesComplete = parseInt(_loc6_[QuestConstants.KEY_PROGRESS]);
         if(isNaN(this.m_GamesComplete))
         {
            this.m_GamesComplete = 0;
         }
         this.m_ProgressText = param4;
         this.m_GoalText = param5;
      }
      
      public function SetQuest(param1:Quest) : void
      {
         this.m_Quest = param1;
      }
      
      public function IsQuestComplete() : Boolean
      {
         return this.m_IsComplete;
      }
      
      public function ForceCompletion() : void
      {
         this.m_GamesComplete = this.m_GamesNeeded;
         this.m_IsComplete = true;
         var _loc1_:Object = QuestConstants.SanitizeQuestObject(this.m_ConfigManager.GetObj(this.m_QuestConfigId));
         _loc1_[QuestConstants.KEY_IS_COMPLETE] = this.m_IsComplete;
         _loc1_[QuestConstants.KEY_PROGRESS] = "" + this.GetProgress();
         this.m_ConfigManager.SetObj(this.m_QuestConfigId,_loc1_);
      }
      
      public function clearCompletion() : void
      {
         this.m_GamesComplete = 0;
         this.m_IsComplete = false;
         var _loc1_:Object = QuestConstants.SanitizeQuestObject(this.m_ConfigManager.GetObj(this.m_QuestConfigId));
         _loc1_[QuestConstants.KEY_IS_COMPLETE] = this.m_IsComplete;
         _loc1_[QuestConstants.KEY_PROGRESS] = "" + 0;
         this.m_ConfigManager.SetObj(this.m_QuestConfigId,_loc1_);
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
         if(this.m_GamesComplete >= this.m_GamesNeeded)
         {
            this.m_IsComplete = true;
         }
      }
      
      public function GetProgressString() : String
      {
         var _loc1_:String = this.m_ProgressText.replace("%cur%",this.m_GamesComplete);
         return _loc1_.replace("%max%",this.m_GamesNeeded);
      }
      
      public function GetProgress() : int
      {
         return this.m_GamesComplete;
      }
      
      public function GetGoalString() : String
      {
         return this.m_GoalText.replace(/%max%/g,this.m_GamesNeeded);
      }
      
      public function GetGoal() : int
      {
         return this.m_GamesNeeded;
      }
      
      public function CleanUpConfigData() : void
      {
         this.m_Logic.RemoveHandler(this);
      }
      
      public function HandleGameLoad() : void
      {
      }
      
      public function HandleGameBegin() : void
      {
      }
      
      public function HandleGameEnd() : void
      {
         if(!this.m_Quest.IsActive())
         {
            return;
         }
         ++this.m_GamesComplete;
         var _loc1_:Object = QuestConstants.SanitizeQuestObject(this.m_ConfigManager.GetObj(this.m_QuestConfigId));
         _loc1_[QuestConstants.KEY_PROGRESS] = "" + this.m_GamesComplete;
         this.m_ConfigManager.SetObj(this.m_QuestConfigId,_loc1_);
      }
      
      public function HandleGameAbort() : void
      {
      }
      
      public function HandleGamePaused() : void
      {
      }
      
      public function HandleGameResumed() : void
      {
      }
      
      public function HandleScore(param1:ScoreValue) : void
      {
      }
      
      public function HandleBlockingEvent() : void
      {
      }
      
      public function HandleGameTimeDelayed() : void
      {
      }
   }
}
