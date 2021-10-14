package com.popcap.flash.bejeweledblitz.logic.raregems
{
   import com.popcap.flash.bejeweledblitz.logic.BlitzRNGManager;
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.MoveData;
   import com.popcap.flash.bejeweledblitz.logic.Point2D;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ITimerLogicTimePhaseEndHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   
   public class CatseyeRGLogic extends RGLogic implements IBlitzLogicHandler, ITimerLogicTimePhaseEndHandler
   {
      
      public static const ID:String = "catseye";
      
      private static const STATE_INACTIVE:int = 0;
      
      private static const STATE_ARMED:int = 1;
      
      private static const STATE_RUNNING:int = 2;
      
      private static const STATE_COMPLETE:int = 3;
       
      
      protected var _state:int;
      
      protected var _numToDestroy:int;
      
      protected var _curDelay:int;
      
      protected var _targetPosQueue:Vector.<Point2D>;
      
      protected var _targetTimerQueue:Vector.<int>;
      
      protected var _catseyeHandlers:Vector.<ICatseyeRGLogicHandler>;
      
      public function CatseyeRGLogic(param1:BlitzLogic)
      {
         super();
         setDefaults(param1,ID);
         this._state = STATE_INACTIVE;
         this._numToDestroy = 0;
         this._curDelay = 0;
         this._targetPosQueue = new Vector.<Point2D>();
         this._targetTimerQueue = new Vector.<int>();
         this._catseyeHandlers = new Vector.<ICatseyeRGLogicHandler>();
      }
      
      public function AddHandler(param1:ICatseyeRGLogicHandler) : void
      {
         this._catseyeHandlers.push(param1);
      }
      
      public function RemoveHandler(param1:ICatseyeRGLogicHandler) : void
      {
         var _loc2_:int = this._catseyeHandlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._catseyeHandlers.splice(_loc2_,1);
      }
      
      override public function init() : void
      {
         _logic.AddHandler(this);
         _logic.lastHurrahLogic.AddHandler(this);
         _logic.timerLogic.AddTimePhaseEndHandler(this);
      }
      
      override public function reset() : void
      {
         this._state = STATE_INACTIVE;
         this._numToDestroy = 0;
         this._curDelay = 0;
         _logic.point2DPool.FreePoint2Ds(this._targetPosQueue);
         this._targetTimerQueue.length = 0;
      }
      
      override public function OnStartGame() : void
      {
         this._state = STATE_ARMED;
         this._numToDestroy = _logic.config.catseyeRGLogicNumLasers;
         this._curDelay = _logic.config.catseyeRGLogicInitialDelay;
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
      
      override public function handlePreCoinHurrah() : void
      {
         var _loc1_:MoveData = null;
         var _loc2_:Gem = null;
         if(this._state == STATE_ARMED)
         {
            this._state = STATE_RUNNING;
            _loc1_ = _logic.movePool.GetMove();
            _loc2_ = _logic.board.GetGemAt(0,0);
            if(_loc2_ != null)
            {
               _loc1_.sourceGem = _loc2_;
               _loc1_.sourcePos.x = _loc2_.col;
               _loc1_.sourcePos.y = _loc2_.row;
               _logic.AddMove(_loc1_);
            }
            _logic.multiLogic.ScaleMultiplier(_logic.config.catseyeRGLogicMultiplierScalar);
            _logic.lastHurrahLogic.StartLastHurrah();
            this.DispatchLaserCatBegin();
         }
      }
      
      override public function canBeginCoinHurrah() : Boolean
      {
         return this._state == STATE_INACTIVE || this._state == STATE_COMPLETE;
      }
      
      public function HandleTimePhaseEnd() : void
      {
         if(this._state != STATE_RUNNING)
         {
            return;
         }
         this.UpdateTargets();
         --this._curDelay;
         if(this._curDelay > 0)
         {
            return;
         }
         this.PickNextTarget();
         if(this._numToDestroy <= 0 && this._targetTimerQueue.length <= 0)
         {
            this._state = STATE_COMPLETE;
            this.DispatchLaserCatEnd();
         }
      }
      
      protected function UpdateTargets() : void
      {
         var _loc3_:Point2D = null;
         var _loc1_:int = this._targetTimerQueue.length;
         if(_loc1_ <= 0)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            --this._targetTimerQueue[_loc2_];
            _loc2_++;
         }
         while(_loc1_ > 0 && this._targetTimerQueue[0] <= 0)
         {
            this._targetTimerQueue.shift();
            _loc3_ = this._targetPosQueue.shift();
            _loc1_--;
            this.DestroyGem(_loc3_.y,_loc3_.x);
         }
      }
      
      protected function PickNextTarget() : void
      {
         var _loc2_:int = 0;
         if(this._numToDestroy <= 0)
         {
            return;
         }
         var _loc1_:Gem = null;
         do
         {
            _loc1_ = _logic.board.GetRandomGem(BlitzRNGManager.RNG_BLITZ_PRIMARY);
         }
         while(_loc1_ == null || _loc1_.type != Gem.TYPE_STANDARD || _loc1_.row != Math.floor(Board.NUM_ROWS * Math.floor(_logic.config.catseyeRGLogicNumLasers - this._numToDestroy) / _logic.config.catseyeRGLogicNumLasers) || (!!(this._numToDestroy % 2) ? Boolean(_loc1_.col < Board.NUM_COLS * 0.5) : Boolean(_loc1_.col >= Board.NUM_COLS * 0.5)));
         
         _loc2_ = _logic.config.catseyeRGLogicExplosionDelay;
         this._targetPosQueue.push(_logic.point2DPool.GetNextPoint2D(_loc1_.col,_loc1_.row));
         this._targetTimerQueue.push(_loc2_);
         --this._numToDestroy;
         this._curDelay = _logic.config.catseyeRGLogicFiringDelay + (_logic.config.catseyeRGLogicNumLasers - this._numToDestroy) * _logic.config.catseyeRGLogicAdditionalFiringDelay;
         this.DispatchLaserCatDestroyedGem(_loc1_.row,_loc1_.col,_loc2_,this._curDelay);
      }
      
      protected function DestroyGem(param1:int, param2:int) : void
      {
         var _loc3_:Gem = _logic.board.GetGemAt(param1,param2);
         if(!_loc3_)
         {
            return;
         }
         _loc3_.upgrade(Gem.TYPE_FLAME,true);
         _loc3_.immuneTime = 0;
         _loc3_.SetFuseTime(1);
         var _loc4_:MoveData;
         (_loc4_ = _logic.movePool.GetMove()).sourceGem = _loc3_;
         _loc4_.sourcePos.x = _loc3_.col;
         _loc4_.sourcePos.y = _loc3_.row;
         _logic.AddMove(_loc4_);
         _loc3_.moveID = _loc4_.id;
         _loc3_.shatterColor = _loc3_.color;
         _loc3_.shatterType = _loc3_.type;
      }
      
      protected function DispatchLaserCatBegin() : void
      {
         var _loc1_:ICatseyeRGLogicHandler = null;
         for each(_loc1_ in this._catseyeHandlers)
         {
            _loc1_.HandleLaserCatBegin();
         }
      }
      
      protected function DispatchLaserCatEnd() : void
      {
         var _loc1_:ICatseyeRGLogicHandler = null;
         for each(_loc1_ in this._catseyeHandlers)
         {
            _loc1_.HandleLaserCatEnd();
         }
      }
      
      protected function DispatchLaserCatDestroyedGem(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:ICatseyeRGLogicHandler = null;
         for each(_loc5_ in this._catseyeHandlers)
         {
            _loc5_.HandleLaserCatDestroyedGem(param1,param2,param3,param4);
         }
      }
      
      public function HandleGameTimeDelayed() : void
      {
      }
   }
}
