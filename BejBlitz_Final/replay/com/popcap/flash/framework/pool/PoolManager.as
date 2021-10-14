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
         var pool:ObjectPool = null;
         for each(pool in this.m_Pools)
         {
            pool.Reset();
         }
      }
      
      public function AddPool(pool:ObjectPool) : void
      {
         this.m_Pools.push(pool);
      }
   }
}
