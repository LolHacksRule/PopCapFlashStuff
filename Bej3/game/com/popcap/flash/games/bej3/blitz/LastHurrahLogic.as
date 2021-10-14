package com.popcap.flash.games.bej3.blitz
{
   import com.popcap.flash.games.bej3.Board;
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.MoveData;
   import com.popcap.flash.games.blitz3.Blitz3App;
   
   public class LastHurrahLogic implements ITimerLogicHandler
   {
      
      protected static const STATE_NOT_STARTED:int = 0;
      
      protected static const STATE_RUNNING:int = 1;
      
      protected static const STATE_COMPLETE:int = 2;
       
      
      protected var m_App:Blitz3App;
      
      protected var m_Handlers:Vector.<ILastHurrahLogicHandler>;
      
      protected var m_State:int = 0;
      
      protected var m_Delay:int;
      
      protected var m_InitialDelay:int;
      
      public function LastHurrahLogic(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_Handlers = new Vector.<ILastHurrahLogicHandler>();
      }
      
      public function Init() : void
      {
         this.m_State = STATE_NOT_STARTED;
         this.m_InitialDelay = BlitzLogic.BASE_HURRAH_DELAY;
         this.m_App.logic.timerLogic.AddHandler(this);
      }
      
      public function Reset() : void
      {
         this.m_State = STATE_NOT_STARTED;
         this.m_Delay = BlitzLogic.SHORT_HURRAH_DELAY;
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
         if(this.m_InitialDelay > 0)
         {
            --this.m_InitialDelay;
            if(this.m_InitialDelay > 0)
            {
               return;
            }
            this.m_App.logic.blazingSpeedBonus.Reset();
         }
         var isStill:Boolean = this.m_App.logic.board.IsStill();
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
               gem = this.m_App.logic.board.GetGemAt(row,col);
               if(gem.type != Gem.TYPE_STANDARD)
               {
                  move = new MoveData();
                  move.sourceGem = gem;
                  move.sourcePos.x = gem.col;
                  move.sourcePos.y = gem.row;
                  this.m_App.logic.AddMove(move);
                  gem.fuseTime = delay;
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
               this.m_App.logic.coinTokenLogic.CollectCoinTokens();
               if(this.m_App.logic.coinTokenLogic.isHurrahDone)
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
      }
      
      public function HandleGameTimeChange(newTime:int) : void
      {
         if(newTime <= 0)
         {
            this.StartLastHurrah();
         }
      }
      
      public function HandleGameDurationChange(newDuration:int) : void
      {
      }
      
      protected function DispatchLastHurrahBegin() : void
      {
         var handler:ILastHurrahLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleLastHurrahBegin();
         }
      }
      
      protected function DispatchLastHurrahEnd() : void
      {
         var handler:ILastHurrahLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleLastHurrahEnd();
         }
      }
      
      protected function DispatchPreCoinHurrah() : void
      {
         var handler:ILastHurrahLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandlePreCoinHurrah();
         }
      }
      
      protected function CanBeginCoinLogic() : Boolean
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
