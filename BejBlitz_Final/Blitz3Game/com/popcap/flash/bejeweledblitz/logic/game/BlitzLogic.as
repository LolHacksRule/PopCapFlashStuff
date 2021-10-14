package com.popcap.flash.bejeweledblitz.logic.game
{
   import com.popcap.flash.bejeweledblitz.logic.BlitzRNGManager;
   import com.popcap.flash.bejeweledblitz.logic.BlitzRandom;
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.BoardPatternConverter;
   import com.popcap.flash.bejeweledblitz.logic.BoardPatternUsurper;
   import com.popcap.flash.bejeweledblitz.logic.Config;
   import com.popcap.flash.bejeweledblitz.logic.DailyChallengeLogicConfig;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.GemColors;
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
   import com.popcap.flash.bejeweledblitz.logic.boostV2.BoostV2;
   import com.popcap.flash.bejeweledblitz.logic.boostV2.BoostV2Logic;
   import com.popcap.flash.bejeweledblitz.logic.finisher.FinisherIndicatorLogic;
   import com.popcap.flash.bejeweledblitz.logic.gems.MatchEventPool;
   import com.popcap.flash.bejeweledblitz.logic.gems.ShatterEventPool;
   import com.popcap.flash.bejeweledblitz.logic.gems.flame.FlameGemLogic;
   import com.popcap.flash.bejeweledblitz.logic.gems.hypercube.HypercubeLogic;
   import com.popcap.flash.bejeweledblitz.logic.gems.multi.MultiplierGemLogic;
   import com.popcap.flash.bejeweledblitz.logic.gems.phoenixprism.PhoenixPrismLogic;
   import com.popcap.flash.bejeweledblitz.logic.gems.scramble.ScrambleEventPool;
   import com.popcap.flash.bejeweledblitz.logic.gems.star.StarGemLogic;
   import com.popcap.flash.bejeweledblitz.logic.gems.unscramble.UnScrambleEventPool;
   import com.popcap.flash.bejeweledblitz.logic.genericBlockingEvent.GenericBlockingEventPool;
   import com.popcap.flash.bejeweledblitz.logic.raregems.ColorChangeRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.RareGemsLogic;
   import com.popcap.flash.bejeweledblitz.logic.tokens.CoinTokenLogic;
   import com.popcap.flash.bejeweledblitz.logic.tokens.RareGemTokenLogic;
   import com.popcap.flash.framework.pool.PoolManager;
   import flash.utils.Dictionary;
   
   public class BlitzLogic implements ILastHurrahLogicHandler
   {
      
      public static const REPLAY_START_TIME:String = "250";
      
      public static const DEFAULT_CONFIG:int = 1;
      
      public static const DAILYCHALLENGE_CONFIG:int = 2;
      
      public static const TOURNAMENT_CONFIG:int = 3;
       
      
      public var replayMoves:Vector.<ReplayData>;
      
      public var replayIndex:int;
      
      public var hadReplayError:Boolean;
      
      public var isActive:Boolean;
      
      public var currentSeed:int;
      
      public var mIsReplay:Boolean;
      
      public var mBlockReplay:Boolean;
      
      public var mGameSeed:String;
      
      public var lifeguard:PoolManager;
      
      public var movePool:MovePool;
      
      public var matchPool:MatchPool;
      
      public var matchSetPool:MatchSetPool;
      
      public var point2DPool:Point2DPool;
      
      public var scrambleEventPool:ScrambleEventPool;
      
      public var unScrambleEventPool:UnScrambleEventPool;
      
      public var shatterEventPool:ShatterEventPool;
      
      public var matchEventPool:MatchEventPool;
      
      public var swapDataPool:SwapDataPool;
      
      public var replayDataPool:ReplayDataPool;
      
      public var totalScore:int;
      
      public var currentScores:Vector.<ScoreValue>;
      
      public var allScores:Vector.<ScoreValue>;
      
      public var config:Config;
      
      public var configDailyChallenge:DailyChallengeLogicConfig;
      
      public var configTournament:Config;
      
      public var configDefaults:Config;
      
      public var board:Board;
      
      public var grid:GemGrid;
      
      public var timerLogic:TimerLogic;
      
      public var infiniteTimeLogic:InfiniteTimeLogic;
      
      public var speedBonus:BlitzSpeedBonus;
      
      public var multiLogic:MultiplierGemLogic;
      
      public var blazingSpeedLogic:BlazingSpeedLogic;
      
      public var finisherIndicatorLogic:FinisherIndicatorLogic;
      
      public var lastHurrahLogic:LastHurrahLogic;
      
      public var changeColorLogic:ColorChangeRGLogic;
      
      public var starGemLogic:StarGemLogic;
      
      public var hypercubeLogic:HypercubeLogic;
      
      public var flameGemLogic:FlameGemLogic;
      
      public var phoenixPrismLogic:PhoenixPrismLogic;
      
      public var coinTokenLogic:CoinTokenLogic;
      
      public var rareGemTokenLogic:RareGemTokenLogic;
      
      public var boostLogicV2:BoostV2Logic;
      
      public var rareGemsLogic:RareGemsLogic;
      
      public var autoHintLogic:AutoHintLogic;
      
      private var _standardScoreKeeper:BlitzScoreKeeper;
      
      private var _dailyChallengeScoreKeeper:BlitzScoreKeeper;
      
      public var compliments:ComplimentLogic;
      
      public var moves:Vector.<MoveData>;
      
      private var _tempMoves:Vector.<MoveData>;
      
      public var swaps:Vector.<SwapData>;
      
      public var completedSwaps:Vector.<SwapData>;
      
      public var sucessfullyCompletedSwaps:Vector.<SwapData>;
      
      public var matchCount:int;
      
      public var manualMatchCount:int;
      
      public var isMatchingEnabled:Boolean;
      
      public var gemsHit:Boolean;
      
      private var _lastHitTick:int;
      
      public var frameID:int;
      
      private var _gameSpeed:Number;
      
      private var _speedBoost:Number;
      
      private var _initialGemsFallen:Boolean;
      
      public var frameMatches:Vector.<Match>;
      
      private var _tempMatchSets:Vector.<MatchSet>;
      
      public var mBlockingEvents:Vector.<IBlitzEvent>;
      
      public var mPassiveEvents:Vector.<IBlitzEvent>;
      
      public var mBlockingButStillUpdateEvents:Vector.<IBlitzEvent>;
      
      public var mTimeBlockingEvents:Vector.<IBlitzEvent>;
      
      public var startedMove:Boolean;
      
      public var badMove:Boolean;
      
      private var _newEvents:Vector.<IBlitzEvent>;
      
      private var _bumpVelocities:Vector.<Number>;
      
      private var _columnHighs:Vector.<ColumnData>;
      
      private var _commandQueue:Vector.<ReplayData>;
      
      private var _pendingCommandQueue:Vector.<ReplayData>;
      
      private var _rottenCommandQueue:Vector.<ReplayData>;
      
      private var _gemColorOptions:Vector.<int>;
      
      private var _handlers:Vector.<IBlitzLogicHandler>;
      
      private var _updateHandlers:Vector.<IBlitzLogicUpdateHandler>;
      
      private var _spawnHandlers:Vector.<IBlitzLogicSpawnHandler>;
      
      private var _eventHandlers:Vector.<IBlitzLogicEventHandler>;
      
      private var _delegates:Vector.<IBlitzLogicDelegate>;
      
      private var _replayHandler:IBlitzReplayHandler;
      
      private var _isDailyChallenge:Boolean;
      
      private var mLastMatchedGemColor:int = 0;
      
      private var mMultiplierBonusValue:int = 0;
      
      private var mScoreBonusValue:int = 0;
      
      private var mScoreBonusValueDuringGame:int = 0;
      
      private var mAllowScoreBonus:Boolean = false;
      
      private var mMaxMultiplierThresholdSet:Boolean = false;
      
      private var _rngManager:BlitzRNGManager;
      
      public var _gemIdToReplayDataMap:Dictionary;
      
      public var genericBlockingEventPool:GenericBlockingEventPool;
      
      private var _characterEventsHandlers:Vector.<ICharacterEventsHandler> = null;
      
      private var mAddBlockingEventUnScramble:Boolean = false;
      
      public function BlitzLogic()
      {
         super();
         this.mGameSeed = "";
         this.lifeguard = new PoolManager();
         this.config = new Config();
         this.configDailyChallenge = new DailyChallengeLogicConfig();
         this.configDefaults = new Config();
         this.configTournament = new Config();
         this.replayMoves = new Vector.<ReplayData>();
         this.replayIndex = 0;
         this.hadReplayError = false;
         this.isActive = false;
         this.totalScore = 0;
         this.matchCount = 0;
         this.isMatchingEnabled = true;
         this.gemsHit = false;
         this._lastHitTick = 0;
         this.frameID = 0;
         this._speedBoost = 0;
         this._gameSpeed = this.config.blitzLogicBaseSpeed;
         this._initialGemsFallen = false;
         this.startedMove = false;
         this.badMove = false;
         this.mIsReplay = false;
         this.mBlockReplay = false;
         this.frameMatches = new Vector.<Match>();
         this._tempMatchSets = new Vector.<MatchSet>();
         this._columnHighs = new Vector.<ColumnData>();
         this._commandQueue = new Vector.<ReplayData>();
         this._pendingCommandQueue = new Vector.<ReplayData>();
         this._rottenCommandQueue = new Vector.<ReplayData>();
         this._gemIdToReplayDataMap = new Dictionary();
         this._handlers = new Vector.<IBlitzLogicHandler>();
         this._updateHandlers = new Vector.<IBlitzLogicUpdateHandler>();
         this._spawnHandlers = new Vector.<IBlitzLogicSpawnHandler>();
         this._eventHandlers = new Vector.<IBlitzLogicEventHandler>();
         this._delegates = new Vector.<IBlitzLogicDelegate>();
         this._characterEventsHandlers = new Vector.<ICharacterEventsHandler>();
         this._rngManager = new BlitzRNGManager(this);
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
         this.unScrambleEventPool = new UnScrambleEventPool(this);
         this.lifeguard.AddPool(this.unScrambleEventPool);
         this.genericBlockingEventPool = new GenericBlockingEventPool(this);
         this.lifeguard.AddPool(this.genericBlockingEventPool);
         this.shatterEventPool = new ShatterEventPool();
         this.lifeguard.AddPool(this.shatterEventPool);
         this.matchEventPool = new MatchEventPool(this);
         this.lifeguard.AddPool(this.matchEventPool);
         this.swapDataPool = new SwapDataPool(this);
         this.lifeguard.AddPool(this.swapDataPool);
         this.replayDataPool = new ReplayDataPool();
         this.lifeguard.AddPool(this.replayDataPool);
         this.grid = new GemGrid(Board.NUM_ROWS,Board.NUM_COLS);
         this.board = new Board(this);
         this.moves = new Vector.<MoveData>();
         this._tempMoves = new Vector.<MoveData>();
         this._bumpVelocities = new Vector.<Number>(Board.WIDTH);
         this.swaps = new Vector.<SwapData>();
         this.completedSwaps = new Vector.<SwapData>();
         this.sucessfullyCompletedSwaps = new Vector.<SwapData>();
         this.mBlockingEvents = new Vector.<IBlitzEvent>();
         this.mBlockingButStillUpdateEvents = new Vector.<IBlitzEvent>();
         this.mPassiveEvents = new Vector.<IBlitzEvent>();
         this.mTimeBlockingEvents = new Vector.<IBlitzEvent>();
         this._newEvents = new Vector.<IBlitzEvent>();
         this.timerLogic = new TimerLogic(this);
         this.infiniteTimeLogic = new InfiniteTimeLogic(this);
         this._standardScoreKeeper = new BlitzScoreKeeper(this);
         this._dailyChallengeScoreKeeper = new BlitzScoreKeeper(this);
         this.speedBonus = new BlitzSpeedBonus(this);
         this.multiLogic = new MultiplierGemLogic(this);
         this.blazingSpeedLogic = new BlazingSpeedLogic(this);
         this.finisherIndicatorLogic = new FinisherIndicatorLogic(this);
         this.lastHurrahLogic = new LastHurrahLogic(this);
         this.changeColorLogic = new ColorChangeRGLogic(this);
         this.starGemLogic = new StarGemLogic(this);
         this.hypercubeLogic = new HypercubeLogic(this);
         this.flameGemLogic = new FlameGemLogic(this);
         this.flameGemLogic.SetupEvents();
         this.phoenixPrismLogic = new PhoenixPrismLogic(this);
         this.coinTokenLogic = new CoinTokenLogic(this);
         this.rareGemTokenLogic = new RareGemTokenLogic(this);
         this.boostLogicV2 = new BoostV2Logic(this);
         this.rareGemsLogic = new RareGemsLogic(this);
         this.autoHintLogic = new AutoHintLogic(this);
         this.compliments = new ComplimentLogic(this);
         this.currentScores = new Vector.<ScoreValue>();
         this.allScores = new Vector.<ScoreValue>();
         this._columnHighs.length = Board.NUM_COLS;
         var _loc1_:int = 0;
         while(_loc1_ < Board.NUM_COLS)
         {
            this._columnHighs[_loc1_] = new ColumnData();
            _loc1_++;
         }
         this._gemColorOptions = new Vector.<int>();
         this._isDailyChallenge = false;
         this._replayHandler = null;
         this.Init();
      }
      
      public function GetPrimaryRNG() : BlitzRandom
      {
         return this._rngManager.GetRNGOfType(BlitzRNGManager.RNG_BLITZ_PRIMARY);
      }
      
      public function GetSecondaryRNG() : BlitzRandom
      {
         return this._rngManager.GetRNGOfType(BlitzRNGManager.RNG_BLITZ_SECONDARY);
      }
      
      private function Init() : void
      {
         this.isActive = false;
         this.timerLogic.Init();
         this.infiniteTimeLogic.Init();
         this.blazingSpeedLogic.Init();
         this.finisherIndicatorLogic.Init();
         this.lastHurrahLogic.Init();
         this.rareGemsLogic.Init();
         this.autoHintLogic.Init();
         this.lastHurrahLogic.AddHandler(this);
         this._rngManager.Init();
      }
      
      public function GetNumMatches() : int
      {
         return this.matchCount;
      }
      
      public function GetCurrentSeed() : int
      {
         return this.currentSeed;
      }
      
      public function IsGameOver() : Boolean
      {
         return this.timerLogic.IsDone() && this.lastHurrahLogic.IsDone();
      }
      
      public function GetScoreKeeper() : BlitzScoreKeeper
      {
         if(this.IsDailyChallengeGame())
         {
            return this._dailyChallengeScoreKeeper;
         }
         return this._standardScoreKeeper;
      }
      
      public function AddHandlerToAllScoreKeepers(param1:IBlitzScoreKeeperHandler) : void
      {
         this._standardScoreKeeper.AddHandler(param1);
         this._dailyChallengeScoreKeeper.AddHandler(param1);
      }
      
      public function RemoveScoreKeeperHandlers(param1:IBlitzScoreKeeperHandler) : void
      {
         this._standardScoreKeeper.RemoveHandler(param1);
         this._dailyChallengeScoreKeeper.RemoveHandler(param1);
      }
      
      public function addSpeedBoost(param1:Number) : void
      {
         this._speedBoost = Math.max(this._speedBoost + param1,0);
      }
      
      public function SetSpeedBoost(param1:Number) : void
      {
         this._speedBoost = param1;
      }
      
      public function SetSpeed(param1:Number) : void
      {
         this._gameSpeed = this._speedBoost + param1;
      }
      
      public function SetConfig(param1:int) : void
      {
         this._isDailyChallenge = false;
         if(param1 == DEFAULT_CONFIG)
         {
            this.config = this.configDefaults;
         }
         else if(param1 == DAILYCHALLENGE_CONFIG)
         {
            this.config = this.configDailyChallenge;
            this._isDailyChallenge = true;
         }
         else if(param1 == TOURNAMENT_CONFIG)
         {
            this.config = this.configTournament;
         }
      }
      
      public function IsDailyChallengeGame() : Boolean
      {
         return this._isDailyChallenge;
      }
      
      public function AddHandler(param1:IBlitzLogicHandler) : void
      {
         this._handlers.push(param1);
      }
      
      public function RemoveHandler(param1:IBlitzLogicHandler) : void
      {
         var _loc2_:int = this._handlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._handlers.splice(_loc2_,1);
      }
      
      public function AddCharacterEventHandler(param1:ICharacterEventsHandler) : void
      {
         this._characterEventsHandlers.push(param1);
      }
      
      public function RemoveCharacterEventHandler(param1:ICharacterEventsHandler) : void
      {
         var _loc2_:int = this._characterEventsHandlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._characterEventsHandlers.splice(_loc2_,1);
      }
      
      public function DispatchCharacterEventEntry() : void
      {
         var _loc1_:ICharacterEventsHandler = null;
         for each(_loc1_ in this._characterEventsHandlers)
         {
            _loc1_.HandleCharacterBoardEntry();
         }
      }
      
      public function DispatchCharacterEventExit() : void
      {
         var _loc1_:ICharacterEventsHandler = null;
         for each(_loc1_ in this._characterEventsHandlers)
         {
            _loc1_.HandleCharacterBoardExit();
         }
      }
      
      public function AddUpdateHandler(param1:IBlitzLogicUpdateHandler) : void
      {
         this._updateHandlers.push(param1);
      }
      
      public function RemoveUpdateHandler(param1:IBlitzLogicUpdateHandler) : void
      {
         var _loc2_:int = this._updateHandlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._updateHandlers.splice(_loc2_,1);
      }
      
      public function AddSpawnHandler(param1:IBlitzLogicSpawnHandler) : void
      {
         this._spawnHandlers.push(param1);
      }
      
      public function RemoveSpawnHandler(param1:IBlitzLogicSpawnHandler) : void
      {
         var _loc2_:int = this._spawnHandlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._spawnHandlers.splice(_loc2_,1);
      }
      
      public function AddEventHandler(param1:IBlitzLogicEventHandler) : void
      {
         this._eventHandlers.push(param1);
      }
      
      public function RemoveEventHandler(param1:IBlitzLogicEventHandler) : void
      {
         var _loc2_:int = this._eventHandlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._eventHandlers.splice(_loc2_,1);
      }
      
      public function AddDelegate(param1:IBlitzLogicDelegate) : void
      {
         this._delegates.push(param1);
      }
      
      public function RemoveDelegate(param1:IBlitzLogicDelegate) : void
      {
         var _loc2_:int = this._delegates.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._delegates.splice(_loc2_,1);
      }
      
      public function AddScore(param1:int) : ScoreValue
      {
         var _loc2_:ScoreValue = this.GetScoreKeeper().scoreValuePool.GetNextScoreValue(param1,this.frameID);
         this.currentScores.push(_loc2_);
         return _loc2_;
      }
      
      public function QueueDetonateOnBoard(param1:String, param2:Number) : void
      {
         if(this.mIsReplay || this.timerLogic.GetTimeRemaining() <= 0 || this.mBlockingEvents.length > 0)
         {
            return;
         }
         var _loc3_:ReplayData = this.replayDataPool.GetNextReplayData();
         _loc3_.commandArray.push(this.boostLogicV2.mBoostIndex[param1].toString());
         _loc3_.commandArray.push(param2.toString());
         this.QueueCommand(ReplayCommands.COMMAND_DETONATE,_loc3_,ReplayCommands.COMMAND_PLAY_AND_REPLAY);
      }
      
      public function DetonatingGemCount() : int
      {
         var _loc5_:int = 0;
         var _loc6_:Gem = null;
         var _loc1_:int = this.coinTokenLogic.getCoinArraySize();
         _loc1_ += this.rareGemTokenLogic.getRareGemTokenArray();
         var _loc2_:int = Board.HEIGHT;
         var _loc3_:int = Board.WIDTH;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               if(!((_loc6_ = this.board.GetGemAt(_loc4_,_loc5_)) == null || _loc6_.type == Gem.TYPE_SCRAMBLE || _loc6_.type == Gem.TYPE_DETONATE))
               {
                  if(_loc6_.type != Gem.TYPE_STANDARD && _loc6_.immuneTime == 0 && !_loc6_.IsMatched() && !_loc6_.IsMatching())
                  {
                     _loc1_++;
                  }
               }
               _loc5_++;
            }
            _loc4_++;
         }
         return _loc1_;
      }
      
      public function DoDetonateOnBoard(param1:int, param2:Number) : void
      {
         var _loc4_:* = null;
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         var _loc7_:Vector.<Gem> = null;
         var _loc11_:int = 0;
         var _loc12_:Gem = null;
         var _loc3_:String = "";
         for(_loc4_ in this.boostLogicV2.mBoostIndex)
         {
            if(this.boostLogicV2.mBoostIndex[_loc4_] == param1)
            {
               _loc3_ = _loc4_;
               break;
            }
         }
         _loc5_ = param2;
         _loc6_ = 0;
         _loc7_ = new Vector.<Gem>();
         if(this._initialGemsFallen)
         {
            _loc6_ += this.coinTokenLogic.DetonateCoinTokens();
            if(this.rareGemTokenLogic != null)
            {
               _loc6_ += this.rareGemTokenLogic.DetonateTokens(-1);
            }
         }
         var _loc8_:int = Board.HEIGHT;
         var _loc9_:int = Board.WIDTH;
         var _loc10_:int = 0;
         while(_loc10_ < _loc8_)
         {
            _loc11_ = 0;
            while(_loc11_ < _loc9_)
            {
               if(!((_loc12_ = this.board.GetGemAt(_loc10_,_loc11_)) == null || _loc12_.type == Gem.TYPE_SCRAMBLE || _loc12_.type == Gem.TYPE_DETONATE))
               {
                  if(_loc12_.type != Gem.TYPE_STANDARD && _loc12_.immuneTime == 0 && !_loc12_.IsMatched() && !_loc12_.IsMatching())
                  {
                     _loc12_.SetDelayedShatter(_loc5_);
                     _loc12_.moveID = 0;
                     _loc12_.shatterColor = _loc12_.color;
                     _loc12_.shatterType = _loc12_.type;
                     _loc5_ += 25;
                     _loc6_++;
                     _loc7_.push(_loc12_);
                  }
               }
               _loc11_++;
            }
            _loc10_++;
         }
         this.boostLogicV2.DispatchBoostFeedback(_loc3_,_loc7_);
      }
      
      public function QueueBoostActivatedCommand(param1:String, param2:String) : void
      {
         if(this.mIsReplay)
         {
            return;
         }
         var _loc3_:ReplayData = this.replayDataPool.GetNextReplayData();
         _loc3_.commandArray.push(param1);
         _loc3_.commandArray.push(param2);
         this.QueueCommand(ReplayCommands.COMMAND_BOOST_ACTIVATED,_loc3_,ReplayCommands.COMMAND_ONLY_REPLAY);
      }
      
      public function QueueChangeGemType(param1:Gem, param2:int, param3:int, param4:int) : void
      {
         if(this.mIsReplay)
         {
            return;
         }
         var _loc5_:ReplayData;
         (_loc5_ = this.replayDataPool.GetNextReplayData()).commandArray.push(param1.id.toString());
         _loc5_.commandArray.push(param2.toString());
         _loc5_.commandArray.push(param3.toString());
         this.QueueCommand(ReplayCommands.COMMAND_CHANGE_TYPE,_loc5_,param4);
      }
      
      public function QueueAddRGToken(param1:Gem) : void
      {
         if(this.mIsReplay)
         {
            return;
         }
         this.rareGemTokenLogic.SpawnRareGemTokenOnGem(param1);
         var _loc2_:ReplayData = this.replayDataPool.GetNextReplayData();
         _loc2_.commandArray.push(param1.id.toString());
         this.QueueCommand(ReplayCommands.COMMAND_ADD_RG_TOKEN,_loc2_,ReplayCommands.COMMAND_ONLY_REPLAY);
      }
      
      public function QueueAddMultiplierToken(param1:Gem) : void
      {
         if(this.mIsReplay)
         {
            return;
         }
         this.multiLogic.SpawnGem(param1);
         var _loc2_:ReplayData = this.replayDataPool.GetNextReplayData();
         _loc2_.commandArray.push(param1.id.toString());
         this.QueueCommand(ReplayCommands.COMMAND_ADD_MULTIPLIER_TOKEN,_loc2_,ReplayCommands.COMMAND_ONLY_REPLAY);
      }
      
      public function QueueAddCoinToken(param1:Gem) : void
      {
         if(this.mIsReplay)
         {
            return;
         }
         this.coinTokenLogic.SpawnCoinOnGem(param1);
         var _loc2_:ReplayData = this.replayDataPool.GetNextReplayData();
         _loc2_.commandArray.push(param1.id.toString());
         this.QueueCommand(ReplayCommands.COMMAND_ADD_COIN_TOKEN,_loc2_,ReplayCommands.COMMAND_ONLY_REPLAY);
      }
      
      public function QueueShowPatternOnBoard(param1:String, param2:int, param3:int, param4:int, param5:int, param6:int) : void
      {
         if(this.mIsReplay)
         {
            return;
         }
         var _loc7_:ReplayData;
         (_loc7_ = this.replayDataPool.GetNextReplayData()).commandArray.push(param1);
         _loc7_.commandArray.push(param2.toString());
         _loc7_.commandArray.push(param3.toString());
         _loc7_.commandArray.push(param4.toString());
         _loc7_.commandArray.push(param5.toString());
         _loc7_.commandArray.push(param6.toString());
         this.QueueCommand(ReplayCommands.COMMAND_SHOW_PATTERN_ON_BOARD,_loc7_,ReplayCommands.COMMAND_PLAY_AND_REPLAY);
      }
      
      private function DoChangeGemType(param1:MoveData, param2:int) : void
      {
         var _loc3_:Gem = param1.sourceGem;
         _loc3_.moveID = param1.id;
         if(param2 == Gem.TYPE_PHOENIXPRISM)
         {
            this.phoenixPrismLogic.UpgradeGem(_loc3_,null,true);
         }
         else if(param2 == Gem.TYPE_STAR)
         {
            this.starGemLogic.UpgradeGem(_loc3_,null,null,true,false);
         }
         else if(param2 == Gem.TYPE_FLAME)
         {
            this.flameGemLogic.UpgradeGem(_loc3_,null,true);
         }
         else if(param2 == Gem.TYPE_HYPERCUBE)
         {
            this.hypercubeLogic.UpgradeGem(_loc3_,null,true);
         }
         else if(param2 == Gem.TYPE_MULTI)
         {
            if(this.multiLogic.CanSpawnMuliplier(_loc3_))
            {
               this.multiLogic.SpawnGem(_loc3_);
            }
         }
      }
      
      private function DoSetGameDuration(param1:int) : void
      {
         this.timerLogic.SetGameDuration(param1);
      }
      
      public function ShouldDelayTimeUp() : Boolean
      {
         var _loc2_:IBlitzLogicDelegate = null;
         var _loc1_:Boolean = false;
         if(this.mIsReplay && this.replayIndex < this.replayMoves.length)
         {
            _loc1_ = true;
         }
         if(!_loc1_)
         {
            for each(_loc2_ in this._delegates)
            {
               if(_loc2_.ShouldDelayTimeUp())
               {
                  _loc1_ = true;
                  break;
               }
            }
         }
         return _loc1_;
      }
      
      public function Pause() : void
      {
         this.timerLogic.SetPaused(true);
         this.isActive = false;
         this.DispatchGamePaused();
      }
      
      public function Resume() : void
      {
         this.timerLogic.SetPaused(false);
         this.isActive = true;
         this.DispatchGameResumed();
      }
      
      public function Quit() : void
      {
         this.timerLogic.ForceGameEnd();
         this._dailyChallengeScoreKeeper.Reset();
         this.DispatchGameAbort();
      }
      
      public function Reset(param1:int) : void
      {
         var _loc2_:ColumnData = null;
         var _loc3_:int = 0;
         var _loc5_:BoardPatternUsurper = null;
         var _loc6_:GemColors = null;
         var _loc7_:BoardPatternConverter = null;
         var _loc8_:Vector.<Vector.<int>> = null;
         this.currentSeed = param1;
         this.mMaxMultiplierThresholdSet = false;
         this.hadReplayError = false;
         this.isActive = false;
         this._initialGemsFallen = false;
         for each(_loc2_ in this._columnHighs)
         {
            _loc2_.Reset();
         }
         this.mScoreBonusValue = 0;
         this.mScoreBonusValueDuringGame = 0;
         this.mMultiplierBonusValue = 0;
         this.SetAllowScoreBonus(false);
         this.moves.length = 0;
         this._tempMoves.length = 0;
         this.board.Reset();
         this.grid.Reset();
         this.infiniteTimeLogic.Reset();
         this._dailyChallengeScoreKeeper.Reset();
         this._standardScoreKeeper.Reset();
         this.speedBonus.Reset();
         this.multiLogic.Reset();
         this.blazingSpeedLogic.Reset(true);
         this.finisherIndicatorLogic.Reset();
         this.lastHurrahLogic.Reset();
         this.boostLogicV2.Reset();
         this.rareGemsLogic.Reset();
         this.compliments.Reset();
         this.phoenixPrismLogic.Reset();
         this.starGemLogic.Reset();
         this.hypercubeLogic.Reset();
         this.flameGemLogic.Reset();
         this.coinTokenLogic.Reset();
         this.rareGemTokenLogic.Reset();
         this.autoHintLogic.Reset();
         this.frameMatches.length = 0;
         this.swaps.length = 0;
         this.completedSwaps.length = 0;
         this.sucessfullyCompletedSwaps.length = 0;
         this.mBlockingEvents.length = 0;
         this.mPassiveEvents.length = 0;
         this.mTimeBlockingEvents.length = 0;
         this._newEvents.length = 0;
         this.totalScore = 0;
         this.currentScores.length = 0;
         this.allScores.length = 0;
         this.matchCount = 0;
         this.manualMatchCount = 0;
         this.frameID = 0;
         this.startedMove = false;
         this.badMove = false;
         this.gemsHit = false;
         this._lastHitTick = 0;
         _loc3_ = 0;
         while(_loc3_ < this._bumpVelocities.length)
         {
            this._bumpVelocities[_loc3_] = 0;
            _loc3_++;
         }
         this._speedBoost = 0;
         this._gameSpeed = this.config.blitzLogicBaseSpeed;
         this.rareGemsLogic.CycleRareGem();
         this._rngManager.SetSeed(param1);
         var _loc4_:Boolean = false;
         if(this.rareGemsLogic.currentRareGem && this.rareGemsLogic.currentRareGem.hasStartingBoard())
         {
            _loc4_ = true;
         }
         if(this.config.startingGameBoardPattern != "")
         {
            _loc4_ = true;
         }
         this.SpawnPhase(false,_loc4_);
         if(this.config.startingGameBoardPattern != "")
         {
            _loc5_ = new BoardPatternUsurper();
            _loc6_ = new GemColors();
            _loc8_ = (_loc7_ = new BoardPatternConverter(_loc6_)).convertBoardStringToIntVector(this.config.startingGameBoardPattern);
            _loc5_.overridePattern(_loc8_,this.board);
         }
         this.mBlockingButStillUpdateEvents = new Vector.<IBlitzEvent>();
         this.rareGemsLogic.UseBoosts();
      }
      
      public function ResetMoveObjectPools() : void
      {
         this.timerLogic.Reset();
         this.lifeguard.ResetPools();
         this.replayMoves.splice(0,this.replayMoves.length);
         this._commandQueue.splice(0,this._commandQueue.length);
         this._pendingCommandQueue.splice(0,this._pendingCommandQueue.length);
         this._rottenCommandQueue.splice(0,this._rottenCommandQueue.length);
      }
      
      public function QueueConfigCommands(param1:Boolean) : void
      {
         var _loc2_:ReplayData = null;
         this.mIsReplay = param1;
         if(this.mIsReplay)
         {
            this.replayIndex = 0;
            this.PopulateGemIdToReplayDataMap();
            this.QueueReplayMoves(true);
         }
         else
         {
            _loc2_ = this.replayDataPool.GetNextReplayData();
            _loc2_.commandArray.push(REPLAY_START_TIME);
            this.QueueCommand(ReplayCommands.COMMAND_ADD_AWARD_EXTRA_TIME,_loc2_,ReplayCommands.COMMAND_PLAY_AND_REPLAY);
            _loc2_ = this.replayDataPool.GetNextReplayData();
            _loc2_.commandArray.push(this.mGameSeed);
            _loc2_.commandArray.push(this.config.gemColors.toString());
            this.QueueCommand(ReplayCommands.COMMAND_SEED,_loc2_,ReplayCommands.COMMAND_PLAY_AND_REPLAY);
         }
      }
      
      public function AddBlockingEvent(param1:IBlitzEvent) : void
      {
         this.mBlockingEvents.push(param1);
         this._newEvents.push(param1);
         this.DispatchBlockingEventAdded();
      }
      
      public function DispatchBlockingEventAdded() : void
      {
         var _loc1_:IBlitzLogicHandler = null;
         for each(_loc1_ in this._handlers)
         {
            _loc1_.HandleBlockingEvent();
         }
      }
      
      public function DispatchGameTimeDelayed() : void
      {
         var _loc1_:IBlitzLogicHandler = null;
         for each(_loc1_ in this._handlers)
         {
            _loc1_.HandleGameTimeDelayed();
         }
      }
      
      public function AddBlockingButStillUpdateEvent(param1:IBlitzEvent) : void
      {
         this.mBlockingButStillUpdateEvents.push(param1);
         this._newEvents.push(param1);
      }
      
      public function AddTimeBlockingEvent(param1:IBlitzEvent) : void
      {
         this.mTimeBlockingEvents.push(param1);
         this._newEvents.push(param1);
      }
      
      public function AddPassiveEvent(param1:IBlitzEvent) : void
      {
         this.mPassiveEvents.push(param1);
         this._newEvents.push(param1);
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
         this.InitializeEvents();
         this.updateGems();
         this.UpdateEvents();
         this.frameMatches.length = 0;
         this.ExecutePendingCommands();
         if(this.mBlockingEvents.length == 0 && this.mTimeBlockingEvents.length == 0)
         {
            if(!this.lastHurrahLogic.IsRunning())
            {
               this.UpdateMoves();
            }
         }
         this.UpdateSwapping();
         if(this.mBlockingEvents.length == 0)
         {
            this.SpawnPhase(true,false);
            this.updateFalling(this._gameSpeed);
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
         var _loc1_:int = this.frameMatches.length;
         var _loc2_:int = 0;
         var _loc3_:Match = null;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.frameMatches[_loc2_];
            this.phoenixPrismLogic.HandleMatch(_loc3_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.frameMatches[_loc2_];
            this.starGemLogic.HandleMatch(_loc3_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.frameMatches[_loc2_];
            this.flameGemLogic.HandleMatch(_loc3_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.frameMatches[_loc2_];
            this.hypercubeLogic.HandleMatch(_loc3_);
            _loc2_++;
         }
         this.HandleShatteredGems();
         this.HandleDetonatedGems();
         this.HandleGems();
         this.resolveGems();
         this.DispatchGemUpdateEnd();
         this.propagateIds();
         this.ScorePhase();
         this.compliments.Update();
         this.ExecutePendingCommands();
         if(this.mIsReplay)
         {
            this.QueueReplayMoves(false);
            if(this.timerLogic.GetTimeRemaining() == 1 && this.mBlockingEvents.length == 0)
            {
               this.UpdateMoves();
            }
         }
         this.UpdateTime();
         this.UpdateLastHurrah();
         this.DispatchUpdateEnd();
      }
      
      public function QueueChangeGemColor(param1:Gem, param2:int, param3:int, param4:int) : void
      {
         if(this.mIsReplay)
         {
            return;
         }
         var _loc5_:ReplayData;
         (_loc5_ = this.replayDataPool.GetNextReplayData()).commandArray.push(param1.id.toString());
         _loc5_.commandArray.push(param2.toString());
         _loc5_.commandArray.push(param3.toString());
         this.QueueCommand(ReplayCommands.COMMAND_CHANGE_COLOR,_loc5_,param4);
      }
      
      private function DoChangeGemColor(param1:MoveData, param2:int) : void
      {
         param1.sourceGem.color = param2;
         param1.sourceGem.moveID = param1.id;
      }
      
      public function QueueShowCharacter(param1:int) : void
      {
         if(this.mIsReplay)
         {
            return;
         }
         var _loc2_:ReplayData = this.replayDataPool.GetNextReplayData();
         this.QueueCommand(ReplayCommands.COMMAND_SHOW_CHARACTER,_loc2_,param1);
      }
      
      public function QueueAddExtraTimeDuringGamePlay(param1:int, param2:int) : void
      {
         if(this.mIsReplay)
         {
            return;
         }
         var _loc3_:ReplayData = this.replayDataPool.GetNextReplayData();
         _loc3_.commandArray.push(param1.toString());
         this.QueueCommand(ReplayCommands.COMMAND_ADD_EXTRA_TIME,_loc3_,param2);
      }
      
      public function QueueEncoreCommand(param1:String, param2:Boolean) : void
      {
         var _loc3_:ReplayData = null;
         var _loc4_:int = 0;
         if(this.mIsReplay)
         {
            this.UnblockReplay();
         }
         else
         {
            _loc3_ = this.replayDataPool.GetNextReplayData();
            _loc4_ = !!param2 ? 1 : 0;
            _loc3_.commandArray.push(param1);
            _loc3_.commandArray.push(_loc4_.toString());
            this.QueueCommand(ReplayCommands.COMMAND_ENCORE,_loc3_,ReplayCommands.COMMAND_ONLY_REPLAY);
         }
      }
      
      private function UnblockReplay() : void
      {
         this.mBlockReplay = false;
      }
      
      public function CleanUpPostGameplay() : void
      {
         this.ResetLogicVariablesAfterReplay();
         this.gemsHit = false;
         this.boostLogicV2.CleanUp();
         this.board.Reset();
         this.config.Reset();
      }
      
      private function ResetLogicVariablesAfterReplay() : void
      {
         this.moves.length = 0;
         this._tempMoves.length = 0;
         this.frameMatches.length = 0;
         this.swaps.length = 0;
         this.completedSwaps.length = 0;
         this.sucessfullyCompletedSwaps.length = 0;
         this.mBlockingEvents.length = 0;
         this.mPassiveEvents.length = 0;
         this.mTimeBlockingEvents.length = 0;
         this._newEvents.length = 0;
         this.totalScore = 0;
         this.currentScores.length = 0;
         this.allScores.length = 0;
         this.matchCount = 0;
         this.manualMatchCount = 0;
         this.frameID = 0;
         this.startedMove = false;
         this.badMove = false;
         this.gemsHit = false;
         this._lastHitTick = 0;
         this.coinTokenLogic.Reset();
         this.timerLogic.Reset();
         this.config.blitzLogicBaseSpeed = 1.2;
         this.config.eternalBlazingSpeed = false;
      }
      
      public function canBeginLastHurrah() : Boolean
      {
         return true;
      }
      
      public function handleLastHurrahBegin() : void
      {
      }
      
      public function handleLastHurrahEnd() : void
      {
         this.timerLogic.ForceGameEnd();
         this.gemsHit = false;
         var _loc1_:int = 0;
         var _loc2_:int = this._rottenCommandQueue.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = this.replayMoves.indexOf(this._rottenCommandQueue[_loc3_]);
            if(_loc1_ > 0)
            {
               this.replayMoves.splice(_loc1_,1);
            }
            _loc3_++;
         }
         this._rottenCommandQueue.splice(0,this._rottenCommandQueue.length);
         this.DispatchGameEnd();
         this.boostLogicV2.CleanUp();
      }
      
      public function handlePreCoinHurrah() : void
      {
      }
      
      public function canBeginCoinHurrah() : Boolean
      {
         return true;
      }
      
      private function DispatchGameLoad() : void
      {
         var _loc2_:IBlitzLogicHandler = null;
         var _loc1_:Vector.<IBlitzLogicHandler> = new Vector.<IBlitzLogicHandler>();
         for each(_loc2_ in this._handlers)
         {
            _loc1_.push(_loc2_);
         }
         for each(_loc2_ in _loc1_)
         {
            _loc2_.HandleGameLoad();
         }
      }
      
      private function DispatchGameBegin() : void
      {
         var _loc2_:IBlitzLogicHandler = null;
         var _loc1_:Vector.<IBlitzLogicHandler> = new Vector.<IBlitzLogicHandler>();
         for each(_loc2_ in this._handlers)
         {
            _loc1_.push(_loc2_);
         }
         for each(_loc2_ in _loc1_)
         {
            _loc2_.HandleGameBegin();
         }
      }
      
      private function DispatchGameEnd() : void
      {
         var _loc2_:IBlitzLogicHandler = null;
         var _loc1_:Vector.<IBlitzLogicHandler> = new Vector.<IBlitzLogicHandler>();
         for each(_loc2_ in this._handlers)
         {
            _loc1_.push(_loc2_);
         }
         for each(_loc2_ in _loc1_)
         {
            _loc2_.HandleGameEnd();
         }
      }
      
      private function DispatchGameAbort() : void
      {
         var _loc2_:IBlitzLogicHandler = null;
         var _loc1_:Vector.<IBlitzLogicHandler> = new Vector.<IBlitzLogicHandler>();
         for each(_loc2_ in this._handlers)
         {
            _loc1_.push(_loc2_);
         }
         for each(_loc2_ in _loc1_)
         {
            _loc2_.HandleGameAbort();
         }
      }
      
      private function DispatchGamePaused() : void
      {
         var _loc1_:IBlitzLogicHandler = null;
         for each(_loc1_ in this._handlers)
         {
            _loc1_.HandleGamePaused();
         }
      }
      
      private function DispatchGameResumed() : void
      {
         var _loc1_:IBlitzLogicHandler = null;
         for each(_loc1_ in this._handlers)
         {
            _loc1_.HandleGameResumed();
         }
      }
      
      private function DispatchUpdateBegin() : void
      {
         var _loc1_:IBlitzLogicUpdateHandler = null;
         for each(_loc1_ in this._updateHandlers)
         {
            _loc1_.HandleLogicUpdateBegin();
         }
      }
      
      private function DispatchUpdateEnd() : void
      {
         var _loc1_:IBlitzLogicUpdateHandler = null;
         for each(_loc1_ in this._updateHandlers)
         {
            _loc1_.HandleLogicUpdateEnd();
         }
      }
      
      private function DispatchGemUpdateEnd() : void
      {
         var _loc1_:IBlitzLogicUpdateHandler = null;
         for each(_loc1_ in this._updateHandlers)
         {
            _loc1_.HandleLogicGemUpdateEnd();
         }
      }
      
      private function DispatchSpawnBegin() : void
      {
         var _loc1_:IBlitzLogicSpawnHandler = null;
         for each(_loc1_ in this._spawnHandlers)
         {
            _loc1_.HandleLogicSpawnPhaseBegin();
         }
      }
      
      private function DispatchSpawnEnd() : void
      {
         var _loc1_:IBlitzLogicSpawnHandler = null;
         for each(_loc1_ in this._spawnHandlers)
         {
            _loc1_.HandleLogicSpawnPhaseEnd();
         }
      }
      
      private function DispatchPostSpawnPhase() : void
      {
         var _loc1_:IBlitzLogicSpawnHandler = null;
         for each(_loc1_ in this._spawnHandlers)
         {
            _loc1_.HandlePostLogicSpawnPhase();
         }
      }
      
      private function DispatchSwapBegin(param1:SwapData) : void
      {
         var _loc2_:IBlitzLogicEventHandler = null;
         for each(_loc2_ in this._eventHandlers)
         {
            _loc2_.HandleSwapBegin(param1);
         }
      }
      
      private function DispatchSwapComplete(param1:SwapData) : void
      {
         var _loc2_:IBlitzLogicEventHandler = null;
         for each(_loc2_ in this._eventHandlers)
         {
            _loc2_.HandleSwapComplete(param1);
         }
      }
      
      private function DispatchLastSuccessfulSwapComplete(param1:SwapData) : void
      {
         var _loc2_:IBlitzLogicEventHandler = null;
         for each(_loc2_ in this._eventHandlers)
         {
            _loc2_.HandleLastSuccessfulSwapComplete(param1);
         }
      }
      
      private function DispatchSwapCancel(param1:SwapData) : void
      {
         var _loc2_:IBlitzLogicEventHandler = null;
         for each(_loc2_ in this._eventHandlers)
         {
            _loc2_.HandleSwapCancel(param1);
         }
      }
      
      private function DispatchSpecialGemBlast(param1:Gem) : void
      {
         var _loc2_:IBlitzLogicEventHandler = null;
         for each(_loc2_ in this._eventHandlers)
         {
            _loc2_.HandleSpecialGemBlast(param1);
         }
      }
      
      public function CancelSwaps() : void
      {
         var _loc3_:SwapData = null;
         var _loc1_:int = this.swaps.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.swaps[_loc2_];
            _loc3_.moveData.sourceGem.isSwapping = false;
            _loc3_.moveData.sourceGem.isUnswapping = false;
            _loc3_.moveData.swapGem.isSwapping = false;
            _loc3_.moveData.swapGem.isUnswapping = false;
            this.DispatchSwapCancel(_loc3_);
            _loc2_++;
         }
         this.swaps.length = 0;
      }
      
      private function UpdateTime() : void
      {
         ++this.frameID;
         if(!(!this.isActive && this.timerLogic.GetTimeRemaining() > this.config.timerLogicBaseGameDuration))
         {
            if(this.mBlockingEvents.length > 0 || this.mTimeBlockingEvents.length > 0 || !this.isActive && this.config.timerLogicBaseGameDuration > this.timerLogic.GetTimeRemaining())
            {
               return;
            }
         }
         this.timerLogic.Update();
      }
      
      private function SpawnPhase(param1:Boolean, param2:Boolean) : void
      {
         var _loc7_:Gem = null;
         var _loc3_:Boolean = false;
         var _loc4_:Vector.<Gem>;
         var _loc5_:int = (_loc4_ = this.board.mGems).length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            if((_loc7_ = _loc4_[_loc6_]) != null)
            {
               if(_loc7_.GetFuseTime() > 0 || _loc7_.IsDetonating())
               {
                  _loc3_ = true;
                  break;
               }
            }
            _loc6_++;
         }
         if(_loc3_)
         {
            return;
         }
         this.DispatchSpawnBegin();
         this.board.DropGems();
         this.SpawnGems(param1,param2);
         if(!param2)
         {
            this.promoteToFlameGems(this.GetScoreKeeper().GetScore());
         }
         this.DispatchSpawnEnd();
         if(!this.mIsReplay && this.isActive)
         {
            this.DispatchPostSpawnPhase();
         }
      }
      
      public function promoteToFlameGems(param1:Number) : void
      {
         if(this.rareGemsLogic == null || this.rareGemsLogic.currentRareGem == null || !this.timerLogic.IsRunning())
         {
            return;
         }
         if(this.rareGemsLogic.currentRareGem.isFlamePromoter())
         {
            this.board.PromoteFlameGems(this.flameGemLogic,this.rareGemsLogic.currentRareGem.getFlameColor(),this.rareGemsLogic.currentRareGem.getDropPercent(param1));
         }
      }
      
      private function SpawnGems(param1:Boolean, param2:Boolean) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:Gem = null;
         var _loc3_:Vector.<Gem> = this.board.SpawnGems();
         if(_loc3_.length == 0)
         {
            return;
         }
         var _loc4_:Boolean = false;
         if(_loc3_.length == 1)
         {
            this._gemColorOptions = this.config.gemColors;
            _loc5_ = this._gemColorOptions.length;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc8_ = this.GetPrimaryRNG().Int(0,_loc5_);
               _loc9_ = this._gemColorOptions[_loc6_];
               _loc10_ = this._gemColorOptions[_loc8_];
               this._gemColorOptions[_loc6_] = _loc10_;
               this._gemColorOptions[_loc8_] = _loc9_;
               _loc6_++;
            }
            _loc7_ = 0;
            while(!_loc4_ && _loc7_ < this._gemColorOptions.length)
            {
               _loc11_ = this._gemColorOptions[_loc7_];
               (_loc12_ = _loc3_[0]).color = _loc11_;
               _loc4_ = this.CheckSpawnedGems(param1);
               _loc7_++;
            }
            _loc4_ = true;
         }
         while(!_loc4_)
         {
            if(!param2)
            {
               this.board.RandomizeColors(_loc3_);
            }
            _loc4_ = this.CheckSpawnedGems(param1);
         }
      }
      
      private function CheckSpawnedGems(param1:Boolean) : Boolean
      {
         var _loc3_:int = 0;
         if(!param1)
         {
            this.board.FindMatches(this._tempMatchSets);
            _loc3_ = this._tempMatchSets.length;
            this.matchSetPool.FreeMatchSets(this._tempMatchSets,true);
            if(_loc3_ > 0)
            {
               return false;
            }
         }
         this.board.moveFinder.FindAllMoves(this.board,this._tempMoves);
         var _loc2_:int = this._tempMoves.length;
         this.movePool.FreeMoves(this._tempMoves);
         return _loc2_ > 0;
      }
      
      private function ScorePhase() : void
      {
         var _loc4_:ScoreValue = null;
         var _loc1_:int = this.currentScores.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc4_ = this.currentScores[_loc2_];
            this.DispatchScore(_loc4_);
            this.totalScore += _loc4_.GetValue();
            this.allScores.push(_loc4_);
            _loc2_++;
         }
         this.currentScores.length = 0;
         this.speedBonus.Update();
         this.GetScoreKeeper().moveBonus = this.speedBonus.GetBonus();
         var _loc3_:Boolean = this.board.IsStill() && this.mBlockingEvents.length == 0;
         this.GetScoreKeeper().Update(_loc3_);
         this.blazingSpeedLogic.Update(this.frameMatches,this);
         this.finisherIndicatorLogic.Update();
      }
      
      private function DispatchScore(param1:ScoreValue) : void
      {
         var _loc2_:IBlitzLogicHandler = null;
         for each(_loc2_ in this._handlers)
         {
            _loc2_.HandleScore(param1);
         }
      }
      
      private function resolveGems() : void
      {
         var _loc3_:Gem = null;
         var _loc1_:int = this.board.mGems.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.board.mGems[_loc2_];
            if(_loc3_ != null)
            {
               if(_loc3_.IsShattering() && !_loc3_.isImmune)
               {
                  if(this.rareGemTokenLogic.GemHasRareGemGiftToken(_loc3_))
                  {
                     _loc3_.SetDelayedShatter(1);
                  }
                  else
                  {
                     this.mPassiveEvents.push(this.shatterEventPool.GetNextShatterEvent(_loc3_));
                  }
               }
               else if(_loc3_.IsMatching() && !_loc3_.isImmune)
               {
                  if(this.rareGemTokenLogic.GemHasRareGemGiftToken(_loc3_))
                  {
                     _loc3_.SetFuseTime(1);
                  }
                  else
                  {
                     this.mPassiveEvents.push(this.matchEventPool.GetNextMatchEvent(_loc3_));
                  }
               }
               if(this.lastHurrahLogic != null && this.lastHurrahLogic.IsRunning() && _loc3_ != null && _loc3_.type == Gem.TYPE_MULTI)
               {
                  if(_loc3_.GetFuseTime() == 0 && _loc3_.IsFuseLit())
                  {
                     _loc3_.ForceShatter(true);
                     if(_loc3_.IsShattering())
                     {
                        this.mPassiveEvents.push(this.shatterEventPool.GetNextShatterEvent(_loc3_));
                     }
                  }
               }
            }
            _loc2_++;
         }
      }
      
      public function punchGem(param1:Gem) : void
      {
         var _loc2_:MoveData = this.movePool.GetMove();
         _loc2_.sourceGem = param1;
         _loc2_.sourcePos.x = param1.col;
         _loc2_.sourcePos.y = param1.row;
         this.AddMove(_loc2_);
         if(param1.type != Gem.TYPE_STANDARD)
         {
            param1.SetFuseTime(1);
            param1.moveID = _loc2_.id;
            param1.shatterColor = param1.color;
            param1.shatterType = param1.type;
            param1.baseValue = 1500;
         }
         else
         {
            param1.immuneTime = 0;
            param1.BenignDestroy();
            param1.shatterColor = param1.color;
            param1.shatterType = param1.type;
            param1.SetPunched(true);
            param1.moveID = _loc2_.id;
            this.mPassiveEvents.push(this.shatterEventPool.GetNextShatterEvent(param1));
            param1.baseValue = 250;
         }
         this.GetScoreKeeper().AddPoints(param1.baseValue,param1);
         this.AddScore(param1.baseValue);
      }
      
      private function GetRefFromGem(param1:Gem) : int
      {
         return param1.row * Board.WIDTH + param1.col;
      }
      
      private function GetGemFromRef(param1:int) : Gem
      {
         var _loc2_:int = param1 / Board.WIDTH;
         var _loc3_:int = param1 % Board.WIDTH;
         return this.board.GetGemAt(_loc2_,_loc3_);
      }
      
      public function QueueCommand(param1:int, param2:ReplayData, param3:int) : void
      {
         if(param1 >= 0)
         {
            if(!this.isActive && this.config.timerLogicBaseGameDuration > this.timerLogic.GetTimeRemaining())
            {
               return;
            }
            param2.commandArray.unshift(this.GetAdjustedTimeForCommand());
         }
         param2.commandArray.unshift(param1);
         param2.commandArray.push(this.GetScoreKeeper().GetScore().toString());
         if(param3 == ReplayCommands.COMMAND_ONLY_PLAY || param3 == ReplayCommands.COMMAND_PLAY_AND_REPLAY)
         {
            this._commandQueue.push(param2);
         }
         if(param3 == ReplayCommands.COMMAND_ONLY_REPLAY || param3 == ReplayCommands.COMMAND_PLAY_AND_REPLAY)
         {
            this.replayMoves.push(param2);
         }
      }
      
      private function updateGems() : void
      {
         var _loc4_:Gem = null;
         var _loc1_:Vector.<Gem> = this.board.mGems;
         var _loc2_:int = _loc1_.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if((_loc4_ = _loc1_[_loc3_]) != null)
            {
               _loc4_.update();
            }
            _loc3_++;
         }
      }
      
      private function updateGemPositions() : void
      {
         var _loc4_:Gem = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:Vector.<Gem> = this.board.mGems;
         var _loc2_:int = _loc1_.length;
         this.grid.clearGrid();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if((_loc4_ = _loc1_[_loc3_]) != null)
            {
               _loc5_ = _loc4_.y + 0.5;
               _loc6_ = _loc4_.x + 0.5;
               this.grid.setGem(_loc5_,_loc6_,_loc4_);
            }
            _loc3_++;
         }
      }
      
      private function UpdateSwapping() : void
      {
         var _loc4_:SwapData = null;
         var _loc1_:Boolean = true;
         var _loc2_:int = this.swaps.length;
         this.completedSwaps.length = 0;
         this.sucessfullyCompletedSwaps.length = 0;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            (_loc4_ = this.swaps[_loc3_]).Update();
            _loc1_ = _loc1_ && _loc4_.IsDone();
            this.badMove = this.badMove || _loc4_.isBadSwap;
            if(_loc4_.IsDone())
            {
               this.completedSwaps.push(_loc4_);
               if(_loc4_.moveData.isSuccessful)
               {
                  this.mLastMatchedGemColor = !!_loc4_.moveData.sourceGem.hasMatch ? int(_loc4_.moveData.sourceGem.color) : int(_loc4_.moveData.swapGem.color);
                  this.sucessfullyCompletedSwaps.push(_loc4_);
               }
               this.DispatchSwapComplete(_loc4_);
            }
            _loc3_++;
         }
         if(this.sucessfullyCompletedSwaps.length > 0 && _loc1_)
         {
            this.DispatchLastSuccessfulSwapComplete(this.sucessfullyCompletedSwaps.pop());
            this.sucessfullyCompletedSwaps.length = 0;
         }
         if(_loc1_)
         {
            this.swaps.length = 0;
         }
      }
      
      private function updateMatches() : void
      {
         var _loc3_:MatchSet = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Match = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Gem = null;
         this.matchPool.FreeMatches(this.frameMatches);
         this.board.FindMatches(this._tempMatchSets);
         var _loc1_:int = this._tempMatchSets.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._tempMatchSets[_loc2_];
            if(_loc3_.IsDeferred() == true)
            {
               this.matchSetPool.FreeMatchSet(_loc3_,true);
               this._tempMatchSets[_loc2_] = null;
            }
            else
            {
               _loc4_ = _loc3_.mMatches.length;
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  (_loc6_ = _loc3_.mMatches[_loc5_]).matchId = this.matchCount;
                  this.frameMatches.push(_loc6_);
                  ++this.matchCount;
                  _loc7_ = -1;
                  _loc8_ = _loc6_.matchGems.length;
                  _loc9_ = 0;
                  while(_loc9_ < _loc8_)
                  {
                     (_loc10_ = _loc6_.matchGems[_loc9_]).Match(_loc6_.matchId);
                     _loc7_ = _loc10_.moveID > _loc7_ ? int(_loc10_.moveID) : int(_loc7_);
                     _loc9_++;
                  }
                  _loc9_ = 0;
                  while(_loc9_ < _loc8_)
                  {
                     (_loc10_ = _loc6_.matchGems[_loc9_]).moveID = _loc7_;
                     _loc9_++;
                  }
                  _loc5_++;
               }
            }
            _loc2_++;
         }
         this.matchSetPool.FreeMatchSets(this._tempMatchSets,false);
      }
      
      private function propagateIds() : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Gem = null;
         var _loc1_:int = Board.NUM_COLS;
         var _loc2_:int = Board.NUM_ROWS;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc4_ = -1;
            _loc5_ = -1;
            _loc6_ = this._columnHighs[_loc3_].matchId;
            _loc7_ = this._columnHighs[_loc3_].moveId;
            _loc8_ = _loc2_ - 1;
            while(_loc8_ >= 0)
            {
               if((_loc9_ = this.board.GetGemAt(_loc8_,_loc3_)) != null)
               {
                  if(_loc9_.IsMatched() || _loc9_.IsShattered() || _loc9_.isSwapping || _loc9_.isFalling)
                  {
                     _loc4_ = _loc4_ > _loc9_.matchID ? int(_loc4_) : int(_loc9_.matchID);
                     _loc5_ = _loc5_ > _loc9_.moveID ? int(_loc5_) : int(_loc9_.moveID);
                     _loc6_ = _loc4_ > _loc6_ ? int(_loc4_) : int(_loc6_);
                     _loc7_ = _loc5_ > _loc7_ ? int(_loc5_) : int(_loc7_);
                  }
                  if(_loc4_ > _loc9_.matchID)
                  {
                     _loc9_.matchID = _loc4_;
                  }
                  if(_loc5_ > _loc9_.moveID)
                  {
                     _loc9_.moveID = _loc5_;
                  }
                  if(_loc9_.y < -1)
                  {
                     _loc9_.matchID = _loc6_;
                     _loc9_.moveID = _loc7_;
                  }
               }
               _loc8_--;
            }
            this._columnHighs[_loc3_].matchId = _loc6_;
            this._columnHighs[_loc3_].moveId = _loc7_;
            _loc3_++;
         }
      }
      
      private function InitializeEvents() : void
      {
         var _loc1_:IBlitzEvent = null;
         while(this._newEvents.length > 0)
         {
            _loc1_ = this._newEvents.pop();
            _loc1_.Init();
         }
         this._newEvents.length = 0;
      }
      
      private function UpdateEvents() : void
      {
         this.UpdateBlockingButStillUpdateEvents();
         this.UpdateBlockingEvents();
         this.UpdateTimeBlockingEvents();
         this.UpdatePassiveEvents();
      }
      
      private function UpdateBlockingEvents() : void
      {
         var _loc2_:IBlitzEvent = null;
         var _loc1_:Boolean = true;
         for each(_loc2_ in this.mBlockingEvents)
         {
            _loc2_.Update(this._gameSpeed);
            _loc1_ = _loc1_ && _loc2_.IsDone();
         }
         if(_loc1_)
         {
            this.mBlockingEvents.length = 0;
         }
      }
      
      private function UpdateBlockingButStillUpdateEvents() : void
      {
         var _loc2_:IBlitzEvent = null;
         var _loc1_:Boolean = true;
         for each(_loc2_ in this.mBlockingButStillUpdateEvents)
         {
            _loc2_.Update(this._gameSpeed);
            _loc1_ = _loc1_ && _loc2_.IsDone();
         }
         if(_loc1_)
         {
            this.mBlockingButStillUpdateEvents.length = 0;
         }
      }
      
      private function UpdateTimeBlockingEvents() : void
      {
         var _loc2_:IBlitzEvent = null;
         var _loc1_:Boolean = true;
         for each(_loc2_ in this.mTimeBlockingEvents)
         {
            _loc2_.Update(this._gameSpeed);
            _loc1_ = _loc1_ && _loc2_.IsDone();
         }
         if(_loc1_)
         {
            this.mTimeBlockingEvents.length = 0;
         }
      }
      
      private function UpdatePassiveEvents() : void
      {
         var _loc2_:IBlitzEvent = null;
         var _loc1_:Boolean = true;
         for each(_loc2_ in this.mPassiveEvents)
         {
            _loc2_.Update(this._gameSpeed);
            _loc1_ = _loc1_ && _loc2_.IsDone();
         }
         if(_loc1_)
         {
            this.mPassiveEvents.length = 0;
         }
      }
      
      private function ExecutePendingCommands() : void
      {
         var _loc1_:ReplayData = null;
         var _loc2_:Vector.<String> = null;
         var _loc3_:int = 0;
         var _loc4_:Gem = null;
         var _loc5_:MoveData = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         while(this._pendingCommandQueue.length > 0)
         {
            _loc1_ = this._pendingCommandQueue.shift();
            _loc2_ = _loc1_.commandArray;
            _loc3_ = parseInt(_loc2_[0],10);
            if(_loc3_ != ReplayCommands.COMMAND_NONE)
            {
               _loc4_ = null;
               if(_loc3_ >= 0)
               {
                  _loc4_ = this.board.GetGem(parseInt(_loc1_.commandArray[2]));
               }
               else
               {
                  _loc4_ = this.board.GetGem(parseInt(_loc1_.commandArray[1]));
               }
               if(_loc4_ == null)
               {
                  this._pendingCommandQueue.unshift(_loc1_);
                  if(_loc3_ >= 0)
                  {
                     _loc7_ = this.timerLogic.GetTimeRemaining();
                     if((_loc9_ = (_loc8_ = parseInt(_loc2_[1])) - _loc7_) > 10)
                     {
                        this._replayHandler.ReplayHasErrors();
                        break;
                     }
                  }
               }
               _loc5_ = null;
            }
            continue;
            if(!this.mIsReplay && !_loc4_.CanSelect())
            {
               this._rottenCommandQueue.push(_loc1_);
            }
            else
            {
               switch(_loc3_)
               {
                  case ReplayCommands.COMMAND_ADD_RG_TOKEN:
                     this.rareGemTokenLogic.SpawnRareGemTokenOnGem(_loc4_);
                     break;
                  case ReplayCommands.COMMAND_ADD_MULTIPLIER_TOKEN:
                     this.multiLogic.SpawnGem(_loc4_);
                     break;
                  case ReplayCommands.COMMAND_ADD_COIN_TOKEN:
                     this.coinTokenLogic.SpawnCoinOnGem(_loc4_);
                     break;
                  case ReplayCommands.COMMAND_CHANGE_TYPE:
                     if((_loc6_ = parseInt(_loc2_[4],10)) >= 0)
                     {
                        _loc5_ = this.moves[_loc6_];
                     }
                     else
                     {
                        _loc5_ = this.movePool.GetMove();
                     }
                     _loc5_.sourceGem = _loc4_;
                     this.DoChangeGemType(_loc5_,parseInt(_loc2_[3]));
                     delete this._gemIdToReplayDataMap[_loc4_.id];
                     break;
                  case ReplayCommands.COMMAND_CHANGE_COLOR:
                     if((_loc6_ = parseInt(_loc2_[4],10)) >= 0)
                     {
                        _loc5_ = this.moves[_loc6_];
                     }
                     else
                     {
                        _loc5_ = this.movePool.GetMove();
                     }
                     _loc5_.sourceGem = _loc4_;
                     this.DoChangeGemColor(_loc5_,parseInt(_loc2_[3]));
                     delete this._gemIdToReplayDataMap[_loc4_.id];
               }
            }
         }
      }
      
      private function UpdateMoves() : void
      {
         var _loc1_:MoveData = null;
         var _loc2_:ReplayData = null;
         while(this._commandQueue.length > 0)
         {
            _loc2_ = this._commandQueue.shift();
            this.DoMoveCommand(_loc2_);
         }
         for each(_loc1_ in this.moves)
         {
            _loc1_.isActive = _loc1_.isActive && !this.board.IsStill();
         }
      }
      
      private function QueueReplayMoves(param1:Boolean) : void
      {
         var _loc4_:ReplayData = null;
         var _loc5_:Vector.<String> = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(this.mBlockReplay)
         {
            return;
         }
         var _loc2_:int = this.replayMoves.length;
         var _loc3_:Boolean = false;
         while(this.replayIndex < _loc2_)
         {
            _loc5_ = (_loc4_ = this.replayMoves[this.replayIndex]).commandArray;
            _loc6_ = parseInt(_loc5_[0],10);
            _loc8_ = _loc7_ = this.timerLogic.GetTimeRemaining();
            if(_loc6_ >= 0)
            {
               if(_loc3_ || param1 || this.mBlockingEvents.length > 0 || !this.isActive && this.config.timerLogicBaseGameDuration > this.timerLogic.GetTimeRemaining())
               {
                  break;
               }
               _loc8_ = parseInt(_loc5_[1],10);
            }
            if(!(_loc7_ <= _loc8_ && Math.abs(_loc8_ - _loc7_) < 5))
            {
               break;
            }
            this._commandQueue.push(_loc4_);
            ++this.replayIndex;
            if(this.ShouldBreakCommandQueueAdditions(_loc6_))
            {
               _loc3_ = true;
            }
         }
      }
      
      private function PopulateGemIdToReplayDataMap() : void
      {
         var _loc3_:ReplayData = null;
         var _loc4_:Vector.<String> = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         this._gemIdToReplayDataMap = new Dictionary();
         var _loc1_:int = this.replayMoves.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.replayMoves[_loc2_];
            _loc4_ = _loc3_.commandArray;
            if((_loc5_ = parseInt(_loc4_[0],10)) == ReplayCommands.COMMAND_CHANGE_TYPE || _loc5_ == ReplayCommands.COMMAND_CHANGE_COLOR)
            {
               _loc6_ = parseInt(_loc3_.commandArray[2],10);
               this._gemIdToReplayDataMap[_loc6_] = _loc3_;
            }
            _loc2_++;
         }
      }
      
      private function ApplyPendingChangesToGemBeforeDeathForReplay(param1:Gem) : Boolean
      {
         var _loc3_:ReplayData = null;
         var _loc2_:Boolean = false;
         if(this.mIsReplay && param1 != null)
         {
            _loc3_ = this._gemIdToReplayDataMap[param1.id];
            if(_loc3_ != null)
            {
               this.DoMoveCommand(_loc3_);
               _loc2_ = true;
            }
         }
         return _loc2_;
      }
      
      private function updateFalling(param1:Number) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         var _loc9_:Gem = null;
         var _loc2_:Number = this.config.blitzLogicGravity * param1;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         this.gemsHit = false;
         var _loc5_:int = 0;
         while(_loc5_ < Board.WIDTH)
         {
            _loc6_ = Board.HEIGHT;
            _loc7_ = 0;
            _loc8_ = Board.HEIGHT - 1;
            while(_loc8_ >= 0)
            {
               if((_loc9_ = this.board.GetGemAt(_loc8_,_loc5_)) != null)
               {
                  if(_loc9_.isSwapping || _loc9_.IsMatched() && !_loc9_.isImmune)
                  {
                     _loc6_ = _loc9_.row;
                  }
                  else
                  {
                     _loc9_.isFalling = true;
                     _loc9_.y += _loc9_.fallVelocity;
                     if(_loc9_.y >= _loc9_.row)
                     {
                        _loc9_.y = _loc9_.row;
                        if(_loc9_.fallVelocity >= this.config.blitzLogicMinVeloToHit)
                        {
                           _loc3_++;
                        }
                        _loc9_.fallVelocity = 0;
                        _loc9_.isFalling = false;
                     }
                     else if(_loc9_.y >= _loc6_ - 1)
                     {
                        _loc9_.y = _loc6_ - 1;
                        _loc9_.fallVelocity = _loc7_;
                     }
                     else
                     {
                        _loc9_.fallVelocity += _loc2_;
                        _loc4_ = true;
                     }
                     _loc6_ = _loc9_.y;
                     _loc7_ = _loc9_.fallVelocity;
                  }
               }
               _loc8_--;
            }
            _loc5_++;
         }
         if(_loc3_ > 0 && Math.abs(this._lastHitTick - this.frameID) > 8)
         {
            this._lastHitTick = this.frameID;
            this.gemsHit = true;
         }
         if(!_loc4_)
         {
            this._initialGemsFallen = true;
         }
      }
      
      private function UpdateLastHurrah() : void
      {
         this.lastHurrahLogic.Update();
      }
      
      public function IsMoveLegal(param1:Gem, param2:int, param3:int) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         if(!param1.isStill())
         {
            return false;
         }
         var _loc4_:Gem;
         if((_loc4_ = this.board.GetGemAt(param2,param3)) == null || !_loc4_.isStill())
         {
            return false;
         }
         if(param2 < Board.TOP || param2 > Board.BOTTOM || param3 < Board.LEFT || param3 > Board.RIGHT)
         {
            return false;
         }
         var _loc5_:int = param3 - param1.col;
         var _loc6_:int = param2 - param1.row;
         if(Math.abs(_loc5_) + Math.abs(_loc6_) != 1)
         {
            return false;
         }
         if(!param1.movePolicy.IsSwapAllowed(_loc5_,_loc6_) || !_loc4_.movePolicy.IsSwapAllowed(_loc5_ * -1,_loc6_ * -1))
         {
            return false;
         }
         return true;
      }
      
      private function DoMoveCommand(param1:ReplayData) : void
      {
         var _loc5_:BoostV2 = null;
         var _loc6_:Gem = null;
         var _loc7_:MoveData = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:Array = null;
         var _loc2_:Vector.<String> = param1.commandArray;
         var _loc3_:int = parseInt(_loc2_[0],10);
         var _loc4_:uint = this._pendingCommandQueue.length;
         if(_loc3_ >= 0)
         {
            if(_loc3_ == ReplayCommands.COMMAND_DETONATE)
            {
               this.CancelSwaps();
               this.DoDetonateOnBoard(parseInt(_loc2_[2],10),parseInt(_loc2_[3],10));
               return;
            }
            if(_loc3_ == ReplayCommands.COMMAND_BOOST_ACTIVATED)
            {
               if(this.boostLogicV2.mBoostMap[_loc2_[2]] != undefined)
               {
                  (_loc5_ = this.boostLogicV2.mBoostMap[_loc2_[2]]).performActions(_loc2_[3]);
               }
            }
            else if(_loc3_ == ReplayCommands.COMMAND_SHOW_CHARACTER)
            {
               this._replayHandler.ShowCharacterForReplay();
            }
            else if(_loc3_ == ReplayCommands.COMMAND_ADD_EXTRA_TIME)
            {
               if(0 != this.timerLogic.GetTimeRemaining())
               {
                  this.timerLogic.AddExtraTimeDuringGame(parseInt(_loc2_[2],10));
               }
            }
            else if(_loc3_ == ReplayCommands.COMMAND_SHOW_PATTERN_ON_BOARD)
            {
               this.boostLogicV2.DispatchBoardCellsActivate(_loc2_[2],parseInt(_loc2_[3]),parseInt(_loc2_[4]),parseInt(_loc2_[5]),parseInt(_loc2_[6]),parseInt(_loc2_[7]));
            }
            else
            {
               _loc6_ = this.board.GetGem(parseInt(_loc2_[2],10));
               if(_loc3_ == ReplayCommands.COMMAND_SWAP)
               {
                  (_loc7_ = this.movePool.GetMove()).sourceGem = _loc6_;
                  this.AddMove(_loc7_);
                  _loc7_.swapGem = this.board.GetGem(parseInt(_loc2_[3],10));
                  if(_loc7_.swapGem != null && _loc7_.sourcePos != null && _loc6_ != null)
                  {
                     _loc7_.sourcePos.x = _loc6_.col;
                     _loc7_.sourcePos.y = _loc6_.row;
                     _loc8_ = _loc7_.swapGem.col;
                     _loc9_ = _loc7_.swapGem.row;
                     _loc7_.isSwap = true;
                     _loc7_.swapDir.x = _loc8_ - _loc6_.col;
                     _loc7_.swapDir.y = _loc9_ - _loc6_.row;
                     _loc7_.swapPos.x = _loc8_;
                     _loc7_.swapPos.y = _loc9_;
                     this.DoSwapGem(_loc7_);
                  }
               }
               else if(_loc3_ == ReplayCommands.COMMAND_CHANGE_TYPE || _loc3_ == ReplayCommands.COMMAND_CHANGE_COLOR)
               {
                  this._pendingCommandQueue.push(param1);
               }
            }
         }
         else if(_loc3_ == ReplayCommands.COMMAND_SEED)
         {
            _loc10_ = parseInt(_loc2_[1]);
            if(_loc2_.length > 2)
            {
               _loc11_ = _loc2_[2].split(",");
               this.config.gemColors = Vector.<int>(_loc11_);
            }
            this.Reset(_loc10_);
         }
         else if(_loc3_ == ReplayCommands.COMMAND_ENCORE)
         {
            if(this.mIsReplay)
            {
               this._replayHandler.SetEncoreForReplay(_loc2_[1],_loc2_[2] == "1");
               this.mBlockReplay = true;
            }
         }
         else if(_loc3_ == ReplayCommands.COMMAND_ADD_RG_TOKEN || _loc3_ == ReplayCommands.COMMAND_ADD_MULTIPLIER_TOKEN || _loc3_ == ReplayCommands.COMMAND_ADD_COIN_TOKEN)
         {
            this._pendingCommandQueue.push(param1);
         }
         else if(_loc3_ == ReplayCommands.COMMAND_ADD_AWARD_EXTRA_TIME)
         {
            this.timerLogic.AddExtraTimeDuringGame(parseInt(_loc2_[1],10));
         }
         if(_loc4_ < this._pendingCommandQueue.length)
         {
            this.ExecutePendingCommands();
         }
      }
      
      private function DoSwapGem(param1:MoveData) : void
      {
         if(!this.IsMoveLegal(param1.sourceGem,param1.swapPos.y,param1.swapPos.x))
         {
            return;
         }
         var _loc2_:Gem = param1.sourceGem;
         var _loc3_:Gem = param1.swapGem;
         _loc2_.SetSelected(false);
         if(_loc3_.isSwapping || _loc2_.isSwapping)
         {
            return;
         }
         var _loc4_:int = Gem.COLOR_NONE;
         var _loc5_:Gem = null;
         if(_loc2_.type == Gem.TYPE_HYPERCUBE && _loc3_.type == Gem.TYPE_HYPERCUBE)
         {
            this.hypercubeLogic.doubleHypercubeMatch();
         }
         if(_loc2_.type == Gem.TYPE_HYPERCUBE && (_loc3_.type == Gem.TYPE_HYPERCUBE || _loc3_.type == Gem.TYPE_PHOENIXPRISM))
         {
            _loc5_ = _loc2_;
            _loc2_.color = Gem.COLOR_NONE;
            _loc4_ = Gem.COLOR_NONE;
         }
         else if(_loc3_.type == Gem.TYPE_HYPERCUBE && _loc2_.type == Gem.TYPE_PHOENIXPRISM)
         {
            _loc5_ = _loc3_;
            _loc2_.color = Gem.COLOR_NONE;
            _loc4_ = Gem.COLOR_NONE;
         }
         else if(_loc2_.type == Gem.TYPE_HYPERCUBE && _loc3_.type != Gem.TYPE_SCRAMBLE && _loc3_.type != Gem.TYPE_DETONATE)
         {
            _loc5_ = _loc2_;
            _loc4_ = _loc3_.color;
         }
         else if(_loc3_.type == Gem.TYPE_HYPERCUBE && _loc2_.type != Gem.TYPE_SCRAMBLE && _loc2_.type != Gem.TYPE_DETONATE)
         {
            _loc5_ = _loc3_;
            _loc4_ = _loc2_.color;
         }
         _loc2_.moveID = param1.id;
         _loc3_.moveID = param1.id;
         if(_loc5_ != null)
         {
            param1.isSuccessful = true;
            _loc5_.color = _loc4_;
            _loc5_.shatterColor = _loc4_;
            _loc5_.SetShattering(true);
            return;
         }
         _loc2_.isSwapping = true;
         _loc3_.isSwapping = true;
         this.startedMove = true;
         var _loc6_:SwapData = this.swapDataPool.GetNextSwapData(param1,this._gameSpeed);
         this.swaps.push(_loc6_);
         this.DispatchSwapBegin(_loc6_);
      }
      
      public function QueueSwap(param1:Gem, param2:int, param3:int) : Boolean
      {
         if(this.mIsReplay)
         {
            return false;
         }
         if(this.timerLogic.GetTimeRemaining() <= 0)
         {
            return true;
         }
         if(this.mBlockingEvents.length > 0 || this.mTimeBlockingEvents.length > 0)
         {
            return false;
         }
         if(!this.IsMoveLegal(param1,param2,param3))
         {
            return false;
         }
         var _loc4_:Gem = this.board.GetGemAt(param2,param3);
         var _loc5_:ReplayData;
         (_loc5_ = this.replayDataPool.GetNextReplayData()).commandArray.push(param1.id.toString());
         _loc5_.commandArray.push(_loc4_.id.toString());
         this.QueueCommand(ReplayCommands.COMMAND_SWAP,_loc5_,ReplayCommands.COMMAND_PLAY_AND_REPLAY);
         return true;
      }
      
      public function bumpColumns(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         var _loc8_:Gem = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Boolean = false;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc4_:int = 0;
         while(_loc4_ < Board.WIDTH)
         {
            _loc5_ = 0;
            _loc6_ = 0;
            _loc7_ = 7;
            for(; _loc7_ >= -1; _loc7_--)
            {
               _loc8_ = this.board.GetGemAt(_loc7_,_loc4_);
               _loc9_ = 0;
               _loc10_ = 0;
               _loc11_ = false;
               if(_loc8_ != null && _loc8_.y < param2)
               {
                  _loc9_ = _loc8_.x - param1;
                  _loc10_ = _loc8_.y - param2;
                  _loc11_ = true;
               }
               else
               {
                  if(_loc7_ != -1)
                  {
                     continue;
                  }
                  _loc9_ = _loc4_ - param1;
                  _loc10_ = _loc7_ - param2;
               }
               _loc12_ = Math.atan2(_loc10_,_loc9_);
               _loc13_ = Math.sqrt(_loc9_ * _loc9_ + _loc10_ * _loc10_);
               _loc14_ = 1;
               _loc15_ = 1;
               _loc16_ = -5 / 128;
               _loc6_ = (_loc17_ = param3 / (Math.max(0,_loc13_ - _loc14_) + _loc15_) * Math.abs(Math.sin(_loc12_))) * _loc16_;
               if(_loc11_)
               {
                  if(_loc5_ == 0)
                  {
                     _loc5_ = _loc6_;
                  }
                  if(_loc8_ != null)
                  {
                     _loc8_.fallVelocity = Math.min(_loc8_.fallVelocity,_loc5_);
                  }
               }
            }
            _loc4_++;
         }
      }
      
      private function clearBumps() : void
      {
         var _loc4_:Gem = null;
         var _loc1_:Vector.<Gem> = this.board.mGems;
         var _loc2_:int = _loc1_.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if((_loc4_ = _loc1_[_loc3_]) != null)
            {
               if(_loc4_.fallVelocity < 0)
               {
                  _loc4_.fallVelocity = 0;
               }
            }
            _loc3_++;
         }
      }
      
      public function AddMove(param1:MoveData) : void
      {
         param1.id = this.moves.length;
         this.moves.push(param1);
      }
      
      private function HandleMatchedGems() : void
      {
         var _loc4_:Gem = null;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc1_:Vector.<Gem> = this.board.mGems;
         var _loc2_:int = this.board.mGems.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if((_loc4_ = _loc1_[_loc3_]) != null && _loc4_.IsMatching())
            {
               _loc5_ = 0;
               for(_loc6_ in _loc4_.rgTokens)
               {
                  _loc5_++;
               }
               if(_loc5_ > 0)
               {
                  this.DispatchSpecialGemBlast(_loc4_);
               }
            }
            if(!(_loc4_ == null || !_loc4_.IsMatching()))
            {
               if(this.ApplyPendingChangesToGemBeforeDeathForReplay(_loc4_))
               {
                  _loc4_.SetMatching(true);
               }
               this.changeColorLogic.HandleMatchedGem(_loc4_);
               this.phoenixPrismLogic.HandleMatchedGem(_loc4_);
               this.starGemLogic.HandleMatchedGem(_loc4_);
               this.flameGemLogic.HandleMatchedGem(_loc4_);
               this.hypercubeLogic.HandleMatchedGem(_loc4_);
               this.multiLogic.HandleMatchedGem(_loc4_);
               this.rareGemTokenLogic.HandleMatchedGem(_loc4_);
            }
            _loc3_++;
         }
      }
      
      private function HandleShatteredGems() : void
      {
         var _loc4_:Gem = null;
         var _loc1_:Vector.<Gem> = this.board.mGems;
         var _loc2_:int = this.board.mGems.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(!((_loc4_ = _loc1_[_loc3_]) == null || !_loc4_.IsShattering()))
            {
               if(this.ApplyPendingChangesToGemBeforeDeathForReplay(_loc4_))
               {
                  _loc4_.SetShattering(true);
               }
               this.changeColorLogic.HandleShatteredGem(_loc4_);
               this.phoenixPrismLogic.HandleShatteredGem(_loc4_);
               this.starGemLogic.HandleShatteredGem(_loc4_);
               this.flameGemLogic.HandleShatteredGem(_loc4_);
               this.hypercubeLogic.HandleShatteredGem(_loc4_);
               this.multiLogic.HandleShatteredGem(_loc4_);
               this.rareGemTokenLogic.HandleShatteredGem(_loc4_);
            }
            _loc3_++;
         }
      }
      
      private function HandleDetonatedGems() : void
      {
         var _loc4_:Gem = null;
         var _loc1_:Vector.<Gem> = this.board.mGems;
         var _loc2_:int = this.board.mGems.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if((_loc4_ = _loc1_[_loc3_]) != null && (_loc4_.isBenignDestroy || _loc4_.IsDetonating()))
            {
               if(_loc4_.type == Gem.TYPE_FLAME || _loc4_.type == Gem.TYPE_STAR || _loc4_.type == Gem.TYPE_HYPERCUBE || _loc4_.type == Gem.TYPE_PHOENIXPRISM)
               {
                  this.DispatchSpecialGemBlast(_loc4_);
               }
               _loc4_.isBenignDestroy = false;
            }
            if(!(_loc4_ == null || !_loc4_.IsDetonating()))
            {
               if(this.ApplyPendingChangesToGemBeforeDeathForReplay(_loc4_))
               {
                  _loc4_.SetDetonating(true);
               }
               this.changeColorLogic.HandleDetonatedGem(_loc4_);
               this.phoenixPrismLogic.HandleDetonatedGem(_loc4_);
               this.starGemLogic.HandleDetonatedGem(_loc4_);
               this.flameGemLogic.HandleDetonatedGem(_loc4_);
               this.hypercubeLogic.HandleDetonatedGem(_loc4_);
               this.multiLogic.HandleDetonatedGem(_loc4_);
               this.rareGemTokenLogic.HandleDetonatedGem(_loc4_);
               _loc4_.Flush();
            }
            _loc3_++;
         }
      }
      
      private function HandleGems() : void
      {
         var _loc4_:Gem = null;
         var _loc1_:Vector.<Gem> = this.board.mGems;
         var _loc2_:int = this.board.mGems.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if((_loc4_ = _loc1_[_loc3_]) != null)
            {
               this.multiLogic.HandleGem(_loc4_);
            }
            _loc3_++;
         }
      }
      
      public function ChangeRandomGemTypes(param1:String, param2:int, param3:String, param4:String, param5:Number, param6:int, param7:int) : Vector.<ActionQueue>
      {
         var _loc21_:Gem = null;
         var _loc22_:Gem = null;
         var _loc8_:Vector.<ActionQueue> = new Vector.<ActionQueue>();
         if(param2 < 0 || param2 > this.grid.getNumGems())
         {
            return _loc8_;
         }
         var _loc9_:Dictionary = new Dictionary();
         var _loc10_:Dictionary = new Dictionary();
         var _loc11_:int = this.GetRNGOfType(param6).Int(0,90);
         var _loc12_:int = 0;
         if(_loc11_ < 30)
         {
            _loc12_ = Gem.TYPE_FLAME;
         }
         else if(_loc11_ < 60)
         {
            _loc12_ = Gem.TYPE_HYPERCUBE;
         }
         else
         {
            _loc12_ = Gem.TYPE_STAR;
         }
         _loc9_["NormalGems"] = Gem.TYPE_STANDARD;
         _loc9_["SpecialGems"] = _loc12_;
         _loc9_["MultiplierGem"] = Gem.TYPE_MULTI;
         _loc9_["FlameGem"] = Gem.TYPE_FLAME;
         _loc9_["HypercubeGem"] = Gem.TYPE_HYPERCUBE;
         _loc9_["StarGem"] = Gem.TYPE_STAR;
         _loc9_["PhoenixPrismGem"] = Gem.TYPE_PHOENIXPRISM;
         _loc9_["SelectedRareGem"] = !!this.rareGemsLogic.hasCurrentRareGem() ? 1 : 0;
         _loc10_["LastMatchedGemColor"] = this.mLastMatchedGemColor;
         _loc10_["White"] = Gem.COLOR_WHITE;
         _loc10_["Orange"] = Gem.COLOR_ORANGE;
         _loc10_["Red"] = Gem.COLOR_RED;
         _loc10_["Green"] = Gem.COLOR_GREEN;
         _loc10_["Blue"] = Gem.COLOR_BLUE;
         _loc10_["Purple"] = Gem.COLOR_PURPLE;
         _loc10_["Yellow"] = Gem.COLOR_YELLOW;
         var _loc13_:Boolean = false;
         var _loc14_:Boolean = false;
         var _loc15_:int = -1;
         var _loc16_:int = Gem.COLOR_ANY;
         var _loc17_:int = -1;
         var _loc18_:int = -1;
         if(param1 in _loc9_ || param1 in _loc10_)
         {
            _loc13_ = true;
            if(param1 in _loc9_)
            {
               _loc15_ = _loc9_[param1];
            }
            if(param1 in _loc10_)
            {
               _loc16_ = _loc10_[param1];
            }
         }
         if(param3 in _loc9_ || param3 in _loc10_)
         {
            _loc14_ = true;
            if(param3 in _loc9_)
            {
               _loc17_ = _loc9_[param3];
            }
            if(param3 in _loc10_)
            {
               _loc18_ = _loc10_[param3];
            }
         }
         if(!_loc13_ || !_loc14_)
         {
            return _loc8_;
         }
         if(_loc17_ == Gem.TYPE_MULTI)
         {
            if(!this.mMaxMultiplierThresholdSet)
            {
               this.multiLogic.remaining = this.config.multiplierGemLogicThresholdMaxMultiplier;
               this.mMaxMultiplierThresholdSet = true;
            }
         }
         var _loc19_:Vector.<Gem> = new Vector.<Gem>();
         var _loc20_:Vector.<Gem> = new Vector.<Gem>();
         if(param3 == "SelectedRareGem" && param7 != -1 && !this.rareGemsLogic.currentRareGem.isTokenRareGem())
         {
            _loc20_ = this.board.GetRandomGemOfTypeAndColor(_loc15_,param7,param6,-1,_loc18_);
            _loc18_ = param7;
         }
         param2 -= _loc20_.length;
         if(param2 > 0)
         {
            _loc19_ = this.board.GetRandomGemOfTypeAndColor(_loc15_,_loc16_,param6,param2,_loc18_,_loc17_ == Gem.TYPE_MULTI);
         }
         for each(_loc21_ in _loc20_)
         {
            _loc19_.push(_loc21_);
         }
         for each(_loc22_ in _loc19_)
         {
            if(param3 in _loc9_)
            {
               if(param3 == "SelectedRareGem")
               {
                  if(this.rareGemsLogic.currentRareGem.isTokenRareGem())
                  {
                     _loc8_.push(new ActionQueue(_loc22_,ActionQueue.QUEUE_SPAWN_TOKEN_GEM,-1,-1));
                  }
                  else if(param7 != -1)
                  {
                     _loc8_.push(new ActionQueue(_loc22_,ActionQueue.QUEUE_CHANGE_TYPE,Gem.TYPE_FLAME,param7));
                  }
               }
               else
               {
                  _loc8_.push(new ActionQueue(_loc22_,ActionQueue.QUEUE_CHANGE_TYPE,_loc17_,-1));
               }
            }
            else if(param3 in _loc10_)
            {
               _loc8_.push(new ActionQueue(_loc22_,ActionQueue.QUEUE_CHANGE_COLOR,_loc18_,-1));
            }
         }
         return _loc8_;
      }
      
      public function ScrambleBoard(param1:String) : void
      {
         if(!this._initialGemsFallen)
         {
            return;
         }
         this.CancelSwaps();
         this.AddBlockingEvent(this.scrambleEventPool.GetNextScrambleEvent());
         var _loc2_:Vector.<Gem> = new Vector.<Gem>();
         this.boostLogicV2.DispatchBoostFeedback(param1,_loc2_);
      }
      
      public function GetSpecialGems() : Vector.<ActionQueue>
      {
         var _loc5_:Gem = null;
         var _loc1_:Vector.<ActionQueue> = new Vector.<ActionQueue>();
         _loc1_.push(new ActionQueue(null,ActionQueue.SHOW_UNSCRAMBLE_FEEDBACK,2,0));
         var _loc2_:Vector.<Gem> = this.board.mGems;
         var _loc3_:Vector.<Gem> = new Vector.<Gem>();
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            if((_loc5_ = _loc2_[_loc4_]) != null)
            {
               if(_loc5_.type != Gem.TYPE_MULTI && _loc5_.type != Gem.TYPE_STANDARD)
               {
                  _loc3_.push(_loc5_);
               }
            }
            _loc4_++;
         }
         for each(_loc5_ in _loc3_)
         {
            _loc1_.push(new ActionQueue(_loc5_,ActionQueue.SHOW_UNSCRAMBLE_FEEDBACK,Gem.COLOR_WHITE,0));
         }
         return _loc1_;
      }
      
      public function UnScrambleBoard(param1:String) : void
      {
         if(!this._initialGemsFallen)
         {
            return;
         }
         this.CancelSwaps();
         this.isMatchingEnabled = false;
         this.SpawnPhase(true,false);
         this.AddBlockingEvent(this.unScrambleEventPool.GetNextUnScrambleEvent(param1));
      }
      
      public function IncrementBlazingSpeedBonus(param1:int, param2:Boolean) : void
      {
         this.speedBonus.IncrementBonus(param1,param2);
      }
      
      public function SetMultiplierBonus(param1:int) : void
      {
         this.mMultiplierBonusValue = param1;
      }
      
      public function GetMultiplierBonus() : int
      {
         return this.mMultiplierBonusValue;
      }
      
      public function SetScoreBonus(param1:int) : void
      {
         this.mScoreBonusValue = param1;
      }
      
      public function GetScoreBonus() : int
      {
         return int(!!this.GetAllowScoreBonus() ? int(this.mScoreBonusValue) : 0);
      }
      
      public function GetAllowScoreBonus() : Boolean
      {
         return this.mAllowScoreBonus;
      }
      
      public function SetAllowScoreBonus(param1:Boolean) : void
      {
         this.mAllowScoreBonus = param1;
      }
      
      public function GetScoreBonusDuringGame() : int
      {
         return this.mScoreBonusValueDuringGame;
      }
      
      public function IncreaseScoreBonusDuringGame(param1:int) : void
      {
         this.mScoreBonusValueDuringGame += param1;
      }
      
      public function DecreaseScoreBonusDuringGame(param1:int) : void
      {
         this.mScoreBonusValueDuringGame -= param1;
         if(this.mScoreBonusValueDuringGame < 0)
         {
            this.mScoreBonusValueDuringGame = 0;
         }
      }
      
      public function GetLastMatchedGemColor() : int
      {
         return this.mLastMatchedGemColor;
      }
      
      public function GetNumRareGemDestroyed() : int
      {
         var _loc1_:int = 0;
         if(!this.rareGemsLogic.currentRareGem || this.rareGemsLogic.currentRareGem.isTokenRareGem())
         {
            _loc1_ = this.rareGemTokenLogic.getTotalTokensCollected();
         }
         else
         {
            _loc1_ = this.flameGemLogic.GetNumRareGemDestroyed();
         }
         return _loc1_;
      }
      
      public function DoDispatchGameLoad() : void
      {
         this.DispatchGameLoad();
      }
      
      public function DoDispatchGameBegin() : void
      {
         this.DispatchGameBegin();
      }
      
      public function IsMaxMultiplierThresholdSet() : Boolean
      {
         return this.mMaxMultiplierThresholdSet;
      }
      
      public function SetReplayHandler(param1:IBlitzReplayHandler) : void
      {
         this._replayHandler = param1;
      }
      
      public function GetRNGOfType(param1:int) : BlitzRandom
      {
         return this._rngManager.GetRNGOfType(param1);
      }
      
      private function ShouldBreakCommandQueueAdditions(param1:int) : Boolean
      {
         var _loc2_:Boolean = false;
         if(param1 == ReplayCommands.COMMAND_ENCORE)
         {
            _loc2_ = true;
         }
         else if(this.timerLogic.GetTimeRemaining() <= 1)
         {
            _loc2_ = false;
         }
         else
         {
            _loc2_ = param1 == ReplayCommands.COMMAND_SWAP || param1 == ReplayCommands.COMMAND_DETONATE || param1 == ReplayCommands.COMMAND_BOOST_ACTIVATED;
         }
         return _loc2_;
      }
      
      private function GetAdjustedTimeForCommand() : int
      {
         return this.timerLogic.GetTimeRemaining() + 1;
      }
      
      private function DebugReadableTimeIndependentCommand(param1:int) : String
      {
         switch(param1)
         {
            case ReplayCommands.COMMAND_SEED:
               return "COMMAND_SEED";
            case ReplayCommands.COMMAND_BOOST:
               return "COMMAND_BOOST";
            case ReplayCommands.COMMAND_RAREGEM:
               return "COMMAND_RAREGEM";
            case ReplayCommands.COMMAND_ENCORE:
               return "COMMAND_ENCORE";
            case ReplayCommands.COMMAND_ADD_RG_TOKEN:
               return "COMMAND_ADD_RG_TOKEN";
            case ReplayCommands.COMMAND_ADD_MULTIPLIER_TOKEN:
               return "COMMAND_ADD_MULTIPLIER_TOKEN";
            case ReplayCommands.COMMAND_ADD_COIN_TOKEN:
               return "COMMAND_ADD_COIN_TOKEN";
            case ReplayCommands.COMMAND_ADD_AWARD_EXTRA_TIME:
               return "COMMAND_ADD_AWARD_EXTRA_TIME";
            default:
               return "";
         }
      }
      
      private function DebugReadableTimeDependentCommand(param1:int) : String
      {
         switch(param1)
         {
            case ReplayCommands.COMMAND_CHANGE_TYPE:
               return "COMMAND_CHANGE_TYPE";
            case ReplayCommands.COMMAND_CHANGE_COLOR:
               return "COMMAND_CHANGE_COLOR";
            case ReplayCommands.COMMAND_DETONATE:
               return "COMMAND_DETONATE";
            case ReplayCommands.COMMAND_SHOW_CHARACTER:
               return "COMMAND_SHOW_CHARACTER";
            case ReplayCommands.COMMAND_ADD_EXTRA_TIME:
               return "COMMAND_ADD_EXTRA_TIME";
            case ReplayCommands.COMMAND_SWAP:
               return "COMMAND_SWAP";
            case ReplayCommands.COMMAND_BOOST_ACTIVATED:
               return "COMMAND_BOOST_ACTIVATED";
            default:
               return "";
         }
      }
   }
}
