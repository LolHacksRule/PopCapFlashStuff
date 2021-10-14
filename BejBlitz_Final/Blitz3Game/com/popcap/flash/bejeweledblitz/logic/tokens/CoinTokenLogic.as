package com.popcap.flash.bejeweledblitz.logic.tokens
{
   import com.popcap.flash.bejeweledblitz.logic.BlitzRandom;
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicSpawnHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicUpdateHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ITimerLogicTimeChangeHandler;
   import com.popcap.flash.bejeweledblitz.logic.gems.multi.IMultiplierGemLogicHandler;
   import com.popcap.flash.framework.math.MersenneTwister;
   import flash.display.MovieClip;
   
   public class CoinTokenLogic implements ITimerLogicTimeChangeHandler, IBlitzLogicUpdateHandler, IBlitzLogicSpawnHandler, IMultiplierGemLogicHandler
   {
       
      
      public var coinArray:Vector.<CoinToken>;
      
      public var collectedCoinArray:Vector.<CoinToken>;
      
      public var bonusCollectedCoinArray:Vector.<CoinToken>;
      
      public var isHurrahDone:Boolean;
      
      public var isEnabled:Boolean;
      
      private var isMultiCoinCollectionSkipped:Boolean;
      
      private var isCollectingMultiCoins:Boolean;
      
      private var _multiCoins:int;
      
      private var _timer:int;
      
      private var _canSpawn:Boolean;
      
      private var _candidates:Vector.<Gem>;
      
      private var _multiCoinCollectionCompleteDelay:int;
      
      private var _logic:BlitzLogic;
      
      private var _collectTimer:int;
      
      private var _curCooldown:int;
      
      private var _coinTokenPool:CoinTokenPool;
      
      private var _handlers:Vector.<ICoinTokenLogicHandler>;
      
      private var random:BlitzRandom;
      
      public function CoinTokenLogic(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
         this.isHurrahDone = false;
         this.isEnabled = true;
         this.isMultiCoinCollectionSkipped = false;
         this.isCollectingMultiCoins = false;
         this._multiCoins = 1;
         this._timer = 0;
         this._canSpawn = true;
         this._collectTimer = this._logic.config.coinTokenLogicCollectCooldown;
         this.coinArray = new Vector.<CoinToken>();
         this.collectedCoinArray = new Vector.<CoinToken>();
         this.bonusCollectedCoinArray = new Vector.<CoinToken>();
         this._coinTokenPool = new CoinTokenPool();
         this._logic.lifeguard.AddPool(this._coinTokenPool);
         this._handlers = new Vector.<ICoinTokenLogicHandler>();
         this._candidates = new Vector.<Gem>();
         param1.timerLogic.AddTimeChangeHandler(this);
         param1.AddUpdateHandler(this);
         param1.AddSpawnHandler(this);
         param1.multiLogic.AddHandler(this);
         this.random = new BlitzRandom(new MersenneTwister());
      }
      
      public function getMultiCoins() : int
      {
         return this._multiCoins;
      }
      
      public function Reset() : void
      {
         this.isEnabled = true;
         this.isMultiCoinCollectionSkipped = false;
         this.isCollectingMultiCoins = false;
         this.coinArray.length = 0;
         this.collectedCoinArray.length = 0;
         this.bonusCollectedCoinArray.length = 0;
         this._curCooldown = this._logic.config.coinTokenLogicSpawnCooldown;
         this._canSpawn = true;
         this._timer = this._curCooldown;
         this._candidates.length = 0;
         this._multiCoins = 1;
         this.isHurrahDone = false;
         this._multiCoinCollectionCompleteDelay = 3;
         this._collectTimer = this._logic.config.coinTokenLogicCollectCooldown;
         this.random.SetSeed(this._logic.GetCurrentSeed());
      }
      
      public function AddHandler(param1:ICoinTokenLogicHandler) : void
      {
         this._handlers.push(param1);
      }
      
      public function RemoveHandler(param1:ICoinTokenLogicHandler) : void
      {
         var _loc2_:int = this._handlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._handlers.splice(_loc2_,1);
      }
      
      public function DetonateCoinTokens() : int
      {
         var _loc4_:CoinToken = null;
         var _loc1_:int = 0;
         var _loc2_:int = this.coinArray.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(!(_loc4_ = this.coinArray[_loc3_]).isCollected)
            {
               _loc4_.autoCollect = 1;
               _loc1_++;
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function SkipMultiplierCoinCollectionAnim() : void
      {
         if(this.isCollectingMultiCoins && !this.isMultiCoinCollectionSkipped)
         {
            this.isMultiCoinCollectionSkipped = true;
         }
      }
      
      public function CollectCoinTokens() : void
      {
         var _loc3_:int = 0;
         var _loc4_:Gem = null;
         var _loc5_:CoinToken = null;
         --this._collectTimer;
         if(this._collectTimer > 0)
         {
            return;
         }
         this._collectTimer = this._logic.config.coinTokenLogicCollectCooldown;
         if(this.coinArray.length == this.collectedCoinArray.length)
         {
            this.isCollectingMultiCoins = true;
            if(this.isMultiCoinCollectionSkipped)
            {
               this.CollectMultiCoinTokensSkipAnim();
            }
            else
            {
               this.CollectMultiCoinTokens();
            }
            return;
         }
         var _loc1_:Board = this._logic.board;
         var _loc2_:int = 0;
         while(_loc2_ < Board.HEIGHT)
         {
            _loc3_ = 0;
            while(_loc3_ < Board.WIDTH)
            {
               if((_loc4_ = _loc1_.GetGemAt(_loc2_,_loc3_)) != null)
               {
                  if(!((_loc5_ = _loc4_.tokens[CoinToken.KEY] as CoinToken) == null || _loc5_.isCollected))
                  {
                     this.CollectCoin(_loc5_,false);
                  }
               }
               continue;
               _loc3_++;
               return;
            }
            _loc2_++;
         }
      }
      
      public function ScoreCoins() : void
      {
         var _loc3_:CoinToken = null;
         var _loc1_:int = this.coinArray.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.coinArray[_loc2_];
            if(_loc3_.collectPoints > 0)
            {
               this._logic.GetScoreKeeper().AddPoints(_loc3_.collectPoints,_loc3_.host);
               _loc3_.collectPoints = 0;
            }
            _loc2_++;
         }
      }
      
      private function CollectMultiCoinTokens() : void
      {
         if(this._multiCoins <= 1 || this._logic.GetScoreKeeper().GetScore() < this._logic.config.coinTokenLogicMinimumScore)
         {
            if(this._multiCoinCollectionCompleteDelay-- <= 0)
            {
               this.isHurrahDone = true;
            }
            this.isCollectingMultiCoins = false;
            return;
         }
         --this._multiCoins;
         this.CreateMultiCoin();
      }
      
      private function CollectMultiCoinTokensSkipAnim() : void
      {
         var _loc2_:CoinToken = null;
         var _loc1_:int = this._multiCoins - 1;
         while(_loc1_ > 0)
         {
            _loc2_ = this._coinTokenPool.GetNextCoinToken(this._logic.config.coinTokenLogicCoinValue);
            _loc2_.id = this.coinArray.length;
            this.coinArray.push(_loc2_);
            _loc2_.isCollected = true;
            this.collectedCoinArray.push(_loc2_);
            _loc1_--;
         }
         this.DispatchMultiCoinCollectionSkipped();
         this._multiCoins = 1;
         this.isHurrahDone = true;
         this.isMultiCoinCollectionSkipped = false;
      }
      
      public function SpawnCoinOnGem(param1:Gem) : void
      {
         if(CoinToken.KEY in param1.tokens)
         {
            return;
         }
         var _loc2_:CoinToken = this._coinTokenPool.GetNextCoinToken(this._logic.config.coinTokenLogicCoinValue);
         _loc2_.id = this.coinArray.length;
         _loc2_.host = param1;
         this.coinArray.push(_loc2_);
         param1.tokens[CoinToken.KEY] = _loc2_;
         this.DispatchCoinCreated(_loc2_);
      }
      
      public function spawnCoinOnClip(param1:int, param2:MovieClip) : void
      {
         var _loc3_:CoinToken = this._coinTokenPool.GetNextCoinToken(param1);
         _loc3_.id = this.coinArray.length;
         _loc3_.container = param2;
         _loc3_.isBonus = true;
         this.bonusCollectedCoinArray.push(_loc3_);
         this.DispatchCoinCreated(_loc3_);
         this.DispatchCoinCollected(_loc3_);
      }
      
      public function SpawnCoinForBonus(param1:int) : void
      {
         var _loc2_:CoinToken = this._coinTokenPool.GetNextCoinToken(param1);
         _loc2_.id = this.coinArray.length;
         _loc2_.isBonus = true;
         this.bonusCollectedCoinArray.push(_loc2_);
         this.DispatchCoinCreated(_loc2_);
         this.DispatchCoinCollected(_loc2_);
      }
      
      public function GetCoinTotal(param1:Boolean) : int
      {
         var _loc3_:CoinToken = null;
         var _loc2_:int = 0;
         for each(_loc3_ in this.collectedCoinArray)
         {
            _loc2_ += _loc3_.value;
         }
         if(param1)
         {
            for each(_loc3_ in this.bonusCollectedCoinArray)
            {
               _loc2_ += _loc3_.value;
            }
         }
         return _loc2_;
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
         var _loc3_:CoinToken = null;
         var _loc4_:Gem = null;
         var _loc5_:Boolean = false;
         var _loc1_:int = this.coinArray.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.coinArray[_loc2_];
            if(!_loc3_.isCollected)
            {
               if(_loc3_.autoCollect > 0)
               {
                  --_loc3_.autoCollect;
               }
               _loc4_ = _loc3_.host;
               if(_loc5_ = _loc3_.autoCollect == 0 || _loc4_.IsMatched() || _loc4_.IsShattered() || _loc4_.immuneTime > 0 || _loc4_.IsPunched())
               {
                  this.CollectCoin(_loc3_,true);
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
         this.SpawnCoin();
      }
      
      public function HandleMultiplierSpawned(param1:Gem) : void
      {
      }
      
      public function HandleMultiplierCollected() : void
      {
         this._multiCoins = this._logic.multiLogic.multiplier;
      }
      
      private function UpdateCandidates() : void
      {
         var _loc4_:Gem = null;
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
            if((_loc4_ = _loc1_[_loc3_]).color == this._logic.config.coinTokenLogicCoinColor && _loc4_.type == Gem.TYPE_STANDARD)
            {
               this._candidates.push(_loc4_);
            }
            _loc3_++;
         }
      }
      
      private function SpawnCoin() : void
      {
         var _loc3_:int = 0;
         var _loc4_:Gem = null;
         if(!this.isEnabled)
         {
            return;
         }
         var _loc1_:int = this._candidates.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            if(this.random.Bool(this._logic.config.coinTokenLogicSpawnChance))
            {
               _loc3_ = this.random.Int(0,this._candidates.length);
               _loc4_ = this._candidates[_loc3_];
               this._logic.QueueAddCoinToken(_loc4_);
               this._timer = this._curCooldown;
               return;
            }
            _loc2_++;
         }
      }
      
      private function CreateMultiCoin() : void
      {
         var _loc1_:CoinToken = this._coinTokenPool.GetNextCoinToken(this._logic.config.coinTokenLogicCoinValue);
         _loc1_.id = this.coinArray.length;
         this.coinArray.push(_loc1_);
         this.DispatchCoinCreated(_loc1_);
         this.CollectCoin(_loc1_,false);
      }
      
      private function CollectCoin(param1:CoinToken, param2:Boolean) : void
      {
         if(param2)
         {
            param1.collectPoints = this._logic.config.coinTokenLogicCoinPoints;
            this._logic.AddScore(this._logic.config.coinTokenLogicCoinPoints);
         }
         param1.isCollected = true;
         this.collectedCoinArray.push(param1);
         this.DispatchCoinCollected(param1);
      }
      
      private function DispatchCoinCreated(param1:CoinToken) : void
      {
         var _loc2_:ICoinTokenLogicHandler = null;
         for each(_loc2_ in this._handlers)
         {
            _loc2_.HandleCoinCreated(param1);
         }
      }
      
      private function DispatchCoinCollected(param1:CoinToken) : void
      {
         var _loc2_:ICoinTokenLogicHandler = null;
         for each(_loc2_ in this._handlers)
         {
            _loc2_.HandleCoinCollected(param1);
         }
      }
      
      private function DispatchMultiCoinCollectionSkipped() : void
      {
         var _loc1_:ICoinTokenLogicHandler = null;
         for each(_loc1_ in this._handlers)
         {
            _loc1_.HandleMultiCoinCollectionSkipped(this._multiCoins - 1);
         }
      }
      
      public function getCoinArraySize() : int
      {
         var _loc4_:CoinToken = null;
         var _loc1_:int = 0;
         var _loc2_:int = this.coinArray.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(!(_loc4_ = this.coinArray[_loc3_]).isCollected)
            {
               _loc1_++;
            }
            _loc3_++;
         }
         return _loc1_;
      }
   }
}
