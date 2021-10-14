package com.popcap.flash.bejeweledblitz.logic.gems.star
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.Match;
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class StarGemCreateEventPool extends ObjectPool
   {
       
      
      public function StarGemCreateEventPool()
      {
         super();
      }
      
      public function GetNextStarGemCreateEvent(locus:Gem, matchA:Match, matchB:Match) : StarGemCreateEvent
      {
         var event:StarGemCreateEvent = GetNextObject() as StarGemCreateEvent;
         event.Set(locus,matchA,matchB);
         return event;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new StarGemCreateEvent();
      }
   }
}
