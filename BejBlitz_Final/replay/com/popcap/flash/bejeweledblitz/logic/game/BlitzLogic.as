package com.popcap.flash.bejeweledblitz.logic.game
{
   import com.popcap.flash.bejeweledblitz.logic.BlitzRandom;
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.GemGrid;
   import com.popcap.flash.bejeweledblitz.logic.Match;
   import com.popcap.flash.bejeweledblitz.logic.MatchPool;
   import com.popcap.flash.bejeweledblitz.logic.MatchSet;
   import com.popcap.flash.bejeweledblitz.logic.MatchSetPool;
   import com.popcap.flash.bejeweledblitz.logic.MoveData;
   import com.popcap.flash.bejeweledblitz.logic.MovePool;
   import com.popcap.flash.bejeweledblitz.logic.Point2DPool;
   import com.popcap.flash.bejeweledblitz.logic.SwapData;
   import com.popcap.flash.bejeweledblitz.logic.SwapDataPool;
   import com.popcap.flash.bejeweledblitz.logic.boosts.BoostLogic;
   import com.popcap.flash.bejeweledblitz.logic.boosts.DetonateBoostLogic;
   import com.popcap.flash.bejeweledblitz.logic.boosts.IBoost;
   import com.popcap.flash.bejeweledblitz.logic.boosts.ScrambleBoostLogic;
   import com.popcap.flash.bejeweledblitz.logic.gems.MatchEventPool;
   import com.popcap.flash.bejeweledblitz.logic.gems.ShatterEventPool;
   import com.popcap.flash.bejeweledblitz.logic.gems.flame.FlameGemLogic;
   import com.popcap.flash.bejeweledblitz.logic.gems.hypercube.HypercubeLogic;
   import com.popcap.flash.bejeweledblitz.logic.gems.multi.MultiplierGemLogic;
   import com.popcap.flash.bejeweledblitz.logic.gems.phoenixprism.PhoenixPrismLogic;
   import com.popcap.flash.bejeweledblitz.logic.gems.scramble.ScrambleEventPool;
   import com.popcap.flash.bejeweledblitz.logic.gems.star.StarGemLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.RareGemLogic;
   import com.popcap.flash.bejeweledblitz.logic.tokens.CoinTokenLogic;
   import com.popcap.flash.framework.math.MersenneTwister;
   import com.popcap.flash.framework.pool.PoolManager;
   
   public class BlitzLogic implements ILastHurrahLogicHandler
   {
      
      public static const ROWS:int = 8;
      
      public static const COLS:int = 8;
      
      public static const MIN_VELO_TO_HIT:Number = 2 / 128;
      
      public static const GRAVITY:Number = 0.275 / 128;
      
      public static const BASE_GAME_DURATION:int = 6000;
      
      public static const BASE_SPEED:Number = 1;
      
      public static const BASE_HURRAH_DELAY:int = 175;
      
      public static const SHORT_HURRAH_DELAY:int = 25;
       
      
      public var isReplay:Boolean;
      
      public var replaySeed:int;
      
      public var replayMoves:Vector.<ReplayData>;
      
      public var replayIndex:int;
      
      public var hadReplayError:Boolean;
      
      public var isActive:Boolean;
      
      public var random:BlitzRandom;
      
      public var lifeguard:PoolManager;
      
      public var movePool:MovePool;
      
      public var matchPool:MatchPool;
      
      public var matchSetPool:MatchSetPool;
      
      public var point2DPool:Point2DPool;
      
      public var scrambleEventPool:ScrambleEventPool;
      
      public var shatterEventPool:ShatterEventPool;
      
      public var matchEventPool:MatchEventPool;
      
      public var swapDataPool:SwapDataPool;
      
      public var replayDataPool:ReplayDataPool;
      
      public var totalScore:int;
      
      public var currentScores:Vector.<ScoreValue>;
      
      public var allScores:Vector.<ScoreValue>;
      
      public var board:Board;
      
      public var grid:GemGrid;
      
      public var timerLogic:TimerLogic;
      
      public var infiniteTimeLogic:InfiniteTimeLogic;
      
      public var scoreKeeper:BlitzScoreKeeper;
      
      public var speedBonus:BlitzSpeedBonus;
      
      public var multiLogic:MultiplierGemLogic;
      
      public var blazingSpeedLogic:BlazingSpeedLogic;
      
      public var lastHurrahLogic:LastHurrahLogic;
      
      public var starGemLogic:StarGemLogic;
      
      public var hypercubeLogic:HypercubeLogic;
      
      public var flameGemLogic:FlameGemLogic;
      
      public var phoenixPrismLogic:PhoenixPrismLogic;
      
      public var coinTokenLogic:CoinTokenLogic;
      
      public var boostLogic:BoostLogic;
      
      public var rareGemLogic:RareGemLogic;
      
      public var autoHintLogic:AutoHintLogic;
      
      public var compliments:ComplimentLogic;
      
      public var moves:Vector.<MoveData>;
      
      private var m_TmpMoves:Vector.<MoveData>;
      
      public var swaps:Vector.<SwapData>;
      
      public var completedSwaps:Vector.<SwapData>;
      
      public var matchCount:int;
      
      public var isMatchingEnabled:Boolean;
      
      public var gemsHit:Boolean;
      
      private var mLastHitTick:int;
      
      public var frameID:int;
      
      private var m_GameSpeed:Number;
      
      private var m_InitialGemsFallen:Boolean;
      
      public var frameMatches:Vector.<Match>;
      
      private var m_TmpMatchSets:Vector.<MatchSet>;
      
      public var mBlockingEvents:Vector.<IBlitzEvent>;
      
      public var mPassiveEvents:Vector.<IBlitzEvent>;
      
      public var mBlockedEvents:Vector.<IBlitzEvent>;
      
      public var startedMove:Boolean;
      
      public var badMove:Boolean;
      
      private var m_NewEvents:Vector.<IBlitzEvent>;
      
      private var m_BumpVelocities:Vector.<Number>;
      
      private var m_ColumnHighs:Vector.<ColumnData>;
      
      private var m_CommandQueue:Vector.<ReplayData>;
      
      private var m_GemColorOptions:Vector.<int>;
      
      private var m_Handlers:Vector.<IBlitzLogicHandler>;
      
      private var m_UpdateHandlers:Vector.<IBlitzLogicUpdateHandler>;
      
      private var m_SpawnHandlers:Vector.<IBlitzLogicSpawnHandler>;
      
      private var m_EventHandlers:Vector.<IBlitzLogicEventHandler>;
      
      public function BlitzLogic()
      {
         super();
         this.lifeguard = new PoolManager();
         this.isReplay = false;
         this.replaySeed = 0;
         this.replayMoves = new Vector.<ReplayData>();
         this.replayIndex = 0;
         this.hadReplayError = false;
         this.isActive = false;
         this.totalScore = 0;
         this.matchCount = 0;
         this.isMatchingEnabled = true;
         this.gemsHit = false;
         this.mLastHitTick = 0;
         this.frameID = 0;
         this.m_GameSpeed = BASE_SPEED;
         this.m_InitialGemsFallen = false;
         this.startedMove = false;
         this.badMove = false;
         this.frameMatches = new Vector.<Match>();
         this.m_TmpMatchSets = new Vector.<MatchSet>();
         this.m_ColumnHighs = new Vector.<ColumnData>();
         this.m_CommandQueue = new Vector.<ReplayData>();
         this.m_Handlers = new Vector.<IBlitzLogicHandler>();
         this.m_UpdateHandlers = new Vector.<IBlitzLogicUpdateHandler>();
         this.m_SpawnHandlers = new Vector.<IBlitzLogicSpawnHandler>();
         this.m_EventHandlers = new Vector.<IBlitzLogicEventHandler>();
         this.random = new BlitzRandom(new MersenneTwister());
         this.movePool = new MovePool();
         this.lifeguard.AddPool(this.movePool);
         this.matchPool = new MatchPool();
         this.lifeguard.AddPool(this.matchPool);
         this.matchSetPool = new MatchSetPool(this);
         this.lifeguard.AddPool(this.matchSetPool);
         this.point2DPool = new Point2DPool();
         this.lifeguard.AddPool(this.point2DPool);
         this.scrambleEventPool = new ScrambleEventPool(this);
         this.lifeguard.AddPool(this.scrambleEventPool);
         this.shatterEventPool = new ShatterEventPool();
         this.lifeguard.AddPool(this.shatterEventPool);
         this.matchEventPool = new MatchEventPool();
         this.lifeguard.AddPool(this.matchEventPool);
         this.swapDataPool = new SwapDataPool(this);
         this.lifeguard.AddPool(this.swapDataPool);
         this.replayDataPool = new ReplayDataPool();
         this.lifeguard.AddPool(this.replayDataPool);
         this.grid = new GemGrid(ROWS,COLS);
         this.board = new Board(this,this.random);
         this.moves = new Vector.<MoveData>();
         this.m_TmpMoves = new Vector.<MoveData>();
         this.m_BumpVelocities = new Vector.<Number>(Board.WIDTH);
         this.swaps = new Vector.<SwapData>();
         this.completedSwaps = new Vector.<SwapData>();
         this.mBlockingEvents = new Vector.<IBlitzEvent>();
         this.mPassiveEvents = new Vector.<IBlitzEvent>();
         this.mBlockedEvents = new Vector.<IBlitzEvent>();
         this.m_NewEvents = new Vector.<IBlitzEvent>();
         this.timerLogic = new TimerLogic(this);
         this.infiniteTimeLogic = new InfiniteTimeLogic(this);
         this.scoreKeeper = new BlitzScoreKeeper(this);
         this.speedBonus = new BlitzSpeedBonus(this);
         this.multiLogic = new MultiplierGemLogic(this);
         this.blazingSpeedLogic = new BlazingSpeedLogic(this);
         this.lastHurrahLogic = new LastHurrahLogic(this);
         this.starGemLogic = new StarGemLogic(this);
         this.hypercubeLogic = new HypercubeLogic(this);
         this.flameGemLogic = new FlameGemLogic(this);
         this.phoenixPrismLogic = new PhoenixPrismLogic(this);
         this.coinTokenLogic = new CoinTokenLogic(this);
         this.boostLogic = new BoostLogic(this);
         this.rareGemLogic = new RareGemLogic(this);
         this.autoHintLogic = new AutoHintLogic(this);
         this.compliments = new ComplimentLogic(this);
         this.currentScores = new Vector.<ScoreValue>();
         this.allScores = new Vector.<ScoreValue>();
         this.m_ColumnHighs.length = Board.NUM_COLS;
         for(var i:int = 0; i < Board.NUM_COLS; i++)
         {
            this.m_ColumnHighs[i] = new ColumnData();
         }
         this.m_GemColorOptions = new Vector.<int>();
         this.Init();
      }
      
      private function Init() : void
      {
         this.timerLogic.Init();
         this.infiniteTimeLogic.Init();
         this.lastHurrahLogic.Init();
         this.boostLogic.Init();
         this.rareGemLogic.Init();
         this.autoHintLogic.Init();
         this.lastHurrahLogic.AddHandler(this);
      }
      
      public function GetNumMatches() : int
      {
         return this.matchCount;
      }
      
      public function IsGameOver() : Boolean
      {
         return this.timerLogic.IsDone() && this.lastHurrahLogic.IsDone();
      }
      
      public function SetSpeed(value:Number) : void
      {
         this.m_GameSpeed = value;
      }
      
      public function AddHandler(handler:IBlitzLogicHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function RemoveHandler(handler:IBlitzLogicHandler) : void
      {
         var index:int = this.m_Handlers.indexOf(handler);
         if(index < 0)
         {
            return;
         }
         this.m_Handlers.splice(index,1);
      }
      
      public function AddUpdateHandler(handler:IBlitzLogicUpdateHandler) : void
      {
         this.m_UpdateHandlers.push(handler);
      }
      
      public function AddSpawnHandler(handler:IBlitzLogicSpawnHandler) : void
      {
         this.m_SpawnHandlers.push(handler);
      }
      
      public function AddEventHandler(handler:IBlitzLogicEventHandler) : void
      {
         this.m_EventHandlers.push(handler);
      }
      
      public function RemoveEventHandler(handler:IBlitzLogicEventHandler) : void
      {
         var index:int = this.m_EventHandlers.indexOf(handler);
         if(index < 0)
         {
            return;
         }
         this.m_EventHandlers.splice(index,1);
      }
      
      public function AddScore(value:int) : ScoreValue
      {
         var score:ScoreValue = this.scoreKeeper.scoreValuePool.GetNextScoreValue(value,this.frameID);
         this.currentScores.push(score);
         return score;
      }
      
      public function QueueBoosts(boosts:Vector.<IBoost>) : void
      {
         var boost:IBoost = null;
         var data:ReplayData = null;
         for each(boost in boosts)
         {
            data = this.replayDataPool.GetNextReplayData();
            data.command.push(boost.GetIntID());
            this.QueueCommand(ReplayCommands.COMMAND_BOOST,data);
         }
      }
      
      public function QueueDetonate(sourceGem:Gem) : void
      {
         if(this.timerLogic.GetTimeRemaining() <= 0)
         {
            return;
         }
         if(this.mBlockingEvents.length > 0)
         {
            return;
         }
         var data:ReplayData = this.replayDataPool.GetNextReplayData();
         data.command.push(sourceGem.id);
         this.QueueCommand(ReplayCommands.COMMAND_DETONATE,data);
      }
      
      private function DoDetonate(move:MoveData) : void
      {
         var row:int = 0;
         var col:int = 0;
         var gem:Gem = null;
         var sourceGem:Gem = move.sourceGem;
         if(sourceGem.uses <= 0)
         {
            return;
         }
         var delay:int = 1;
         var detonated:int = 0;
         if(this.m_InitialGemsFallen)
         {
            detonated = this.coinTokenLogic.DetonateCoinTokens();
            for(row = 0; row < Board.HEIGHT; row++)
            {
               for(col = 0; col < Board.WIDTH; col++)
               {
                  gem = this.board.GetGemAt(row,col);
                  if(!(gem.type == Gem.TYPE_SCRAMBLE || gem.type == Gem.TYPE_DETONATE))
                  {
                     if(gem.type != Gem.TYPE_STANDARD && gem.immuneTime == 0 && !gem.IsMatched() && !gem.IsMatching())
                     {
                        gem.SetFuseTime(delay);
                        gem.mMoveId = move.id;
                        gem.mShatterColor = gem.color;
                        gem.mShatterType = gem.type;
                        delay += 25;
                        detonated++;
                     }
                  }
               }
            }
         }
         var detonateLogic:DetonateBoostLogic = this.boostLogic.GetBoostByStringID(DetonateBoostLogic.ID) as DetonateBoostLogic;
         if(detonated > 0)
         {
            --sourceGem.uses;
            if(sourceGem.uses == 0)
            {
               sourceGem.SetDead(true);
            }
            if(detonateLogic != null)
            {
               detonateLogic.DoDetonateActivated();
            }
         }
         else if(detonateLogic != null)
         {
            detonateLogic.DoDetonateFailed();
         }
      }
      
      public function QueueScramble(sourceGem:Gem) : void
      {
         if(this.timerLogic.GetTimeRemaining() <= 0)
         {
            return;
         }
         if(this.mBlockingEvents.length > 0)
         {
            return;
         }
         var data:ReplayData = this.replayDataPool.GetNextReplayData();
         data.command.push(sourceGem.id);
         this.QueueCommand(ReplayCommands.COMMAND_SCRAMBLE,data);
      }
      
      private function DoScramble(move:MoveData) : void
      {
         var sourceGem:Gem = move.sourceGem;
         if(sourceGem.uses <= 0 || !this.m_InitialGemsFallen)
         {
            return;
         }
         --sourceGem.uses;
         if(sourceGem.uses == 0)
         {
            sourceGem.SetDead(true);
         }
         this.CancelSwaps();
         this.AddBlockingEvent(this.scrambleEventPool.GetNextScrambleEvent(move));
         var scrambleLogic:ScrambleBoostLogic = this.boostLogic.GetBoostByStringID(ScrambleBoostLogic.ID) as ScrambleBoostLogic;
         if(scrambleLogic != null)
         {
            scrambleLogic.DoScrambleActivated();
         }
      }
      
      public function QueueChangeGemType(gem:Gem, type:int) : void
      {
         var data:ReplayData = this.replayDataPool.GetNextReplayData();
         data.command.push(gem.id);
         data.command.push(type);
         this.QueueCommand(ReplayCommands.COMMAND_CHANGE_TYPE,data);
      }
      
      private function DoChangeGemType(move:MoveData, type:int) : void
      {
         var gem:Gem = move.sourceGem;
         gem.mMoveId = move.id;
         if(type == Gem.TYPE_FLAME)
         {
            this.flameGemLogic.UpgradeGem(gem,null,true);
         }
         else if(type == Gem.TYPE_STAR)
         {
            this.starGemLogic.UpgradeGem(gem,null,null,true);
         }
         else if(type == Gem.TYPE_HYPERCUBE)
         {
            this.hypercubeLogic.UpgradeGem(gem,null,true);
         }
         else if(type == Gem.TYPE_PHOENIXPRISM)
         {
            this.phoenixPrismLogic.UpgradeGem(gem,null,true);
         }
      }
      
      public function QueueSetGameDuration(duration:int) : void
      {
         var data:ReplayData = this.replayDataPool.GetNextReplayData();
         data.command.push(duration);
         this.QueueCommand(ReplayCommands.COMMAND_SET_GAME_DURATION,data);
      }
      
      private function DoSetGameDuration(duration:int) : void
      {
         this.timerLogic.SetGameDuration(duration);
      }
      
      public function Pause() : void
      {
         this.timerLogic.SetPaused(true);
         this.DispatchGamePaused();
      }
      
      public function Resume() : void
      {
         this.timerLogic.SetPaused(false);
         this.DispatchGameResumed();
      }
      
      public function Quit() : void
      {
         this.timerLogic.ForceGameEnd();
         this.DispatchGameAbort();
      }
      
      public function Reset(randomSeed:int) : void
      {
         var colData:ColumnData = null;
         var i:int = 0;
         var data:ReplayData = null;
         this.hadReplayError = false;
         if(this.isReplay == false)
         {
            this.replayMoves.length = 0;
         }
         this.m_CommandQueue.length = 0;
         this.m_InitialGemsFallen = false;
         for each(colData in this.m_ColumnHighs)
         {
            colData.Reset();
         }
         this.moves.length = 0;
         this.m_TmpMoves.length = 0;
         this.lifeguard.ResetPools();
         this.board.Reset();
         this.grid.Reset();
         this.timerLogic.Reset();
         this.infiniteTimeLogic.Reset();
         this.scoreKeeper.Reset();
         this.speedBonus.Reset();
         this.multiLogic.Reset();
         this.blazingSpeedLogic.Reset();
         this.lastHurrahLogic.Reset();
         this.boostLogic.Reset();
         this.rareGemLogic.Reset();
         this.compliments.Reset();
         this.starGemLogic.Reset();
         this.hypercubeLogic.Reset();
         this.flameGemLogic.Reset();
         this.phoenixPrismLogic.Reset();
         this.coinTokenLogic.Reset();
         this.autoHintLogic.Reset();
         this.frameMatches.length = 0;
         this.swaps.length = 0;
         this.completedSwaps.length = 0;
         this.mBlockingEvents.length = 0;
         this.mBlockedEvents.length = 0;
         this.mPassiveEvents.length = 0;
         this.m_NewEvents.length = 0;
         this.totalScore = 0;
         this.currentScores.length = 0;
         this.allScores.length = 0;
         this.matchCount = 0;
         this.frameID = 0;
         this.startedMove = false;
         this.badMove = false;
         this.gemsHit = false;
         this.mLastHitTick = 0;
         for(i = 0; i < this.m_BumpVelocities.length; i++)
         {
            this.m_BumpVelocities[i] = 0;
         }
         this.m_GameSpeed = BASE_SPEED;
         this.boostLogic.CycleBoosts();
         this.rareGemLogic.CycleRareGem();
         this.replayIndex = 0;
         if(this.isReplay == false)
         {
            this.random.SetSeed(randomSeed);
            this.replaySeed = randomSeed;
            data = this.replayDataPool.GetNextReplayData();
            data.command.push(randomSeed);
            this.QueueCommand(ReplayCommands.COMMAND_SEED,data);
         }
         else
         {
            this.StartReplay();
         }
         this.SpawnPhase(false);
         this.boostLogic.UseBoosts();
         this.rareGemLogic.UseBoosts();
         this.DispatchGameBegin();
      }
      
      public function AddBlockingEvent(event:IBlitzEvent) : void
      {
         this.mBlockingEvents.push(event);
         this.m_NewEvents.push(event);
      }
      
      public function AddBlockedEvent(event:IBlitzEvent) : void
      {
         this.mBlockedEvents.push(event);
         this.m_NewEvents.push(event);
      }
      
      public function AddPassiveEvent(event:IBlitzEvent) : void
      {
         this.mPassiveEvents.push(event);
         this.m_NewEvents.push(event);
      }
      
      public function Update() : void
      {
         if(this.timerLogic.IsPaused())
         {
            return;
         }
         this.DispatchUpdateBegin();
         this.gemsHit = false;
         if(this.IsGameOver())
         {
            return;
         }
         this.startedMove = false;
         this.badMove = false;
         this.updateGems();
         this.InitializeEvents();
         this.UpdateEvents();
         this.frameMatches.length = 0;
         if(this.mBlockingEvents.length == 0)
         {
            if(!this.lastHurrahLogic.IsRunning())
            {
               this.UpdateMoves();
            }
         }
         this.UpdateSwapping();
         if(this.mBlockingEvents.length == 0)
         {
            this.SpawnPhase(true);
            this.updateFalling(this.m_GameSpeed);
         }
         else
         {
            this.clearBumps();
         }
         if(this.isMatchingEnabled)
         {
            this.updateMatches();
         }
         this.updateGemPositions();
         this.blazingSpeedLogic.DoExplosions();
         this.HandleMatchedGems();
         this.HandleDetonatedGems();
         var numMatches:int = this.frameMatches.length;
         var j:int = 0;
         var m:Match = null;
         for(j = 0; j < numMatches; j++)
         {
            m = this.frameMatches[j];
            this.phoenixPrismLogic.HandleMatch(m);
         }
         for(j = 0; j < numMatches; j++)
         {
            m = this.frameMatches[j];
            this.starGemLogic.HandleMatch(m);
         }
         for(j = 0; j < numMatches; j++)
         {
            m = this.frameMatches[j];
            this.hypercubeLogic.HandleMatch(m);
         }
         for(j = 0; j < numMatches; j++)
         {
            m = this.frameMatches[j];
            this.flameGemLogic.HandleMatch(m);
         }
         this.HandleShatteredGems();
         this.HandleDetonatedGems();
         this.HandleGems();
         this.resolveGems();
         this.DispatchGemUpdateEnd();
         this.propagateIds();
         this.ScorePhase();
         this.compliments.Update();
         this.UpdateTime();
         this.UpdateLastHurrah();
         this.DispatchUpdateEnd();
      }
      
      public function createFlameGem(row:int, col:int) : void
      {
         var gem:Gem = this.board.GetGemAt(row,col);
         this.flameGemLogic.UpgradeGem(gem,null,true);
      }
      
      public function createLaserGem(row:int, col:int) : void
      {
         var gem:Gem = this.board.GetGemAt(row,col);
         this.starGemLogic.UpgradeGem(gem,null,null,true);
      }
      
      public function createHypercube(row:int, col:int) : void
      {
         var gem:Gem = this.board.GetGemAt(row,col);
         this.hypercubeLogic.UpgradeGem(gem,null,true);
      }
      
      public function QueueChangeGemColor(gem:Gem, color:int) : void
      {
         var data:ReplayData = this.replayDataPool.GetNextReplayData();
         data.command.push(gem.id);
         data.command.push(color);
         this.QueueCommand(ReplayCommands.COMMAND_CHANGE_COLOR,data);
      }
      
      private function DoChangeGemColor(move:MoveData, color:int) : void
      {
         move.sourceGem.color = color;
         move.sourceGem.mMoveId = move.id;
      }
      
      public function QueueRemoveGem(gem:Gem) : void
      {
         var data:ReplayData = this.replayDataPool.GetNextReplayData();
         data.command.push(gem.id);
         this.QueueCommand(ReplayCommands.COMMAND_REMOVE,data);
      }
      
      private function DoRemoveGem(move:MoveData) : void
      {
         var gem:Gem = move.sourceGem;
         gem.mMoveId = move.id;
         gem.SetDead(true);
      }
      
      public function QueueDestroyGem(gem:Gem) : void
      {
         var data:ReplayData = this.replayDataPool.GetNextReplayData();
         data.command.push(gem.id);
         this.QueueCommand(ReplayCommands.COMMAND_DESTROY,data);
      }
      
      private function DoDestroyGem(move:MoveData) : void
      {
         move.sourceGem.mMoveId = move.id;
         move.sourceGem.SetShattering(true);
      }
      
      public function HandleLastHurrahBegin() : void
      {
      }
      
      public function HandleLastHurrahEnd() : void
      {
         this.timerLogic.ForceGameEnd();
         this.gemsHit = false;
         this.DispatchGameEnd();
      }
      
      public function HandlePreCoinHurrah() : void
      {
      }
      
      public function CanBeginCoinHurrah() : Boolean
      {
         return true;
      }
      
      private function DispatchGameBegin() : void
      {
         var handler:IBlitzLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleGameBegin();
         }
      }
      
      private function DispatchGameEnd() : void
      {
         var handler:IBlitzLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleGameEnd();
         }
      }
      
      private function DispatchGameAbort() : void
      {
         var handler:IBlitzLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleGameAbort();
         }
      }
      
      private function DispatchGamePaused() : void
      {
         var handler:IBlitzLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleGamePaused();
         }
      }
      
      private function DispatchGameResumed() : void
      {
         var handler:IBlitzLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleGameResumed();
         }
      }
      
      private function DispatchUpdateBegin() : void
      {
         var handler:IBlitzLogicUpdateHandler = null;
         for each(handler in this.m_UpdateHandlers)
         {
            handler.HandleLogicUpdateBegin();
         }
      }
      
      private function DispatchUpdateEnd() : void
      {
         var handler:IBlitzLogicUpdateHandler = null;
         for each(handler in this.m_UpdateHandlers)
         {
            handler.HandleLogicUpdateEnd();
         }
      }
      
      private function DispatchGemUpdateEnd() : void
      {
         var handler:IBlitzLogicUpdateHandler = null;
         for each(handler in this.m_UpdateHandlers)
         {
            handler.HandleLogicGemUpdateEnd();
         }
      }
      
      private function DispatchSpawnBegin() : void
      {
         var handler:IBlitzLogicSpawnHandler = null;
         for each(handler in this.m_SpawnHandlers)
         {
            handler.HandleLogicSpawnPhaseBegin();
         }
      }
      
      private function DispatchSpawnEnd() : void
      {
         var handler:IBlitzLogicSpawnHandler = null;
         for each(handler in this.m_SpawnHandlers)
         {
            handler.HandleLogicSpawnPhaseEnd();
         }
      }
      
      private function DispatchPostSpawnPhase() : void
      {
         var handler:IBlitzLogicSpawnHandler = null;
         for each(handler in this.m_SpawnHandlers)
         {
            handler.HandlePostLogicSpawnPhase();
         }
      }
      
      private function DispatchSwapBegin(swap:SwapData) : void
      {
         var handler:IBlitzLogicEventHandler = null;
         for each(handler in this.m_EventHandlers)
         {
            handler.HandleSwapBegin(swap);
         }
      }
      
      private function DispatchSwapComplete(swap:SwapData) : void
      {
         var handler:IBlitzLogicEventHandler = null;
         for each(handler in this.m_EventHandlers)
         {
            handler.HandleSwapComplete(swap);
         }
      }
      
      private function CancelSwaps() : void
      {
         var data:SwapData = null;
         var numSwaps:int = this.swaps.length;
         for(var i:int = 0; i < numSwaps; i++)
         {
            data = this.swaps[i];
            data.moveData.sourceGem.mIsSwapping = false;
            data.moveData.sourceGem.isUnswapping = false;
            data.moveData.swapGem.mIsSwapping = false;
            data.moveData.swapGem.isUnswapping = false;
         }
         this.swaps.length = 0;
      }
      
      private function UpdateTime() : void
      {
         ++this.frameID;
         if(this.mBlockingEvents.length > 0 || !this.isActive)
         {
            return;
         }
         this.timerLogic.Update();
      }
      
      private function SpawnPhase(allowCascades:Boolean) : void
      {
         var gem:Gem = null;
         var isCancelled:Boolean = false;
         var gems:Vector.<Gem> = this.board.mGems;
         var numGems:int = gems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = gems[i];
            if(gem != null)
            {
               if(gem.GetFuseTime() > 0 || gem.IsDetonating())
               {
                  isCancelled = true;
                  break;
               }
            }
         }
         if(isCancelled)
         {
            return;
         }
         this.DispatchSpawnBegin();
         this.board.DropGems();
         this.SpawnGems(allowCascades);
         this.DispatchSpawnEnd();
         this.multiLogic.HandleSpawnEndEvent();
         this.DispatchPostSpawnPhase();
      }
      
      private function SpawnGems(allowCascades:Boolean) : void
      {
         var numColors:int = 0;
         var j:int = 0;
         var numOptions:int = 0;
         var i:int = 0;
         var probe:int = 0;
         var optionIndex:int = 0;
         var colorA:int = 0;
         var colorB:int = 0;
         var color:int = 0;
         var gem:Gem = null;
         var newGems:Vector.<Gem> = this.board.SpawnGems();
         var isDone:Boolean = false;
         if(newGems.length == 0)
         {
            return;
         }
         if(newGems.length == 1)
         {
            numColors = Gem.GEM_COLORS.length;
            this.m_GemColorOptions.length = 0;
            this.m_GemColorOptions.length = numColors;
            for(j = 0; j < numColors; j++)
            {
               this.m_GemColorOptions[j] = Gem.GEM_COLORS[j];
            }
            numOptions = this.m_GemColorOptions.length;
            for(i = 0; i < numOptions; i++)
            {
               optionIndex = this.random.Int(0,numOptions);
               colorA = this.m_GemColorOptions[i];
               colorB = this.m_GemColorOptions[optionIndex];
               this.m_GemColorOptions[i] = colorB;
               this.m_GemColorOptions[optionIndex] = colorA;
            }
            probe = 0;
            while(!isDone && probe < this.m_GemColorOptions.length)
            {
               color = this.m_GemColorOptions[probe];
               gem = newGems[0];
               gem.color = color;
               isDone = this.CheckSpawnedGems(allowCascades);
               probe++;
            }
            isDone = true;
         }
         while(!isDone)
         {
            this.board.RandomizeColors(newGems);
            isDone = this.CheckSpawnedGems(allowCascades);
         }
      }
      
      private function CheckSpawnedGems(allowCascades:Boolean) : Boolean
      {
         var numMatches:int = 0;
         if(!allowCascades)
         {
            this.board.FindMatches(this.m_TmpMatchSets);
            numMatches = this.m_TmpMatchSets.length;
            this.matchSetPool.FreeMatchSets(this.m_TmpMatchSets,true);
            if(numMatches > 0)
            {
               return false;
            }
         }
         this.board.moveFinder.FindAllMoves(this.board,this.m_TmpMoves);
         var numMoves:int = this.m_TmpMoves.length;
         this.movePool.FreeMoves(this.m_TmpMoves);
         return numMoves > 0;
      }
      
      private function ScorePhase() : void
      {
         var score:ScoreValue = null;
         var numScores:int = this.currentScores.length;
         for(var i:int = 0; i < numScores; i++)
         {
            score = this.currentScores[i];
            this.DispatchScore(score);
            this.totalScore += score.GetValue();
            this.allScores.push(score);
         }
         this.currentScores.length = 0;
         this.speedBonus.Update();
         this.scoreKeeper.moveBonus = this.speedBonus.GetBonus();
         var isStill:Boolean = this.board.IsStill() && this.mBlockingEvents.length == 0;
         this.scoreKeeper.Update(isStill);
         this.blazingSpeedLogic.Update(this.frameMatches,this);
      }
      
      private function DispatchScore(score:ScoreValue) : void
      {
         var handler:IBlitzLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleScore(score);
         }
      }
      
      private function resolveGems() : void
      {
         var gem:Gem = null;
         var numGems:int = this.board.mGems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = this.board.mGems[i];
            if(gem != null)
            {
               if(gem.IsShattering())
               {
                  this.mPassiveEvents.push(this.shatterEventPool.GetNextShatterEvent(gem));
               }
               else if(gem.IsMatching())
               {
                  this.mPassiveEvents.push(this.matchEventPool.GetNextMatchEvent(gem));
               }
               if(this.lastHurrahLogic.IsRunning() && gem.type == Gem.TYPE_MULTI)
               {
                  if(gem.GetFuseTime() == 0 && gem.IsFuseLit())
                  {
                     gem.ForceShatter(true);
                     if(gem.IsShattering())
                     {
                        this.mPassiveEvents.push(this.shatterEventPool.GetNextShatterEvent(gem));
                     }
                  }
               }
            }
         }
      }
      
      public function shatterArea(row:Number, col:Number, locus:Gem) : void
      {
         var gem:Gem = null;
         var left:Number = col - 1.5;
         var right:Number = col + 1.5;
         var top:Number = row - 1.5;
         var bottom:Number = row + 1.5;
         var br:Number = Board.WIDTH - 0.5;
         var bb:Number = Board.HEIGHT - 0.5;
         left = left > -0.5 ? Number(left) : Number(-0.5);
         right = right < br ? Number(right) : Number(br);
         top = top > -0.5 ? Number(top) : Number(-0.5);
         bottom = bottom < bb ? Number(bottom) : Number(bb);
         var gems:Vector.<Gem> = this.board.mGems;
         var numGems:int = gems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = gems[i];
            if(!(gem.x < left || gem.x > right || gem.y < top || gem.y > bottom))
            {
               gem.Shatter(locus);
            }
         }
      }
      
      public function shatterCross(locus:Gem) : void
      {
         var row:int = locus.row;
         var col:int = locus.col;
         var left:int = row - 7;
         var right:int = row + 7;
         var top:int = row - 7;
         var bottom:int = row + 7;
         var br:int = Board.WIDTH - 1;
         var bb:int = Board.HEIGHT - 1;
         left = left > 0 ? int(left) : int(0);
         right = right < br ? int(right) : int(br);
         top = top > 0 ? int(top) : int(0);
         bottom = bottom < bb ? int(bottom) : int(bb);
         var gem:Gem = null;
         for(var r:int = top; r <= bottom; r++)
         {
            gem = this.board.GetGemAt(r,col);
            gem.Shatter(locus);
         }
         for(var c:int = left; c <= right; c++)
         {
            gem = this.board.GetGemAt(row,c);
            gem.Shatter(locus);
         }
      }
      
      private function GetRefFromGem(gem:Gem) : int
      {
         return gem.row * Board.WIDTH + gem.col;
      }
      
      private function GetGemFromRef(ref:int) : Gem
      {
         var row:int = ref / Board.WIDTH;
         var col:int = ref % Board.WIDTH;
         return this.board.GetGemAt(row,col);
      }
      
      public function QueueCommand(commandID:int, data:ReplayData) : void
      {
         if(this.isReplay)
         {
            return;
         }
         if(commandID >= 0)
         {
            data.command.unshift(this.frameID);
         }
         data.command.unshift(commandID);
         if(commandID >= 0)
         {
            this.m_CommandQueue.push(data);
         }
         this.replayMoves.push(data);
      }
      
      private function updateGems() : void
      {
         var gem:Gem = null;
         var gems:Vector.<Gem> = this.board.mGems;
         var numGems:int = gems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = gems[i];
            if(gem != null)
            {
               gem.update();
            }
         }
      }
      
      private function updateGemPositions() : void
      {
         var gem:Gem = null;
         var row:int = 0;
         var col:int = 0;
         var gems:Vector.<Gem> = this.board.mGems;
         var numGems:int = gems.length;
         this.grid.clearGrid();
         for(var i:int = 0; i < numGems; i++)
         {
            gem = gems[i];
            if(gem != null)
            {
               row = gem.y + 0.5;
               col = gem.x + 0.5;
               this.grid.setGem(row,col,gem);
            }
         }
      }
      
      private function UpdateSwapping() : void
      {
         var effect:SwapData = null;
         var isEmpty:Boolean = true;
         var numEffects:int = this.swaps.length;
         this.completedSwaps.length = 0;
         for(var i:int = 0; i < numEffects; i++)
         {
            effect = this.swaps[i];
            effect.Update();
            isEmpty = isEmpty && effect.IsDone();
            this.badMove = this.badMove || effect.isBadSwap;
            if(effect.IsDone())
            {
               this.completedSwaps.push(effect);
               this.DispatchSwapComplete(effect);
            }
         }
         if(isEmpty)
         {
            this.swaps.length = 0;
         }
      }
      
      private function updateMatches() : void
      {
         var matchSet:MatchSet = null;
         var numMatches:int = 0;
         var k:int = 0;
         var match:Match = null;
         var highestMoveId:int = 0;
         var numGems:int = 0;
         var n:int = 0;
         var gem:Gem = null;
         this.matchPool.FreeMatches(this.frameMatches);
         this.board.FindMatches(this.m_TmpMatchSets);
         var numSets:int = this.m_TmpMatchSets.length;
         for(var i:int = 0; i < numSets; i++)
         {
            matchSet = this.m_TmpMatchSets[i];
            if(matchSet.IsDeferred() == true)
            {
               this.matchSetPool.FreeMatchSet(matchSet,true);
               this.m_TmpMatchSets[i] = null;
            }
            else
            {
               numMatches = matchSet.mMatches.length;
               for(k = 0; k < numMatches; k++)
               {
                  match = matchSet.mMatches[k];
                  match.matchId = this.matchCount;
                  this.frameMatches.push(match);
                  ++this.matchCount;
                  highestMoveId = -1;
                  numGems = match.matchGems.length;
                  for(n = 0; n < numGems; n++)
                  {
                     gem = match.matchGems[n];
                     gem.Match(match.matchId);
                     highestMoveId = gem.mMoveId > highestMoveId ? int(gem.mMoveId) : int(highestMoveId);
                  }
                  for(n = 0; n < numGems; n++)
                  {
                     gem = match.matchGems[n];
                     gem.mMoveId = highestMoveId;
                  }
               }
            }
         }
         this.matchSetPool.FreeMatchSets(this.m_TmpMatchSets,false);
      }
      
      private function propagateIds() : void
      {
         var highestMatch:int = 0;
         var highestMove:int = 0;
         var colMatch:int = 0;
         var colMove:int = 0;
         var row:int = 0;
         var gem:Gem = null;
         var numMoves:int = 0;
         var numCols:int = Board.NUM_COLS;
         var numRows:int = Board.NUM_ROWS;
         for(var col:int = 0; col < numCols; col++)
         {
            highestMatch = -1;
            highestMove = -1;
            colMatch = this.m_ColumnHighs[col].matchId;
            colMove = this.m_ColumnHighs[col].moveId;
            for(row = numRows - 1; row >= 0; row--)
            {
               gem = this.board.GetGemAt(row,col);
               if(gem != null)
               {
                  if(gem.IsMatched() || gem.IsShattered() || gem.mIsSwapping || gem.mIsFalling)
                  {
                     numMoves = this.moves.length;
                     highestMatch = highestMatch > gem.mMatchId ? int(highestMatch) : int(gem.mMatchId);
                     highestMove = highestMove > gem.mMoveId ? int(highestMove) : int(gem.mMoveId);
                     colMatch = highestMatch > colMatch ? int(highestMatch) : int(colMatch);
                     colMove = highestMove > colMove ? int(highestMove) : int(colMove);
                  }
                  if(highestMatch > gem.mMatchId)
                  {
                     gem.mMatchId = highestMatch;
                  }
                  if(highestMove > gem.mMoveId)
                  {
                     gem.mMoveId = highestMove;
                  }
                  if(gem.y < -1)
                  {
                     gem.mMatchId = colMatch;
                     gem.mMoveId = colMove;
                  }
               }
            }
            this.m_ColumnHighs[col].matchId = colMatch;
            this.m_ColumnHighs[col].moveId = colMove;
         }
      }
      
      private function InitializeEvents() : void
      {
         var e:IBlitzEvent = null;
         for each(e in this.m_NewEvents)
         {
            e.Init();
         }
         this.m_NewEvents.length = 0;
      }
      
      private function UpdateEvents() : void
      {
         this.UpdateBlockingEvents();
         if(this.mBlockingEvents.length == 0)
         {
            this.UpdateBlockedEvents();
         }
         this.UpdatePassiveEvents();
      }
      
      private function UpdateBlockingEvents() : void
      {
         var e:IBlitzEvent = null;
         var isEmpty:Boolean = true;
         for each(e in this.mBlockingEvents)
         {
            e.Update(this.m_GameSpeed);
            isEmpty = isEmpty && e.IsDone();
         }
         if(isEmpty)
         {
            this.mBlockingEvents.length = 0;
         }
      }
      
      private function UpdateBlockedEvents() : void
      {
         var e:IBlitzEvent = null;
         var isEmpty:Boolean = true;
         for each(e in this.mBlockedEvents)
         {
            e.Update(this.m_GameSpeed);
            isEmpty = isEmpty && e.IsDone();
         }
         if(isEmpty)
         {
            this.mBlockedEvents.length = 0;
         }
      }
      
      private function UpdatePassiveEvents() : void
      {
         var e:IBlitzEvent = null;
         var isEmpty:Boolean = true;
         for each(e in this.mPassiveEvents)
         {
            e.Update(this.m_GameSpeed);
            isEmpty = isEmpty && e.IsDone();
         }
         if(isEmpty)
         {
            this.mPassiveEvents.length = 0;
         }
      }
      
      private function UpdateMoves() : void
      {
         var move:MoveData = null;
         var command:ReplayData = null;
         if(this.isReplay)
         {
            this.QueueReplayMoves();
         }
         while(this.m_CommandQueue.length > 0)
         {
            command = this.m_CommandQueue.shift();
            this.DoMoveCommand(command);
         }
         for each(move in this.moves)
         {
            move.isActive = move.isActive && !this.board.IsStill();
         }
      }
      
      private function StartReplay() : void
      {
         var data:ReplayData = null;
         var command:Vector.<int> = null;
         var commandID:int = 0;
         var numCommands:int = this.replayMoves.length;
         while(this.replayIndex < numCommands)
         {
            data = this.replayMoves[this.replayIndex];
            command = data.command;
            commandID = command[0];
            if(commandID > 0)
            {
               break;
            }
            if(commandID == ReplayCommands.COMMAND_SEED)
            {
               this.replaySeed = command[1];
               this.random.SetSeed(this.replaySeed);
            }
            else if(commandID == ReplayCommands.COMMAND_BOOST)
            {
               this.boostLogic.ActivateBoost(command[1]);
            }
            else if(commandID == ReplayCommands.COMMAND_RAREGEM)
            {
               this.rareGemLogic.ActivateRareGem(command[1]);
            }
            else if(commandID == ReplayCommands.COMMAND_SET_GAME_DURATION)
            {
               this.timerLogic.SetGameDuration(command[1]);
            }
            ++this.replayIndex;
         }
      }
      
      private function QueueReplayMoves() : void
      {
         var data:ReplayData = null;
         var command:Vector.<int> = null;
         var commandID:int = 0;
         var time:int = 0;
         var numMoves:int = this.replayMoves.length;
         while(this.replayIndex < numMoves)
         {
            data = this.replayMoves[this.replayIndex];
            command = data.command;
            commandID = command[0];
            if(commandID < 0)
            {
               return;
            }
            time = command[1];
            if(time != this.frameID)
            {
               break;
            }
            this.m_CommandQueue.push(data);
            ++this.replayIndex;
         }
      }
      
      private function updateFalling(gravityFactor:Number) : void
      {
         var aLastY:Number = NaN;
         var aLastVelocity:Number = NaN;
         var row:int = 0;
         var gem:Gem = null;
         var aGravity:Number = GRAVITY * gravityFactor;
         var aHitCount:int = 0;
         var didGemsFall:Boolean = false;
         this.gemsHit = false;
         for(var col:int = 0; col < Board.WIDTH; col++)
         {
            aLastY = Board.HEIGHT;
            aLastVelocity = 0;
            for(row = Board.HEIGHT - 1; row >= 0; row--)
            {
               gem = this.board.GetGemAt(row,col);
               if(gem != null)
               {
                  if(gem.mIsSwapping || gem.IsMatched())
                  {
                     aLastY = gem.row;
                  }
                  else
                  {
                     gem.mIsFalling = true;
                     gem.y += gem.fallVelocity;
                     if(gem.y >= gem.row)
                     {
                        gem.y = gem.row;
                        if(gem.fallVelocity >= MIN_VELO_TO_HIT)
                        {
                           aHitCount++;
                        }
                        gem.fallVelocity = 0;
                        gem.mIsFalling = false;
                     }
                     else if(gem.y >= aLastY - 1)
                     {
                        gem.y = aLastY - 1;
                        gem.fallVelocity = aLastVelocity;
                     }
                     else
                     {
                        gem.fallVelocity += aGravity;
                        didGemsFall = true;
                     }
                     aLastY = gem.y;
                     aLastVelocity = gem.fallVelocity;
                  }
               }
            }
         }
         if(aHitCount > 0 && Math.abs(this.mLastHitTick - this.frameID) > 8)
         {
            this.mLastHitTick = this.frameID;
            this.gemsHit = true;
         }
         if(!didGemsFall)
         {
            this.m_InitialGemsFallen = true;
         }
      }
      
      private function UpdateLastHurrah() : void
      {
         this.lastHurrahLogic.Update();
      }
      
      public function IsMoveLegal(gem:Gem, destRow:int, destCol:int) : Boolean
      {
         if(gem == null)
         {
            return false;
         }
         if(!gem.isStill())
         {
            return false;
         }
         var swapped:Gem = this.board.GetGemAt(destRow,destCol);
         if(swapped == null || !swapped.isStill())
         {
            return false;
         }
         if(destRow < Board.TOP || destRow > Board.BOTTOM || destCol < Board.LEFT || destCol > Board.RIGHT)
         {
            return false;
         }
         var dirX:int = destCol - gem.col;
         var dirY:int = destRow - gem.row;
         if(Math.abs(dirX) + Math.abs(dirY) != 1)
         {
            return false;
         }
         if(!gem.movePolicy.IsSwapAllowed(dirX,dirY) || !swapped.movePolicy.IsSwapAllowed(dirX * -1,dirY * -1))
         {
            return false;
         }
         return true;
      }
      
      private function DoMoveCommand(data:ReplayData) : void
      {
         var destCol:int = 0;
         var destRow:int = 0;
         var command:Vector.<int> = data.command;
         var commandID:int = command[0];
         var gem:Gem = this.board.GetGem(command[2]);
         var move:MoveData = this.movePool.GetMove();
         move.sourceGem = gem;
         this.AddMove(move);
         if(commandID == ReplayCommands.COMMAND_REMOVE)
         {
            this.DoRemoveGem(move);
         }
         else if(commandID == ReplayCommands.COMMAND_DESTROY)
         {
            this.DoDestroyGem(move);
         }
         else if(commandID == ReplayCommands.COMMAND_CHANGE_TYPE)
         {
            this.DoChangeGemType(move,this.board.GetGem(command[3]).id);
         }
         else if(commandID == ReplayCommands.COMMAND_CHANGE_COLOR)
         {
            this.DoChangeGemColor(move,this.board.GetGem(command[3]).id);
         }
         else if(commandID == ReplayCommands.COMMAND_SWAP)
         {
            move.swapGem = this.board.GetGem(command[3]);
            move.sourcePos.x = gem.col;
            move.sourcePos.y = gem.row;
            destCol = move.swapGem.col;
            destRow = move.swapGem.row;
            move.isSwap = true;
            move.swapDir.x = destCol - gem.col;
            move.swapDir.y = destRow - gem.row;
            move.swapPos.x = destCol;
            move.swapPos.y = destRow;
            this.DoSwapGem(move);
         }
         else if(commandID == ReplayCommands.COMMAND_DETONATE || commandID == ReplayCommands.COMMAND_SCRAMBLE)
         {
            this.DoUseGem(move);
         }
         else if(commandID == ReplayCommands.COMMAND_SET_GAME_DURATION)
         {
         }
      }
      
      private function DoUseGem(move:MoveData) : void
      {
         var gem:Gem = move.sourceGem;
         if(gem.type == Gem.TYPE_DETONATE)
         {
            this.DoDetonate(move);
         }
         else if(gem.type == Gem.TYPE_SCRAMBLE)
         {
            this.DoScramble(move);
         }
      }
      
      private function DoSwapGem(move:MoveData) : void
      {
         if(!this.IsMoveLegal(move.sourceGem,move.swapPos.y,move.swapPos.x))
         {
            return;
         }
         var sourceGem:Gem = move.sourceGem;
         var swapGem:Gem = move.swapGem;
         sourceGem.SetSelected(false);
         if(swapGem.mIsSwapping || sourceGem.mIsSwapping)
         {
            return;
         }
         var triggerColor:int = Gem.COLOR_NONE;
         var hypercube:Gem = null;
         if(sourceGem.type == Gem.TYPE_HYPERCUBE && (swapGem.type == Gem.TYPE_HYPERCUBE || swapGem.type == Gem.TYPE_PHOENIXPRISM))
         {
            hypercube = sourceGem;
            sourceGem.color = Gem.COLOR_NONE;
            triggerColor = Gem.COLOR_NONE;
         }
         else if(swapGem.type == Gem.TYPE_HYPERCUBE && sourceGem.type == Gem.TYPE_PHOENIXPRISM)
         {
            hypercube = swapGem;
            sourceGem.color = Gem.COLOR_NONE;
            triggerColor = Gem.COLOR_NONE;
         }
         else if(sourceGem.type == Gem.TYPE_HYPERCUBE && swapGem.type != Gem.TYPE_SCRAMBLE && swapGem.type != Gem.TYPE_DETONATE)
         {
            hypercube = sourceGem;
            triggerColor = swapGem.color;
         }
         else if(swapGem.type == Gem.TYPE_HYPERCUBE && sourceGem.type != Gem.TYPE_SCRAMBLE && sourceGem.type != Gem.TYPE_DETONATE)
         {
            hypercube = swapGem;
            triggerColor = sourceGem.color;
         }
         sourceGem.mMoveId = move.id;
         swapGem.mMoveId = move.id;
         if(hypercube != null)
         {
            move.isSuccessful = true;
            hypercube.color = triggerColor;
            hypercube.mShatterColor = triggerColor;
            hypercube.SetShattering(true);
            return;
         }
         sourceGem.mIsSwapping = true;
         swapGem.mIsSwapping = true;
         this.startedMove = true;
         var swap:SwapData = this.swapDataPool.GetNextSwapData(move,this.m_GameSpeed);
         this.swaps.push(swap);
         this.DispatchSwapBegin(swap);
      }
      
      public function QueueSwap(gem:Gem, destRow:int, destCol:int) : Boolean
      {
         if(this.timerLogic.GetTimeRemaining() <= 0)
         {
            return true;
         }
         if(this.mBlockingEvents.length > 0)
         {
            return false;
         }
         if(!this.IsMoveLegal(gem,destRow,destCol))
         {
            return false;
         }
         var destGem:Gem = this.board.GetGemAt(destRow,destCol);
         var data:ReplayData = this.replayDataPool.GetNextReplayData();
         data.command.push(gem.id);
         data.command.push(destGem.id);
         this.QueueCommand(ReplayCommands.COMMAND_SWAP,data);
         return true;
      }
      
      public function bumpColumns(x:Number, y:Number, power:Number) : void
      {
         var newVel:Number = NaN;
         var lastCheckVal:Number = NaN;
         var row:int = 0;
         var gem:Gem = null;
         var dx:Number = NaN;
         var dy:Number = NaN;
         var setPiece:Boolean = false;
         var anAngle:Number = NaN;
         var aGemDist:Number = NaN;
         var mysteryX:Number = NaN;
         var mysteryY:Number = NaN;
         var mysteryZ:Number = NaN;
         var aForce:Number = NaN;
         for(var col:int = 0; col < Board.WIDTH; col++)
         {
            newVel = 0;
            lastCheckVal = 0;
            for(row = 7; row >= -1; row--)
            {
               gem = this.board.GetGemAt(row,col);
               dx = 0;
               dy = 0;
               setPiece = false;
               if(gem != null && gem.y < y)
               {
                  dx = gem.x - x;
                  dy = gem.y - y;
                  setPiece = true;
               }
               else
               {
                  if(row != -1)
                  {
                     continue;
                  }
                  dx = col - x;
                  dy = row - y;
               }
               anAngle = Math.atan2(dy,dx);
               aGemDist = Math.sqrt(dx * dx + dy * dy);
               mysteryX = 1;
               mysteryY = 1;
               mysteryZ = -5 / 128;
               aForce = power / (Math.max(0,aGemDist - mysteryX) + mysteryY) * Math.abs(Math.sin(anAngle));
               lastCheckVal = aForce * mysteryZ;
               if(setPiece)
               {
                  if(newVel == 0)
                  {
                     newVel = lastCheckVal;
                  }
                  gem.fallVelocity = Math.min(gem.fallVelocity,newVel);
               }
            }
         }
      }
      
      private function clearBumps() : void
      {
         var gem:Gem = null;
         var gems:Vector.<Gem> = this.board.mGems;
         var numGems:int = gems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = gems[i];
            if(gem != null)
            {
               if(gem.fallVelocity < 0)
               {
                  gem.fallVelocity = 0;
               }
            }
         }
      }
      
      public function AddMove(move:MoveData) : void
      {
         move.id = this.moves.length;
         this.moves.push(move);
      }
      
      private function HandleMatchedGems() : void
      {
         var gem:Gem = null;
         var gems:Vector.<Gem> = this.board.mGems;
         var numGems:int = this.board.mGems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = gems[i];
            if(!(gem == null || !gem.IsMatching()))
            {
               this.phoenixPrismLogic.HandleMatchedGem(gem);
               this.starGemLogic.HandleMatchedGem(gem);
               this.flameGemLogic.HandleMatchedGem(gem);
               this.hypercubeLogic.HandleMatchedGem(gem);
               this.multiLogic.HandleMatchedGem(gem);
            }
         }
      }
      
      private function HandleShatteredGems() : void
      {
         var gem:Gem = null;
         var gems:Vector.<Gem> = this.board.mGems;
         var numGems:int = this.board.mGems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = gems[i];
            if(!(gem == null || !gem.IsShattering()))
            {
               this.phoenixPrismLogic.HandleShatteredGem(gem);
               this.starGemLogic.HandleShatteredGem(gem);
               this.flameGemLogic.HandleShatteredGem(gem);
               this.hypercubeLogic.HandleShatteredGem(gem);
               this.multiLogic.HandleShatteredGem(gem);
            }
         }
      }
      
      private function HandleDetonatedGems() : void
      {
         var gem:Gem = null;
         var gems:Vector.<Gem> = this.board.mGems;
         var numGems:int = this.board.mGems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = gems[i];
            if(!(gem == null || !gem.IsDetonating()))
            {
               this.phoenixPrismLogic.HandleDetonatedGem(gem);
               this.starGemLogic.HandleDetonatedGem(gem);
               this.flameGemLogic.HandleDetonatedGem(gem);
               this.hypercubeLogic.HandleDetonatedGem(gem);
               this.multiLogic.HandleDetonatedGem(gem);
               gem.Flush();
            }
         }
      }
      
      private function HandleGems() : void
      {
         var gem:Gem = null;
         var gems:Vector.<Gem> = this.board.mGems;
         var numGems:int = this.board.mGems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = gems[i];
            if(gem != null)
            {
               this.multiLogic.HandleGem(gem);
            }
         }
      }
      
      public function SetReplayData(commands:Vector.<ReplayData>) : void
      {
         this.isReplay = true;
         this.replayMoves = commands;
      }
      
      public function GetReplayData() : Vector.<ReplayData>
      {
         return this.replayMoves;
      }
   }
}
