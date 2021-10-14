package com.popcap.flash.bejeweledblitz.logic.game
{
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class ScoreDataPool extends ObjectPool
   {
       
      
      public function ScoreDataPool()
      {
         super();
         PreAllocate(150);
      }
      
      public function GetNextScoreData() : ScoreData
      {
         return GetNextObject() as ScoreData;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new ScoreData();
      }
   }
}
