package com.popcap.flash.bejeweledblitz.logic.raregems
{
   import com.popcap.flash.bejeweledblitz.logic.BlitzRNGManager;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.ITimerLogicTimeChangeHandler;
   import com.popcap.flash.bejeweledblitz.logic.raregems.kangaruby.KangaRubyAttackPatterns;
   import com.popcap.flash.bejeweledblitz.logic.raregems.kangaruby.KangaRubyGemExplodeEvent;
   import com.popcap.flash.bejeweledblitz.logic.raregems.kangaruby.KangaRubyGemExplodeEventPool;
   
   public class KangaRubyRGLogic extends RGLogic implements IKangaRubyRGLogic, ITimerLogicTimeChangeHandler
   {
      
      public static const INTRO_ATTACK:String = "intro_attack";
      
      public static const SMALL_ATTACK:String = "small_attack";
      
      public static const MEDIUM_ATTACK:String = "big_attack";
      
      public static const PRESTIGE_ATTACK:String = "prestige_attack";
      
      protected static const STATE_INACTIVE:int = 0;
      
      protected static const STATE_INTRO:int = 1;
      
      protected static const STATE_COOLDOWN:int = 2;
      
      protected static const STATE_WARMUP:int = 3;
      
      protected static const STATE_RUNNING:int = 4;
      
      protected static const STATE_PRESTIGE:int = 5;
      
      protected static const STATE_COMPLETE:int = 6;
      
      public static const COOLDOWN_TIMER_MIN:int = 800;
      
      public static const COOLDOWN_TIMER_VARIANCE:int = 200;
      
      public static const WARMUP_TIMER:int = 1000;
      
      public static const COINS_PER_RUBY_PAYOUT:int = 100;
      
      public static const FIXED_SHARDS_PER_RUBY_PAYOUT:uint = 1;
      
      public static const RED_GEM_TIME_REDUCTION:int = 65;
       
      
      protected var _state:int;
      
      protected var _animationPlaying:Boolean;
      
      protected var _rubyGemsDestroyedTotal:int;
      
      protected var _rubyGemsDestroyedLastPhase:int;
      
      protected var _rubyGemsDestroyedCurrentPhase:int;
      
      protected var _kangaRubyGemExplodeEvent:KangaRubyGemExplodeEvent;
      
      protected var m_Handlers:Vector.<IKangaRubyRGLogicHandler>;
      
      protected var _id:String;
      
      protected var _phaseTimer:int;
      
      protected var _endPhaseTime:int;
      
      protected var _lastCycleStartTime:int;
      
      protected var _attackCounter:int;
      
      protected var _percentageToAttack:Number;
      
      protected var m_ExplodeEventPool:KangaRubyGemExplodeEventPool;
      
      protected var _kangaRubyAttackPatterns:KangaRubyAttackPatterns;
      
      public function KangaRubyRGLogic()
      {
         super();
      }
      
      override protected function setDefaults(param1:BlitzLogic, param2:String) : void
      {
         super.setDefaults(param1,param2);
         this.m_Handlers = new Vector.<IKangaRubyRGLogicHandler>();
      }
      
      public function AddHandler(param1:IKangaRubyRGLogicHandler) : void
      {
         this.m_Handlers.push(param1);
      }
      
      public function RemoveHandler(param1:IKangaRubyRGLogicHandler) : void
      {
         var _loc2_:int = this.m_Handlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this.m_Handlers.splice(_loc2_,1);
      }
      
      public function IsKangaRubyRunning() : Boolean
      {
         return this._state == STATE_PRESTIGE || this._animationPlaying;
      }
      
      protected function countRubyKills() : void
      {
         var _loc1_:Gem = null;
         this._rubyGemsDestroyedTotal = 0;
         for each(_loc1_ in _logic.board.m_GemMap)
         {
            if(_loc1_.IsDead() && _loc1_.type != Gem.TYPE_HYPERCUBE)
            {
               if(_loc1_.color == Gem.COLOR_RED)
               {
                  ++this._rubyGemsDestroyedTotal;
               }
            }
         }
         this._rubyGemsDestroyedCurrentPhase = this._rubyGemsDestroyedTotal - this._rubyGemsDestroyedLastPhase;
      }
      
      protected function determineWhichAttack(param1:Boolean) : void
      {
      }
      
      protected function dispatchKangaRubyAnimation(param1:String, param2:int) : void
      {
         var _loc3_:IKangaRubyRGLogicHandler = null;
         for each(_loc3_ in this.m_Handlers)
         {
            _loc3_.HandleKangaRubyAnimation(param1,param2);
         }
      }
      
      protected function determineQuadrant(param1:int, param2:int) : int
      {
         var _loc3_:int = -1;
         if(param1 < 4)
         {
            if(param2 < 4)
            {
               _loc3_ = 0;
            }
            else
            {
               _loc3_ = 1;
            }
         }
         else if(param2 < 4)
         {
            _loc3_ = 2;
         }
         else
         {
            _loc3_ = 3;
         }
         return _loc3_;
      }
      
      public function ExplodeCurrentPattern() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:Vector.<Vector.<Boolean>> = this._kangaRubyGemExplodeEvent.GetPattern();
         _loc3_ = 0;
         while(_loc3_ < 8)
         {
            _loc2_ = 0;
            while(_loc2_ < 8)
            {
               if(_loc1_[_loc2_][_loc3_])
               {
                  this.destroyGem(_logic.board.GetGemAt(_loc2_,_loc3_));
               }
               _loc2_++;
            }
            _loc3_++;
         }
      }
      
      public function ExplodePrestigePattern(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:Vector.<Vector.<Vector.<Boolean>>> = this._kangaRubyGemExplodeEvent.GetPrestigePattern();
         var _loc3_:Vector.<Vector.<Boolean>> = _loc2_[param1];
         _loc5_ = 0;
         while(_loc5_ < 8)
         {
            _loc4_ = 0;
            while(_loc4_ < 8)
            {
               if(_loc3_[_loc4_][_loc5_])
               {
                  this.destroyGem(_logic.board.GetGemAt(_loc4_,_loc5_));
               }
               _loc4_++;
            }
            _loc5_++;
         }
         this.countRubyKills();
      }
      
      private function destroyGem(param1:Gem) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.type == Gem.TYPE_DETONATE || param1.type == Gem.TYPE_SCRAMBLE)
         {
            return;
         }
         if(param1.isImmune || param1.immuneTime > 0)
         {
            return;
         }
         if(param1.IsDead() || param1.IsShattered() || param1.IsDetonated() || param1.GetFuseTime() > 0)
         {
            return;
         }
         _logic.punchGem(param1);
      }
      
      protected function determineWhichMoveWillHit(param1:int, param2:int, param3:String) : int
      {
         if(param3 == SMALL_ATTACK)
         {
            if(this._kangaRubyAttackPatterns.getSmallAttack(0)[param1][param2])
            {
               return 0;
            }
            if(this._kangaRubyAttackPatterns.getSmallAttack(1)[param1][param2])
            {
               return 1;
            }
            if(this._kangaRubyAttackPatterns.getSmallAttack(2)[param1][param2])
            {
               return 2;
            }
            if(this._kangaRubyAttackPatterns.getSmallAttack(3)[param1][param2])
            {
               return 3;
            }
            return -1;
         }
         if(this._kangaRubyAttackPatterns.getMediumAttack(0)[param1][param2])
         {
            return 0;
         }
         if(this._kangaRubyAttackPatterns.getMediumAttack(1)[param1][param2])
         {
            return 1;
         }
         return -1;
      }
      
      protected function resetKangaForNextCycle() : void
      {
         this._endPhaseTime = this._phaseTimer + COOLDOWN_TIMER_MIN + _logic.GetRNGOfType(BlitzRNGManager.RNG_BLITZ_RG_KANGARUBY).Int(0,COOLDOWN_TIMER_VARIANCE);
         this._phaseTimer = 0;
         this._rubyGemsDestroyedLastPhase = this._rubyGemsDestroyedTotal;
         this._rubyGemsDestroyedCurrentPhase = 0;
         if(this._kangaRubyGemExplodeEvent)
         {
            this._kangaRubyGemExplodeEvent.SetDone(true);
         }
         this._state = STATE_COOLDOWN;
      }
      
      public function AttackAnimationComplete() : void
      {
         if(this._state == STATE_PRESTIGE)
         {
            this._state = STATE_COMPLETE;
         }
         else
         {
            this._state = STATE_COOLDOWN;
         }
         this._animationPlaying = false;
      }
      
      public function NumberOfRubysDestroyed() : int
      {
         return this._rubyGemsDestroyedTotal;
      }
      
      public function AttackCounter() : int
      {
         return this._attackCounter;
      }
      
      override public function getCurrentBoardPatternsIndex() : int
      {
         return _boardPatterns.getCurrentBoardPatternsIndex();
      }
      
      public function overrideAttackPattern(param1:Boolean, param2:Vector.<Vector.<Boolean>>, param3:int) : void
      {
         this._kangaRubyAttackPatterns.overrideAttackPattern(param1,param2,param3);
      }
      
      public function overridePrestigeAttackPattern(param1:Vector.<Vector.<Vector.<Boolean>>>) : void
      {
         this._kangaRubyAttackPatterns.overridePrestigeAttackPattern(param1);
      }
      
      override public function handleLastHurrahBegin() : void
      {
         _logic.lastHurrahLogic.StartLastHurrah();
      }
      
      override public function handleLastHurrahEnd() : void
      {
         this.countRubyKills();
      }
      
      override public function handlePreCoinHurrah() : void
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         this.countRubyKills();
         if(this.canBeginCoinHurrah())
         {
            return;
         }
         if(!this.IsKangaRubyRunning())
         {
            this._state = STATE_PRESTIGE;
            this.determineWhichAttack(true);
            _loc1_ = this._kangaRubyGemExplodeEvent.GetAttackType();
            _loc2_ = this._kangaRubyGemExplodeEvent.GetAttackId();
            this.dispatchKangaRubyAnimation(_loc1_,_loc2_);
         }
      }
      
      override public function canBeginCoinHurrah() : Boolean
      {
         return this._state == STATE_INACTIVE || this._state == STATE_COMPLETE;
      }
      
      override public function HandleGameTimeChange(param1:int) : void
      {
         var _loc5_:String = null;
         var _loc6_:int = 0;
         if(this._state == STATE_INACTIVE)
         {
            return;
         }
         this.countRubyKills();
         this._phaseTimer = _logic.timerLogic.GetTimeElapsed();
         if(this._endPhaseTime == -1)
         {
            this._endPhaseTime = COOLDOWN_TIMER_MIN + _logic.GetRNGOfType(BlitzRNGManager.RNG_BLITZ_RG_KANGARUBY).Int(0,COOLDOWN_TIMER_VARIANCE);
            this._lastCycleStartTime = this._phaseTimer;
         }
         var _loc2_:int = this._rubyGemsDestroyedCurrentPhase * RED_GEM_TIME_REDUCTION;
         if(_loc2_ > 1000)
         {
            _loc2_ = 1000;
         }
         var _loc3_:int = WARMUP_TIMER + COOLDOWN_TIMER_MIN + COOLDOWN_TIMER_VARIANCE / 2 - _loc2_;
         var _loc4_:Number = this._lastCycleStartTime + _loc3_;
         this._percentageToAttack = (this._phaseTimer - this._lastCycleStartTime) / (_loc4_ - this._lastCycleStartTime);
         if(this._percentageToAttack > 1 || this._animationPlaying)
         {
            this._percentageToAttack = 1;
         }
         if(this._state == STATE_COOLDOWN)
         {
            if(this._phaseTimer >= this._endPhaseTime)
            {
               this._state = STATE_WARMUP;
               this._endPhaseTime = this._phaseTimer + WARMUP_TIMER;
            }
         }
         else if(this._state == STATE_WARMUP)
         {
            if(this._phaseTimer >= this._endPhaseTime - _loc2_)
            {
               this.determineWhichAttack(false);
               _loc5_ = this._kangaRubyGemExplodeEvent.GetAttackType();
               _loc6_ = this._kangaRubyGemExplodeEvent.GetAttackId();
               this.dispatchKangaRubyAnimation(_loc5_,_loc6_);
               this._lastCycleStartTime = this._phaseTimer;
               this.resetKangaForNextCycle();
               this._percentageToAttack = 1;
            }
         }
      }
      
      public function getTimeLeftBeforeAttack() : Number
      {
         return this._percentageToAttack;
      }
      
      override public function init() : void
      {
         _logic.lastHurrahLogic.AddHandler(this);
         _logic.timerLogic.AddTimeChangeHandler(this);
      }
      
      override public function reset() : void
      {
         this._state = STATE_INACTIVE;
         this._rubyGemsDestroyedTotal = 0;
         this._rubyGemsDestroyedLastPhase = 0;
         this._rubyGemsDestroyedCurrentPhase = 0;
         this._phaseTimer = 0;
         this._endPhaseTime = -1;
         this._attackCounter = 0;
         this._percentageToAttack = 0;
         this._kangaRubyGemExplodeEvent = null;
         this._animationPlaying = false;
      }
      
      override public function OnStartGame() : void
      {
         var _loc4_:Gem = null;
         this._state = STATE_INTRO;
         this._rubyGemsDestroyedTotal = 0;
         this._rubyGemsDestroyedLastPhase = 0;
         this._rubyGemsDestroyedCurrentPhase = 0;
         this._phaseTimer = 0;
         this._attackCounter = 0;
         this._kangaRubyGemExplodeEvent = null;
         this._animationPlaying = false;
         var _loc1_:Vector.<Vector.<int>> = _boardPatterns.getRandomBoard();
         var _loc2_:Vector.<Gem> = new Vector.<Gem>();
         var _loc3_:Vector.<Gem> = _logic.board.mGems;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.length)
         {
            if((_loc4_ = _loc3_[_loc5_]).type == Gem.TYPE_STANDARD || _loc4_.type == Gem.TYPE_MULTI || _loc4_.type == Gem.TYPE_FLAME || _loc4_.type == Gem.TYPE_STAR || _loc4_.type == Gem.TYPE_HYPERCUBE)
            {
               _loc4_.color = _loc1_[_loc4_.row][_loc4_.col];
            }
            _loc2_.push(_loc3_[_loc5_]);
            _loc5_++;
         }
         _logic.board.SetGemArray(_loc2_);
         this.dispatchKangaRubyAnimation(INTRO_ATTACK,0);
      }
   }
}
