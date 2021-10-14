package com.popcap.flash.bejeweledblitz.logic.tokens
{
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class CoinTokenPool extends ObjectPool
   {
       
      
      public function CoinTokenPool()
      {
         super();
         PreAllocate(6);
      }
      
      public function GetNextCoinToken(param1:int) : CoinToken
      {
         var _loc2_:CoinToken = GetNextObject() as CoinToken;
         _loc2_.Set(param1);
         return _loc2_;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new CoinToken();
      }
   }
}
