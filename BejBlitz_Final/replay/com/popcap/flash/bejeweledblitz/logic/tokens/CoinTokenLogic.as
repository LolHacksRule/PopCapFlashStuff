package com.popcap.flash.bejeweledblitz.logic.tokens
{
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicSpawnHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicUpdateHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ITimerLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.gems.multi.IMultiplierGemLogicHandler;
   
   public class CoinTokenLogic implements ITimerLogicHandler, IBlitzLogicUpdateHandler, IBlitzLogicSpawnHandler, IMultiplierGemLogicHandler
   {
      
      public static const MINIMUM_SCORE:int = 1000;
      
      public static const COIN_COLOR:int = Gem.COLOR_YELLOW;
      
      public static const SPAWN_CHANCE:Number = 0.5;
      
      public static const COLLECT_COOLDOWN:int = 25;
      
      public static const COIN_VALUE:int = 100;
      
      public static const COIN_POINTS:int = 1250;
      
      public static const SPAWN_COOLDOWN:int = 1000;
       
      
      public var coins:Vector.<CoinToken>;
      
      public var collected:Vector.<CoinToken>;
      
      public var bonusCollected:Vector.<CoinToken>;
      
      public var isHurrahDone:Boolean;
      
      public var isEnabled:Boolean;
      
      private var m_MultiCoinCollectionCompleteDelay:int;
      
      public var multiCoins:int;
      
      private var m_Logic:BlitzLogic;
      
      private var mTimer:int;
      
      private var mCanSpawn:Boolean;
      
      private var mCandidates:Vector.<Gem>;
      
      private var mCollectTimer:int;
      
      private var m_CurCooldown:int;
      
      private var m_CoinTokenPool:CoinTokenPool;
      
      private var m_Handlers:Vector.<ICoinTokenLogicHandler>;
      
      public function CoinTokenLogic(logic:BlitzLogic)
      {
         super();
         this.isHurrahDone = false;
         this.isEnabled = true;
         this.multiCoins = 1;
         this.mTimer = 0;
         this.mCanSpawn = true;
         this.mCollectTimer = COLLECT_COOLDOWN;
         this.coins = new Vector.<CoinToken>();
         this.collected = new Vector.<CoinToken>();
         this.bonusCollected = new Vector.<CoinToken>();
         this.m_Logic = logic;
         this.m_CoinTokenPool = new CoinTokenPool();
         this.m_Logic.lifeguard.AddPool(this.m_CoinTokenPool);
         this.m_Handlers = new Vector.<ICoinTokenLogicHandler>();
         this.mCandidates = new Vector.<Gem>();
         logic.timerLogic.AddHandler(this);
         logic.AddUpdateHandler(this);
         logic.AddSpawnHandler(this);
         logic.multiLogic.AddHandler(this);
      }
      
      public function Reset() : void
      {
         this.isEnabled = true;
         this.coins.length = 0;
         this.collected.length = 0;
         this.bonusCollected.length = 0;
         this.m_CurCooldown = SPAWN_COOLDOWN;
         this.mCanSpawn = true;
         this.mTimer = this.m_CurCooldown;
         this.mCandidates.length = 0;
         this.multiCoins = 1;
         this.isHurrahDone = false;
         this.m_MultiCoinCollectionCompleteDelay = 3;
         this.mCollectTimer = COLLECT_COOLDOWN;
      }
      
      public function AddHandler(handler:ICoinTokenLogicHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function DetonateCoinTokens() : int
      {
         var coin:CoinToken = null;
         var numDetonated:int = 0;
         var numCoins:int = this.coins.length;
         for(var i:int = 0; i < numCoins; i++)
         {
            coin = this.coins[i];
            if(!coin.isCollected)
            {
               coin.autoCollect = 1;
               numDetonated++;
            }
         }
         return numDetonated;
      }
      
      public function CollectCoinTokens() : void
      {
         var col:int = 0;
         var gem:Gem = null;
         var coin:CoinToken = null;
         --this.mCollectTimer;
         if(this.mCollectTimer > 0)
         {
            return;
         }
         this.mCollectTimer = COLLECT_COOLDOWN;
         if(this.coins.length == this.collected.length)
         {
            this.CollectMultiCoinTokens();
            return;
         }
         var board:Board = this.m_Logic.board;
         for(var row:int = 0; row < Board.HEIGHT; row++)
         {
            for(col = 0; col < Board.WIDTH; )
            {
               gem = board.GetGemAt(row,col);
               coin = gem.tokens[CoinToken.KEY] as CoinToken;
               if(!(coin == null || coin.isCollected))
               {
                  this.CollectCoin(coin,false);
               }
               continue;
               col++;
               return;
            }
         }
      }
      
      public function ScoreCoins() : void
      {
         var coin:CoinToken = null;
         var numCoins:int = this.coins.length;
         for(var i:int = 0; i < numCoins; i++)
         {
            coin = this.coins[i];
            if(coin.collectPoints > 0)
            {
               this.m_Logic.scoreKeeper.AddPoints(coin.collectPoints,coin.host);
               coin.collectPoints = 0;
            }
         }
      }
      
      private function CollectMultiCoinTokens() : void
      {
         if(this.multiCoins <= 1 || this.m_Logic.scoreKeeper.GetScore() < MINIMUM_SCORE)
         {
            if(this.m_MultiCoinCollectionCompleteDelay-- <= 0)
            {
               this.isHurrahDone = true;
            }
            return;
         }
         --this.multiCoins;
         this.CreateMultiCoin();
      }
      
      public function SpawnCoinOnGem(gem:Gem) : void
      {
         if(CoinToken.KEY in gem.tokens)
         {
            return;
         }
         var coin:CoinToken = this.m_CoinTokenPool.GetNextCoinToken(COIN_VALUE);
         coin.id = this.coins.length;
         coin.host = gem;
         this.coins.push(coin);
         gem.tokens[CoinToken.KEY] = coin;
         this.DispatchCoinCreated(coin);
      }
      
      public function SpawnCoinForBonus(bonusAmount:int, xPos:int, yPos:int) : void
      {
         var coin:CoinToken = this.m_CoinTokenPool.GetNextCoinToken(bonusAmount);
         coin.id = this.coins.length;
         coin.isBonus = true;
         this.bonusCollected.push(coin);
         this.DispatchCoinCreated(coin);
         this.DispatchCoinCollected(coin);
      }
      
      public function GetCoinTotal(includeBonus:Boolean) : int
      {
         var coin:CoinToken = null;
         var total:int = 0;
         for each(coin in this.collected)
         {
            total += coin.value;
         }
         if(includeBonus)
         {
            for each(coin in this.bonusCollected)
            {
               total += coin.value;
            }
         }
         return total;
      }
      
      public function HandleTimePhaseBegin() : void
      {
      }
      
      public function HandleTimePhaseEnd() : void
      {
      }
      
      public function HandleGameTimeChange(newTime:int) : void
      {
         --this.mTimer;
      }
      
      public function HandleGameDurationChange(prevDuration:int, newDuration:int) : void
      {
      }
      
      public function HandleLogicUpdateBegin() : void
      {
      }
      
      public function HandleLogicGemUpdateEnd() : void
      {
         var coin:CoinToken = null;
         var gem:Gem = null;
         var isCollected:Boolean = false;
         var numCoins:int = this.coins.length;
         for(var i:int = 0; i < numCoins; i++)
         {
            coin = this.coins[i];
            if(!coin.isCollected)
            {
               if(coin.autoCollect > 0)
               {
                  --coin.autoCollect;
               }
               gem = coin.host;
               isCollected = coin.autoCollect == 0 || gem.IsMatched() || gem.IsShattered() || gem.immuneTime > 0;
               if(isCollected)
               {
                  this.CollectCoin(coin,true);
               }
            }
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
         if(this.m_Logic.lastHurrahLogic.IsRunning())
         {
            return;
         }
         if(this.mTimer > 0)
         {
            return;
         }
         this.UpdateCandidates();
         this.SpawnCoin();
      }
      
      public function HandleMultiplierSpawned(gem:Gem) : void
      {
      }
      
      public function HandleMultiplierCollected() : void
      {
         this.multiCoins = this.m_Logic.multiLogic.multiplier;
      }
      
      private function UpdateCandidates() : void
      {
         var gem:Gem = null;
         if(!this.isEnabled)
         {
            return;
         }
         this.mCandidates.length = 0;
         var gems:Vector.<Gem> = this.m_Logic.board.freshGems;
         var numGems:int = gems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = gems[i];
            if(gem.color == COIN_COLOR && gem.type == Gem.TYPE_STANDARD)
            {
               this.mCandidates.push(gem);
            }
         }
      }
      
      private function SpawnCoin() : void
      {
         if(!this.isEnabled)
         {
            return;
         }
         var numCandidates:int = this.mCandidates.length;
         var shouldSpawn:Boolean = false;
         for(var i:int = 0; i < numCandidates; i++)
         {
            shouldSpawn = shouldSpawn || this.m_Logic.random.Bool(SPAWN_CHANCE);
         }
         if(shouldSpawn == false)
         {
            return;
         }
         var index:int = this.m_Logic.random.Int(0,this.mCandidates.length);
         var gem:Gem = this.mCandidates[index];
         var coin:CoinToken = this.m_CoinTokenPool.GetNextCoinToken(COIN_VALUE);
         coin.id = this.coins.length;
         coin.host = gem;
         gem.tokens[CoinToken.KEY] = coin;
         this.coins.push(coin);
         this.DispatchCoinCreated(coin);
         this.mTimer = this.m_CurCooldown;
      }
      
      private function CreateMultiCoin() : void
      {
         var coin:CoinToken = this.m_CoinTokenPool.GetNextCoinToken(COIN_VALUE);
         coin.id = this.coins.length;
         this.coins.push(coin);
         this.DispatchCoinCreated(coin);
         this.CollectCoin(coin,false);
      }
      
      private function CollectCoin(coin:CoinToken, awardPoints:Boolean) : void
      {
         if(awardPoints)
         {
            coin.collectPoints = COIN_POINTS;
            this.m_Logic.AddScore(COIN_POINTS);
         }
         coin.isCollected = true;
         this.collected.push(coin);
         this.DispatchCoinCollected(coin);
      }
      
      private function DispatchCoinCreated(token:CoinToken) : void
      {
         var handler:ICoinTokenLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleCoinCreated(token);
         }
      }
      
      private function DispatchCoinCollected(token:CoinToken) : void
      {
         var handler:ICoinTokenLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleCoinCollected(token);
         }
      }
   }
}
