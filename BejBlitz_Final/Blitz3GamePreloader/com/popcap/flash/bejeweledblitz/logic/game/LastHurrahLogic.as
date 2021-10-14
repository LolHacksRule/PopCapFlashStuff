package com.popcap.flash.bejeweledblitz.logic.game
{
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.MoveData;
   
   public class LastHurrahLogic implements ITimerLogicTimeChangeHandler, ITimerLogicTimePhaseEndHandler
   {
      
      private static const STATE_NOT_STARTED:int = 0;
      
      private static const STATE_RUNNING:int = 1;
      
      private static const STATE_COMPLETE:int = 2;
       
      
      private var _logic:BlitzLogic;
      
      private var _handlers:Vector.<ILastHurrahLogicHandler>;
      
      private var _state:int;
      
      private var _delay:int;
      
      private var _initialDelay:int;
      
      private var _currentTime:int;
      
      private var _isPreCoinHurrah:Boolean = false;
      
      public var isEnabled:Boolean;
      
      public function LastHurrahLogic(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
         this._handlers = new Vector.<ILastHurrahLogicHandler>();
         this._state = STATE_NOT_STARTED;
         this.isEnabled = true;
      }
      
      public function Init() : void
      {
         this._state = STATE_NOT_STARTED;
         this._initialDelay = this._logic.config.lastHurrahLogicBaseHurrahDelay;
         this._logic.timerLogic.AddTimeChangeHandler(this);
         this._logic.timerLogic.AddTimePhaseEndHandler(this);
      }
      
      public function Reset() : void
      {
         this._isPreCoinHurrah = false;
         this.isEnabled = true;
         this._state = STATE_NOT_STARTED;
         this._delay = this._logic.config.lastHurrahLogicShortHurrahDelay;
         this._currentTime = this._logic.timerLogic.GetTimeRemaining();
      }
      
      private function SetupGemToExplode(param1:Gem, param2:int) : void
      {
         var _loc3_:MoveData = this._logic.movePool.GetMove();
         _loc3_.sourceGem = param1;
         _loc3_.sourcePos.x = param1.col;
         _loc3_.sourcePos.y = param1.row;
         this._logic.AddMove(_loc3_);
         param1.SetFuseTime(param2);
         param1.moveID = _loc3_.id;
         param1.shatterColor = param1.color;
         param1.shatterType = param1.type;
         if(param1.type == Gem.TYPE_DETONATE || param1.type == Gem.TYPE_SCRAMBLE)
         {
            param1.baseValue = 1500;
         }
      }
      
      public function Update() : void
      {
         var _loc5_:int = 0;
         var _loc6_:Gem = null;
         if(this._state != STATE_RUNNING)
         {
            return;
         }
         if(!this.isEnabled)
         {
            this._state = STATE_COMPLETE;
            this.DispatchLastHurrahEnd();
         }
         if(this._initialDelay > 0)
         {
            --this._initialDelay;
            if(this._initialDelay > 0)
            {
               return;
            }
            this._logic.blazingSpeedLogic.Reset(false);
         }
         var _loc1_:Boolean = this._logic.board.IsStill();
         if(!_loc1_)
         {
            return;
         }
         var _loc2_:int = 0;
         var _loc3_:Number = this._delay;
         this._delay = this._logic.config.lastHurrahLogicShortHurrahDelay;
         var _loc4_:int = 0;
         while(_loc4_ < Board.HEIGHT)
         {
            _loc5_ = 0;
            while(_loc5_ < Board.WIDTH)
            {
               if((_loc6_ = this._logic.board.GetGemAt(_loc4_,_loc5_)) != null && (_loc6_.type != Gem.TYPE_STANDARD || this._logic.rareGemTokenLogic.GemHasRareGemToken(_loc6_)))
               {
                  this.SetupGemToExplode(_loc6_,_loc3_);
                  _loc3_ += 25;
                  _loc2_++;
               }
               _loc5_++;
            }
            _loc4_++;
         }
         if(_loc2_ == 0 && !this._logic.ShouldDelayTimeUp())
         {
            this._isPreCoinHurrah = true;
            this.DispatchPreCoinHurrah();
            if(this.CanBeginCoinLogic())
            {
               this._logic.coinTokenLogic.CollectCoinTokens();
               if(this._logic.coinTokenLogic.isHurrahDone)
               {
                  this._isPreCoinHurrah = false;
                  this._state = STATE_COMPLETE;
                  this.DispatchLastHurrahEnd();
               }
            }
         }
      }
      
      public function isPreCoinHurrah() : Boolean
      {
         return this._isPreCoinHurrah;
      }
      
      public function AddHandler(param1:ILastHurrahLogicHandler) : void
      {
         this._handlers.push(param1);
      }
      
      public function RemoveHandler(param1:ILastHurrahLogicHandler) : void
      {
         var _loc2_:int = this._handlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._handlers.splice(_loc2_,1);
      }
      
      public function StartLastHurrah() : void
      {
         if(this._state == STATE_RUNNING)
         {
            return;
         }
         this._state = STATE_RUNNING;
         this.DispatchLastHurrahBegin();
      }
      
      public function IsRunning() : Boolean
      {
         return this._state == STATE_RUNNING;
      }
      
      public function IsDone() : Boolean
      {
         return this._state == STATE_COMPLETE;
      }
      
      public function HandleTimePhaseEnd() : void
      {
         if(this._currentTime <= 0 && !this._logic.ShouldDelayTimeUp())
         {
            if(this._logic.board.IsStill())
            {
               this.StartLastHurrah();
            }
         }
      }
      
      public function HandleGameTimeChange(param1:int) : void
      {
         this._currentTime = param1;
      }
      
      private function DispatchLastHurrahBegin() : void
      {
         var _loc1_:ILastHurrahLogicHandler = null;
         for each(_loc1_ in this._handlers)
         {
            _loc1_.handleLastHurrahBegin();
         }
      }
      
      private function DispatchLastHurrahEnd() : void
      {
         var _loc1_:ILastHurrahLogicHandler = null;
         for each(_loc1_ in this._handlers)
         {
            _loc1_.handleLastHurrahEnd();
         }
      }
      
      private function DispatchPreCoinHurrah() : void
      {
         var _loc1_:ILastHurrahLogicHandler = null;
         for each(_loc1_ in this._handlers)
         {
            _loc1_.handlePreCoinHurrah();
         }
      }
      
      private function CanBeginCoinLogic() : Boolean
      {
         var _loc2_:ILastHurrahLogicHandler = null;
         var _loc1_:Boolean = true;
         for each(_loc2_ in this._handlers)
         {
            _loc1_ = _loc1_ && _loc2_.canBeginCoinHurrah();
         }
         return _loc1_;
      }
   }
}
