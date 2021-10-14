package com.popcap.flash.bejeweledblitz.logic.gems.multi
{
   import com.popcap.flash.bejeweledblitz.logic.BlitzRandom;
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.Match;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzScoreKeeper;
   import com.popcap.flash.bejeweledblitz.logic.game.CascadeScore;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicSpawnHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ITimerLogicTimeChangeHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import com.popcap.flash.framework.math.MersenneTwister;
   
   public class MultiplierGemLogic implements ITimerLogicTimeChangeHandler, IBlitzLogicHandler, IBlitzLogicSpawnHandler
   {
       
      
      public var multiplier:int = 1;
      
      public var maxMultiplier:int = 1;
      
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
      
      private var _logic:BlitzLogic;
      
      private var _board:Board;
      
      private var _history:Vector.<Boolean>;
      
      private var _isFirst:Boolean;
      
      private var _candidates:Vector.<Gem>;
      
      private var _backupCandidates:Vector.<Gem>;
      
      private var _useDataPool:MultiplierUseDataPool;
      
      private var _handlers:Vector.<IMultiplierGemLogicHandler>;
      
      private var _random:BlitzRandom;
      
      public function MultiplierGemLogic(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
         this._board = param1.board;
         this.multiplier = 1;
         this.maxMultiplier = 1;
         this.gemThreshold = this._logic.config.multiplierGemLogicStartThreshold;
         this.deltaTimer = this._logic.config.multiplierGemLogicDeltaRate;
         this.lastHighest = 0;
         this.numSpawned = 0;
         this.remaining = this._logic.config.multiplierGemLogicMaxMultipliersDefault;
         this.triggered = false;
         this.awarded = false;
         this.spawned = false;
         this._isFirst = true;
         this.isEnabled = true;
         this._candidates = new Vector.<Gem>();
         this._backupCandidates = new Vector.<Gem>();
         this._history = new Vector.<Boolean>();
         this.used = new Vector.<MultiplierUseData>(9);
         this._useDataPool = new MultiplierUseDataPool();
         this._logic.lifeguard.AddPool(this._useDataPool);
         this._handlers = new Vector.<IMultiplierGemLogicHandler>();
         param1.timerLogic.AddTimeChangeHandler(this);
         param1.AddHandler(this);
         this._random = new BlitzRandom(new MersenneTwister());
      }
      
      public function AddHandler(param1:IMultiplierGemLogicHandler) : void
      {
         this._handlers.push(param1);
      }
      
      public function RemoveHandler(param1:IMultiplierGemLogicHandler) : void
      {
         var _loc2_:int = this._handlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._handlers.splice(_loc2_,1);
      }
      
      public function GetMaxMultiplier() : int
      {
         return this.maxMultiplier;
      }
      
      public function Reset() : void
      {
         this.multiplier = 1;
         this.maxMultiplier = 1;
         this.gemThreshold = this._logic.config.multiplierGemLogicStartThreshold;
         this.deltaTimer = this._logic.config.multiplierGemLogicDeltaRate;
         this.lastHighest = 9;
         this.numSpawned = 0;
         this.remaining = this._logic.config.multiplierGemLogicMaxMultipliersDefault;
         this.triggered = false;
         this.awarded = false;
         this.spawned = false;
         this._history.length = 0;
         this._isFirst = true;
         this._candidates.length = 0;
         this._backupCandidates.length = 0;
         this.isEnabled = true;
         var _loc1_:int = 0;
         while(_loc1_ < this.used.length)
         {
            this.used[_loc1_] = null;
            _loc1_++;
         }
         this._random.SetSeed(this._logic.GetCurrentSeed());
      }
      
      public function HandleLogicSpawnPhaseBegin() : void
      {
      }
      
      public function HandleLogicSpawnPhaseEnd() : void
      {
      }
      
      public function HandlePostLogicSpawnPhase() : void
      {
         var _loc5_:CascadeScore = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Gem = null;
         this.spawned = false;
         if(this._logic.lastHurrahLogic != null && this._logic.lastHurrahLogic.IsRunning())
         {
            return;
         }
         if(this.remaining == 0)
         {
            return;
         }
         var _loc1_:Vector.<CascadeScore> = this._logic.GetScoreKeeper().cascadeScores;
         var _loc2_:int = _loc1_.length;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            if((_loc5_ = _loc1_[_loc4_]).active)
            {
               if((_loc6_ = _loc5_.GetGemCount()) > _loc3_)
               {
                  _loc3_ = _loc6_;
               }
            }
            _loc4_++;
         }
         if(this.deltaTimer == 0)
         {
            this.deltaTimer = this._logic.config.multiplierGemLogicDeltaRate;
            if(!this._isFirst)
            {
               _loc7_ = this._random.Int(0,this._logic.config.multiplierGemLogicThresholdDelta);
               this.gemThreshold = Math.max(this.gemThreshold - _loc7_,this._logic.config.multiplierGemLogicMinThreshold);
            }
         }
         if(_loc3_ >= this.gemThreshold && !this.awarded)
         {
            this.triggered = true;
            this.gemThreshold = this._logic.config.multiplierGemLogicMaxThreshold;
            this._isFirst = false;
         }
         if(this.triggered)
         {
            this._candidates.length = 0;
            this.UpdateCandidates();
            if(this._candidates.length > 0)
            {
               _loc8_ = this._random.Int(0,this._candidates.length);
               _loc9_ = 0;
               while(_loc9_ < this._candidates.length)
               {
                  _loc10_ = this._candidates[_loc8_];
                  if(this.CanSpawnMuliplier(_loc10_))
                  {
                     this._logic.QueueAddMultiplierToken(_loc10_);
                     break;
                  }
                  _loc8_++;
                  if(_loc8_ >= this._candidates.length)
                  {
                     _loc8_ = 0;
                  }
                  _loc9_++;
               }
               if(_loc9_ >= this._candidates.length)
               {
                  return;
               }
            }
         }
         if(_loc3_ < this._logic.config.multiplierGemLogicThresholdReset)
         {
            this.awarded = false;
         }
         this.lastHighest = _loc3_;
      }
      
      public function HandleMatchedGem(param1:Gem) : void
      {
         this.HandleMultiplier(param1);
      }
      
      public function HandleShatteredGem(param1:Gem) : void
      {
         this.HandleMultiplier(param1);
      }
      
      public function HandleDetonatedGem(param1:Gem) : void
      {
         if(param1 == null || param1.type != Gem.TYPE_MULTI)
         {
            return;
         }
         this.HandleMultiplier(param1);
         param1.SetDead(true);
         param1.ForceShatter(false);
      }
      
      public function HandleGem(param1:Gem) : void
      {
         if(param1 == null || param1.type != Gem.TYPE_MULTI)
         {
            return;
         }
         param1.multiValue = this.multiplier + 1;
      }
      
      public function CanSpawnMuliplier(param1:Gem) : Boolean
      {
         if(!this.isEnabled)
         {
            return false;
         }
         if(this.remaining <= 0)
         {
            return false;
         }
         if(!this._logic.IsMaxMultiplierThresholdSet())
         {
            if(this._logic.multiLogic.multiplier > this._logic.config.multiplierGemLogicMaxMultipliersDefault)
            {
               this.remaining = 0;
               return false;
            }
         }
         if(param1.type >= Gem.TYPE_MULTI)
         {
            return false;
         }
         if(!param1.CanUpgrade(Gem.TYPE_MULTI))
         {
            return false;
         }
         return true;
      }
      
      public function SpawnGem(param1:Gem) : void
      {
         param1.upgrade(Gem.TYPE_MULTI,false);
         param1.multiValue = this.multiplier + 1;
         ++this.numSpawned;
         this.awarded = true;
         --this.remaining;
         this.triggered = false;
         this.spawned = true;
         if(param1.id >= this._history.length)
         {
            this._history.length = param1.id + 1;
         }
         this._history[param1.id] = false;
         this.DispatchMultiplierSpawned(param1);
      }
      
      public function UpgradeGem(param1:Gem, param2:Match, param3:Boolean) : void
      {
         if(this.CanSpawnMuliplier(param1))
         {
            this.SpawnGem(param1);
         }
      }
      
      public function ScaleMultiplier(param1:Number) : void
      {
         this.multiplier *= param1;
         if(this.maxMultiplier < this.multiplier)
         {
            this.maxMultiplier = this.multiplier;
         }
      }
      
      public function HandleGameTimeChange(param1:int) : void
      {
         --this.deltaTimer;
      }
      
      public function HandleGameLoad() : void
      {
      }
      
      public function HandleGameBegin() : void
      {
         this._logic.AddSpawnHandler(this);
      }
      
      public function HandleGameEnd() : void
      {
         this._logic.RemoveSpawnHandler(this);
      }
      
      public function HandleGameAbort() : void
      {
         this._logic.RemoveSpawnHandler(this);
      }
      
      public function HandleGamePaused() : void
      {
      }
      
      public function HandleGameResumed() : void
      {
      }
      
      public function HandleScore(param1:ScoreValue) : void
      {
         if(param1.HasTag(BlitzScoreKeeper.TAG_NOTMULTIPLIED))
         {
            return;
         }
         param1.SetValue(param1.GetValue() * this.multiplier);
      }
      
      public function HandleBlockingEvent() : void
      {
      }
      
      private function DispatchMultiplierSpawned(param1:Gem) : void
      {
         var _loc2_:IMultiplierGemLogicHandler = null;
         for each(_loc2_ in this._handlers)
         {
            _loc2_.HandleMultiplierSpawned(param1);
         }
      }
      
      private function DispatchMultiplierCollected() : void
      {
         var _loc1_:IMultiplierGemLogicHandler = null;
         for each(_loc1_ in this._handlers)
         {
            _loc1_.HandleMultiplierCollected();
         }
      }
      
      private function HandleMultiplier(param1:Gem) : void
      {
         var _loc4_:MultiplierUseData = null;
         if(param1 == null || param1.type != Gem.TYPE_MULTI)
         {
            return;
         }
         var _loc2_:int = this._history.length;
         if(param1.id < _loc2_ && this._history[param1.id] == true)
         {
            return;
         }
         param1.bonusValue = this._logic.config.multiplierGemLogicPointValue * (this.multiplier + 1);
         var _loc3_:ScoreValue = this._logic.AddScore(this._logic.config.multiplierGemLogicPointValue * (this.multiplier + 1));
         _loc3_.AddTag(BlitzScoreKeeper.TAG_NOTMULTIPLIED);
         this.IncrementMultiplier(param1.moveID);
         if(param1.id >= _loc2_)
         {
            this._history.length = param1.id + 1;
         }
         this._history[param1.id] = true;
         if(this._logic.lastHurrahLogic != null && !this._logic.lastHurrahLogic.IsRunning())
         {
            (_loc4_ = this._useDataPool.GetNextMultiplierUseData()).time = this._logic.timerLogic.GetTimeElapsed();
            _loc4_.color = param1.color;
            _loc4_.number = Math.max(this.multiplier,param1.multiValue);
            if(this.used.length <= _loc4_.number)
            {
               this.used.length = _loc4_.number + 1;
            }
            this.used[_loc4_.number] = _loc4_;
         }
      }
      
      private function IncrementMultiplier(param1:int) : void
      {
         if(!this.ForceSetMultiplier(this.multiplier + 1))
         {
            return;
         }
         this._logic.GetScoreKeeper().IncrementMultiplier(param1);
      }
      
      public function ForceSetMultiplier(param1:int) : Boolean
      {
         if(this._logic.lastHurrahLogic != null && this._logic.lastHurrahLogic.IsRunning())
         {
            return false;
         }
         this.multiplier = param1;
         if(this.maxMultiplier < this.multiplier)
         {
            this.maxMultiplier = this.multiplier;
         }
         this.DispatchMultiplierCollected();
         return true;
      }
      
      private function UpdateCandidates() : void
      {
         var _loc4_:Gem = null;
         var _loc5_:Vector.<Gem> = null;
         if(!this.isEnabled)
         {
            return;
         }
         this._candidates.length = 0;
         this._backupCandidates.length = 0;
         var _loc1_:Vector.<Gem> = this._board.freshGems;
         var _loc2_:int = _loc1_.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(!((_loc4_ = _loc1_[_loc3_]).HasToken() || _loc4_.type >= Gem.TYPE_MULTI))
            {
               if(this._logic.board.GetColorCount(_loc4_.color,false) < this._logic.config.multiplierGemLogicMinToSpawn)
               {
                  this._backupCandidates.push(_loc4_);
               }
               else
               {
                  this._candidates.push(_loc4_);
               }
            }
            _loc3_++;
         }
         if(this._candidates.length == 0 && this._backupCandidates.length > 0)
         {
            _loc5_ = this._candidates;
            this._candidates = this._backupCandidates;
            this._backupCandidates = _loc5_;
         }
      }
      
      private function DetonateGem(param1:Gem) : void
      {
         if(param1 == null || param1.type != Gem.TYPE_MULTI)
         {
            return;
         }
         this._logic.GetScoreKeeper().IncrementMultiplier(param1.moveID);
      }
      
      public function HandleGameTimeDelayed() : void
      {
      }
   }
}
