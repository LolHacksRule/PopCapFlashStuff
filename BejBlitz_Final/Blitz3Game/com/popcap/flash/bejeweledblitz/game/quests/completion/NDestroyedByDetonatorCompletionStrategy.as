package com.popcap.flash.bejeweledblitz.game.quests.completion
{
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   
   public class NDestroyedByDetonatorCompletionStrategy implements IQuestCompletionStrategy, IBlitzLogicHandler
   {
      
      public static const FLAME_GEM:String = "flame";
      
      public static const HYPER_CUBE:String = "cube";
      
      public static const STAR_GEM:String = "star";
      
      public static const COIN_GEM:String = "coin";
       
      
      private var m_App:Blitz3Game;
      
      private var m_Quest:Quest;
      
      private var m_Logic:BlitzLogic;
      
      private var m_ConfigManager:ConfigManager;
      
      private var m_IsComplete:Boolean;
      
      private var m_QuestConfigId:String;
      
      private var m_ProgressString:String;
      
      private var m_GoalString:String;
      
      private var m_TargetGems:int;
      
      private var m_gemType:String;
      
      private var m_CurGems:int;
      
      public function NDestroyedByDetonatorCompletionStrategy(param1:Blitz3Game, param2:int, param3:String, param4:String, param5:String, param6:String)
      {
         super();
         this.m_App = param1;
         this.m_Logic = param1.logic;
         this.m_ConfigManager = param1.sessionData.configManager;
         this.m_gemType = param3;
         this.m_TargetGems = param2;
         this.m_QuestConfigId = param4;
         this.m_ProgressString = param5;
         this.m_GoalString = param6.replace(/%max%/g,param2);
         this.m_GoalString = this.m_GoalString.replace(/%gemtype%/g,this.GetLocalizedGemType(this.m_gemType,param2 == 1));
         var _loc7_:Object = QuestConstants.SanitizeQuestObject(this.m_ConfigManager.GetObj(this.m_QuestConfigId));
         this.m_CurGems = parseInt(_loc7_[QuestConstants.KEY_PROGRESS]);
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
         this.m_CurGems = this.m_TargetGems;
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
         if(this.m_CurGems >= this.m_TargetGems)
         {
            this.m_IsComplete = true;
         }
      }
      
      public function GetProgress() : int
      {
         return this.m_CurGems;
      }
      
      public function GetProgressString() : String
      {
         return this.m_ProgressString.replace("%cur%",Math.min(this.m_CurGems,this.m_TargetGems)).replace("%max%",this.m_TargetGems);
      }
      
      public function GetGoalString() : String
      {
         return this.m_GoalString;
      }
      
      public function GetGoal() : int
      {
         return this.m_TargetGems;
      }
      
      public function CleanUpConfigData() : void
      {
      }
      
      public function HandleGameLoad() : void
      {
      }
      
      public function HandleGameBegin() : void
      {
      }
      
      public function HandleGameEnd() : void
      {
         var _loc1_:Object = QuestConstants.SanitizeQuestObject(this.m_ConfigManager.GetObj(this.m_QuestConfigId));
         _loc1_[QuestConstants.KEY_PROGRESS] = "" + this.GetProgress();
         this.m_ConfigManager.SetObj(this.m_QuestConfigId,_loc1_);
      }
      
      public function HandleGameAbort() : void
      {
         var _loc1_:Object = null;
         if(!this.m_App.mIsReplay)
         {
            _loc1_ = QuestConstants.SanitizeQuestObject(this.m_ConfigManager.GetObj(this.m_QuestConfigId));
            _loc1_[QuestConstants.KEY_PROGRESS] = "" + this.GetProgress();
            this.m_ConfigManager.SetObj(this.m_QuestConfigId,_loc1_);
         }
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
      
      private function GetLocalizedGemType(param1:String, param2:Boolean = false) : String
      {
         if(param1 == FLAME_GEM)
         {
            if(param2)
            {
               return "FLAME GEM";
            }
            return "FLAME GEMS";
         }
         if(param1 == HYPER_CUBE)
         {
            if(param2)
            {
               return "HYPERCUBE";
            }
            return "HYPERCUBES";
         }
         if(param1 == STAR_GEM)
         {
            if(param2)
            {
               return "STAR GEM";
            }
            return "STAR GEMS";
         }
         if(param1 == COIN_GEM)
         {
            if(param2)
            {
               return "Coin";
            }
            return "Coins";
         }
         return "SOME GEM";
      }
      
      public function HandleGameTimeDelayed() : void
      {
      }
   }
}
