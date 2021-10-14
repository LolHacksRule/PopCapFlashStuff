package com.popcap.flash.bejeweledblitz.logic.raregems
{
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.MatchSet;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicSpawnHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ITimerLogicTimePhaseEndHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import com.popcap.flash.bejeweledblitz.logic.gems.phoenixprism.PhoenixPrismHurrahExplodeEvent;
   
   public class PhoenixPrismRGLogic extends RGLogic implements IBlitzLogicHandler, IBlitzLogicSpawnHandler, ITimerLogicTimePhaseEndHandler
   {
      
      public static const ID:String = "phoenixPrism";
      
      private static const _STATE_INACTIVE:int = 0;
      
      private static const _STATE_ARMED:int = 1;
      
      private static const _STATE_HURRAH:int = 2;
      
      private static const _STATE_PRESTIGE:int = 3;
      
      private static const _STATE_COMPLETE:int = 4;
       
      
      private var _numSpawned:int;
      
      private var _shouldSpawn:Boolean;
      
      private var _nextSpawnTime:int;
      
      private var _pointAwardTimer:int;
      
      private var _showPointAwardTimer:int;
      
      private var _overrideColors:Vector.<int>;
      
      private var _tmpMatchSets:Vector.<MatchSet>;
      
      private var _tmpShuffledGems:Vector.<Gem>;
      
      private var _phoenixHandlers:Vector.<IPhoenixPrismRGLogicHandler>;
      
      private var _state:int;
      
      public function PhoenixPrismRGLogic(param1:BlitzLogic)
      {
         super();
         setDefaults(param1,ID);
         this._pointAwardTimer = -1;
         this._showPointAwardTimer = -1;
         this._state = _STATE_INACTIVE;
         this._overrideColors = new Vector.<int>(Board.NUM_GEMS);
         var _loc2_:int = 0;
         while(_loc2_ < Board.NUM_GEMS)
         {
            this._overrideColors[_loc2_] = Gem.COLOR_NONE;
            _loc2_++;
         }
         this._tmpMatchSets = new Vector.<MatchSet>();
         this._tmpShuffledGems = new Vector.<Gem>();
         this._phoenixHandlers = new Vector.<IPhoenixPrismRGLogicHandler>();
         this.reset();
      }
      
      public function SetShouldSpawn() : void
      {
         this._shouldSpawn = true;
         this._nextSpawnTime = _logic.timerLogic.GetTimeElapsed() + (_logic.config.phoenixPrismRGLogicMinSpawnDelay + _logic.GetPrimaryRNG().Next() * (_logic.config.phoenixPrismRGLogicMaxSpawnDelay - _logic.config.phoenixPrismRGLogicMinSpawnDelay));
      }
      
      public function AddHandler(param1:IPhoenixPrismRGLogicHandler) : void
      {
         this._phoenixHandlers.push(param1);
      }
      
      public function RemoveHandler(param1:IPhoenixPrismRGLogicHandler) : void
      {
         var _loc2_:int = this._phoenixHandlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._phoenixHandlers.splice(_loc2_,1);
      }
      
      override public function init() : void
      {
         _logic.lastHurrahLogic.AddHandler(this);
         _logic.timerLogic.AddTimePhaseEndHandler(this);
         _logic.AddSpawnHandler(this);
         _logic.AddHandler(this);
      }
      
      override public function reset() : void
      {
         this._state = _STATE_INACTIVE;
         this._numSpawned = 0;
         this._shouldSpawn = true;
         this._nextSpawnTime = 0;
         this._pointAwardTimer = -1;
         this._showPointAwardTimer = -1;
         this._tmpShuffledGems.length = 0;
      }
      
      override public function OnStartGame() : void
      {
         this._state = _STATE_ARMED;
      }
      
      override public function handleLastHurrahBegin() : void
      {
         var _loc1_:PhoenixPrismHurrahExplodeEvent = null;
         if(this._state == _STATE_ARMED)
         {
            this._state = _STATE_HURRAH;
            this.DispatchPointPrestigeInit();
            _logic.lastHurrahLogic.StartLastHurrah();
            _loc1_ = _logic.phoenixPrismLogic.hurrahExplodeEventPool.GetNextPhoenixPrismHurrahExplodeEvent();
            _logic.AddBlockingEvent(_loc1_);
            this.DispatchPhoenixPrismHurrahExploded(_loc1_);
         }
      }
      
      override public function handlePreCoinHurrah() : void
      {
         if(this._state == _STATE_HURRAH)
         {
            if(_logic.IsDailyChallengeGame())
            {
               this._state = _STATE_COMPLETE;
               return;
            }
            this._state = _STATE_PRESTIGE;
            this._pointAwardTimer = _logic.config.phoenixPrismRGLogicPointAwardDelay;
            this.DispatchPointPrestigeBegin();
         }
      }
      
      override public function canBeginCoinHurrah() : Boolean
      {
         return this._state == _STATE_INACTIVE || this._state == _STATE_COMPLETE;
      }
      
      public function HandleTimePhaseEnd() : void
      {
         if(this._state != _STATE_PRESTIGE)
         {
            return;
         }
         --this._pointAwardTimer;
         if(this._pointAwardTimer == 0)
         {
            this.DispatchPointsAwarded(_logic.config.phoenixPrismRGLogicBaseBonusPoints,_logic.multiLogic.multiplier);
            this._showPointAwardTimer = _logic.config.phoenixPrismRGLogicShowPointAwardDelay;
         }
         --this._showPointAwardTimer;
         if(this._showPointAwardTimer == 0)
         {
            _logic.GetScoreKeeper().AddPoints(_logic.config.phoenixPrismRGLogicBaseBonusPoints * _logic.multiLogic.multiplier,null);
         }
         if(this._state == _STATE_PRESTIGE && this.AllowPointPrestigeComplete())
         {
            this.DispatchPointPrestigeComplete();
            this._state = _STATE_COMPLETE;
         }
      }
      
      override public function HandleGameTimeChange(param1:int) : void
      {
      }
      
      public function HandleGameLoad() : void
      {
      }
      
      public function HandleGameBegin() : void
      {
      }
      
      public function HandleGameEnd() : void
      {
         this.reset();
      }
      
      public function HandleGameAbort() : void
      {
         this.reset();
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
      
      public function HandleBlockingEvent() : void
      {
      }
      
      public function HandleLogicSpawnPhaseBegin() : void
      {
      }
      
      public function HandleLogicSpawnPhaseEnd() : void
      {
         if(_logic.rareGemsLogic.currentRareGem != this)
         {
            return;
         }
         if(this.ShouldSpawn())
         {
            this.SpawnNewPhoenixPrism();
         }
      }
      
      public function HandlePostLogicSpawnPhase() : void
      {
      }
      
      private function DispatchPhoenixPrismHurrahExploded(param1:PhoenixPrismHurrahExplodeEvent) : void
      {
         var _loc2_:IPhoenixPrismRGLogicHandler = null;
         for each(_loc2_ in this._phoenixHandlers)
         {
            _loc2_.HandlePhoenixPrismHurrahExploded(param1);
         }
      }
      
      private function DispatchPointPrestigeInit() : void
      {
         var _loc1_:IPhoenixPrismRGLogicHandler = null;
         for each(_loc1_ in this._phoenixHandlers)
         {
            _loc1_.HandlePhoenixPrismPrestigeInit();
         }
      }
      
      private function DispatchPointPrestigeBegin() : void
      {
         var _loc1_:IPhoenixPrismRGLogicHandler = null;
         for each(_loc1_ in this._phoenixHandlers)
         {
            _loc1_.HandlePhoenixPrismPrestigeBegin();
         }
      }
      
      private function DispatchPointPrestigeComplete() : void
      {
         var _loc1_:IPhoenixPrismRGLogicHandler = null;
         for each(_loc1_ in this._phoenixHandlers)
         {
            _loc1_.HandlePhoenixPrismPrestigeComplete();
         }
      }
      
      private function AllowPointPrestigeComplete() : Boolean
      {
         var _loc2_:IPhoenixPrismRGLogicHandler = null;
         var _loc1_:Boolean = true;
         for each(_loc2_ in this._phoenixHandlers)
         {
            _loc1_ = _loc1_ && _loc2_.AllowPhoenixPrismPrestigeComplete();
         }
         return _loc1_;
      }
      
      private function DispatchPointsAwarded(param1:int, param2:int) : void
      {
         var _loc3_:IPhoenixPrismRGLogicHandler = null;
         for each(_loc3_ in this._phoenixHandlers)
         {
            _loc3_.HandlePhoenixPrismPointsAwarded(param1,param2);
         }
      }
      
      private function ShouldSpawn() : Boolean
      {
         return this._shouldSpawn && this._numSpawned < _logic.config.phoenixPrismRGLogicMaxSpawned && (_logic.timerLogic.GetTimeElapsed() >= this._nextSpawnTime || this._state == _STATE_HURRAH);
      }
      
      private function SpawnNewPhoenixPrism() : void
      {
         this.ShuffleGems(_logic.board.freshGems,this._tmpShuffledGems);
         var _loc1_:Gem = this.GetUpgradeLocation(this._tmpShuffledGems);
         if(_loc1_ == null)
         {
            return;
         }
         _logic.phoenixPrismLogic.UpgradeGem(_loc1_,null,true);
         ++this._numSpawned;
         this._shouldSpawn = false;
      }
      
      private function ShuffleGems(param1:Vector.<Gem>, param2:Vector.<Gem>) : void
      {
         var _loc3_:Gem = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Gem = null;
         param2.length = 0;
         for each(_loc3_ in param1)
         {
            if(_loc3_.col != 0 && _loc3_.col != 7 && _loc3_.row != 7 && _loc3_.type == Gem.TYPE_STANDARD)
            {
               param2.push(_loc3_);
            }
         }
         _loc4_ = param2.length;
         _loc5_ = 0;
         while(_loc5_ < 2 * _loc4_)
         {
            _loc6_ = _logic.GetPrimaryRNG().Int(0,_loc4_);
            _loc7_ = _logic.GetPrimaryRNG().Int(0,_loc4_);
            _loc8_ = param2[_loc6_];
            param2[_loc6_] = param2[_loc7_];
            param2[_loc7_] = _loc8_;
            _loc5_++;
         }
      }
      
      private function GetUpgradeLocation(param1:Vector.<Gem>) : Gem
      {
         var _loc2_:Gem = null;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:MatchSet = null;
         var _loc6_:Gem = null;
         var _loc7_:int = 0;
         var _loc8_:* = param1;
         while(true)
         {
            for each(_loc2_ in _loc8_)
            {
               _loc3_ = _loc2_.row * Board.NUM_COLS + _loc2_.col;
               if(!(_loc3_ < 0 || _loc3_ >= Board.NUM_GEMS))
               {
                  this._overrideColors[_loc3_] = Gem.COLOR_ANY;
                  _logic.board.matchGenerator.FindMatches(_logic.board.mGems,this._overrideColors,this._tmpMatchSets);
                  this._overrideColors[_loc3_] = Gem.COLOR_NONE;
                  _loc4_ = true;
                  for each(_loc5_ in this._tmpMatchSets)
                  {
                     for each(_loc6_ in _loc5_.mGems)
                     {
                        if(_loc6_ == _loc2_)
                        {
                           _loc4_ = false;
                           break;
                        }
                     }
                     if(_loc4_)
                     {
                        break;
                     }
                  }
                  _logic.matchSetPool.FreeMatchSets(this._tmpMatchSets,true);
                  if(_loc4_)
                  {
                     break;
                  }
               }
            }
            return null;
         }
         return _loc2_;
      }
      
      public function HandleGameTimeDelayed() : void
      {
      }
   }
}
