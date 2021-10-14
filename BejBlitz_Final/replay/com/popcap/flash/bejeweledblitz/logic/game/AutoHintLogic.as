package com.popcap.flash.bejeweledblitz.logic.game
{
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.MoveData;
   import com.popcap.flash.bejeweledblitz.logic.MoveFinder;
   
   public class AutoHintLogic implements ITimerLogicHandler
   {
      
      public static const HINT_INTERVAL:int = 500;
       
      
      private var m_Logic:BlitzLogic;
      
      private var m_Moves:Vector.<MoveData>;
      
      private var m_Handlers:Vector.<IAutoHintLogicHandler>;
      
      private var m_Timer:int;
      
      private var m_PrevTime:int;
      
      public function AutoHintLogic(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
         this.m_Moves = new Vector.<MoveData>();
         this.m_Handlers = new Vector.<IAutoHintLogicHandler>();
      }
      
      public function Init() : void
      {
         this.Reset();
         this.m_Logic.timerLogic.AddHandler(this);
      }
      
      public function Reset() : void
      {
         this.m_Moves.length = 0;
         this.m_Timer = HINT_INTERVAL;
         this.m_PrevTime = this.m_Logic.timerLogic.GetGameDuration();
      }
      
      public function AddHandler(handler:IAutoHintLogicHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function HandleTimePhaseBegin() : void
      {
      }
      
      public function HandleTimePhaseEnd() : void
      {
      }
      
      public function HandleGameTimeChange(newTime:int) : void
      {
         var dt:int = this.m_PrevTime - newTime;
         this.m_PrevTime = newTime;
         this.m_Timer -= dt;
         if(this.m_Logic.swaps.length > 0)
         {
            this.m_Timer = HINT_INTERVAL;
         }
         if(this.ShouldHint())
         {
            if(this.m_Timer <= 0)
            {
               this.CreateHint();
               this.m_Timer = HINT_INTERVAL;
            }
         }
         else if(this.m_Timer < 0)
         {
            this.m_Timer = 0;
         }
      }
      
      public function HandleGameDurationChange(prevDuration:int, newDuration:int) : void
      {
      }
      
      private function AllowAutoHint() : Boolean
      {
         var handler:IAutoHintLogicHandler = null;
         var result:Boolean = true;
         for each(handler in this.m_Handlers)
         {
            result = result && handler.AllowAutoHint();
         }
         return result;
      }
      
      private function CreateHint() : void
      {
         var board:Board = this.m_Logic.board;
         var moveFinder:MoveFinder = board.moveFinder;
         moveFinder.FindAllMoves(board,this.m_Moves);
         if(this.m_Moves.length <= 0)
         {
            return;
         }
         var moveData:MoveData = this.m_Moves[0];
         var gem:Gem = moveData.sourceGem;
         gem.isHinted = true;
         this.m_Logic.movePool.FreeMoves(this.m_Moves);
      }
      
      private function ShouldHint() : Boolean
      {
         return !this.m_Logic.isReplay && this.AllowAutoHint();
      }
   }
}
