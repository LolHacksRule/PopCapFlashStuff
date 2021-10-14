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
      
      public function FreePhoenixPrismDelayData(data:PhoenixPrismDelayData) : void
      {
         FreeObject(data);
      }
      
      public function FreePhoenixPrismDelayDatas(datas:Vector.<PhoenixPrismDelayData>) : void
      {
         var data:PhoenixPrismDelayData = null;
         for each(data in datas)
         {
            if(data != null)
            {
               FreeObject(data);
            }
         }
         datas.length = 0;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new PhoenixPrismDelayData();
      }
   }
}
