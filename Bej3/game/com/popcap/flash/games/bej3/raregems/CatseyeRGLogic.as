package com.popcap.flash.games.bej3.raregems
{
   import com.popcap.flash.games.bej3.Board;
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.MoveData;
   import com.popcap.flash.games.bej3.blitz.IBlitzLogicHandler;
   import com.popcap.flash.games.bej3.blitz.ILastHurrahLogicHandler;
   import com.popcap.flash.games.bej3.blitz.ITimerLogicHandler;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.geom.Point;
   
   public class CatseyeRGLogic implements IRareGem, IBlitzLogicHandler, ILastHurrahLogicHandler, ITimerLogicHandler
   {
      
      public static const ID:String = "Catseye";
      
      public static const ORDERING_ID:int = 1;
      
      public static const NUM_LASERS:int = 14;
      
      public static const FIRING_DELAY:int = 25;
      
      public static const ADDITIONAL_FIRING_DELAY:Number = 0;
      
      public static const EXPLOSION_DELAY:int = 10;
      
      public static const INITIAL_DELAY:int = 250;
      
      private static const STATE_INACTIVE:int = 0;
      
      private static const STATE_ARMED:int = 1;
      
      private static const STATE_RUNNING:int = 2;
      
      private static const STATE_COMPLETE:int = 3;
       
      
      private var m_App:Blitz3App;
      
      protected var m_State:int = 0;
      
      protected var m_NumToDestroy:int = 0;
      
      protected var m_CurDelay:int = 0;
      
      protected var m_TargetPosQueue:Vector.<Point>;
      
      protected var m_TargetTimerQueue:Vector.<int>;
      
      protected var m_Handlers:Vector.<ICatseyeRGLogicHandler>;
      
      public function CatseyeRGLogic(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_TargetPosQueue = new Vector.<Point>();
         this.m_TargetTimerQueue = new Vector.<int>();
         this.m_Handlers = new Vector.<ICatseyeRGLogicHandler>();
      }
      
      public function Reset() : void
      {
         this.m_State = STATE_INACTIVE;
         this.m_NumToDestroy = 0;
         this.m_CurDelay = 0;
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
      
      public function Init() : void
      {
         this.m_App.logic.AddBlitzLogicHandler(this);
         this.m_App.logic.lastHurrahLogic.AddHandler(this);
         this.m_App.logic.timerLogic.AddHandler(this);
      }
      
      public function OnStartGame() : void
      {
         this.m_State = STATE_ARMED;
         this.m_NumToDestroy = NUM_LASERS;
         this.m_CurDelay = INITIAL_DELAY;
      }
      
      public function HandleGameEnd() : void
      {
         this.Reset();
      }
      
      public function HandleGameAbort() : void
      {
         this.Reset();
      }
      
      public function HandleLastHurrahBegin() : void
      {
      }
      
      public function HandleLastHurrahEnd() : void
      {
      }
      
      public function HandlePreCoinHurrah() : void
      {
         if(this.m_State == STATE_ARMED)
         {
            this.m_State = STATE_RUNNING;
            this.m_App.logic.lastHurrahLogic.StartLastHurrah();
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
      
      public function HandleGameDurationChange(newDuration:int) : void
      {
      }
      
      protected function UpdateTargets() : void
      {
         var point:Point = null;
         var numTargets:int = this.m_TargetTimerQueue.length;
         if(numTargets <= 0)
         {
            return;
         }
         for(var i:int = 0; i < numTargets; i++)
         {
            --this.m_TargetTimerQueue[i];
         }
         while(this.m_TargetTimerQueue[0] <= 0)
         {
            this.m_TargetTimerQueue.shift();
            point = this.m_TargetPosQueue.shift();
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
            gem = this.m_App.logic.board.GetRandomGem();
         }
         while(gem == null || gem.type != Gem.TYPE_STANDARD || gem.row != int(Board.NUM_ROWS * (NUM_LASERS - this.m_NumToDestroy) / NUM_LASERS) || (Boolean(this.m_NumToDestroy % 2) ? Boolean(gem.col < Board.NUM_COLS / 2) : Boolean(gem.col >= Board.NUM_COLS / 2)));
         
         explosionDelay = EXPLOSION_DELAY;
         this.m_TargetPosQueue.push(new Point(gem.col,gem.row));
         this.m_TargetTimerQueue.push(explosionDelay);
         --this.m_NumToDestroy;
         this.m_CurDelay = FIRING_DELAY + (NUM_LASERS - this.m_NumToDestroy) * ADDITIONAL_FIRING_DELAY;
         this.DispatchLaserCatDestroyedGem(gem.row,gem.col,explosionDelay,this.m_CurDelay);
      }
      
      protected function DestroyGem(row:int, col:int) : void
      {
         var gem:Gem = this.m_App.logic.board.GetGemAt(row,col);
         if(!gem)
         {
            return;
         }
         gem.upgrade(Gem.TYPE_FLAME,true);
         gem.immuneTime = 0;
         gem.fuseTime = 1;
         var move:MoveData = new MoveData();
         move.sourceGem = gem;
         move.sourcePos.x = gem.col;
         move.sourcePos.y = gem.row;
         this.m_App.logic.AddMove(move);
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
