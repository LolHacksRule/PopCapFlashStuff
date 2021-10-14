package com.popcap.flash.framework.pool
{
   public class PoolManager
   {
       
      
      private var m_Pools:Vector.<ObjectPool>;
      
      public function PoolManager()
      {
         super();
         this.m_Pools = new Vector.<ObjectPool>();
      }
      
      public function ResetPools() : void
      {
         var _loc1_:ObjectPool = null;
         for each(_loc1_ in this.m_Pools)
         {
            _loc1_.Reset();
         }
      }
      
      public function AddPool(param1:ObjectPool) : void
      {
         this.m_Pools.push(param1);
      }
   }
}
