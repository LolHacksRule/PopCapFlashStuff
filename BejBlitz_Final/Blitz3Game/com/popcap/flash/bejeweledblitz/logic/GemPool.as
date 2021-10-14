package com.popcap.flash.bejeweledblitz.logic
{
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class GemPool extends ObjectPool
   {
       
      
      public function GemPool()
      {
         super();
      }
      
      public function GetNextGem() : Gem
      {
         return GetNextObject() as Gem;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new Gem();
      }
   }
}
