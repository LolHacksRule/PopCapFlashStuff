package com.popcap.flash.bejeweledblitz.dailyspin.misc
{
   public class FrameTicker
   {
       
      
      private var m_Ticks:int;
      
      private var m_ElapsedTicks:int;
      
      private var m_Function:Function;
      
      public function FrameTicker()
      {
         super();
      }
      
      public function init(numTicks:int, func:Function) : void
      {
         this.m_Ticks = numTicks;
         this.m_ElapsedTicks = 0;
         this.m_Function = func;
      }
      
      public function update() : void
      {
         if(this.m_ElapsedTicks++ > this.m_Ticks)
         {
            this.m_Function();
            this.m_ElapsedTicks = 0;
         }
      }
      
      public function reset() : void
      {
         this.m_ElapsedTicks = 0;
      }
   }
}
