package com.popcap.flash.bejeweledblitz.logic.game
{
   public class InfiniteTimeLogic implements ITimerLogicTimeChangeHandler
   {
       
      
      private var m_Logic:BlitzLogic;
      
      private var m_PrevTime:int;
      
      public var isEnabled:Boolean;
      
      public function InfiniteTimeLogic(param1:BlitzLogic)
      {
         super();
         this.m_Logic = param1;
         this.isEnabled = false;
      }
      
      public function Init() : void
      {
         this.m_Logic.timerLogic.AddTimeChangeHandler(this);
      }
      
      public function Reset() : void
      {
         this.isEnabled = false;
         this.m_PrevTime = -1;
      }
      
      public function HandleGameTimeChange(param1:int) : void
      {
         var _loc2_:int = 0;
         if(this.isEnabled)
         {
            if(this.m_PrevTime < 0)
            {
               this.m_PrevTime = param1;
            }
            _loc2_ = this.m_PrevTime - param1;
            this.m_Logic.timerLogic.SetGameTime(this.m_Logic.timerLogic.GetTimeRemaining() + _loc2_);
         }
      }
   }
}
