package com.popcap.flash.bejeweledblitz.logic.gems
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class MatchEventPool extends ObjectPool
   {
       
      
      public function MatchEventPool()
      {
         super();
         PreAllocate(150);
      }
      
      public function GetNextMatchEvent(gem:Gem) : MatchEvent
      {
         var event:MatchEvent = GetNextObject() as MatchEvent;
         event.Set(gem);
         return event;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new MatchEvent();
      }
   }
}
