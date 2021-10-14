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
      
      public function GetNextCoinToken(value:int) : CoinToken
      {
         var token:CoinToken = GetNextObject() as CoinToken;
         token.Set(value);
         return token;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new CoinToken();
      }
   }
}
