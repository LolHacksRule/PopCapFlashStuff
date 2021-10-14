package com.popcap.flash.bejeweledblitz.game.quests.completion
{
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   
   public class UseBoostAtCertainTimeCompletionStrategy implements IQuestCompletionStrategy
   {
      
      public static const FLAME_GEM:String = "flame";
      
      public static const HYPER_CUBE:String = "cube";
      
      public static const STAR_GEM:String = "star";
      
      public static const COIN_GEM:String = "coin";
      
      private static const QUEST_WAITING:String = "waiting";
      
      private static const QUEST_SUCCESS:String = "success";
      
      private static const QUEST_FAILURE:String = "failure";
       
      
      private var m_App:Blitz3Game;
      
      private var m_Quest:Quest;
      
      private var m_Logic:BlitzLogic;
      
      private var m_ConfigManager:ConfigManager;
      
      private var _isComplete:Boolean;
      
      private var m_QuestConfigId:String;
      
      private var _progressString:String;
      
      private var _goalString:String;
      
      private var _useBoostAtTime:int;
      
      private var _timeBoostUsed:int;
      
      private var _boostType:String;
      
      private var _questState:String;
      
      public function UseBoostAtCertainTimeCompletionStrategy(param1:Blitz3Game, param2:int, param3:String, param4:String, param5:String, param6:String)
      {
         super();
         this.m_App = param1;
         this.m_Logic = param1.logic;
         this.m_ConfigManager = param1.sessionData.configManager;
         this._boostType = param3;
         this._useBoostAtTime = param2;
         this._timeBoostUsed = -1;
         this.m_QuestConfigId = param4;
         this._progressString = param5;
         this._goalString = param6;
         this._questState = QUEST_WAITING;
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
         this._timeBoostUsed = this._useBoostAtTime;
         this._isComplete = true;
         var _loc1_:Object = QuestConstants.SanitizeQuestObject(this.m_ConfigManager.GetObj(this.m_QuestConfigId));
         _loc1_[QuestConstants.KEY_IS_COMPLETE] = this._isComplete;
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
         if(this._questState == QUEST_SUCCESS)
         {
            this._isComplete = true;
         }
      }
      
      public function GetProgress() : int
      {
         return Math.round(this._timeBoostUsed / 100);
      }
      
      public function GetProgressString() : String
      {
         var _loc1_:* = this.GetProgress().toString() + " seconds";
         if(this._questState == QUEST_WAITING)
         {
            return "";
         }
         if(this._questState == QUEST_FAILURE)
         {
            return "<font color=\'#ff0000\'>" + _loc1_ + "</font>";
         }
         return _loc1_;
      }
      
      public function GetGoalString() : String
      {
         return this._goalString;
      }
      
      public function GetGoal() : int
      {
         return this._useBoostAtTime;
      }
      
      public function CleanUpConfigData() : void
      {
      }
   }
}
