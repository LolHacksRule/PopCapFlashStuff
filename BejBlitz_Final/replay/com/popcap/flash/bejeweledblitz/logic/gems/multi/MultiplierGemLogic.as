package com.popcap.flash.bejeweledblitz.logic.gems.multi
{
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzScoreKeeper;
   import com.popcap.flash.bejeweledblitz.logic.game.CascadeScore;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ITimerLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   
   public class MultiplierGemLogic implements ITimerLogicHandler, IBlitzLogicHandler
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
       
      
      public var multiplier:int;
      
      public var gemThreshold:int;
      
      public var deltaTimer:int;
      
      public var lastHighest:int;
      
      public var numSpawned:int;
      
      public var remaining:int;
      
      public var triggered:Boolean;
      
      public var awarded:Boolean;
      
      public var spawned:Boolean;
      
      public var isEnabled:Boolean;
      
      public var used:Vector.<MultiplierUseData>;
      
      private var mLogic:BlitzLogic;
      
      private var mBoard:Board;
      
      private var mScore:BlitzScoreKeeper;
      
      private var m_History:Vector.<Boolean>;
      
      private var mIsFirst:Boolean;
      
      private var mCandidates:Vector.<Gem>;
      
      private var mBackupCandidates:Vector.<Gem>;
      
      private var m_UseDataPool:MultiplierUseDataPool;
      
      private var m_Handlers:Vector.<IMultiplierGemLogicHandler>;
      
      public function MultiplierGemLogic(logic:BlitzLogic)
      {
         super();
         this.mLogic = logic;
         this.mBoard = logic.board;
         this.mScore = logic.scoreKeeper;
         this.multiplier = 1;
         this.gemThreshold = START_THRESHOLD;
         this.deltaTimer = DELTA_RATE;
         this.lastHighest = 0;
         this.numSpawned = 0;
         this.remaining = MAX_MULTIPLIERS;
         this.triggered = false;
         this.awarded = false;
         this.spawned = false;
         this.mIsFirst = true;
         this.isEnabled = true;
         this.mCandidates = new Vector.<Gem>();
         this.mBackupCandidates = new Vector.<Gem>();
         this.m_History = new Vector.<Boolean>();
         this.used = new Vector.<MultiplierUseData>(9);
         this.m_UseDataPool = new MultiplierUseDataPool();
         this.mLogic.lifeguard.AddPool(this.m_UseDataPool);
         this.m_Handlers = new Vector.<IMultiplierGemLogicHandler>();
         logic.timerLogic.AddHandler(this);
         logic.AddHandler(this);
      }
      
      public function AddHandler(handler:IMultiplierGemLogicHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function Reset() : void
      {
         this.multiplier = 1;
         this.gemThreshold = START_THRESHOLD;
         this.deltaTimer = DELTA_RATE;
         this.lastHighest = 9;
         this.numSpawned = 0;
         this.remaining = MAX_MULTIPLIERS;
         this.triggered = false;
         this.awarded = false;
         this.spawned = false;
         this.m_History.length = 0;
         this.mIsFirst = true;
         this.mCandidates.length = 0;
         this.mBackupCandidates.length = 0;
         this.isEnabled = true;
         for(var i:int = 0; i < this.used.length; i++)
         {
            this.used[i] = null;
         }
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
               dec = this.mLogic.random.Int(0,THRESHOLD_DELTA);
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
               index = this.mLogic.random.Int(0,this.mCandidates.length);
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
         gem.SetDead(true);
         gem.ForceShatter(false);
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
         if(!this.isEnabled)
         {
            return;
         }
         if(this.remaining <= 0)
         {
            return;
         }
         if(gem.type == Gem.TYPE_MULTI)
         {
            return;
         }
         gem.upgrade(Gem.TYPE_MULTI,false);
         gem.multiValue = this.multiplier + 1;
         ++this.numSpawned;
         this.awarded = true;
         --this.remaining;
         this.triggered = false;
         this.spawned = true;
         if(gem.id >= this.m_History.length)
         {
            this.m_History.length = gem.id + 1;
         }
         this.m_History[gem.id] = false;
         this.DispatchMultiplierSpawned(gem);
      }
      
      public function ScaleMultiplier(scalar:Number) : void
      {
         this.multiplier *= scalar;
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
      
      public function HandleGameDurationChange(prevDuration:int, newDuration:int) : void
      {
      }
      
      public function HandleGameBegin() : void
      {
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
      
      public function HandleScore(score:ScoreValue) : void
      {
         if(score.HasTag(BlitzScoreKeeper.TAG_NOTMULTIPLIED))
         {
            return;
         }
         score.SetValue(score.GetValue() * this.multiplier);
      }
      
      private function DispatchMultiplierSpawned(gem:Gem) : void
      {
         var handler:IMultiplierGemLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleMultiplierSpawned(gem);
         }
      }
      
      private function DispatchMultiplierCollected() : void
      {
         var handler:IMultiplierGemLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleMultiplierCollected();
         }
      }
      
      private function HandleMultiplier(gem:Gem) : void
      {
         var useData:MultiplierUseData = null;
         if(gem == null || gem.type != Gem.TYPE_MULTI)
         {
            return;
         }
         var historyLength:int = this.m_History.length;
         if(gem.id < historyLength && this.m_History[gem.id] == true)
         {
            return;
         }
         gem.bonusValue = VALUE * (this.multiplier + 1);
         var score:ScoreValue = this.mLogic.AddScore(VALUE * (this.multiplier + 1));
         score.AddTag(BlitzScoreKeeper.TAG_NOTMULTIPLIED);
         this.IncrementMultiplier(gem.mMoveId);
         if(gem.id >= historyLength)
         {
            this.m_History.length = gem.id + 1;
         }
         this.m_History[gem.id] = true;
         if(!this.mLogic.lastHurrahLogic.IsRunning())
         {
            useData = this.m_UseDataPool.GetNextMultiplierUseData();
            useData.time = this.mLogic.timerLogic.GetTimeElapsed();
            useData.color = gem.color;
            useData.number = Math.max(this.multiplier,gem.multiValue);
            this.used[useData.number] = useData;
         }
      }
      
      private function IncrementMultiplier(moveId:int) : void
      {
         if(this.mLogic.lastHurrahLogic.IsRunning())
         {
            return;
         }
         ++this.multiplier;
         this.DispatchMultiplierCollected();
         this.mScore.IncrementMultiplier(moveId);
      }
      
      private function UpdateCandidates() : void
      {
         var gem:Gem = null;
         var temp:Vector.<Gem> = null;
         if(!this.isEnabled)
         {
            return;
         }
         this.mCandidates.length = 0;
         this.mBackupCandidates.length = 0;
         var fresh:Vector.<Gem> = this.mBoard.freshGems;
         var numGems:int = fresh.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = fresh[i];
            if(!gem.HasToken())
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
