package com.popcap.flash.bejeweledblitz.game.quests.completion
{
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.gems.flame.FlameGemCreateEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.flame.FlameGemExplodeEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.flame.IFlameGemLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.gems.hypercube.HypercubeCreateEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.hypercube.HypercubeExplodeEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.hypercube.IHypercubeLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.gems.star.IStarGemLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.gems.star.StarGemCreateEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.star.StarGemExplodeEvent;
   import com.popcap.flash.bejeweledblitz.logic.tokens.CoinToken;
   import com.popcap.flash.bejeweledblitz.logic.tokens.ICoinTokenLogicHandler;
   
   public class NPowerGemsDestroyedCompletionStrategy implements IQuestCompletionStrategy, IFlameGemLogicHandler, IHypercubeLogicHandler, IStarGemLogicHandler, ICoinTokenLogicHandler
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
      
      private var m_TargetPowerGems:int;
      
      private var m_PowerGemType:String;
      
      private var m_CurPowerGems:int;
      
      private var m_StartingCurPowerGems:int;
      
      public function NPowerGemsDestroyedCompletionStrategy(param1:Blitz3Game, param2:BlitzLogic, param3:ConfigManager, param4:int, param5:String, param6:String, param7:String, param8:String, param9:int)
      {
         var _loc10_:Object = null;
         super();
         this.m_App = param1;
         this.m_Logic = param2;
         this.m_ConfigManager = param3;
         this.m_PowerGemType = param5;
         this.m_TargetPowerGems = param4;
         this.m_QuestConfigId = param6;
         this.m_ProgressString = param7;
         this.m_GoalString = param8.replace(/%max%/g,param4);
         this.m_GoalString = this.m_GoalString.replace(/%gemtype%/g,this.GetLocalizedGemType(param5,param4 == 1));
         if(param9 == -1)
         {
            _loc10_ = QuestConstants.SanitizeQuestObject(this.m_ConfigManager.GetObj(this.m_QuestConfigId));
            this.m_CurPowerGems = parseInt(_loc10_[QuestConstants.KEY_PROGRESS]);
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
         else if(this.m_PowerGemType == COIN_GEM)
         {
            this.m_Logic.coinTokenLogic.AddHandler(this);
         }
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
         else if(this.m_PowerGemType == COIN_GEM)
         {
            this.m_Logic.coinTokenLogic.RemoveHandler(this);
         }
      }
      
      public function handleFlameGemCreated(param1:FlameGemCreateEvent) : void
      {
      }
      
      public function handleFlameGemExploded(param1:FlameGemExplodeEvent) : void
      {
         this.IncrementProgress();
      }
      
      public function handleFlameGemExplosionRange(param1:Gem, param2:Vector.<Gem>) : void
      {
      }
      
      public function HandleHypercubeCreated(param1:HypercubeCreateEvent) : void
      {
      }
      
      public function HandleHypercubeExploded(param1:HypercubeExplodeEvent) : void
      {
         this.IncrementProgress();
      }
      
      public function HandleStarGemCreated(param1:StarGemCreateEvent) : void
      {
      }
      
      public function HandleStarGemExploded(param1:StarGemExplodeEvent) : void
      {
         this.IncrementProgress();
      }
      
      public function HandleCoinCreated(param1:CoinToken) : void
      {
      }
      
      public function HandleCoinCollected(param1:CoinToken) : void
      {
         if(!this.m_App.logic.lastHurrahLogic.IsRunning())
         {
            this.IncrementProgress();
         }
      }
      
      public function HandleMultiCoinCollectionSkipped(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1)
         {
            if(!this.m_App.logic.lastHurrahLogic.IsRunning())
            {
               this.IncrementProgress();
            }
            _loc2_++;
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
   }
}
