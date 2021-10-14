package com.popcap.flash.bejeweledblitz.logic.gems.phoenixprism
{
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class PhoenixPrismDelayDataPool extends ObjectPool
   {
       
      
      public function PhoenixPrismDelayDataPool()
      {
         super();
      }
      
      public function GetNextPhoenixPrismDelayData() : PhoenixPrismDelayData
      {
         return GetNextObject() as PhoenixPrismDelayData;
      }
      
      public function FreePhoenixPrismDelayData(param1:PhoenixPrismDelayData) : void
      {
         FreeObject(param1);
      }
      
      public function FreePhoenixPrismDelayDatas(param1:Vector.<PhoenixPrismDelayData>) : void
      {
         var _loc2_:PhoenixPrismDelayData = null;
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
         return new PhoenixPrismDelayData();
      }
   }
}
