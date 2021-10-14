package com.popcap.flash.bejeweledblitz.logic.gems.phoenixprism
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.Match;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class PhoenixPrismCreateEventPool extends ObjectPool
   {
       
      
      public function PhoenixPrismCreateEventPool(logic:BlitzLogic)
      {
         super();
      }
      
      public function GetNextPhoenixPrismCreateEvent(gem:Gem, match:Match) : PhoenixPrismCreateEvent
      {
         var event:PhoenixPrismCreateEvent = GetNextObject() as PhoenixPrismCreateEvent;
         event.Set(gem,match);
         return event;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new PhoenixPrismCreateEvent();
      }
   }
}
