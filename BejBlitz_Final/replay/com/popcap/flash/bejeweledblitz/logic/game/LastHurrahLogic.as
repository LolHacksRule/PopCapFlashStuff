package com.popcap.flash.bejeweledblitz.logic.game
{
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.MoveData;
   
   public class LastHurrahLogic implements ITimerLogicHandler
   {
      
      private static const STATE_NOT_STARTED:int = 0;
      
      private static const STATE_RUNNING:int = 1;
      
      private static const STATE_COMPLETE:int = 2;
       
      
      private var m_Logic:BlitzLogic;
      
      private var m_Handlers:Vector.<ILastHurrahLogicHandler>;
      
      private var m_State:int;
      
      private var m_Delay:int;
      
      private var m_InitialDelay:int;
      
      private var m_CurrentTime:int;
      
      public var isEnabled:Boolean;
      
      public function LastHurrahLogic(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
         this.m_Handlers = new Vector.<ILastHurrahLogicHandler>();
         this.m_State = STATE_NOT_STARTED;
         this.isEnabled = true;
      }
      
      public function Init() : void
      {
         this.m_State = STATE_NOT_STARTED;
         this.m_InitialDelay = BlitzLogic.BASE_HURRAH_DELAY;
         this.m_Logic.timerLogic.AddHandler(this);
      }
      
      public function Reset() : void
      {
         this.isEnabled = true;
         this.m_State = STATE_NOT_STARTED;
         this.m_Delay = BlitzLogic.SHORT_HURRAH_DELAY;
         this.m_CurrentTime = this.m_Logic.timerLogic.GetTimeRemaining();
      }
      
      public function Update() : void
      {
         var col:int = 0;
         var gem:Gem = null;
         var move:MoveData = null;
         if(this.m_State != STATE_RUNNING)
         {
            return;
         }
         if(!this.isEnabled)
         {
            this.m_State = STATE_COMPLETE;
            this.DispatchLastHurrahEnd();
         }
         if(this.m_InitialDelay > 0)
         {
            --this.m_InitialDelay;
            if(this.m_InitialDelay > 0)
            {
               return;
            }
            this.m_Logic.blazingSpeedLogic.Reset();
         }
         var isStill:Boolean = this.m_Logic.board.IsStill();
         if(!isStill)
         {
            return;
         }
         var specialCount:int = 0;
         var delay:Number = this.m_Delay;
         this.m_Delay = BlitzLogic.SHORT_HURRAH_DELAY;
         for(var row:int = 0; row < Board.HEIGHT; row++)
         {
            for(col = 0; col < Board.WIDTH; col++)
            {
               gem = this.m_Logic.board.GetGemAt(row,col);
               if(gem.type != Gem.TYPE_STANDARD)
               {
                  move = this.m_Logic.movePool.GetMove();
                  move.sourceGem = gem;
                  move.sourcePos.x = gem.col;
                  move.sourcePos.y = gem.row;
                  this.m_Logic.AddMove(move);
                  gem.SetFuseTime(delay);
                  gem.mMoveId = move.id;
                  gem.mShatterColor = gem.color;
                  gem.mShatterType = gem.type;
                  if(gem.type == Gem.TYPE_DETONATE || gem.type == Gem.TYPE_SCRAMBLE)
                  {
                     gem.baseValue = 1500;
                  }
                  delay += 25;
                  specialCount++;
               }
            }
         }
         if(specialCount == 0)
         {
            this.DispatchPreCoinHurrah();
            if(this.CanBeginCoinLogic())
            {
               this.m_Logic.coinTokenLogic.CollectCoinTokens();
               if(this.m_Logic.coinTokenLogic.isHurrahDone)
               {
                  this.m_State = STATE_COMPLETE;
                  this.DispatchLastHurrahEnd();
               }
            }
         }
      }
      
      public function AddHandler(handler:ILastHurrahLogicHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function StartLastHurrah() : void
      {
         if(this.m_State == STATE_RUNNING)
         {
            return;
         }
         this.m_State = STATE_RUNNING;
         this.DispatchLastHurrahBegin();
      }
      
      public function IsRunning() : Boolean
      {
         return this.m_State == STATE_RUNNING;
      }
      
      public function IsDone() : Boolean
      {
         return this.m_State == STATE_COMPLETE;
      }
      
      public function HandleTimePhaseBegin() : void
      {
      }
      
      public function HandleTimePhaseEnd() : void
      {
         if(this.m_CurrentTime <= 0)
         {
            if(this.m_Logic.board.IsStill())
            {
               this.StartLastHurrah();
            }
         }
      }
      
      public function HandleGameTimeChange(newTime:int) : void
      {
         this.m_CurrentTime = newTime;
      }
      
      public function HandleGameDurationChange(prevDuration:int, newDuration:int) : void
      {
      }
      
      private function DispatchLastHurrahBegin() : void
      {
         var handler:ILastHurrahLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleLastHurrahBegin();
         }
      }
      
      private function DispatchLastHurrahEnd() : void
      {
         var handler:ILastHurrahLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleLastHurrahEnd();
         }
      }
      
      private function DispatchPreCoinHurrah() : void
      {
         var handler:ILastHurrahLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandlePreCoinHurrah();
         }
      }
      
      private function CanBeginCoinLogic() : Boolean
      {
         var handler:ILastHurrahLogicHandler = null;
         var canBegin:Boolean = true;
         for each(handler in this.m_Handlers)
         {
            canBegin = canBegin && handler.CanBeginCoinHurrah();
         }
         return canBegin;
      }
   }
}
