package com.popcap.flash.bejeweledblitz.logic.game
{
   public class InfiniteTimeLogic implements ITimerLogicHandler
   {
       
      
      private var m_Logic:BlitzLogic;
      
      private var m_PrevTime:int;
      
      public var isEnabled:Boolean;
      
      public function InfiniteTimeLogic(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
         this.isEnabled = false;
      }
      
      public function Init() : void
      {
         this.m_Logic.timerLogic.AddHandler(this);
      }
      
      public function Reset() : void
      {
         this.isEnabled = false;
         this.m_PrevTime = -1;
      }
      
      public function HandleTimePhaseBegin() : void
      {
      }
      
      public function HandleTimePhaseEnd() : void
      {
      }
      
      public function HandleGameTimeChange(newTime:int) : void
      {
         var dTime:int = 0;
         if(this.isEnabled)
         {
            if(this.m_PrevTime < 0)
            {
               this.m_PrevTime = newTime;
            }
            dTime = this.m_PrevTime - newTime;
            this.m_Logic.timerLogic.SetGameTime(this.m_Logic.timerLogic.GetTimeRemaining() + dTime);
         }
      }
      
      public function HandleGameDurationChange(prevDuration:int, newDuration:int) : void
      {
      }
   }
}
