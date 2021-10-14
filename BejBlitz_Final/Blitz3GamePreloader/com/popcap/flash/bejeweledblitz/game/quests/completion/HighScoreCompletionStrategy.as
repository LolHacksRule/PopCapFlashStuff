package com.popcap.flash.bejeweledblitz.game.quests.completion
{
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import com.popcap.flash.framework.utils.StringUtils;
   
   public class HighScoreCompletionStrategy implements IQuestCompletionStrategy, IBlitzLogicHandler
   {
       
      
      protected var m_Quest:Quest;
      
      protected var m_Logic:BlitzLogic;
      
      protected var m_ConfigManager:ConfigManager;
      
      protected var m_QuestConfigId:String;
      
      protected var m_ProgressString:String;
      
      protected var m_GoalString:String;
      
      protected var m_HighScore:int;
      
      protected var m_CurScore:int;
      
      protected var m_IsComplete:Boolean;
      
      public function HighScoreCompletionStrategy(param1:BlitzLogic, param2:ConfigManager, param3:int, param4:String, param5:String, param6:String)
      {
         super();
         this.m_Logic = param1;
         this.m_ConfigManager = param2;
         this.m_HighScore = param3;
         this.m_QuestConfigId = param4;
         var _loc7_:String = StringUtils.InsertNumberCommas(this.m_HighScore);
         this.m_ProgressString = param5;
         this.m_GoalString = param6.replace(/%min%/g,_loc7_);
         this.m_IsComplete = false;
         this.m_CurScore = 0;
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
         this.m_CurScore = this.m_HighScore + 1;
         this.m_IsComplete = true;
         var _loc1_:Object = QuestConstants.SanitizeQuestObject(this.m_ConfigManager.GetObj(this.m_QuestConfigId));
         _loc1_[QuestConstants.KEY_IS_COMPLETE] = this.m_IsComplete;
         this.m_ConfigManager.SetObj(this.m_QuestConfigId,_loc1_);
      }
      
      public function UpdateCompletionState() : void
      {
         if(this.m_CurScore > this.m_HighScore)
         {
            this.m_IsComplete = true;
         }
      }
      
      public function GetProgressString() : String
      {
         return this.m_ProgressString;
      }
      
      public function GetProgress() : int
      {
         return this.m_CurScore;
      }
      
      public function GetGoalString() : String
      {
         return this.m_GoalString;
      }
      
      public function GetGoal() : int
      {
         return this.m_HighScore;
      }
      
      public function CleanUpConfigData() : void
      {
         this.m_Logic.RemoveHandler(this);
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
      
      public function HandleGameLoad() : void
      {
      }
      
      public function HandleGameBegin() : void
      {
      }
      
      public function HandleGameEnd() : void
      {
         var _loc1_:int = this.m_Logic.GetScoreKeeper().GetScore();
         if(!this.m_Quest.IsActive())
         {
            if(_loc1_ > this.m_HighScore)
            {
               this.m_HighScore = _loc1_;
            }
         }
         if(_loc1_ > this.m_CurScore)
         {
            this.m_CurScore = _loc1_;
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
