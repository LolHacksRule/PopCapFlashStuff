package com.popcap.flash.games.bej3.blitz
{
   import com.popcap.flash.framework.events.EventBus;
   import com.popcap.flash.framework.math.MersenneTwister;
   import com.popcap.flash.framework.math.Random;
   import com.popcap.flash.framework.utils.Base64;
   import com.popcap.flash.games.bej3.Board;
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.GemGrid;
   import com.popcap.flash.games.bej3.Match;
   import com.popcap.flash.games.bej3.MatchSet;
   import com.popcap.flash.games.bej3.MoveData;
   import com.popcap.flash.games.bej3.SwapData;
   import com.popcap.flash.games.bej3.boosts.BoostLogic;
   import com.popcap.flash.games.bej3.boosts.IBoost;
   import com.popcap.flash.games.bej3.gems.MatchEvent;
   import com.popcap.flash.games.bej3.gems.ShatterEvent;
   import com.popcap.flash.games.bej3.gems.flame.FlameGemLogic;
   import com.popcap.flash.games.bej3.gems.hypercube.HypercubeLogic;
   import com.popcap.flash.games.bej3.gems.multi.MultiplierGemLogic;
   import com.popcap.flash.games.bej3.gems.scramble.ScrambleDelayEvent;
   import com.popcap.flash.games.bej3.gems.scramble.ScrambleEvent;
   import com.popcap.flash.games.bej3.gems.star.StarGemLogic;
   import com.popcap.flash.games.bej3.raregems.RareGemLogic;
   import com.popcap.flash.games.bej3.tokens.CoinTokenLogic;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class BlitzLogic extends EventDispatcher implements ITimerLogicHandler, ILastHurrahLogicHandler
   {
      
      public static const ROWS:int = 8;
      
      public static const COLS:int = 8;
      
      public static const MIN_VELO_TO_HIT:Number = 2 / 128;
      
      public static const GRAVITY:Number = 0.275 / 128;
      
      public static const BASE_GAME_DURATION:int = 6000;
      
      public static const BASE_SPEED:Number = 1;
      
      public static const BASE_HURRAH_DELAY:int = 175;
      
      public static const SHORT_HURRAH_DELAY:int = 25;
      
      public static const COMMAND_REMOVE:int = 0;
      
      public static const COMMAND_DESTROY:int = 1;
      
      public static const COMMAND_CHANGE_TYPE:int = 2;
      
      public static const COMMAND_CHANGE_COLOR:int = 3;
      
      public static const COMMAND_SWAP:int = 4;
      
      public static const COMMAND_DETONATE:int = 5;
      
      public static const COMMAND_SCRAMBLE:int = 6;
      
      public static const COMMAND_SEED:int = -1;
      
      public static const COMMAND_BOOST:int = -2;
      
      public static const COMMAND_RAREGEM:int = -3;
      
      public static const LOGIC_VERSION:String = "6";
       
      
      public var isReplay:Boolean = false;
      
      public var replaySeed:int = 0;
      
      public var replayMoves:Array;
      
      public var replayIndex:int = 0;
      
      public var hadReplayError:Boolean = false;
      
      public var isActive:Boolean = false;
      
      public var random:Random;
      
      private var m_GemSpawnRandom:Random;
      
      private var m_MysteryBoostRandom:Random;
      
      private var m_HyperColorRandom:Random;
      
      private var m_GetPieceRandom:Random;
      
      private var m_ClearGemsRandom:Random;
      
      private var m_level:int;
      
      private var m_levelPoints:int;
      
      private var m_needLevelUp:Boolean;
      
      private var m_specialGems:Vector.<int>;
      
      private var m_totalPoints:int;
      
      private var m_noMoreMoves:Boolean;
      
      private var m_timePlayed:int;
      
      private var m_bestMove:int;
      
      private var m_numGraceMoves:int;
      
      private var m_bestCascade:int;
      
      private var m_cascadePointsBefore:Array;
      
      private var m_cascadePointsAfter:Array;
      
      public var totalScore:int = 0;
      
      public var currentScores:Vector.<BlitzScoreValue>;
      
      public var allScores:Vector.<BlitzScoreValue>;
      
      public var board:Board;
      
      public var grid:GemGrid;
      
      public var timerLogic:TimerLogic;
      
      public var scoreKeeper:BlitzScoreKeeper;
      
      public var speedBonus:BlitzSpeedBonus;
      
      public var multiLogic:MultiplierGemLogic;
      
      public var blazingSpeedBonus:BlazingSpeedBonus;
      
      public var lastHurrahLogic:LastHurrahLogic;
      
      public var starGemLogic:StarGemLogic;
      
      public var hypercubeLogic:HypercubeLogic;
      
      public var flameGemLogic:FlameGemLogic;
      
      public var coinTokenLogic:CoinTokenLogic;
      
      public var boostLogic:BoostLogic;
      
      public var rareGemLogic:RareGemLogic;
      
      public var compliments:ComplimentLogic;
      
      public var moves:Vector.<MoveData>;
      
      public var swaps:Vector.<SwapData>;
      
      public var completedSwaps:Vector.<SwapData>;
      
      public var matchCount:int = 0;
      
      public var isMatchingEnabled:Boolean = true;
      
      public var gemsHit:Boolean = false;
      
      private var mLastHitTick:int = 0;
      
      public var frameID:int = 0;
      
      private var m_GameSpeed:Number = 1.0;
      
      private var m_InitialGemsFallen:Boolean = false;
      
      public var frameMatches:Vector.<Match>;
      
      public var mBlockingEvents:Vector.<BlitzEvent>;
      
      public var mPassiveEvents:Vector.<BlitzEvent>;
      
      public var mBlockedEvents:Vector.<BlitzEvent>;
      
      public var startedMove:Boolean = false;
      
      public var badMove:Boolean = false;
      
      private var m_App:Blitz3App;
      
      private var m_NewEvents:Vector.<BlitzEvent>;
      
      private var m_NewMatchSets:Vector.<MatchSet>;
      
      private var m_BumpVelocities:Vector.<Number>;
      
      private var m_ColumnHighs:Array;
      
      private var m_CommandQueue:Array;
      
      private var m_Handlers:Vector.<IBlitzLogicHandler>;
      
      public var m_MakeRandomSwaps:Boolean = false;
      
      private var m_RandomSwapDelay:int;
      
      public var m_totalFlameGems:int;
      
      public var m_totalStarGems:int;
      
      public var m_totalHyperCubes:int;
      
      public function BlitzLogic(app:Blitz3App)
      {
         this.replayMoves = [];
         this.m_cascadePointsBefore = new Array();
         this.m_cascadePointsAfter = new Array();
         this.frameMatches = new Vector.<Match>();
         this.m_NewMatchSets = new Vector.<MatchSet>();
         this.m_ColumnHighs = new Array();
         this.m_CommandQueue = [];
         this.m_RandomSwapDelay = 5 + Math.random() * 10;
         super();
         this.m_App = app;
         this.random = new Random(new MersenneTwister());
         this.m_GemSpawnRandom = new Random(new MersenneTwister());
         this.m_MysteryBoostRandom = new Random(new MersenneTwister());
         this.m_HyperColorRandom = new Random(new MersenneTwister());
         this.m_GetPieceRandom = new Random(new MersenneTwister());
         this.m_ClearGemsRandom = new Random(new MersenneTwister());
         this.grid = new GemGrid(ROWS,COLS);
         this.board = new Board(this.random);
         this.moves = new Vector.<MoveData>();
         this.m_BumpVelocities = new Vector.<Number>(Board.WIDTH,true);
         this.swaps = new Vector.<SwapData>();
         this.completedSwaps = new Vector.<SwapData>();
         this.mBlockingEvents = new Vector.<BlitzEvent>();
         this.mPassiveEvents = new Vector.<BlitzEvent>();
         this.mBlockedEvents = new Vector.<BlitzEvent>();
         this.m_NewEvents = new Vector.<BlitzEvent>();
         this.timerLogic = new TimerLogic(app);
         this.scoreKeeper = new BlitzScoreKeeper(this);
         this.speedBonus = new BlitzSpeedBonus(app);
         this.multiLogic = new MultiplierGemLogic(this);
         this.blazingSpeedBonus = new BlazingSpeedBonus(app);
         this.lastHurrahLogic = new LastHurrahLogic(app);
         this.starGemLogic = new StarGemLogic(app);
         this.hypercubeLogic = new HypercubeLogic(app);
         this.flameGemLogic = new FlameGemLogic(app);
         this.coinTokenLogic = new CoinTokenLogic(app,this);
         this.boostLogic = new BoostLogic(app);
         this.rareGemLogic = new RareGemLogic(app);
         this.compliments = new ComplimentLogic(this);
         this.currentScores = new Vector.<BlitzScoreValue>();
         this.allScores = new Vector.<BlitzScoreValue>();
         this.m_Handlers = new Vector.<IBlitzLogicHandler>();
      }
      
      public function Init() : void
      {
         trace("logic initting");
         this.timerLogic.Init();
         this.lastHurrahLogic.Init();
         this.boostLogic.Init();
         this.rareGemLogic.Init();
         this.timerLogic.AddHandler(this);
         this.lastHurrahLogic.AddHandler(this);
         this.scoreKeeper.addEventListener(ScoreEvent.ID,this.HandleScoreEvent);
         this.m_level = 1;
         this.m_totalFlameGems = 0;
         this.m_totalStarGems = 0;
         this.m_totalHyperCubes = 0;
         this.m_numGraceMoves = 4;
      }
      
      public function get numMatches() : int
      {
         return this.matchCount;
      }
      
      public function IsGameOver() : Boolean
      {
         return false;
      }
      
      public function IsWinning() : Boolean
      {
         var basePoints:int = this.m_levelPoints / this.m_level;
         return basePoints >= this.GetLevelPointGoal();
      }
      
      public function GetCurrentLevel() : int
      {
         return this.m_level;
      }
      
      public function NoMoreMoves() : Boolean
      {
         return this.m_noMoreMoves;
      }
      
      public function GetTimePlayed() : int
      {
         return this.m_timePlayed;
      }
      
      public function GetBestMove() : int
      {
         return this.m_bestMove;
      }
      
      public function GetBestCascade() : int
      {
         return this.m_bestCascade;
      }
      
      public function SetSpeed(value:Number) : void
      {
         this.m_GameSpeed = value;
      }
      
      public function SetBestCascade(value:int) : void
      {
         this.m_bestCascade = value;
      }
      
      public function CheckLevelUp() : void
      {
         var basePoints:int = this.m_levelPoints / this.m_level;
         if(basePoints >= this.GetLevelPointGoal())
         {
            this.m_needLevelUp = true;
         }
      }
      
      public function CanLevelUp() : Boolean
      {
         var isStill:Boolean = this.board.IsStill() && this.mBlockingEvents.length == 0;
         if(isStill && this.IsWinning())
         {
            return true;
         }
         return false;
      }
      
      public function LevelUp() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Gem = null;
         var _loc4_:CascadeScore = null;
         ++this.m_level;
         this.m_totalPoints += this.m_levelPoints;
         this.m_levelPoints = 0;
         this.m_specialGems = this.board.GetSpecialGems();
         this.Reset();
         for(_loc1_ = 0; _loc1_ < this.m_specialGems.length; _loc1_++)
         {
            _loc2_ = this.m_specialGems[_loc1_];
            _loc3_ = this.board.GetRandomGem();
            while(_loc3_.type != Gem.TYPE_STANDARD)
            {
               _loc3_ = this.board.GetRandomGem();
            }
            switch(_loc2_)
            {
               case Gem.TYPE_FLAME:
                  this.QueueChangeGemType(_loc3_,_loc2_);
                  this.flameGemLogic.decrementNumCreated();
                  break;
               case Gem.TYPE_STAR:
                  this.QueueChangeGemType(_loc3_,_loc2_);
                  this.starGemLogic.decrementNumCreated();
                  break;
               case Gem.TYPE_RAINBOW:
                  this.QueueChangeGemType(_loc3_,_loc2_);
                  this.hypercubeLogic.decrementNumCreated();
                  break;
            }
            _loc3_.upgrade(_loc2_,true);
         }
         trace("Scores length: " + this.scoreKeeper.cascadeScores.length);
         for(_loc1_ = 0; _loc1_ < this.scoreKeeper.cascadeScores.length; _loc1_++)
         {
            _loc4_ = this.scoreKeeper.cascadeScores[_loc1_];
            trace("Cascade scores: " + _loc4_.score);
         }
      }
      
      public function SetBestMove(bestMove:int) : void
      {
         this.m_bestMove = bestMove;
      }
      
      public function GetLevelPointGoal() : int
      {
         return 2500 + this.m_level * 750;
      }
      
      public function AddBlitzLogicHandler(handler:IBlitzLogicHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function GetScore() : int
      {
         return this.m_totalPoints + this.m_levelPoints;
      }
      
      public function AddScore(value:int) : BlitzScoreValue
      {
         var score:BlitzScoreValue = new BlitzScoreValue();
         score.time = this.frameID;
         score.value = value;
         this.currentScores.push(score);
         return score;
      }
      
      public function QueueBoosts(boosts:Vector.<IBoost>) : void
      {
         var boost:IBoost = null;
         for each(boost in boosts)
         {
            this.QueueCommand(COMMAND_BOOST,boost.GetIntID());
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
         this.QueueCommand(COMMAND_DETONATE,sourceGem.id);
      }
      
      private function DoDetonate(move:MoveData) : void
      {
         var row:int = 0;
         var col:int = 0;
         var gem:Gem = null;
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
                     if(gem.type != Gem.TYPE_STANDARD && gem.immuneTime == 0)
                     {
                        gem.fuseTime = delay;
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
         if(detonated > 0)
         {
            move.sourceGem.isDead = true;
            this.m_App.soundManager.playSound(Blitz3Sounds.SOUND_DETONATE_USE);
         }
         else
         {
            this.m_App.soundManager.playSound(Blitz3Sounds.SOUND_DETONATE_FAIL);
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
         this.QueueCommand(COMMAND_SCRAMBLE,sourceGem.id);
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
            sourceGem.isDead = true;
         }
         this.CancelSwaps();
         this.AddBlockingEvent(new ScrambleEvent(this.m_App,move));
         this.m_App.soundManager.playSound(Blitz3Sounds.SOUND_SCRAMBLE_USE);
      }
      
      public function CanScramble() : Boolean
      {
         var event:BlitzEvent = null;
         for each(event in this.mBlockedEvents)
         {
            if(event is ScrambleDelayEvent)
            {
               return false;
            }
         }
         for each(event in this.mBlockingEvents)
         {
            if(event is ScrambleEvent)
            {
               return false;
            }
         }
         return true;
      }
      
      public function QueueChangeGemType(gem:Gem, type:int) : void
      {
         this.QueueCommand(COMMAND_CHANGE_TYPE,gem.id,type);
      }
      
      private function DoChangeGemType(move:MoveData, type:int) : void
      {
         var gem:Gem = move.sourceGem;
         gem.mMoveId = move.id;
         switch(type)
         {
            case Gem.TYPE_FLAME:
               this.flameGemLogic.UpgradeGem(gem,null,true);
               break;
            case Gem.TYPE_STAR:
               this.starGemLogic.UpgradeGem(gem,null,null,true);
               break;
            case Gem.TYPE_RAINBOW:
               this.hypercubeLogic.UpgradeGem(gem,null,true);
         }
      }
      
      public function Pause() : void
      {
         this.timerLogic.SetPaused(true);
         this.blazingSpeedBonus.Pause();
      }
      
      public function Resume() : void
      {
         this.blazingSpeedBonus.Resume();
         this.timerLogic.SetPaused(false);
      }
      
      public function Quit() : void
      {
         trace("quitting logic");
         this.starGemLogic.Reset();
         this.hypercubeLogic.Reset();
         this.flameGemLogic.Reset();
         this.m_level = 1;
         this.m_totalPoints = 0;
         this.m_levelPoints = 0;
         this.m_totalFlameGems = 0;
         this.m_totalStarGems = 0;
         this.m_totalHyperCubes = 0;
         this.m_bestCascade = 0;
         this.m_bestMove = 0;
         this.timerLogic.ForceGameEnd();
         this.blazingSpeedBonus.Quit();
         this.DispatchGameAbort();
         this.m_cascadePointsAfter = new Array();
         this.m_cascadePointsBefore = new Array();
      }
      
      public function ForceGameEnd() : void
      {
         this.m_noMoreMoves = true;
         this.SetBestMove(this.findBestMove());
         this.m_totalFlameGems += this.flameGemLogic.numCreated;
         this.m_totalStarGems += this.starGemLogic.numCreated;
         this.m_totalHyperCubes += this.hypercubeLogic.numCreated;
      }
      
      public function SetTimePlayed(time:int) : void
      {
         this.m_timePlayed = time;
      }
      
      public function Reset() : void
      {
         var seed:int = 0;
         trace("Logic resetting");
         this.m_numGraceMoves = 4;
         this.m_noMoreMoves = false;
         this.m_needLevelUp = false;
         this.hadReplayError = false;
         this.m_InitialGemsFallen = false;
         this.m_ColumnHighs[0] = {
            "moveId":-1,
            "matchId":-1
         };
         this.m_ColumnHighs[1] = {
            "moveId":-1,
            "matchId":-1
         };
         this.m_ColumnHighs[2] = {
            "moveId":-1,
            "matchId":-1
         };
         this.m_ColumnHighs[3] = {
            "moveId":-1,
            "matchId":-1
         };
         this.m_ColumnHighs[4] = {
            "moveId":-1,
            "matchId":-1
         };
         this.m_ColumnHighs[5] = {
            "moveId":-1,
            "matchId":-1
         };
         this.m_ColumnHighs[6] = {
            "moveId":-1,
            "matchId":-1
         };
         this.m_ColumnHighs[7] = {
            "moveId":-1,
            "matchId":-1
         };
         this.moves.length = 0;
         this.board.Reset();
         this.grid.Reset();
         this.timerLogic.Reset();
         this.scoreKeeper.Reset();
         this.speedBonus.Reset();
         this.multiLogic.Reset();
         this.blazingSpeedBonus.Reset();
         this.lastHurrahLogic.Reset();
         this.compliments.Reset();
         this.m_totalFlameGems += this.flameGemLogic.numCreated;
         this.m_totalStarGems += this.starGemLogic.numCreated;
         this.m_totalHyperCubes += this.hypercubeLogic.numCreated;
         trace("Flame gems: " + this.m_totalFlameGems + "  " + this.flameGemLogic.numCreated);
         trace("Star gems: " + this.m_totalStarGems + "  " + this.starGemLogic.numCreated);
         trace("Hyper cubes: " + this.m_totalHyperCubes + "  " + this.hypercubeLogic.numCreated);
         this.starGemLogic.Reset();
         this.hypercubeLogic.Reset();
         this.flameGemLogic.Reset();
         this.coinTokenLogic.Reset();
         this.frameMatches.length = 0;
         this.m_NewMatchSets.length = 0;
         this.m_CommandQueue.length = 0;
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
         for(var i:int = 0; i < this.m_BumpVelocities.length; i++)
         {
            this.m_BumpVelocities[i] = 0;
         }
         this.m_GameSpeed = BASE_SPEED;
         this.boostLogic.CycleBoosts();
         this.rareGemLogic.CycleRareGem();
         this.replayIndex = 0;
         if(this.isReplay == false)
         {
            seed = new Date().time;
            this.random.SetSeed(seed);
            this.replaySeed = seed;
            this.replayMoves.length = 0;
            this.QueueCommand(COMMAND_SEED,seed);
            this.InitializeRNGs();
         }
         else
         {
            this.StartReplay();
         }
         if(this.m_level == 1)
         {
            this.SpawnPhase(false);
         }
         else
         {
            this.SpawnPhase(false,true);
         }
         this.boostLogic.UseBoosts();
         this.rareGemLogic.UseBoosts();
         if(this.m_MakeRandomSwaps)
         {
            this.m_App.updatesPerTick = 10;
         }
      }
      
      public function GetCurrentLevelPoints() : int
      {
         return this.m_levelPoints;
      }
      
      public function GetBasePointsForLevel() : int
      {
         return this.m_levelPoints / this.m_level;
      }
      
      public function AddPointsCheat() : void
      {
         this.m_levelPoints += 1000;
      }
      
      public function AddBlockingEvent(event:BlitzEvent) : void
      {
         this.mBlockingEvents.push(event);
         this.m_NewEvents.push(event);
      }
      
      public function AddBlockedEvent(event:BlitzEvent) : void
      {
         this.mBlockedEvents.push(event);
         this.m_NewEvents.push(event);
      }
      
      public function AddPassiveEvent(event:BlitzEvent) : void
      {
         this.mPassiveEvents.push(event);
         this.m_NewEvents.push(event);
      }
      
      public function update() : void
      {
         var numMatches:int = 0;
         var j:int = 0;
         var m:Match = null;
         try
         {
            EventBus.GetGlobal().Dispatch("UpdateStartEvent");
            this.gemsHit = false;
            if(this.IsGameOver())
            {
               return;
            }
            this.CheckLevelUp();
            this.CanLevelUp();
            this.startedMove = false;
            this.badMove = false;
            this.updateGems();
            this.UpdateEvents();
            this.m_NewMatchSets.length = 0;
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
            this.blazingSpeedBonus.DoExplosions();
            this.HandleMatchedGems();
            this.HandleDetonatedGems();
            numMatches = this.frameMatches.length;
            j = 0;
            m = null;
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
            this.InitializeEvents();
            this.HandleGems();
            this.resolveGems();
            EventBus.GetGlobal().Dispatch("GemPhaseEnd");
            this.propagateIds();
            this.ScorePhase();
            this.compliments.Update();
            this.UpdateTime();
            this.UpdateLastHurrah();
            EventBus.GetGlobal().Dispatch("UpdateEndEvent");
         }
         catch(err:Error)
         {
            if(isReplay)
            {
               hadReplayError = true;
            }
         }
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
         this.QueueCommand(COMMAND_CHANGE_COLOR,gem.id,color);
      }
      
      private function DoChangeGemColor(move:MoveData, color:int) : void
      {
         move.sourceGem.color = color;
         move.sourceGem.mMoveId = move.id;
      }
      
      public function QueueRemoveGem(gem:Gem) : void
      {
         this.QueueCommand(COMMAND_REMOVE,gem.id);
      }
      
      private function DoRemoveGem(move:MoveData) : void
      {
         var gem:Gem = move.sourceGem;
         gem.mMoveId = move.id;
         gem.isDead = true;
      }
      
      public function QueueDestroyGem(gem:Gem) : void
      {
         this.QueueCommand(COMMAND_DESTROY,gem.id);
      }
      
      private function DoDestroyGem(move:MoveData) : void
      {
         move.sourceGem.mMoveId = move.id;
         move.sourceGem.isShattering = true;
      }
      
      public function HandleTimePhaseBegin() : void
      {
      }
      
      public function HandleTimePhaseEnd() : void
      {
      }
      
      public function HandleGameTimeChange(newTime:int) : void
      {
         if(newTime <= 0)
         {
            this.m_App.soundManager.playSound(Blitz3Sounds.SOUND_VOICE_TIME_UP);
         }
      }
      
      public function HandleGameDurationChange(newDuration:int) : void
      {
         this.m_App.soundManager.playSound(Blitz3Sounds.SOUND_VOICE_EXTRA_TIME);
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
      
      protected function DispatchGameEnd() : void
      {
         var handler:IBlitzLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleGameEnd();
         }
      }
      
      protected function DispatchGameAbort() : void
      {
         var handler:IBlitzLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleGameAbort();
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
      
      private function SpawnPhase(allowCascades:Boolean, spawnInPlace:Boolean = false) : void
      {
         var gem:Gem = null;
         var eventBus:EventBus = EventBus.GetGlobal();
         var isCancelled:Boolean = false;
         eventBus.Dispatch("SpawnCancelEvent");
         var gems:Vector.<Gem> = this.board.mGems;
         var numGems:int = gems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = gems[i];
            if(gem != null)
            {
               if(gem.fuseTime > 0 || gem.isDetonating)
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
         eventBus.Dispatch("SpawnBeginEvent");
         this.board.DropGems();
         this.SpawnGems(allowCascades,spawnInPlace);
         eventBus.Dispatch("SpawnEndEvent");
         this.multiLogic.HandleSpawnEndEvent();
      }
      
      private function SpawnGems(allowCascades:Boolean, spawnInPlace:Boolean = false) : void
      {
         var options:Array = null;
         var numOptions:int = 0;
         var i:int = 0;
         var optionIndex:int = 0;
         var colorA:int = 0;
         var colorB:int = 0;
         var color:int = 0;
         var gem:Gem = null;
         var eventBus:EventBus = EventBus.GetGlobal();
         var newGems:Vector.<Gem> = this.board.SpawnGems(spawnInPlace);
         var isDone:Boolean = false;
         var isRejected:Boolean = true;
         if(newGems.length == 0)
         {
            return;
         }
         if(newGems.length == 1)
         {
            options = [Gem.COLOR_RED,Gem.COLOR_ORANGE,Gem.COLOR_YELLOW,Gem.COLOR_GREEN,Gem.COLOR_BLUE,Gem.COLOR_PURPLE,Gem.COLOR_WHITE];
            numOptions = options.length;
            for(i = 0; i < numOptions; i++)
            {
               optionIndex = this.random.Int(numOptions);
               colorA = options[i];
               colorB = options[optionIndex];
               options[i] = colorB;
               options[optionIndex] = colorA;
            }
            while(!isDone && options.length > 0)
            {
               color = options.shift();
               gem = newGems[0];
               gem.color = color;
               eventBus.Dispatch("SpawnAcceptEvent");
               isDone = this.CheckSpawnedGems(allowCascades);
            }
            isDone = true;
         }
         while(!isDone)
         {
            this.board.RandomizeColors(newGems);
            eventBus.Dispatch("SpawnAcceptEvent");
            isDone = this.CheckSpawnedGems(allowCascades);
         }
      }
      
      private function CheckSpawnedGems(allowCascades:Boolean) : Boolean
      {
         var moves:Vector.<MoveData> = null;
         var matches:Vector.<MatchSet> = null;
         var hypers:Boolean = false;
         if(!allowCascades)
         {
            matches = this.board.FindMatches();
            if(matches.length > 0)
            {
               return false;
            }
         }
         if(!allowCascades || this.m_level == 1 || this.m_numGraceMoves > 0)
         {
            moves = this.board.moveFinder.FindAllMoves(this.board);
            if(moves.length > 0)
            {
               --this.m_numGraceMoves;
            }
            return moves.length > 0;
         }
         hypers = this.board.FindHypers();
         moves = this.board.moveFinder.FindAllMoves(this.board);
         if(moves.length <= 0 && !hypers)
         {
            this.m_noMoreMoves = true;
            this.SetBestMove(this.findBestMove());
            this.m_totalFlameGems += this.flameGemLogic.numCreated;
            this.m_totalStarGems += this.starGemLogic.numCreated;
            this.m_totalHyperCubes += this.hypercubeLogic.numCreated;
         }
         return true;
      }
      
      private function findBestMove() : int
      {
         var bestMove:int = 0;
         for(var i:int = 0; i < this.m_cascadePointsAfter.length; i++)
         {
            if(this.m_cascadePointsAfter[i] - this.m_cascadePointsBefore[i] > bestMove)
            {
               bestMove = this.m_cascadePointsAfter[i] - this.m_cascadePointsBefore[i];
            }
         }
         trace("Best move: " + bestMove);
         return bestMove;
      }
      
      private function ScorePhase() : void
      {
         var score:BlitzScoreValue = null;
         var numScores:int = this.currentScores.length;
         for(var i:int = 0; i < numScores; i++)
         {
            score = this.currentScores[i];
            this.ProcessScore(score);
            this.totalScore += score.value;
            this.allScores.push(score);
         }
         this.currentScores.length = 0;
         var isStill:Boolean = this.board.IsStill() && this.mBlockingEvents.length == 0;
         this.scoreKeeper.Update(isStill);
      }
      
      private function ProcessScore(score:BlitzScoreValue) : void
      {
         this.multiLogic.ProcessScore(score);
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
               if(gem.isShattering)
               {
                  this.mPassiveEvents.push(new ShatterEvent(gem));
               }
               else if(gem.isMatching)
               {
                  this.mPassiveEvents.push(new MatchEvent(gem));
               }
               if(this.lastHurrahLogic.IsRunning() && gem.type == Gem.TYPE_MULTI)
               {
                  if(gem.fuseTime == 0 && gem.isFuseLit)
                  {
                     gem.ForceShatter(true);
                     if(gem.isShattering)
                     {
                        this.mPassiveEvents.push(new ShatterEvent(gem));
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
         var bl:Number = -0.5;
         var br:Number = Board.WIDTH - 0.5;
         var bt:Number = -0.5;
         var bb:Number = Board.HEIGHT - 0.5;
         left = left > bl ? Number(left) : Number(bl);
         right = right < br ? Number(right) : Number(br);
         top = top > bt ? Number(top) : Number(bt);
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
         var bl:int = 0;
         var br:int = Board.WIDTH - 1;
         var bt:int = 0;
         var bb:int = Board.HEIGHT - 1;
         left = left > bl ? int(left) : int(bl);
         right = right < br ? int(right) : int(br);
         top = top > bt ? int(top) : int(bt);
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
         var row:int = int(ref / Board.WIDTH);
         var col:int = ref % Board.WIDTH;
         return this.board.GetGemAt(row,col);
      }
      
      public function QueueCommand(commandID:int, ... args) : void
      {
         if(this.isReplay)
         {
            return;
         }
         var command:Array = [commandID];
         if(commandID >= 0)
         {
            command.push(this.frameID);
         }
         var numArgs:int = args.length;
         for(var i:int = 0; i < numArgs; i++)
         {
            command.push(args[i]);
         }
         if(commandID >= 0)
         {
            this.m_CommandQueue.push(command);
         }
         this.replayMoves.push(command);
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
               row = int(gem.y + 0.5);
               col = int(gem.x + 0.5);
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
            effect.update();
            isEmpty = isEmpty && effect.isDone();
            this.badMove = this.badMove || effect.isBadSwap;
            if(effect.isDone())
            {
               this.completedSwaps.push(effect);
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
         this.m_NewMatchSets.length = 0;
         this.frameMatches.length = 0;
         var sets:Vector.<MatchSet> = this.board.FindMatches();
         var numSets:int = sets.length;
         for(var i:int = 0; i < numSets; i++)
         {
            matchSet = sets[i];
            if(matchSet.isDeferred != true)
            {
               this.m_NewMatchSets.push(matchSet);
               numMatches = matchSet.mMatches.length;
               for(k = 0; k < numMatches; k++)
               {
                  match = matchSet.mMatches[k];
                  match.mMatchId = this.matchCount;
                  this.frameMatches.push(match);
                  ++this.matchCount;
                  highestMoveId = -1;
                  numGems = match.mGems.length;
                  for(n = 0; n < numGems; n++)
                  {
                     gem = match.mGems[n];
                     gem.Match(match.mMatchId);
                     highestMoveId = gem.mMoveId > highestMoveId ? int(gem.mMoveId) : int(highestMoveId);
                  }
                  for(n = 0; n < numGems; n++)
                  {
                     gem = match.mGems[n];
                     gem.mMoveId = highestMoveId;
                  }
               }
            }
         }
      }
      
      private function propagateIds() : void
      {
         var highestMatch:int = 0;
         var highestMove:int = 0;
         var colMatch:int = 0;
         var colMove:int = 0;
         var row:int = 0;
         var gem:Gem = null;
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
                  if(gem.isMatched || gem.isShattered || gem.mIsSwapping || gem.mIsFalling)
                  {
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
         var e:BlitzEvent = null;
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
         var e:BlitzEvent = null;
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
         var e:BlitzEvent = null;
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
         var e:BlitzEvent = null;
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
         var gem:Gem = null;
         var otherRow:int = 0;
         var otherCol:int = 0;
         var rand:Number = NaN;
         var command:Array = null;
         if(this.m_MakeRandomSwaps)
         {
            --this.m_RandomSwapDelay;
            if(this.m_RandomSwapDelay <= 0)
            {
               gem = this.board.GetGemAt(Math.random() * Board.NUM_ROWS,Math.random() * Board.NUM_COLS);
               otherRow = gem.row;
               otherCol = gem.col;
               rand = Math.random();
               if(rand < 0.25)
               {
                  otherRow += 1;
               }
               else if(rand < 0.5)
               {
                  otherRow -= 1;
               }
               else if(rand < 0.75)
               {
                  otherCol += 1;
               }
               else
               {
                  otherCol -= 1;
               }
               this.QueueSwap(gem,otherRow,otherCol);
               this.m_RandomSwapDelay = 5 + Math.random() * 10;
            }
         }
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
      
      private function InitializeRNGs() : void
      {
         this.m_GemSpawnRandom.SetSeed(this.random.Next());
         this.m_MysteryBoostRandom.SetSeed(this.random.Next());
         this.m_HyperColorRandom.SetSeed(this.random.Next());
         this.m_GetPieceRandom.SetSeed(this.random.Next());
         this.m_ClearGemsRandom.SetSeed(this.random.Next());
      }
      
      private function StartReplay() : void
      {
         var command:Array = null;
         var commandID:int = 0;
         var numCommands:int = this.replayMoves.length;
         for(; this.replayIndex < numCommands; ++this.replayIndex)
         {
            command = this.replayMoves[this.replayIndex];
            commandID = command[0];
            if(commandID > 0)
            {
               break;
            }
            switch(commandID)
            {
               case COMMAND_SEED:
                  this.replaySeed = command[1];
                  this.random.SetSeed(this.replaySeed);
                  this.InitializeRNGs();
                  continue;
               case COMMAND_BOOST:
                  this.boostLogic.ActivateBoost(command[1]);
                  continue;
               case COMMAND_RAREGEM:
                  this.rareGemLogic.ActivateRareGem(command[1]);
                  continue;
               default:
                  continue;
            }
         }
      }
      
      private function QueueReplayMoves() : void
      {
         var command:Array = null;
         var commandID:int = 0;
         var time:int = 0;
         var numMoves:int = this.replayMoves.length;
         while(this.replayIndex < numMoves)
         {
            command = this.replayMoves[this.replayIndex];
            commandID = command[0];
            if(commandID < 0)
            {
               throw new Error("Encountered a header command after the header.");
            }
            time = command[1];
            if(time != this.frameID)
            {
               break;
            }
            this.m_CommandQueue.push(command);
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
                  if(gem.mIsSwapping || gem.isMatched)
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
         if(swapped != null)
         {
            if(!swapped.isStill())
            {
               return false;
            }
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
         return true;
      }
      
      private function DoMoveCommand(command:Array) : void
      {
         var move:MoveData = null;
         var destCol:int = 0;
         var destRow:int = 0;
         var commandID:int = command[0];
         var gem:Gem = this.board.GetGem(command[2]);
         move = new MoveData();
         move.sourceGem = gem;
         this.AddMove(move);
         switch(commandID)
         {
            case COMMAND_REMOVE:
               this.DoRemoveGem(move);
               break;
            case COMMAND_DESTROY:
               this.DoDestroyGem(move);
               break;
            case COMMAND_CHANGE_TYPE:
               this.DoChangeGemType(move,this.board.GetGem(command[3]).id);
               break;
            case COMMAND_CHANGE_COLOR:
               this.DoChangeGemColor(move,this.board.GetGem(command[3]).id);
               break;
            case COMMAND_SWAP:
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
               break;
            case COMMAND_DETONATE:
            case COMMAND_SCRAMBLE:
               this.DoUseGem(move);
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
         sourceGem.isSelected = false;
         if(swapGem.mIsSwapping || sourceGem.mIsSwapping)
         {
            return;
         }
         var triggerColor:int = Gem.COLOR_NONE;
         var hypercube:Gem = null;
         if(sourceGem.type == Gem.TYPE_RAINBOW && swapGem.type == Gem.TYPE_RAINBOW)
         {
            hypercube = sourceGem;
            sourceGem.color = Gem.COLOR_NONE;
            triggerColor = Gem.COLOR_NONE;
         }
         else if(sourceGem.type == Gem.TYPE_RAINBOW && swapGem.type != Gem.TYPE_SCRAMBLE && swapGem.type != Gem.TYPE_DETONATE)
         {
            hypercube = sourceGem;
            triggerColor = swapGem.color;
         }
         else if(swapGem.type == Gem.TYPE_RAINBOW && sourceGem.type != Gem.TYPE_SCRAMBLE && sourceGem.type != Gem.TYPE_DETONATE)
         {
            hypercube = swapGem;
            triggerColor = sourceGem.color;
         }
         this.AddMove(move);
         sourceGem.mMoveId = move.id;
         swapGem.mMoveId = move.id;
         if(hypercube != null)
         {
            move.isSuccessful = true;
            hypercube.mShatterColor = triggerColor;
            hypercube.isShattering = true;
            return;
         }
         sourceGem.mIsSwapping = true;
         swapGem.mIsSwapping = true;
         this.startedMove = true;
         var swap:SwapData = new SwapData();
         swap.moveData = move;
         swap.board = this.board;
         swap.init();
         swap.speedFactor = this.m_GameSpeed;
         this.swaps.push(swap);
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
         this.QueueCommand(COMMAND_SWAP,gem.id,destGem.id);
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
         var nextId:int = this.moves.length;
         move.id = nextId;
         this.moves[nextId] = move;
      }
      
      private function HandleMatchedGems() : void
      {
         var gem:Gem = null;
         var gems:Vector.<Gem> = this.board.mGems;
         var numGems:int = this.board.mGems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = gems[i];
            if(!(gem == null || !gem.isMatching))
            {
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
            if(!(gem == null || !gem.isShattering))
            {
               this.starGemLogic.HandleShatteredGem(gem);
               this.flameGemLogic.HandleShatteredGem(gem);
               this.hypercubeLogic.HandleShatteredGem(gem);
               this.multiLogic.HandleShatteredGem(gem);
            }
         }
      }
      
      private function HandleScoreEvent(e:ScoreEvent) : void
      {
         if(this.m_cascadePointsBefore[e.cascade] == null)
         {
            this.m_cascadePointsBefore[e.cascade] = this.scoreKeeper.score - 50;
            trace("Score keeper score: " + this.scoreKeeper.score);
         }
         this.m_cascadePointsAfter[e.cascade] = this.scoreKeeper.score;
         this.m_levelPoints = this.scoreKeeper.score;
         if(this.m_App.mAdAPI._isEnabled)
         {
            this.m_App.mAdAPI.SetScore(this.GetScore());
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
            if(!(gem == null || !gem.isDetonating))
            {
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
      
      public function SerializeCommands() : ByteArray
      {
         var move:Array = null;
         var commandID:int = 0;
         var numItems:int = 0;
         var i:int = 0;
         if(!this.m_App.canPostReplays)
         {
            return null;
         }
         var buffer:ByteArray = new ByteArray();
         buffer.endian = Endian.LITTLE_ENDIAN;
         for each(move in this.replayMoves)
         {
            commandID = move[0];
            if(commandID < 0)
            {
               if(commandID == COMMAND_SEED)
               {
                  buffer.writeByte(COMMAND_SEED);
                  buffer.writeInt(move[1]);
               }
               else if(commandID == COMMAND_BOOST)
               {
                  buffer.writeByte(COMMAND_BOOST);
                  buffer.writeByte(move[1]);
               }
               else if(commandID == COMMAND_RAREGEM)
               {
                  buffer.writeByte(COMMAND_RAREGEM);
                  buffer.writeByte(move[1]);
               }
            }
            else
            {
               buffer.writeByte(commandID);
               buffer.writeShort(move[1]);
               buffer.writeByte(move.length - 2);
               numItems = move.length;
               for(i = 2; i < numItems; i++)
               {
                  buffer.writeShort(move[i]);
               }
            }
         }
         buffer.compress();
         return buffer;
      }
      
      public function DeserializeCommands(buffer:ByteArray) : void
      {
         var commandID:int = 0;
         var command:Array = null;
         var numArgs:int = 0;
         var i:int = 0;
         try
         {
            this.isReplay = true;
            this.replayMoves.length = 0;
            buffer.uncompress();
            while(buffer.bytesAvailable > 0)
            {
               commandID = buffer.readByte();
               command = [];
               command[0] = commandID;
               if(commandID >= 0)
               {
                  command.push(buffer.readUnsignedShort());
                  numArgs = buffer.readUnsignedByte();
                  for(i = 0; i < numArgs; i++)
                  {
                     command.push(buffer.readUnsignedShort());
                  }
               }
               else if(command[0] == COMMAND_SEED)
               {
                  command.push(buffer.readInt());
               }
               else if(command[0] == COMMAND_BOOST)
               {
                  command.push(buffer.readUnsignedByte());
               }
               else if(command[0] == COMMAND_RAREGEM)
               {
                  command.push(buffer.readUnsignedByte());
               }
               this.replayMoves.push(command);
            }
         }
         catch(err:Error)
         {
            hadReplayError = true;
         }
      }
      
      public function GetReplayString() : String
      {
         if(!this.m_App.canPostReplays)
         {
            return "";
         }
         var replay:ByteArray = this.m_App.logic.SerializeCommands();
         return Base64.Encode(replay).toString();
      }
   }
}
