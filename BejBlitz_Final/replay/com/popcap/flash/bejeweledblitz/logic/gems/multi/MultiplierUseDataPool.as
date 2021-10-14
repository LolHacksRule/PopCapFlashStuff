package com.popcap.flash.bejeweledblitz.logic.gems.multi
{
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class MultiplierUseDataPool extends ObjectPool
   {
       
      
      public function MultiplierUseDataPool()
      {
         super();
         PreAllocate(4);
      }
      
      public function GetNextMultiplierUseData() : MultiplierUseData
      {
         return GetNextObject() as MultiplierUseData;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new MultiplierUseData();
      }
   }
}
