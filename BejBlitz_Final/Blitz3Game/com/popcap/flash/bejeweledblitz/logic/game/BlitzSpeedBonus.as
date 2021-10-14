package com.popcap.flash.bejeweledblitz.logic.game
{
   import com.popcap.flash.bejeweledblitz.logic.Match;
   
   public class BlitzSpeedBonus
   {
       
      
      private var _logic:BlitzLogic;
      
      private var _isActive:Boolean;
      
      private var _level:int;
      
      private var _bonus:int;
      
      private var _idleCount:int;
      
      private var _updateCount:int;
      
      private var _moveHistory:Vector.<Boolean>;
      
      private var _moveTimes:Vector.<int>;
      
      private var _threshold:Number;
      
      private var _timeLeft:Number;
      
      private var _startTime:Number;
      
      private var _lastMoveTime:int;
      
      private var _moveTime:int;
      
      private var _moveMade:Boolean;
      
      private var _highestLevel:int;
      
      private var _bonusLevels:Number;
      
      private var _bonusThreshold:Number;
      
      public var isEnabled:Boolean = false;
      
      public function BlitzSpeedBonus(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
         this._moveHistory = new Vector.<Boolean>();
         this._moveTimes = new Vector.<int>();
         this.Reset();
      }
      
      public function Reset() : void
      {
         this._isActive = false;
         this._level = 0;
         this._bonus = 0;
         this._idleCount = 0;
         this._updateCount = 0;
         this._moveHistory.length = 0;
         this._moveTimes.length = 0;
         this._threshold = this._logic.config.blitzSpeedBonusInitialThreshold;
         this._timeLeft = this._logic.config.blitzSpeedBonusInitialThreshold;
         this._startTime = 0;
         this._lastMoveTime = 0;
         this._moveTime = this._logic.config.blitzSpeedBonusMaxMoveTime;
         this._moveMade = false;
         this._highestLevel = 0;
         this._bonusLevels = 0;
         this.isEnabled = true;
         this._bonusThreshold = 0;
      }
      
      public function GetHighestLevel() : int
      {
         return this._highestLevel;
      }
      
      public function IsActive() : Boolean
      {
         return this._isActive;
      }
      
      public function GetLevel() : int
      {
         return this._level;
      }
      
      public function GetBonus() : int
      {
         return this._bonus;
      }
      
      public function GetThreshold() : Number
      {
         return this._threshold;
      }
      
      public function SetBonus(param1:int) : void
      {
         this._bonus = param1;
         this._level = 1;
      }
      
      public function SetThreshold(param1:Number) : void
      {
         this._threshold = param1;
      }
      
      public function SetBonusThreshold(param1:Number) : void
      {
         this._bonusThreshold = param1;
      }
      
      public function GetTimeLeft() : Number
      {
         return this._timeLeft;
      }
      
      public function GetMoveTime() : int
      {
         if(this._moveTimes.length == 0)
         {
            return this._logic.config.blitzSpeedBonusMaxMoveTime;
         }
         return this._moveTime;
      }
      
      public function WasMoveMade() : Boolean
      {
         return this._moveMade || this._bonusLevels > 0;
      }
      
      public function Update() : void
      {
         var _loc6_:Boolean = false;
         var _loc7_:Match = null;
         var _loc8_:int = 0;
         if(this._logic.blazingSpeedLogic.IsAnimationPending())
         {
            return;
         }
         var _loc1_:Vector.<Match> = this._logic.frameMatches;
         var _loc2_:Boolean = this._logic.board.IsIdle();
         var _loc3_:int = this._logic.moves.length;
         if(this._logic.lastHurrahLogic.IsRunning() || this._logic.IsGameOver())
         {
            this.EndBonus();
            return;
         }
         if(!this.isEnabled)
         {
            return;
         }
         this._moveMade = false;
         while(_loc3_ > this._moveHistory.length)
         {
            _loc6_ = (_loc6_ = false) || this._logic.hypercubeLogic.IsHyperMove(this._moveHistory.length);
            this._moveHistory.push(_loc6_);
         }
         var _loc4_:int = _loc1_.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if(!((_loc8_ = (_loc7_ = _loc1_[_loc5_]).cascadeId) >= this._moveHistory.length || this._moveHistory[_loc8_] == true))
            {
               this._moveMade = true;
               this._moveHistory[_loc8_] = true;
               this._moveTimes.unshift(this._idleCount);
               this.CheckBonus();
               if(this._idleCount > this._lastMoveTime)
               {
                  this._lastMoveTime = this._idleCount;
               }
            }
            _loc5_++;
         }
         if(this._logic.mBlockingEvents.length > 0)
         {
            return;
         }
         this._moveTime = this._idleCount - this._lastMoveTime;
         this.CheckEndBonus();
         if(_loc2_)
         {
            ++this._idleCount;
         }
         this._highestLevel = Math.max(this._highestLevel,this._level);
         ++this._updateCount;
         if(this._bonusThreshold > 0)
         {
            --this._bonusThreshold;
         }
      }
      
      private function CheckBonus() : void
      {
         if(this._moveTimes.length < this._logic.config.blitzSpeedBonusStartingMoves || this._bonusThreshold > 0)
         {
            return;
         }
         if(this._isActive)
         {
            this.CheckContinueBonus();
         }
         else
         {
            this.CheckStartBonus();
         }
      }
      
      private function CheckEndBonus() : void
      {
         if(this._moveTimes.length < this._logic.config.blitzSpeedBonusStartingMoves || this._bonusThreshold > 0)
         {
            return;
         }
         this._timeLeft = this._threshold - (this._idleCount - this._startTime);
         var _loc1_:Number = this._idleCount - this._moveTimes[0];
         if(_loc1_ > this._threshold)
         {
            this.EndBonus();
         }
      }
      
      private function CheckContinueBonus() : void
      {
         var _loc1_:Number = this._moveTimes[0] - this._moveTimes[1];
         if(_loc1_ <= this._threshold)
         {
            this.IncrementBonus(0,false);
         }
         else
         {
            this.EndBonus();
         }
      }
      
      private function CheckStartBonus() : void
      {
         var _loc1_:Number = this._moveTimes[0] - this._moveTimes[2];
         if(_loc1_ <= this._threshold)
         {
            this.StartBonus();
         }
      }
      
      private function StartBonus() : void
      {
         this._isActive = true;
         this._threshold = this._logic.config.blitzSpeedBonusSpeedThreshold;
         this._level = this._logic.config.blitzSpeedBonusLevelBase;
         this._bonus = this._logic.config.blitzSpeedBonusBonusBase;
         this._startTime = this._idleCount;
      }
      
      public function IncrementBonus(param1:int, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(!this.isEnabled)
         {
            return;
         }
         if(param1)
         {
            _loc3_ = 0;
            if(this._level == 0)
            {
               if(param1 < this._logic.config.blitzSpeedBonusBonusBase)
               {
                  return;
               }
               this._isActive = true;
               this._threshold = this._logic.config.blitzSpeedBonusSpeedThreshold;
               this._level = this._logic.config.blitzSpeedBonusLevelBase;
               this._bonus = this._logic.config.blitzSpeedBonusBonusBase;
               param1 -= this._bonus;
               this._lastMoveTime = this._idleCount;
               this._moveTimes.unshift(this._idleCount);
               if(param2)
               {
                  _loc3_ = this._logic.config.blitzSpeedBonusStartingMoves - this._moveTimes.length;
                  _loc4_ = 0;
                  while(_loc4_ < _loc3_)
                  {
                     this._moveTimes.unshift(this._idleCount);
                     _loc4_++;
                  }
               }
            }
            if(param1 > 0)
            {
               _loc3_ = 0;
               _loc5_ = param1 / this._logic.config.blitzSpeedBonusBonusBonus;
               _loc6_ = this._level + _loc5_ >= this._logic.config.blitzSpeedBonusLevelMax ? int(this._logic.config.blitzSpeedBonusLevelMax - this._level - 1) : int(_loc5_);
               if(this._level < this._logic.config.blitzSpeedBonusLevelMax)
               {
                  this._threshold += _loc6_ * this._logic.config.blitzSpeedBonusSpeedThresholdBonus;
                  this._bonus += _loc6_ * this._logic.config.blitzSpeedBonusBonusBonus;
               }
               this._level += _loc5_;
               this._lastMoveTime = this._idleCount;
               this._moveTimes.unshift(this._idleCount);
               if(param2)
               {
                  _loc3_ = this._logic.config.blitzSpeedBonusStartingMoves - this._moveTimes.length;
                  _loc4_ = 0;
                  while(_loc4_ < _loc3_)
                  {
                     this._moveTimes.unshift(this._idleCount);
                     _loc4_++;
                  }
               }
               this._bonusLevels = _loc5_;
            }
         }
         else
         {
            this._level += this._logic.config.blitzSpeedBonusLevelBonus;
            if(this._level < this._logic.config.blitzSpeedBonusLevelMax)
            {
               this._threshold += this._logic.config.blitzSpeedBonusSpeedThresholdBonus;
               this._bonus += this._logic.config.blitzSpeedBonusBonusBonus;
            }
         }
         this._startTime = this._idleCount;
      }
      
      public function GetBonusLevels() : Number
      {
         return this._bonusLevels;
      }
      
      public function ResetBonusLevels() : void
      {
         this._bonusLevels = 0;
      }
      
      private function EndBonus() : void
      {
         this._isActive = false;
         this._threshold = this._logic.config.blitzSpeedBonusInitialThreshold;
         this._level = 0;
         this._bonus = 0;
         this._bonusLevels = 0;
         this._bonusThreshold = 0;
      }
   }
}
