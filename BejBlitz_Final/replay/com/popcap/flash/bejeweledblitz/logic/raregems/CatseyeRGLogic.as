package com.popcap.flash.bejeweledblitz.logic.raregems
{
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.MoveData;
   import com.popcap.flash.bejeweledblitz.logic.Point2D;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ILastHurrahLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ITimerLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   
   public class CatseyeRGLogic implements IRareGem, IBlitzLogicHandler, ILastHurrahLogicHandler, ITimerLogicHandler
   {
      
      public static const ID:String = "Catseye";
      
      public static const ORDERING_ID:int = 1;
      
      public static const MULTIPLIER_SCALAR:Number = 3;
      
      public static const NUM_LASERS:int = 14;
      
      public static const FIRING_DELAY:int = 20;
      
      public static const ADDITIONAL_FIRING_DELAY:Number = 0;
      
      public static const EXPLOSION_DELAY:int = 10;
      
      public static const INITIAL_DELAY:int = 250;
      
      private static const STATE_INACTIVE:int = 0;
      
      private static const STATE_ARMED:int = 1;
      
      private static const STATE_RUNNING:int = 2;
      
      private static const STATE_COMPLETE:int = 3;
       
      
      private var m_Logic:BlitzLogic;
      
      protected var m_State:int;
      
      protected var m_NumToDestroy:int;
      
      protected var m_CurDelay:int;
      
      protected var m_TargetPosQueue:Vector.<Point2D>;
      
      protected var m_TargetTimerQueue:Vector.<int>;
      
      protected var m_Handlers:Vector.<ICatseyeRGLogicHandler>;
      
      public function CatseyeRGLogic()
      {
         super();
         this.m_State = STATE_INACTIVE;
         this.m_NumToDestroy = 0;
         this.m_CurDelay = 0;
         this.m_TargetPosQueue = new Vector.<Point2D>();
         this.m_TargetTimerQueue = new Vector.<int>();
         this.m_Handlers = new Vector.<ICatseyeRGLogicHandler>();
      }
      
      public function AddHandler(handler:ICatseyeRGLogicHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function GetStringID() : String
      {
         return ID;
      }
      
      public function GetOrderingID() : int
      {
         return ORDERING_ID;
      }
      
      public function Init(logic:BlitzLogic) : void
      {
         this.m_Logic = logic;
         this.m_Logic.AddHandler(this);
         this.m_Logic.lastHurrahLogic.AddHandler(this);
         this.m_Logic.timerLogic.AddHandler(this);
      }
      
      public function Reset() : void
      {
         this.m_State = STATE_INACTIVE;
         this.m_NumToDestroy = 0;
         this.m_CurDelay = 0;
         this.m_Logic.point2DPool.FreePoint2Ds(this.m_TargetPosQueue);
         this.m_TargetTimerQueue.length = 0;
      }
      
      public function OnStartGame() : void
      {
         this.m_State = STATE_ARMED;
         this.m_NumToDestroy = NUM_LASERS;
         this.m_CurDelay = INITIAL_DELAY;
      }
      
      public function HandleGameBegin() : void
      {
      }
      
      public function HandleGameEnd() : void
      {
         this.Reset();
      }
      
      public function HandleGameAbort() : void
      {
         this.Reset();
      }
      
      public function HandleGamePaused() : void
      {
      }
      
      public function HandleGameResumed() : void
      {
      }
      
      public function HandleScore(score:ScoreValue) : void
      {
      }
      
      public function HandleLastHurrahBegin() : void
      {
      }
      
      public function HandleLastHurrahEnd() : void
      {
      }
      
      public function HandlePreCoinHurrah() : void
      {
         var move:MoveData = null;
         var gem:Gem = null;
         if(this.m_State == STATE_ARMED)
         {
            this.m_State = STATE_RUNNING;
            move = this.m_Logic.movePool.GetMove();
            gem = this.m_Logic.board.GetGemAt(0,0);
            move.sourceGem = gem;
            move.sourcePos.x = gem.col;
            move.sourcePos.y = gem.row;
            this.m_Logic.AddMove(move);
            this.m_Logic.multiLogic.ScaleMultiplier(MULTIPLIER_SCALAR);
            this.m_Logic.lastHurrahLogic.StartLastHurrah();
            this.DispatchLaserCatBegin();
         }
      }
      
      public function CanBeginCoinHurrah() : Boolean
      {
         return this.m_State == STATE_INACTIVE || this.m_State == STATE_COMPLETE;
      }
      
      public function HandleTimePhaseBegin() : void
      {
      }
      
      public function HandleTimePhaseEnd() : void
      {
         if(this.m_State != STATE_RUNNING)
         {
            return;
         }
         this.UpdateTargets();
         --this.m_CurDelay;
         if(this.m_CurDelay > 0)
         {
            return;
         }
         this.PickNextTarget();
         if(this.m_NumToDestroy <= 0 && this.m_TargetTimerQueue.length <= 0)
         {
            this.m_State = STATE_COMPLETE;
            this.DispatchLaserCatEnd();
         }
      }
      
      public function HandleGameTimeChange(newTime:int) : void
      {
      }
      
      public function HandleGameDurationChange(prevDuration:int, newDuration:int) : void
      {
      }
      
      protected function UpdateTargets() : void
      {
         var point:Point2D = null;
         var numTargets:int = this.m_TargetTimerQueue.length;
         if(numTargets <= 0)
         {
            return;
         }
         for(var i:int = 0; i < numTargets; i++)
         {
            --this.m_TargetTimerQueue[i];
         }
         while(numTargets > 0 && this.m_TargetTimerQueue[0] <= 0)
         {
            this.m_TargetTimerQueue.shift();
            point = this.m_TargetPosQueue.shift();
            numTargets--;
            this.DestroyGem(point.y,point.x);
         }
      }
      
      protected function PickNextTarget() : void
      {
         var explosionDelay:int = 0;
         if(this.m_NumToDestroy <= 0)
         {
            return;
         }
         var gem:Gem = null;
         do
         {
            gem = this.m_Logic.board.GetRandomGem();
         }
         while(gem == null || gem.type != Gem.TYPE_STANDARD || gem.row != Math.floor(Board.NUM_ROWS * Math.floor(NUM_LASERS - this.m_NumToDestroy) / NUM_LASERS) || (Boolean(this.m_NumToDestroy % 2) ? Boolean(gem.col < Board.NUM_COLS * 0.5) : Boolean(gem.col >= Board.NUM_COLS * 0.5)));
         
         explosionDelay = EXPLOSION_DELAY;
         this.m_TargetPosQueue.push(this.m_Logic.point2DPool.GetNextPoint2D(gem.col,gem.row));
         this.m_TargetTimerQueue.push(explosionDelay);
         --this.m_NumToDestroy;
         this.m_CurDelay = FIRING_DELAY + (NUM_LASERS - this.m_NumToDestroy) * ADDITIONAL_FIRING_DELAY;
         this.DispatchLaserCatDestroyedGem(gem.row,gem.col,explosionDelay,this.m_CurDelay);
      }
      
      protected function DestroyGem(row:int, col:int) : void
      {
         var gem:Gem = this.m_Logic.board.GetGemAt(row,col);
         if(!gem)
         {
            return;
         }
         gem.upgrade(Gem.TYPE_FLAME,true);
         gem.immuneTime = 0;
         gem.SetFuseTime(1);
         var move:MoveData = this.m_Logic.movePool.GetMove();
         move.sourceGem = gem;
         move.sourcePos.x = gem.col;
         move.sourcePos.y = gem.row;
         this.m_Logic.AddMove(move);
         gem.mMoveId = move.id;
         gem.mShatterColor = gem.color;
         gem.mShatterType = gem.type;
      }
      
      protected function DispatchLaserCatBegin() : void
      {
         var handler:ICatseyeRGLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleLaserCatBegin();
         }
      }
      
      protected function DispatchLaserCatEnd() : void
      {
         var handler:ICatseyeRGLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleLaserCatEnd();
         }
      }
      
      protected function DispatchLaserCatDestroyedGem(row:int, col:int, delayTicks:int, firingDelay:int) : void
      {
         var handler:ICatseyeRGLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleLaserCatDestroyedGem(row,col,delayTicks,firingDelay);
         }
      }
   }
}
