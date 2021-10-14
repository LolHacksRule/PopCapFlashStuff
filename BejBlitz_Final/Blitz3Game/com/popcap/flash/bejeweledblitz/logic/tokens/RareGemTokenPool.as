package com.popcap.flash.bejeweledblitz.logic.tokens
{
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class RareGemTokenPool extends ObjectPool
   {
       
      
      public function RareGemTokenPool()
      {
         super();
         PreAllocate(6);
      }
      
      public function GetNextRareGemToken(param1:int) : RareGemToken
      {
         var _loc2_:RareGemToken = GetNextObject() as RareGemToken;
         _loc2_.Set(param1);
         return _loc2_;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new RareGemToken();
      }
   }
}
