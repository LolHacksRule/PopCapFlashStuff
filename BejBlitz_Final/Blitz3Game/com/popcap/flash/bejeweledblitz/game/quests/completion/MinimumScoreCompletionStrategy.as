package com.popcap.flash.bejeweledblitz.game.quests.completion
{
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import com.popcap.flash.framework.utils.StringUtils;
   
   public class MinimumScoreCompletionStrategy implements IQuestCompletionStrategy, IBlitzLogicHandler
   {
       
      
      protected var m_Quest:Quest;
      
      protected var m_Logic:BlitzLogic;
      
      protected var m_ConfigManager:ConfigManager;
      
      protected var m_QuestConfigId:String;
      
      protected var m_ProgressString:String;
      
      protected var m_GoalString:String;
      
      protected var m_TargetScore:int;
      
      protected var m_CurScore:int;
      
      protected var m_IsComplete:Boolean;
      
      public function MinimumScoreCompletionStrategy(param1:BlitzLogic, param2:ConfigManager, param3:int, param4:String, param5:String, param6:String)
      {
         super();
         this.m_Logic = param1;
         this.m_ConfigManager = param2;
         this.m_TargetScore = param3;
         this.m_QuestConfigId = param4;
         var _loc7_:String = StringUtils.InsertNumberCommas(this.m_TargetScore);
         this.m_ProgressString = param5;
         this.m_GoalString = param6.replace(/%min%/g,_loc7_);
         this.m_IsComplete = false;
         var _loc8_:Object = QuestConstants.SanitizeQuestObject(this.m_ConfigManager.GetObj(this.m_QuestConfigId));
         this.m_CurScore = parseInt(_loc8_[QuestConstants.KEY_PROGRESS]);
         this.m_Logic.AddHandler(this);
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
         this.m_CurScore = this.m_TargetScore + 1;
         var _loc1_:Object = QuestConstants.SanitizeQuestObject(this.m_ConfigManager.GetObj(this.m_QuestConfigId));
         _loc1_[QuestConstants.KEY_IS_COMPLETE] = true;
         this.m_ConfigManager.SetObj(this.m_QuestConfigId,_loc1_);
      }
      
      public function clearCompletion() : void
      {
         var _loc1_:Object = QuestConstants.SanitizeQuestObject(this.m_ConfigManager.GetObj(this.m_QuestConfigId));
         _loc1_[QuestConstants.KEY_IS_COMPLETE] = false;
         _loc1_[QuestConstants.KEY_PROGRESS] = "" + 0;
         this.m_ConfigManager.SetObj(this.m_QuestConfigId,_loc1_);
      }
      
      public function forceReset() : void
      {
         var _loc1_:Object = QuestConstants.SanitizeQuestObject(this.m_ConfigManager.GetObj(this.m_QuestConfigId));
         _loc1_[QuestConstants.KEY_IS_COMPLETE] = "expire";
         _loc1_[QuestConstants.KEY_PROGRESS] = "" + 0;
         this.m_ConfigManager.SetObj(this.m_QuestConfigId,_loc1_);
      }
      
      public function UpdateCompletionState() : void
      {
         if(this.m_CurScore >= this.m_TargetScore)
         {
            this.m_IsComplete = true;
         }
      }
      
      public function GetProgressString() : String
      {
         return this.m_ProgressString.replace("%cur%",this.m_CurScore);
      }
      
      public function GetProgress() : int
      {
         return int(this.m_IsComplete);
      }
      
      public function GetGoalString() : String
      {
         return this.m_GoalString;
      }
      
      public function GetGoal() : int
      {
         return this.m_TargetScore;
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
         var _loc1_:Object = null;
         if(this.m_Quest.IsActive())
         {
            this.m_CurScore = this.m_Logic.GetScoreKeeper().GetScore();
            _loc1_ = QuestConstants.SanitizeQuestObject(this.m_ConfigManager.GetObj(this.m_QuestConfigId));
            _loc1_[QuestConstants.KEY_PROGRESS] = "" + this.m_CurScore;
            this.m_ConfigManager.SetObj(this.m_QuestConfigId,_loc1_);
         }
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
