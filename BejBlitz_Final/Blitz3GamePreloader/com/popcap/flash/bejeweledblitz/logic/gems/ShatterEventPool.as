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
      
      public function GetNextShatterEvent(param1:Gem) : ShatterEvent
      {
         var _loc2_:ShatterEvent = GetNextObject() as ShatterEvent;
         _loc2_.Set(param1);
         return _loc2_;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new ShatterEvent();
      }
   }
}
