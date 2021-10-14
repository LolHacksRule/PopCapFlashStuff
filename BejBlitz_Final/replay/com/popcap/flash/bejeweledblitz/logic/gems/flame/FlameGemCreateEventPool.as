package com.popcap.flash.bejeweledblitz.logic.gems.flame
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.Match;
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class FlameGemCreateEventPool extends ObjectPool
   {
       
      
      public function FlameGemCreateEventPool()
      {
         super();
      }
      
      public function GetNextFlameGemCreateEvent(gem:Gem, match:Match) : FlameGemCreateEvent
      {
         var event:FlameGemCreateEvent = GetNextObject() as FlameGemCreateEvent;
         event.Set(gem,match);
         return event;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new FlameGemCreateEvent();
      }
   }
}
