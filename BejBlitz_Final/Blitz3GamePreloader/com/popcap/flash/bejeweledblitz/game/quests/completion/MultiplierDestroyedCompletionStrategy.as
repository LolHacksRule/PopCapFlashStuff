package com.popcap.flash.bejeweledblitz.game.quests.completion
{
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.gems.multi.IMultiplierGemLogicHandler;
   
   public class MultiplierDestroyedCompletionStrategy implements IQuestCompletionStrategy, IMultiplierGemLogicHandler
   {
       
      
      private var m_App:Blitz3Game;
      
      private var m_Quest:Quest;
      
      private var m_Logic:BlitzLogic;
      
      private var m_ConfigManager:ConfigManager;
      
      private var m_IsComplete:Boolean;
      
      private var m_QuestConfigId:String;
      
      private var m_ProgressString:String;
      
      private var m_GoalString:String;
      
      private var m_TargetPowerGems:int;
      
      private var m_MultiplierType:int;
      
      private var m_CurPowerGems:int;
      
      private var m_StartingCurPowerGems:int;
      
      public function MultiplierDestroyedCompletionStrategy(param1:Blitz3Game, param2:int, param3:String, param4:String, param5:String, param6:String, param7:int)
      {
         var _loc8_:Object = null;
         super();
         this.m_App = param1;
         this.m_Logic = this.m_App.logic;
         this.m_ConfigManager = this.m_App.sessionData.configManager;
         this.m_TargetPowerGems = param2;
         this.m_QuestConfigId = param4;
         this.m_ProgressString = param5;
         this.m_GoalString = param6.replace("%max%",param2);
         if(param3)
         {
            this.m_MultiplierType = int(param3.substr(-1));
            this.m_GoalString = this.m_GoalString.replace("%multi%",param3);
         }
         else
         {
            this.m_MultiplierType = -1;
            this.m_GoalString = this.m_GoalString.replace("%multi%","");
         }
         this.m_GoalString = this.m_GoalString.replace("%gemtype%",this.GetLocalizedGemType(param2 == 1));
         if(param7 == -1)
         {
            _loc8_ = QuestConstants.SanitizeQuestObject(this.m_ConfigManager.GetObj(this.m_QuestConfigId));
            this.m_CurPowerGems = parseInt(_loc8_[QuestConstants.KEY_PROGRESS]);
         }
         else
         {
            this.m_CurPowerGems = 0;
         }
         this.m_Logic.multiLogic.AddHandler(this);
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
         this.m_CurPowerGems = this.m_TargetPowerGems;
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
         if(this.m_CurPowerGems >= this.m_TargetPowerGems)
         {
            this.m_IsComplete = true;
         }
      }
      
      public function GetProgress() : int
      {
         return this.m_CurPowerGems;
      }
      
      public function GetProgressString() : String
      {
         return this.m_ProgressString.replace("%cur%",Math.min(this.m_CurPowerGems,this.m_TargetPowerGems)).replace("%max%",this.m_TargetPowerGems);
      }
      
      public function GetGoalString() : String
      {
         return this.m_GoalString;
      }
      
      public function GetGoal() : int
      {
         return this.m_TargetPowerGems;
      }
      
      public function CleanUpConfigData() : void
      {
         this.m_Logic.multiLogic.RemoveHandler(this);
      }
      
      public function HandleMultiplierSpawned(param1:Gem) : void
      {
      }
      
      public function HandleMultiplierCollected() : void
      {
         if(this.m_MultiplierType == this.m_Logic.multiLogic.multiplier || this.m_MultiplierType == -1)
         {
            this.IncrementProgress();
         }
      }
      
      private function IncrementProgress() : void
      {
         var _loc1_:Object = null;
         if(this.m_Quest.IsActive())
         {
            ++this.m_CurPowerGems;
            _loc1_ = QuestConstants.SanitizeQuestObject(this.m_ConfigManager.GetObj(this.m_QuestConfigId));
            _loc1_[QuestConstants.KEY_PROGRESS] = "" + this.m_CurPowerGems;
            this.m_ConfigManager.SetObj(this.m_QuestConfigId,_loc1_);
         }
      }
      
      private function GetLocalizedGemType(param1:Boolean = false) : String
      {
         if(param1)
         {
            return "MULTIPLIER";
         }
         return "MULTIPLIERS";
      }
   }
}
