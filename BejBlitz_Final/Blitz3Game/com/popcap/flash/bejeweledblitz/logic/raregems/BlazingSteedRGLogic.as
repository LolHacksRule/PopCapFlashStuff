package com.popcap.flash.bejeweledblitz.logic.raregems
{
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlazingSpeedLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ITimerLogicTimePhaseEndHandler;
   import com.popcap.flash.bejeweledblitz.logic.gems.flame.FlameGemExplodeEvent;
   
   public class BlazingSteedRGLogic extends RGLogic implements IBlazingSpeedLogicHandler, ITimerLogicTimePhaseEndHandler
   {
      
      public static const ID:String = "blazingSteed";
      
      private static const STATE_INACTIVE:int = 0;
      
      private static const STATE_ARMED:int = 1;
      
      private static const STATE_RUNNING:int = 2;
      
      private static const STATE_COMPLETE:int = 3;
       
      
      private var _state:int;
      
      private var _delayTimer:int;
      
      private var _prestiegeTimer:int;
      
      private var _curCol:int;
      
      private var _hurrahExplosionPattern:Vector.<Vector.<Boolean>>;
      
      private var _blazingSteedHandlers:Vector.<IBlazingSteedRGLogicHandler>;
      
      public function BlazingSteedRGLogic(param1:BlitzLogic)
      {
         var _loc3_:int = 0;
         super();
         setDefaults(param1,ID);
         this._delayTimer = _logic.config.blazingSteedRGLogicGemExplosionDelay;
         this._prestiegeTimer = _logic.config.blazingSteedRGLogicGemExplosionDuration;
         this._state = STATE_INACTIVE;
         this._curCol = -1;
         this._blazingSteedHandlers = new Vector.<IBlazingSteedRGLogicHandler>();
         this._hurrahExplosionPattern = new Vector.<Vector.<Boolean>>(Board.NUM_ROWS);
         var _loc2_:int = 0;
         while(_loc2_ < Board.NUM_ROWS)
         {
            this._hurrahExplosionPattern[_loc2_] = new Vector.<Boolean>(Board.NUM_COLS);
            _loc3_ = 0;
            while(_loc3_ < Board.NUM_COLS)
            {
               this._hurrahExplosionPattern[_loc2_][_loc3_] = false;
               _loc3_++;
            }
            _loc2_++;
         }
         this._hurrahExplosionPattern[5][0] = true;
         this._hurrahExplosionPattern[5][3] = true;
         this._hurrahExplosionPattern[5][6] = true;
         this._hurrahExplosionPattern[6][1] = true;
         this._hurrahExplosionPattern[6][4] = true;
         this._hurrahExplosionPattern[6][7] = true;
         this._hurrahExplosionPattern[7][2] = true;
         this._hurrahExplosionPattern[7][5] = true;
      }
      
      public function AddHandler(param1:IBlazingSteedRGLogicHandler) : void
      {
         this._blazingSteedHandlers.push(param1);
      }
      
      public function RemoveHandler(param1:IBlazingSteedRGLogicHandler) : void
      {
         var _loc2_:int = this._blazingSteedHandlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._blazingSteedHandlers.splice(_loc2_,1);
      }
      
      override public function init() : void
      {
         super.init();
         _logic.timerLogic.AddTimePhaseEndHandler(this);
         _logic.blazingSpeedLogic.AddHandler(this);
      }
      
      override public function reset() : void
      {
         this._delayTimer = _logic.config.blazingSteedRGLogicGemExplosionDelay;
         this._prestiegeTimer = _logic.config.blazingSteedRGLogicGemExplosionDuration;
         this._curCol = -1;
         this._state = STATE_INACTIVE;
      }
      
      override public function OnStartGame() : void
      {
         this._state = STATE_ARMED;
         _logic.blazingSpeedLogic.SetDuration(_logic.config.blazingSteedRGLogicStartDuration);
         _logic.blazingSpeedLogic.StartBonus();
      }
      
      override public function handleFlameGemExploded(param1:FlameGemExplodeEvent) : void
      {
      }
      
      override public function handleFlameGemExplosionRange(param1:Gem, param2:Vector.<Gem>) : void
      {
         if(this._state == STATE_INACTIVE || param1 == null)
         {
            return;
         }
         if(param1.row >= 2)
         {
            param2.push(_logic.board.GetGemAt(param1.row - 2,param1.col));
         }
         if(param1.row < Board.NUM_ROWS - 2)
         {
            param2.push(_logic.board.GetGemAt(param1.row + 2,param1.col));
         }
         if(param1.col >= 2)
         {
            param2.push(_logic.board.GetGemAt(param1.row,param1.col - 2));
         }
         if(param1.col < Board.NUM_COLS - 2)
         {
            param2.push(_logic.board.GetGemAt(param1.row,param1.col + 2));
         }
      }
      
      override public function handlePreCoinHurrah() : void
      {
         if(this._state == STATE_ARMED)
         {
            this._state = STATE_RUNNING;
            this.DispatchBlazingSteedBegin();
         }
      }
      
      override public function canBeginCoinHurrah() : Boolean
      {
         return this._state == STATE_INACTIVE || this._state == STATE_COMPLETE;
      }
      
      public function IsBlazingSteedRunning() : Boolean
      {
         return this._state == STATE_RUNNING;
      }
      
      public function HandleTimePhaseEnd() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Gem = null;
         if(this._state != STATE_RUNNING)
         {
            return;
         }
         if(this._delayTimer > 0)
         {
            --this._delayTimer;
         }
         else if(this._prestiegeTimer > 0)
         {
            --this._prestiegeTimer;
            _loc1_ = Math.min(_logic.config.blazingSteedRGLogicGemExplosionDuration,Math.max(0,this._prestiegeTimer));
            _loc2_ = 1 - _loc1_ / _logic.config.blazingSteedRGLogicGemExplosionDuration;
            _loc3_ = Math.floor(_loc2_ * (Board.NUM_COLS - 1));
            if(_loc3_ != this._curCol)
            {
               this._curCol = _loc3_;
               _loc4_ = 0;
               while(_loc4_ < 8)
               {
                  if(this._hurrahExplosionPattern[_loc4_][this._curCol])
                  {
                     if((_loc5_ = _logic.board.GetGemAt(_loc4_,this._curCol)) != null)
                     {
                        _logic.flameGemLogic.UpgradeGem(_loc5_,null,true);
                        _loc5_.immuneTime = 0;
                        _loc5_.SetFuseTime(200 + _loc4_);
                     }
                  }
                  _loc4_++;
               }
            }
            if(this._prestiegeTimer <= 0)
            {
               this._state = STATE_COMPLETE;
            }
         }
      }
      
      override public function HandleGameTimeChange(param1:int) : void
      {
      }
      
      public function HandleBlazingSpeedBegin() : void
      {
      }
      
      public function HandleBlazingSpeedEnd() : void
      {
         _logic.blazingSpeedLogic.SetDuration(_logic.config.blazingSteedRGLogicDuration);
      }
      
      public function HandleBlazingSpeedReset() : void
      {
         _logic.blazingSpeedLogic.SetDuration(_logic.config.blazingSteedRGLogicDuration);
      }
      
      public function HandleBlazingSpeedPercentChanged(param1:Number) : void
      {
      }
      
      private function DispatchBlazingSteedBegin() : void
      {
         var _loc1_:IBlazingSteedRGLogicHandler = null;
         for each(_loc1_ in this._blazingSteedHandlers)
         {
            _loc1_.HandleBlazingSteedBegin(0,_logic.config.blazingSteedRGLogicStampedeDuration);
         }
      }
   }
}
