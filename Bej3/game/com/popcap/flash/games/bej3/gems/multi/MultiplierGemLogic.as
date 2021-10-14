package com.popcap.flash.games.bej3.gems.multi
{
   import com.popcap.flash.framework.events.EventBus;
   import com.popcap.flash.games.bej3.Board;
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.blitz.BlitzLogic;
   import com.popcap.flash.games.bej3.blitz.BlitzScoreKeeper;
   import com.popcap.flash.games.bej3.blitz.BlitzScoreValue;
   import com.popcap.flash.games.bej3.blitz.CascadeScore;
   import com.popcap.flash.games.bej3.blitz.ITimerLogicHandler;
   import flash.utils.Dictionary;
   
   public class MultiplierGemLogic implements ITimerLogicHandler
   {
      
      public static const VALUE:int = 1000;
      
      public static const FUSE_TIME:int = 5;
      
      public static const MIN_TO_SPAWN:int = 4;
      
      public static const START_THRESHOLD:int = 12;
      
      public static const MAX_THRESHOLD:int = 20;
      
      public static const MIN_THRESHOLD:int = 5;
      
      public static const THRESHOLD_DELTA:int = 5;
      
      public static const DELTA_RATE:int = 400;
      
      public static const THRESHOLD_RESET:int = 8;
      
      public static const MAX_MULTIPLIERS:int = 7;
       
      
      public var multiplier:int = 1;
      
      public var gemThreshold:int = 12;
      
      public var deltaTimer:int = 400;
      
      public var lastHighest:int = 0;
      
      public var numSpawned:int = 0;
      
      public var remaining:int = 7;
      
      public var triggered:Boolean = false;
      
      public var awarded:Boolean = false;
      
      public var spawned:Boolean = false;
      
      public var used:Array;
      
      private var mLogic:BlitzLogic;
      
      private var mBoard:Board;
      
      private var mScore:BlitzScoreKeeper;
      
      private var mHistory:Dictionary;
      
      private var mIsFirst:Boolean = true;
      
      private var mCandidates:Vector.<Gem>;
      
      private var mBackupCandidates:Vector.<Gem>;
      
      public function MultiplierGemLogic(logic:BlitzLogic)
      {
         super();
         this.mLogic = logic;
         this.mBoard = logic.board;
         this.mScore = logic.scoreKeeper;
         this.mCandidates = new Vector.<Gem>();
         this.mBackupCandidates = new Vector.<Gem>();
         logic.timerLogic.AddHandler(this);
      }
      
      public function Reset() : void
      {
         this.multiplier = this.mLogic.GetCurrentLevel();
         this.gemThreshold = START_THRESHOLD;
         this.deltaTimer = DELTA_RATE;
         this.lastHighest = 9;
         this.numSpawned = 0;
         this.remaining = MAX_MULTIPLIERS;
         this.triggered = false;
         this.awarded = false;
         this.spawned = false;
         this.mHistory = new Dictionary();
         this.used = new Array();
         this.mIsFirst = true;
         this.mCandidates.length = 0;
         this.mBackupCandidates.length = 0;
      }
      
      public function ProcessScore(score:BlitzScoreValue) : void
      {
         if(score.tags.find("NotMultiplied"))
         {
            return;
         }
         score.value *= this.multiplier;
      }
      
      public function HandleSpawnEndEvent() : void
      {
         var cs:CascadeScore = null;
         var gemCount:int = 0;
         var dec:int = 0;
         var index:int = 0;
         var gem:Gem = null;
         this.spawned = false;
         if(this.mLogic.lastHurrahLogic.IsRunning())
         {
            return;
         }
         if(this.remaining == 0)
         {
            return;
         }
         var cascades:Vector.<CascadeScore> = this.mScore.cascadeScores;
         var numCascades:int = cascades.length;
         var highest:int = 0;
         for(var i:int = 0; i < numCascades; i++)
         {
            cs = cascades[i];
            if(cs.active)
            {
               gemCount = cs.GetGemCount();
               if(gemCount > highest)
               {
                  highest = gemCount;
               }
            }
         }
         if(this.deltaTimer == 0)
         {
            this.deltaTimer = DELTA_RATE;
            if(!this.mIsFirst)
            {
               dec = this.mLogic.random.Int(THRESHOLD_DELTA);
               this.gemThreshold = Math.max(this.gemThreshold - dec,MIN_THRESHOLD);
            }
         }
         if(highest >= this.gemThreshold && !this.awarded)
         {
            this.triggered = true;
            this.gemThreshold = MAX_THRESHOLD;
            this.mIsFirst = false;
         }
         if(this.triggered)
         {
            this.mCandidates.length = 0;
            this.UpdateCandidates();
            if(this.mCandidates.length > 0)
            {
               index = this.mLogic.random.Int(this.mCandidates.length);
               gem = this.mCandidates[index];
               this.SpawnGem(gem);
            }
         }
         if(highest < THRESHOLD_RESET)
         {
            this.awarded = false;
         }
         this.lastHighest = highest;
      }
      
      public function HandleMatchedGem(gem:Gem) : void
      {
         this.HandleMultiplier(gem);
      }
      
      public function HandleShatteredGem(gem:Gem) : void
      {
         this.HandleMultiplier(gem);
      }
      
      public function HandleDetonatedGem(gem:Gem) : void
      {
         if(gem == null || gem.type != Gem.TYPE_MULTI)
         {
            return;
         }
         this.HandleMultiplier(gem);
         gem.isDead = true;
         gem.ForceShatter();
      }
      
      public function HandleGem(gem:Gem) : void
      {
         if(gem == null || gem.type != Gem.TYPE_MULTI)
         {
            return;
         }
         gem.multiValue = this.multiplier + 1;
      }
      
      public function SpawnGem(gem:Gem) : void
      {
      }
      
      public function HandleTimePhaseBegin() : void
      {
      }
      
      public function HandleTimePhaseEnd() : void
      {
      }
      
      public function HandleGameTimeChange(newTime:int) : void
      {
         --this.deltaTimer;
      }
      
      public function HandleGameDurationChange(newDuration:int) : void
      {
      }
      
      private function HandleMultiplier(gem:Gem) : void
      {
         var useData:Object = null;
         if(gem == null || gem.type != Gem.TYPE_MULTI)
         {
            return;
         }
         if(this.mHistory[gem.id] == true)
         {
            return;
         }
         gem.bonusValue = VALUE * (this.multiplier + 1);
         this.mLogic.AddScore(VALUE * (this.multiplier + 1)).tags.insert("NotMultiplied","NotMultiplied");
         this.IncrementMultiplier(gem.mMoveId);
         this.mHistory[gem.id] = true;
         if(!this.mLogic.lastHurrahLogic.IsRunning())
         {
            useData = new Object();
            useData.time = this.mLogic.timerLogic.GetTimeElapsed();
            useData.color = gem.color;
            useData.number = Math.max(this.multiplier,gem.multiValue);
            this.used.push(useData);
         }
      }
      
      private function IncrementMultiplier(moveId:int) : void
      {
         if(this.mLogic.lastHurrahLogic.IsRunning())
         {
            return;
         }
         ++this.multiplier;
         EventBus.GetGlobal().Dispatch("MultiplierCollectedEvent");
         this.mScore.IncrementMultiplier(moveId);
      }
      
      private function UpdateCandidates() : void
      {
         var gem:Gem = null;
         var temp:Vector.<Gem> = null;
         this.mCandidates.length = 0;
         this.mBackupCandidates.length = 0;
         var fresh:Vector.<Gem> = this.mBoard.freshGems;
         var numGems:int = fresh.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = fresh[i];
            if(gem.tokens.size <= 0)
            {
               if(this.mLogic.board.GetColorCount(gem.color,false) < MIN_TO_SPAWN)
               {
                  this.mBackupCandidates.push(gem);
               }
               else
               {
                  this.mCandidates.push(gem);
               }
            }
         }
         if(this.mCandidates.length == 0 && this.mBackupCandidates.length > 0)
         {
            temp = this.mCandidates;
            this.mCandidates = this.mBackupCandidates;
            this.mBackupCandidates = temp;
         }
      }
      
      private function DetonateGem(gem:Gem) : void
      {
         if(gem == null || gem.type != Gem.TYPE_MULTI)
         {
            return;
         }
         this.mScore.IncrementMultiplier(gem.mMoveId);
      }
   }
}
