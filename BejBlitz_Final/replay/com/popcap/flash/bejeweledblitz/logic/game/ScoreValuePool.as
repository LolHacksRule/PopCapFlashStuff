package com.popcap.flash.bejeweledblitz.logic.game
{
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class ScoreValuePool extends ObjectPool
   {
       
      
      public function ScoreValuePool()
      {
         super();
         PreAllocate(400);
      }
      
      public function GetNextScoreValue(points:int, time:int) : ScoreValue
      {
         var value:ScoreValue = GetNextObject() as ScoreValue;
         value.Set(points,time);
         return value;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new ScoreValue();
      }
   }
}
