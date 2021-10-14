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
      
      public function FreeStarGemDelayData(data:StarGemDelayData) : void
      {
         FreeObject(data);
      }
      
      public function FreeStarGemDelayDatas(datas:Vector.<StarGemDelayData>) : void
      {
         var data:StarGemDelayData = null;
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
         return new StarGemDelayData();
      }
   }
}
