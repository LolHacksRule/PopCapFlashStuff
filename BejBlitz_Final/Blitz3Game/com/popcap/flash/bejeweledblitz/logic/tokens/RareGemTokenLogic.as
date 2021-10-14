package com.popcap.flash.bejeweledblitz.logic.tokens
{
   import com.popcap.flash.bejeweledblitz.logic.BlitzRNGManager;
   import com.popcap.flash.bejeweledblitz.logic.BlitzRandom;
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicDelegate;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicSpawnHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicUpdateHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ITimerLogicTimeChangeHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ReplayCommands;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import com.popcap.flash.bejeweledblitz.logic.raregems.RGLogic;
   import com.popcap.flash.framework.math.MersenneTwister;
   import flash.display.MovieClip;
   import flash.utils.Dictionary;
   
   public class RareGemTokenLogic implements ITimerLogicTimeChangeHandler, IBlitzLogicHandler, IBlitzLogicUpdateHandler, IBlitzLogicSpawnHandler, IBlitzLogicDelegate
   {
       
      
      public var rareGemTokenArray:Vector.<RareGemToken>;
      
      public var collectedRareGemTokenArray:Vector.<RareGemToken>;
      
      public var isHurrahDone:Boolean;
      
      public var isEnabled:Boolean;
      
      public var totalEffectValueAdded:int;
      
      private var _tokensCollectedInLastHurrah:uint;
      
      private var _tokensCollectedInGame:uint;
      
      private var _timer:int;
      
      private var _candidates:Vector.<Gem>;
      
      private var _logic:BlitzLogic;
      
      private var _collectTimer:int;
      
      private var _curCooldown:int;
      
      private var _rareGemTokenPool:RareGemTokenPool;
      
      private var _handlers:Vector.<IRareGemTokenLogicHandler>;
      
      private var _tokensInCollectionAnimation:int;
      
      private var _random:BlitzRandom;
      
      public function RareGemTokenLogic(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
         this._random = new BlitzRandom(new MersenneTwister());
         this.Reset();
         this._rareGemTokenPool = new RareGemTokenPool();
         this._logic.lifeguard.AddPool(this._rareGemTokenPool);
         this._logic.AddHandler(this);
         this._logic.AddDelegate(this);
         this._handlers = new Vector.<IRareGemTokenLogicHandler>();
      }
      
      public function Reset() : void
      {
         this.isEnabled = true;
         this.rareGemTokenArray = new Vector.<RareGemToken>();
         this.collectedRareGemTokenArray = new Vector.<RareGemToken>();
         this._curCooldown = this._logic.config.rareGemTokenLogicSpawnCooldown;
         this._timer = this._curCooldown;
         this._candidates = new Vector.<Gem>();
         this.isHurrahDone = false;
         this._collectTimer = this._logic.config.rareGemTokenLogicCollectCooldown;
         this._tokensInCollectionAnimation = 0;
         this.totalEffectValueAdded = 0;
         this._tokensCollectedInGame = 0;
         this._tokensCollectedInLastHurrah = 0;
         this._random.SetSeed(this._logic.GetCurrentSeed());
      }
      
      public function AddHandler(param1:IRareGemTokenLogicHandler) : void
      {
         this._handlers.push(param1);
      }
      
      public function RemoveHandler(param1:IRareGemTokenLogicHandler) : void
      {
         var _loc2_:int = this._handlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._handlers.splice(_loc2_,1);
      }
      
      public function DetonateTokens(param1:int) : int
      {
         var _loc5_:RareGemToken = null;
         var _loc2_:int = 0;
         var _loc3_:int = this.rareGemTokenArray.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(!(_loc5_ = this.rareGemTokenArray[_loc4_]).isCollected)
            {
               _loc5_.autoCollect = 1;
               if(_loc5_.host && this.GemHasRareGemGiftToken(_loc5_.host) && !_loc5_.host.isImmune)
               {
                  _loc5_.host.isImmune = true;
                  _loc5_.host.moveID = param1;
                  this.DetonateFlameGem(_loc5_.host);
               }
               _loc2_++;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function incrementTokensCollectedInGame() : void
      {
         ++this._tokensCollectedInGame;
      }
      
      public function incrementTokensCollectedInLastHurrah() : void
      {
         ++this._tokensCollectedInLastHurrah;
      }
      
      public function getTokensCollectedInGame() : uint
      {
         return this._tokensCollectedInGame;
      }
      
      public function getTokensCollectedInLastHurrah() : uint
      {
         return this._tokensCollectedInLastHurrah;
      }
      
      public function getTotalTokensCollected() : uint
      {
         return this._tokensCollectedInGame + this._tokensCollectedInLastHurrah;
      }
      
      public function spawnRareGemTokensForGameStart() : void
      {
         if(!this.isEnabled)
         {
            return;
         }
         if(!this._logic.rareGemsLogic.currentRareGem || !this._logic.rareGemsLogic.currentRareGem.isTokenRareGem())
         {
            return;
         }
         var _loc1_:Gem = null;
         while(_loc1_ == null || _loc1_.row == Board.NUM_ROWS - 1 && (_loc1_.col == 0 || _loc1_.col == Board.NUM_COLS - 1) || _loc1_.type != Gem.TYPE_STANDARD)
         {
            _loc1_ = this._logic.board.GetRandomGem(BlitzRNGManager.RNG_BLITZ_PRIMARY);
         }
         this.SpawnRareGemTokenOnGem(_loc1_);
      }
      
      public function SpawnRareGemTokenOnGem(param1:Gem) : void
      {
         if(!this._logic.rareGemsLogic.currentRareGem.isTokenRareGem())
         {
            return;
         }
         if(RareGemToken.KEY in param1.rgTokens)
         {
            return;
         }
         var _loc2_:RareGemToken = this._rareGemTokenPool.GetNextRareGemToken(this._logic.rareGemsLogic.currentRareGem.getTokenGemEffectVal());
         _loc2_.id = this.rareGemTokenArray.length;
         _loc2_.host = param1;
         var _loc3_:String = this._logic.rareGemsLogic.currentRareGem.getTokenGemEffectType();
         if(_loc3_ != RGLogic.TOKEN_GEM_EFFECT_GIFT)
         {
            param1.type = Gem.TYPE_FLAME;
         }
         this.rareGemTokenArray.push(_loc2_);
         param1.rgTokens[RareGemToken.KEY] = _loc2_;
         this.DispatchRareGemTokenCreated(_loc2_);
      }
      
      public function spawnRareGemTokenOnClip(param1:int, param2:MovieClip) : void
      {
         var _loc3_:RareGemToken = this._rareGemTokenPool.GetNextRareGemToken(param1);
         _loc3_.id = this.rareGemTokenArray.length;
         _loc3_.container = param2;
         _loc3_.isBonus = true;
         this.DispatchRareGemTokenCreated(_loc3_);
         this.DispatchRareGemTokenCollected(_loc3_);
      }
      
      public function SpawnRareGemTokenForBonus(param1:int) : void
      {
      }
      
      public function GetRareGemTokenTotal(param1:Boolean) : int
      {
         var _loc3_:RareGemToken = null;
         var _loc2_:int = 0;
         for each(_loc3_ in this.rareGemTokenArray)
         {
            _loc2_ += _loc3_.value;
         }
         return _loc2_;
      }
      
      public function GemHasRareGemToken(param1:Gem) : Boolean
      {
         return this.isEnabled && param1 != null && RareGemToken.KEY in param1.rgTokens;
      }
      
      public function GemHasRareGemGiftToken(param1:Gem) : Boolean
      {
         return this.GemHasRareGemToken(param1) && this._logic.rareGemsLogic.currentRareGem != null && this._logic.rareGemsLogic.currentRareGem.getTokenGemEffectType() == RGLogic.TOKEN_GEM_EFFECT_GIFT;
      }
      
      public function HandleMatchedGem(param1:Gem) : void
      {
         if(!this.GemHasRareGemGiftToken(param1))
         {
            return;
         }
         if(param1 && !param1.isImmune)
         {
            param1.isImmune = true;
            this.DetonateFlameGem(param1);
         }
      }
      
      public function HandleShatteredGem(param1:Gem) : void
      {
         if(!this.GemHasRareGemGiftToken(param1))
         {
            return;
         }
         if(param1 && !param1.isImmune)
         {
            param1.isImmune = true;
            this.DetonateFlameGem(param1);
         }
      }
      
      public function HandleDetonatedGem(param1:Gem) : void
      {
         if(!this.GemHasRareGemToken(param1))
         {
            return;
         }
         var _loc2_:String = this._logic.rareGemsLogic.currentRareGem.getTokenGemEffectType();
         param1.bonusValue = RareGemToken.GEM_BONUS_VALUE;
         if(_loc2_ == RGLogic.TOKEN_GEM_EFFECT_GIFT)
         {
            if(param1 && !param1.isImmune)
            {
               param1.isImmune = true;
               this.DetonateFlameGem(param1);
            }
         }
         else
         {
            param1.SetDead(true);
            param1.ForceShatter(false);
         }
      }
      
      public function HandleGameTimeChange(param1:int) : void
      {
         --this._timer;
      }
      
      public function HandleLogicUpdateBegin() : void
      {
      }
      
      public function HandleLogicGemUpdateEnd() : void
      {
         var _loc3_:RareGemToken = null;
         var _loc4_:Gem = null;
         var _loc5_:Boolean = false;
         if(!this._logic.rareGemsLogic.currentRareGem || !this._logic.rareGemsLogic.currentRareGem.isTokenRareGem())
         {
            return;
         }
         var _loc1_:int = this.rareGemTokenArray.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.rareGemTokenArray[_loc2_];
            if(!_loc3_.isCollected)
            {
               if(_loc3_.autoCollect > 0)
               {
                  --_loc3_.autoCollect;
               }
               _loc4_ = _loc3_.host;
               if(_loc5_ = _loc3_.autoCollect == 0 || _loc4_.IsMatched() && !_loc4_.IsElectric() || _loc4_.IsShattered() && !(_loc4_.IsFuseLit() && _loc4_.GetFuseTime() > 0) || _loc4_.immuneTime > 0 || _loc4_.IsPunched())
               {
                  this.CollectRareGemToken(_loc3_);
               }
            }
            _loc2_++;
         }
      }
      
      public function HandleLogicUpdateEnd() : void
      {
      }
      
      public function HandleLogicSpawnPhaseBegin() : void
      {
      }
      
      public function HandleLogicSpawnPhaseEnd() : void
      {
      }
      
      public function HandlePostLogicSpawnPhase() : void
      {
         if(this._logic.lastHurrahLogic.IsRunning())
         {
            return;
         }
         if(this._timer > 0)
         {
            return;
         }
         this.UpdateCandidates();
         this.SpawnRareGemToken();
      }
      
      public function HandleGameLoad() : void
      {
      }
      
      public function HandleGameBegin() : void
      {
         if(this._logic.rareGemsLogic.currentRareGem && this._logic.rareGemsLogic.currentRareGem.isTokenRareGem())
         {
            this._logic.timerLogic.AddTimeChangeHandler(this);
            this._logic.AddUpdateHandler(this);
            this._logic.AddSpawnHandler(this);
            if(this._logic.rareGemsLogic.currentRareGem != null && this._logic.rareGemsLogic.currentRareGem.hasTokenCooldown())
            {
               this._curCooldown = this._logic.rareGemsLogic.currentRareGem.getTokenCooldown() * 100;
            }
            else
            {
               this._curCooldown = this._logic.config.rareGemTokenLogicSpawnCooldown;
            }
            this._timer = this._curCooldown;
         }
      }
      
      public function HandleGameEnd() : void
      {
         if(this._logic.rareGemsLogic.currentRareGem && this._logic.rareGemsLogic.currentRareGem.isTokenRareGem())
         {
            this._logic.timerLogic.RemoveTimeChangeHandler(this);
            this._logic.RemoveUpdateHandler(this);
            this._logic.RemoveSpawnHandler(this);
            this.rareGemTokenArray = new Vector.<RareGemToken>();
         }
      }
      
      public function HandleGameAbort() : void
      {
         if(this._logic.rareGemsLogic.currentRareGem && this._logic.rareGemsLogic.currentRareGem.isTokenRareGem())
         {
            this._logic.timerLogic.RemoveTimeChangeHandler(this);
            this._logic.RemoveUpdateHandler(this);
            this._logic.RemoveSpawnHandler(this);
            this.rareGemTokenArray = new Vector.<RareGemToken>();
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
      
      public function ShouldDelayTimeUp() : Boolean
      {
         return this._tokensInCollectionAnimation != 0;
      }
      
      private function UpdateCandidates() : void
      {
         var _loc4_:Gem = null;
         var _loc5_:int = 0;
         if(!this.isEnabled)
         {
            return;
         }
         this._candidates.length = 0;
         var _loc1_:Vector.<Gem> = this._logic.board.freshGems;
         var _loc2_:int = _loc1_.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if((_loc4_ = _loc1_[_loc3_]).type == Gem.TYPE_STANDARD)
            {
               if((_loc5_ = this._logic.rareGemsLogic.currentRareGem.getFlameColor()) == Gem.COLOR_ANY || _loc4_.color == _loc5_)
               {
                  this._candidates.push(_loc4_);
               }
            }
            _loc3_++;
         }
      }
      
      private function SpawnRareGemToken() : void
      {
         var _loc3_:int = 0;
         var _loc4_:Gem = null;
         if(!this.isEnabled)
         {
            return;
         }
         if(!this._logic.rareGemsLogic.currentRareGem || !this._logic.rareGemsLogic.currentRareGem.isTokenRareGem())
         {
            return;
         }
         if(!this.CanSpawnNewRareGemToken())
         {
            return;
         }
         var _loc1_:int = this._candidates.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            if(this._random.Bool(this._logic.config.rareGemTokenLogicSpawnChance))
            {
               _loc3_ = this._random.Int(0,this._candidates.length);
               _loc4_ = this._candidates[_loc3_];
               this._logic.QueueAddRGToken(_loc4_);
               this._timer = this._curCooldown;
               return;
            }
            _loc2_++;
         }
      }
      
      private function CollectRareGemToken(param1:RareGemToken) : void
      {
         var _loc2_:Gem = null;
         if(this.isEnabled)
         {
            _loc2_ = param1.host;
            if(_loc2_ != null)
            {
               _loc2_.bonusValue = RareGemToken.GEM_BONUS_VALUE;
            }
            param1.isCollected = true;
            this.collectedRareGemTokenArray.push(param1);
            ++this._tokensInCollectionAnimation;
            this.DispatchRareGemTokenCollected(param1);
         }
      }
      
      public function DetonateFlameGem(param1:Gem) : void
      {
         this._logic.flameGemLogic.ExplodeGem(param1);
      }
      
      public function TokenDidFinishCollectionAnimation(param1:RareGemToken) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Gem = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         --this._tokensInCollectionAnimation;
         var _loc2_:String = this._logic.rareGemsLogic.currentRareGem.getTokenGemEffectType();
         if(this._logic.lastHurrahLogic.IsRunning() && _loc2_ != RGLogic.TOKEN_GEM_EFFECT_GIFT)
         {
            return;
         }
         if(_loc2_ == RGLogic.TOKEN_GEM_EFFECT_TIME)
         {
            _loc3_ = param1.value * 100;
            this._logic.QueueAddExtraTimeDuringGamePlay(_loc3_,ReplayCommands.COMMAND_PLAY_AND_REPLAY);
         }
         else if(_loc2_ == RGLogic.TOKEN_GEM_EFFECT_GIFT)
         {
            if((_loc4_ = param1.host) && _loc4_.isImmune)
            {
               _loc5_ = Gem.TYPE_STANDARD;
               if((_loc6_ = this._logic.GetPrimaryRNG().Int(0,6)) < 3)
               {
                  _loc5_ = Gem.TYPE_FLAME;
               }
               else if(_loc6_ < 5)
               {
                  _loc5_ = Gem.TYPE_STAR;
               }
               else
               {
                  _loc5_ = Gem.TYPE_HYPERCUBE;
               }
               if((_loc5_ = Math.max(_loc4_.type,_loc5_)) == Gem.TYPE_FLAME)
               {
                  this._logic.flameGemLogic.UpgradeGem(_loc4_,null,false);
               }
               else if(_loc5_ == Gem.TYPE_STAR)
               {
                  this._logic.starGemLogic.UpgradeGem(_loc4_,null,null,true,false);
               }
               else
               {
                  this._logic.hypercubeLogic.UpgradeGem(_loc4_,null,false);
               }
            }
            _loc4_.rgTokens = new Dictionary();
         }
         this.totalEffectValueAdded += param1.value;
      }
      
      private function DispatchRareGemTokenCreated(param1:RareGemToken) : void
      {
         var _loc2_:IRareGemTokenLogicHandler = null;
         for each(_loc2_ in this._handlers)
         {
            _loc2_.HandleRareGemTokenCreated(param1);
         }
      }
      
      private function DispatchRareGemTokenCollected(param1:RareGemToken) : void
      {
         var _loc2_:IRareGemTokenLogicHandler = null;
         for each(_loc2_ in this._handlers)
         {
            _loc2_.HandleRareGemTokenCollected(param1);
         }
      }
      
      private function CanSpawnNewRareGemToken() : Boolean
      {
         if(this._logic.rareGemsLogic.currentRareGem.hasTokensPerGameLimit() && this.rareGemTokenArray.length >= this._logic.rareGemsLogic.currentRareGem.getMaxTokensPerGame())
         {
            return false;
         }
         var _loc1_:int = this.rareGemTokenArray.length - this.collectedRareGemTokenArray.length;
         if(this._logic.rareGemsLogic.currentRareGem.hasTokensOnScreenLimit() && _loc1_ >= this._logic.rareGemsLogic.currentRareGem.getMaxTokensOnScreen())
         {
            return false;
         }
         return true;
      }
      
      public function getRareGemTokenArray() : int
      {
         var _loc4_:RareGemToken = null;
         var _loc1_:int = 0;
         var _loc2_:int = this.rareGemTokenArray.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(!(_loc4_ = this.rareGemTokenArray[_loc3_]).isCollected)
            {
               _loc1_++;
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function HandleBlockingEvent() : void
      {
      }
      
      public function HandleGameTimeDelayed() : void
      {
      }
   }
}
