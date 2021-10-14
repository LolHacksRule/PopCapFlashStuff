package com.popcap.flash.bejeweledblitz.game.quests.completion
{
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import com.popcap.flash.bejeweledblitz.logic.gems.flame.FlameGemCreateEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.flame.FlameGemExplodeEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.flame.IFlameGemLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.gems.hypercube.HypercubeCreateEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.hypercube.HypercubeExplodeEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.hypercube.IHypercubeLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.gems.multi.IMultiplierGemLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.gems.star.IStarGemLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.gems.star.StarGemCreateEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.star.StarGemExplodeEvent;
   
   public class NPowerGemsCreatedCompletionStrategy implements IQuestCompletionStrategy, IFlameGemLogicHandler, IHypercubeLogicHandler, IStarGemLogicHandler, IMultiplierGemLogicHandler, IBlitzLogicHandler
   {
      
      public static const FLAME_GEM:String = "flame";
      
      public static const HYPER_CUBE:String = "cube";
      
      public static const STAR_GEM:String = "star";
      
      public static const MULTI_GEM:String = "multi";
       
      
      private var m_App:Blitz3Game;
      
      private var m_Quest:Quest;
      
      private var m_Logic:BlitzLogic;
      
      private var m_ConfigManager:ConfigManager;
      
      private var m_IsComplete:Boolean;
      
      private var m_QuestConfigId:String;
      
      private var m_ProgressString:String;
      
      private var m_GoalString:String;
      
      private var m_TargetPowerGems:int;
      
      private var m_PowerGemType:String;
      
      private var m_PowerGemColor:int;
      
      private var m_CurPowerGems:int;
      
      private var m_StartingCurPowerGems:int;
      
      public function NPowerGemsCreatedCompletionStrategy(param1:Blitz3Game, param2:BlitzLogic, param3:ConfigManager, param4:int, param5:String, param6:String, param7:String, param8:String, param9:String, param10:int)
      {
         var _loc11_:Object = null;
         super();
         this.m_App = param1;
         this.m_Logic = param2;
         this.m_ConfigManager = param3;
         this.m_PowerGemType = param5;
         this.m_TargetPowerGems = param4;
         this.m_PowerGemColor = QuestConstants.gemColorAsInt(param6);
         this.m_QuestConfigId = param7;
         this.m_ProgressString = param8;
         this.m_GoalString = param9.replace(/%max%/g,param4);
         this.m_GoalString = this.m_GoalString.replace(/%gemtype%/g,this.GetLocalizedGemType(param5,param4 == 1));
         if(this.m_PowerGemColor == Gem.COLOR_NONE)
         {
            this.m_GoalString = this.m_GoalString.replace(/%color% /g,"");
         }
         else
         {
            this.m_GoalString = this.m_GoalString.replace(/%color%/g,param6.toUpperCase());
         }
         if(param10 == -1)
         {
            _loc11_ = QuestConstants.SanitizeQuestObject(this.m_ConfigManager.GetObj(this.m_QuestConfigId));
            this.m_CurPowerGems = parseInt(_loc11_[QuestConstants.KEY_PROGRESS]);
         }
         else
         {
            this.m_CurPowerGems = 0;
         }
         if(this.m_PowerGemType == FLAME_GEM)
         {
            this.m_Logic.flameGemLogic.AddHandler(this);
         }
         else if(this.m_PowerGemType == HYPER_CUBE)
         {
            this.m_Logic.hypercubeLogic.AddHandler(this);
         }
         else if(this.m_PowerGemType == STAR_GEM)
         {
            this.m_Logic.starGemLogic.AddHandler(this);
         }
         else if(this.m_PowerGemType == MULTI_GEM)
         {
            this.m_Logic.multiLogic.AddHandler(this);
         }
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
         if(this.m_PowerGemType == FLAME_GEM)
         {
            this.m_Logic.flameGemLogic.RemoveHandler(this);
         }
         else if(this.m_PowerGemType == HYPER_CUBE)
         {
            this.m_Logic.hypercubeLogic.RemoveHandler(this);
         }
         else if(this.m_PowerGemType == STAR_GEM)
         {
            this.m_Logic.starGemLogic.RemoveHandler(this);
         }
         else if(this.m_PowerGemType == MULTI_GEM)
         {
            this.m_Logic.multiLogic.RemoveHandler(this);
         }
         this.m_Logic.RemoveHandler(this);
      }
      
      public function handleFlameGemCreated(param1:FlameGemCreateEvent) : void
      {
         if(this.m_PowerGemColor == 0 || this.m_PowerGemColor == param1.GetLocus().color)
         {
            this.IncrementProgress();
         }
      }
      
      public function handleFlameGemExploded(param1:FlameGemExplodeEvent) : void
      {
      }
      
      public function handleFlameGemExplosionRange(param1:Gem, param2:Vector.<Gem>) : void
      {
      }
      
      public function HandleHypercubeCreated(param1:HypercubeCreateEvent) : void
      {
         this.IncrementProgress();
      }
      
      public function HandleHypercubeExploded(param1:HypercubeExplodeEvent) : void
      {
      }
      
      public function HandleStarGemCreated(param1:StarGemCreateEvent) : void
      {
         if(!param1.isCreatedFromMoonstone() && this.m_PowerGemColor == 0 || this.m_PowerGemColor == param1.GetLocus().color)
         {
            this.IncrementProgress();
         }
      }
      
      public function HandleStarGemExploded(param1:StarGemExplodeEvent) : void
      {
      }
      
      public function HandleMultiplierSpawned(param1:Gem) : void
      {
         this.IncrementProgress();
      }
      
      public function HandleMultiplierCollected() : void
      {
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
         if(param1 == MULTI_GEM)
         {
            if(param2)
            {
               return "MULTIPLIER";
            }
            return "MULTIPLIERS";
         }
         return "";
      }
      
      public function HandleGameLoad() : void
      {
      }
      
      public function HandleGameBegin() : void
      {
         var _loc1_:Gem = null;
         for each(_loc1_ in this.m_Logic.board.m_GemMap)
         {
            if(this.m_PowerGemType == FLAME_GEM)
            {
               if(_loc1_.type == Gem.TYPE_FLAME)
               {
                  if(this.m_PowerGemColor == 0 || this.m_PowerGemColor == _loc1_.color)
                  {
                     this.IncrementProgress();
                  }
               }
            }
            else if(this.m_PowerGemType == HYPER_CUBE)
            {
               if(_loc1_.type == Gem.TYPE_HYPERCUBE)
               {
                  this.IncrementProgress();
               }
            }
            else if(this.m_PowerGemType == STAR_GEM)
            {
               if(_loc1_.type == Gem.TYPE_STAR)
               {
                  if(this.m_PowerGemColor == 0 || this.m_PowerGemColor == _loc1_.color)
                  {
                     this.IncrementProgress();
                  }
               }
            }
         }
      }
      
      public function HandleGameEnd() : void
      {
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
