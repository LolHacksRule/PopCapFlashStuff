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
      
      public function GetNextScoreValue(param1:int, param2:int) : ScoreValue
      {
         var _loc3_:ScoreValue = GetNextObject() as ScoreValue;
         _loc3_.Set(param1,param2);
         return _loc3_;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new ScoreValue();
      }
   }
}
