package com.popcap.flash.bejeweledblitz.logic.gems.hypercube
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.Match;
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class HypercubeCreateEventPool extends ObjectPool
   {
       
      
      public function HypercubeCreateEventPool()
      {
         super();
      }
      
      public function GetNextHypercubeCreateEvent(gem:Gem, match:Match) : HypercubeCreateEvent
      {
         var event:HypercubeCreateEvent = GetNextObject() as HypercubeCreateEvent;
         event.Set(gem,match);
         return event;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new HypercubeCreateEvent();
      }
   }
}
