package com.popcap.flash.games.bej3.tokens
{
   import com.popcap.flash.framework.events.EventBus;
   import com.popcap.flash.framework.events.EventContext;
   import com.popcap.flash.games.bej3.Board;
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.blitz.BlitzLogic;
   import com.popcap.flash.games.bej3.blitz.ITimerLogicHandler;
   import com.popcap.flash.games.blitz3.Blitz3App;
   
   public class CoinTokenLogic implements ITimerLogicHandler
   {
      
      public static const MINIMUM_SCORE:int = 1000;
      
      public static const COIN_COLOR:int = Gem.COLOR_YELLOW;
      
      public static const SPAWN_CHANCE:Number = 0.5;
      
      public static const SPAWN_COOLDOWN:int = 1000;
      
      public static const COLLECT_COOLDOWN:int = 25;
      
      public static const COIN_VALUE:int = 100;
      
      public static const COIN_POINTS:int = 1250;
       
      
      public var coins:Vector.<CoinToken>;
      
      public var collected:Vector.<CoinToken>;
      
      public var isHurrahDone:Boolean = false;
      
      public var multiCoins:int = 1;
      
      private var mApp:Blitz3App;
      
      private var mLogic:BlitzLogic;
      
      private var mTimer:int = 0;
      
      private var mCanSpawn:Boolean = true;
      
      private var mCandidates:Vector.<Gem>;
      
      private var mCollectTimer:int = 25;
      
      public function CoinTokenLogic(app:Blitz3App, logic:BlitzLogic)
      {
         super();
         this.coins = new Vector.<CoinToken>();
         this.collected = new Vector.<CoinToken>();
         this.mApp = app;
         this.mLogic = logic;
         this.mCandidates = new Vector.<Gem>();
         var eventBus:EventBus = EventBus.GetGlobal();
         eventBus.OnEvent("GemPhaseEnd",this.HandleGemPhaseEndEvent);
         eventBus.OnEvent("SpawnEndEvent",this.HandleSpawnEndEvent);
         eventBus.OnEvent("MultiplierCollectedEvent",this.HandleMultiplierCollectedEvent);
         logic.timerLogic.AddHandler(this);
      }
      
      public function Reset() : void
      {
         this.coins.length = 0;
         this.collected.length = 0;
         this.mCanSpawn = true;
         this.mTimer = SPAWN_COOLDOWN;
         this.mCandidates.length = 0;
         this.multiCoins = 1;
         this.isHurrahDone = false;
         this.mCollectTimer = COLLECT_COOLDOWN;
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
         var board:Board = this.mLogic.board;
         for(var row:int = 0; row < Board.HEIGHT; row++)
         {
            for(col = 0; col < Board.WIDTH; )
            {
               gem = board.GetGemAt(row,col);
               coin = gem.tokens.find(CoinToken.KEY);
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
         var gem:Gem = null;
         var numCoins:int = this.coins.length;
         for(var i:int = 0; i < numCoins; i++)
         {
            coin = this.coins[i];
            gem = coin.host;
            if(coin.collectPoints > 0)
            {
               this.mApp.logic.scoreKeeper.AddPoints(coin.collectPoints,gem);
               coin.collectPoints = 0;
            }
         }
      }
      
      private function CollectMultiCoinTokens() : void
      {
         if(this.multiCoins == 0 || this.mApp.logic.GetScore() < MINIMUM_SCORE)
         {
            this.isHurrahDone = true;
            return;
         }
         --this.multiCoins;
         this.CreateMultiCoin();
      }
      
      public function SpawnCoinOnGem(gem:Gem) : void
      {
         if(gem.tokens.containsKey(CoinToken.KEY))
         {
            return;
         }
         var coin:CoinToken = new CoinToken();
         coin.id = this.coins.length;
         coin.host = gem;
         gem.tokens.insert(CoinToken.KEY,coin);
         this.coins.push(coin);
         EventBus.GetGlobal().Dispatch(CoinTokenSpawnedEvent.ID,coin);
         this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_COIN_CREATED);
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
      
      public function HandleGameDurationChange(newDuration:int) : void
      {
      }
      
      private function UpdateCandidates() : void
      {
         var gem:Gem = null;
         this.mCandidates.length = 0;
         var gems:Vector.<Gem> = this.mLogic.board.freshGems;
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
         var numCandidates:int = this.mCandidates.length;
         var shouldSpawn:Boolean = false;
         for(var i:int = 0; i < numCandidates; i++)
         {
            shouldSpawn = shouldSpawn || this.mLogic.random.Bool(SPAWN_CHANCE);
         }
         if(shouldSpawn == false)
         {
            return;
         }
         var index:int = this.mLogic.random.Int(this.mCandidates.length);
         var gem:Gem = this.mCandidates[index];
         var coin:CoinToken = new CoinToken();
         coin.id = this.coins.length;
         coin.host = gem;
         gem.tokens.insert(CoinToken.KEY,coin);
         this.coins.push(coin);
         EventBus.GetGlobal().Dispatch(CoinTokenSpawnedEvent.ID,coin);
         this.mTimer = SPAWN_COOLDOWN;
         this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_COIN_CREATED);
      }
      
      private function CreateMultiCoin() : void
      {
         var coin:CoinToken = new CoinToken();
         coin.id = this.coins.length;
         this.coins.push(coin);
         EventBus.GetGlobal().Dispatch(CoinTokenSpawnedEvent.ID,coin);
         this.CollectCoin(coin,false);
      }
      
      private function CollectCoin(coin:CoinToken, awardPoints:Boolean) : void
      {
         if(awardPoints)
         {
            coin.collectPoints = COIN_POINTS;
            this.mApp.logic.AddScore(COIN_POINTS);
         }
         coin.isCollected = true;
         this.collected.push(coin);
         EventBus.GetGlobal().Dispatch(CoinTokenCollectedEvent.ID,coin);
         this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_COIN_COLLECTED);
      }
      
      private function HandleSpawnEndEvent(ctx:EventContext) : void
      {
         if(this.mLogic.lastHurrahLogic.IsRunning())
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
      
      private function HandleGemPhaseEndEvent(ctx:EventContext) : void
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
               isCollected = gem.isMatched || gem.isShattered || coin.autoCollect == 0;
               isCollected = isCollected || gem.immuneTime > 0;
               if(isCollected)
               {
                  this.CollectCoin(coin,true);
               }
            }
         }
      }
      
      private function HandleMultiplierCollectedEvent(ctx:EventContext) : void
      {
         this.multiCoins = this.mLogic.multiLogic.multiplier;
      }
   }
}
