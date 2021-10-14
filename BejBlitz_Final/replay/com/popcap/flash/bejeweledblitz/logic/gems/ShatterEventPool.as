package com.popcap.flash.bejeweledblitz.logic.gems
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class ShatterEventPool extends ObjectPool
   {
       
      
      public function ShatterEventPool()
      {
         super();
         PreAllocate(75);
      }
      
      public function GetNextShatterEvent(gem:Gem) : ShatterEvent
      {
         var event:ShatterEvent = GetNextObject() as ShatterEvent;
         event.Set(gem);
         return event;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new ShatterEvent();
      }
   }
}
