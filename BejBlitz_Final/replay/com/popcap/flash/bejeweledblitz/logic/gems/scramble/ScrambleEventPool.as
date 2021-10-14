package com.popcap.flash.bejeweledblitz.logic.gems.scramble
{
   import com.popcap.flash.bejeweledblitz.logic.MoveData;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class ScrambleEventPool extends ObjectPool
   {
       
      
      private var m_Logic:BlitzLogic;
      
      public function ScrambleEventPool(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
         PreAllocate(2);
      }
      
      public function GetNextScrambleEvent(moveData:MoveData) : ScrambleEvent
      {
         var event:ScrambleEvent = GetNextObject() as ScrambleEvent;
         event.Set(moveData);
         return event;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new ScrambleEvent(this.m_Logic);
      }
   }
}
