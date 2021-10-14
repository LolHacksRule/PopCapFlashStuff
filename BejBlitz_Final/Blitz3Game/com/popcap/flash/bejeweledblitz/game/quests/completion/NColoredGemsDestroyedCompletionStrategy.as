package com.popcap.flash.bejeweledblitz.game.quests.completion
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ILastHurrahLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ITimerLogicTimeChangeHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   
   public class NColoredGemsDestroyedCompletionStrategy implements IQuestCompletionStrategy, IBlitzLogicHandler, ITimerLogicTimeChangeHandler, ILastHurrahLogicHandler
   {
      
      private static const COLOR_NAME_IDS:Vector.<String> = new Vector.<String>(Gem.NUM_COLORS);
      
      private static const UPDATE_DELAY:int = 100;
      
      {
         COLOR_NAME_IDS[Gem.COLOR_NONE] = Blitz3GameLoc.LOC_GEM_COLOR_ANY;
         COLOR_NAME_IDS[Gem.COLOR_RED] = Blitz3GameLoc.LOC_GEM_COLOR_RED;
         COLOR_NAME_IDS[Gem.COLOR_ORANGE] = Blitz3GameLoc.LOC_GEM_COLOR_ORANGE;
         COLOR_NAME_IDS[Gem.COLOR_YELLOW] = Blitz3GameLoc.LOC_GEM_COLOR_YELLOW;
         COLOR_NAME_IDS[Gem.COLOR_GREEN] = Blitz3GameLoc.LOC_GEM_COLOR_GREEN;
         COLOR_NAME_IDS[Gem.COLOR_BLUE] = Blitz3GameLoc.LOC_GEM_COLOR_BLUE;
         COLOR_NAME_IDS[Gem.COLOR_PURPLE] = Blitz3GameLoc.LOC_GEM_COLOR_PURPLE;
         COLOR_NAME_IDS[Gem.COLOR_WHITE] = Blitz3GameLoc.LOC_GEM_COLOR_WHITE;
         COLOR_NAME_IDS[Gem.COLOR_ANY] = Blitz3GameLoc.LOC_GEM_COLOR_ANY;
      }
      
      private var m_Quest:Quest;
      
      private var m_App:Blitz3App;
      
      private var m_Logic:BlitzLogic;
      
      private var m_ConfigManager:ConfigManager;
      
      private var m_QuestConfigId:String;
      
      private var m_IsComplete:Boolean;
      
      private var m_ProgressString:String;
      
      private var m_GoalString:String;
      
      private var m_NumGems:int;
      
      private var m_CurGameGems:int;
      
      private var m_TargetGems:int;
      
      private var m_TargetColor:int;
      
      private var _oldCurGems:int = 0;
      
      public function NColoredGemsDestroyedCompletionStrategy(param1:Blitz3App, param2:BlitzLogic, param3:ConfigManager, param4:int, param5:int, param6:String, param7:String, param8:String)
      {
         super();
         this.m_App = param1;
         this.m_Logic = param2;
         this.m_ConfigManager = param3;
         this.m_TargetGems = param4;
         this.m_TargetColor = param5;
         this.m_QuestConfigId = param6;
         this.m_ProgressString = param7;
         this.m_GoalString = param8.replace(/%max%/g,param4);
         if(param5 < 0 || param5 >= COLOR_NAME_IDS.length)
         {
            param5 = Gem.COLOR_ANY;
         }
         var _loc9_:String = COLOR_NAME_IDS[param5];
         this.m_GoalString = this.m_GoalString.replace(/%color%/g,this.m_App.TextManager.GetLocString(COLOR_NAME_IDS[param5]));
         var _loc10_:Object = QuestConstants.SanitizeQuestObject(this.m_ConfigManager.GetObj(this.m_QuestConfigId));
         this.m_NumGems = parseInt(_loc10_[QuestConstants.KEY_PROGRESS]);
         this.m_CurGameGems = 0;
         this._oldCurGems = 0;
         this.m_Logic.AddHandler(this);
         this.m_Logic.timerLogic.AddTimeChangeHandler(this);
         this.m_Logic.lastHurrahLogic.AddHandler(this);
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
         this.m_NumGems = this.m_TargetGems;
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
         if(this.GetProgress() >= this.m_TargetGems)
         {
            this.m_IsComplete = true;
         }
      }
      
      public function GetProgress() : int
      {
         return this.m_NumGems + this.m_CurGameGems;
      }
      
      public function GetProgressString() : String
      {
         var _loc1_:int = Math.min(this.GetProgress(),this.m_TargetGems);
         return this.m_ProgressString.replace("%cur%",_loc1_).replace("%max%",this.m_TargetGems);
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
         this.m_Logic.RemoveHandler(this);
         this.m_Logic.timerLogic.RemoveTimeChangeHandler(this);
         this.m_Logic.lastHurrahLogic.RemoveHandler(this);
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
      
      public function HandleGameTimeChange(param1:int) : void
      {
         if(param1 % UPDATE_DELAY == 0)
         {
            this.UpdateCurrentGameCount();
         }
      }
      
      public function handleLastHurrahBegin() : void
      {
      }
      
      public function handleLastHurrahEnd() : void
      {
         this.UpdateCurrentGameCount();
      }
      
      public function handlePreCoinHurrah() : void
      {
         this.UpdateCurrentGameCount();
      }
      
      public function canBeginCoinHurrah() : Boolean
      {
         return true;
      }
      
      private function UpdateCurrentGameCount() : void
      {
         var _loc1_:Gem = null;
         if(!this.m_Quest.isTournamentGame() && !this.m_App.isDailyChallengeGame())
         {
            this.m_CurGameGems = 0;
            for each(_loc1_ in this.m_Logic.board.m_GemMap)
            {
               if(_loc1_.IsDead() && _loc1_.type != Gem.TYPE_HYPERCUBE)
               {
                  if(_loc1_.color == this.m_TargetColor || this.m_TargetColor == 0)
                  {
                     ++this.m_CurGameGems;
                  }
               }
            }
         }
      }
      
      public function HandleGameTimeDelayed() : void
      {
      }
   }
}
