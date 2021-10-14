package com.popcap.flash.bejeweledblitz.logic.gems.hypercube
{
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class HypercubeExplodeJumpDataPool extends ObjectPool
   {
       
      
      public function HypercubeExplodeJumpDataPool()
      {
         super();
         PreAllocate(30);
      }
      
      public function GetNextHypercubeExplodeJumpData() : HypercubeExplodeJumpData
      {
         return GetNextObject() as HypercubeExplodeJumpData;
      }
      
      public function FreeHypercubeExplodeJumpDatas(param1:Vector.<HypercubeExplodeJumpData>) : void
      {
         var _loc2_:HypercubeExplodeJumpData = null;
         for each(_loc2_ in param1)
         {
            FreeObject(_loc2_);
         }
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new HypercubeExplodeJumpData();
      }
   }
}
