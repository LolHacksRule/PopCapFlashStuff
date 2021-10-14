package com.popcap.flash.bejeweledblitz.logic.gems.star
{
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class StarGemDelayDataPool extends ObjectPool
   {
       
      
      public function StarGemDelayDataPool()
      {
         super();
      }
      
      public function GetNextStarGemDelayData() : StarGemDelayData
      {
         return GetNextObject() as StarGemDelayData;
      }
      
      public function FreeStarGemDelayData(param1:StarGemDelayData) : void
      {
         FreeObject(param1);
      }
      
      public function FreeStarGemDelayDatas(param1:Vector.<StarGemDelayData>) : void
      {
         var _loc2_:StarGemDelayData = null;
         for each(_loc2_ in param1)
         {
            if(_loc2_ != null)
            {
               FreeObject(_loc2_);
            }
         }
         param1.length = 0;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new StarGemDelayData();
      }
   }
}
