package com.popcap.flash.bejeweledblitz.logic.game
{
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class ReplayDataPool extends ObjectPool
   {
       
      
      public function ReplayDataPool()
      {
         super();
         PreAllocate(100);
      }
      
      public function GetNextReplayData() : ReplayData
      {
         return GetNextObject() as ReplayData;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new ReplayData();
      }
   }
}
