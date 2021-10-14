package com.popcap.flash.bejeweledblitz.logic.game
{
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class CascadeScorePool extends ObjectPool
   {
       
      
      public function CascadeScorePool()
      {
         super();
         PreAllocate(100);
      }
      
      public function GetNextCascadeScore() : CascadeScore
      {
         return GetNextObject() as CascadeScore;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new CascadeScore();
      }
   }
}
