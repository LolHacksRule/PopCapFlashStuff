package com.popcap.flash.bejeweledblitz.game.quests.completion
{
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlazingSpeedLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   
   public class BlazingSpeedCompletionStrategy implements IQuestCompletionStrategy, IBlitzLogicHandler, IBlazingSpeedLogicHandler
   {
       
      
      private var m_Quest:Quest;
      
      private var m_Logic:BlitzLogic;
      
      private var m_ConfigManager:ConfigManager;
      
      private var m_CurBlazingSpeeds:int;
      
      private var m_TargetBlazingSpeeds:int;
      
      private var m_IsComplete:Boolean;
      
      private var m_QuestConfigId:String;
      
      private var m_ProgressString:String;
      
      private var m_GoalString:String;
      
      public function BlazingSpeedCompletionStrategy(param1:BlitzLogic, param2:ConfigManager, param3:int, param4:String, param5:String, param6:String)
      {
         super();
         this.m_Logic = param1;
         this.m_ConfigManager = param2;
         this.m_TargetBlazingSpeeds = param3;
         this.m_QuestConfigId = param4;
         this.m_ProgressString = param5;
         this.m_GoalString = param6.replace(/%max%/g,this.m_TargetBlazingSpeeds);
         var _loc7_:Object = QuestConstants.SanitizeQuestObject(this.m_ConfigManager.GetObj(this.m_QuestConfigId));
         this.m_CurBlazingSpeeds = parseInt(_loc7_[QuestConstants.KEY_PROGRESS]);
         this.m_Logic.AddHandler(this);
         this.m_Logic.blazingSpeedLogic.AddHandler(this);
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
         this.m_IsComplete = true;
         var _loc1_:Object = QuestConstants.SanitizeQuestObject(this.m_ConfigManager.GetObj(this.m_QuestConfigId));
         _loc1_[QuestConstants.KEY_IS_COMPLETE] = this.m_IsComplete;
         _loc1_[QuestConstants.KEY_PROGRESS] = "" + this.GetProgress();
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
         if(this.m_CurBlazingSpeeds >= this.m_TargetBlazingSpeeds)
         {
            this.m_IsComplete = true;
         }
      }
      
      public function GetProgress() : int
      {
         return this.m_CurBlazingSpeeds;
      }
      
      public function GetProgressString() : String
      {
         return this.m_ProgressString.replace("%cur%",Math.min(this.m_CurBlazingSpeeds,this.m_TargetBlazingSpeeds)).replace("%max%",this.m_TargetBlazingSpeeds);
      }
      
      public function GetGoalString() : String
      {
         return this.m_GoalString;
      }
      
      public function GetGoal() : int
      {
         return this.m_TargetBlazingSpeeds;
      }
      
      public function CleanUpConfigData() : void
      {
         this.m_Logic.RemoveHandler(this);
         this.m_Logic.blazingSpeedLogic.RemoveHandler(this);
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
         if(!this.m_IsComplete)
         {
            if(this.m_CurBlazingSpeeds < this.m_TargetBlazingSpeeds)
            {
               this.m_CurBlazingSpeeds = 0;
            }
            _loc1_ = QuestConstants.SanitizeQuestObject(this.m_ConfigManager.GetObj(this.m_QuestConfigId));
            _loc1_[QuestConstants.KEY_PROGRESS] = "" + this.m_CurBlazingSpeeds;
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
      
      public function HandleBlazingSpeedBegin() : void
      {
         if(this.m_Quest.IsActive())
         {
            ++this.m_CurBlazingSpeeds;
         }
      }
      
      public function HandleBlazingSpeedEnd() : void
      {
      }
      
      public function HandleBlazingSpeedReset() : void
      {
      }
      
      public function HandleBlazingSpeedPercentChanged(param1:Number) : void
      {
      }
      
      public function HandleGameTimeDelayed() : void
      {
      }
   }
}
