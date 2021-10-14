package com.popcap.flash.framework.pool
{
   public class ObjectPool
   {
       
      
      private var m_History:Vector.<IPoolObject>;
      
      private var m_Pool:Vector.<IPoolObject>;
      
      private var m_HistoryIndex:int;
      
      private var m_PoolSize:int;
      
      public function ObjectPool()
      {
         super();
         this.m_History = new Vector.<IPoolObject>();
         this.m_Pool = new Vector.<IPoolObject>();
      }
      
      public function Reset() : void
      {
         var _loc1_:IPoolObject = null;
         for each(_loc1_ in this.m_History)
         {
            _loc1_.Reset();
         }
         this.m_HistoryIndex = 0;
         this.m_Pool.length = 0;
         this.m_PoolSize = 0;
      }
      
      protected function GetNextObject() : IPoolObject
      {
         var _loc1_:IPoolObject = null;
         if(this.m_PoolSize > 0)
         {
            _loc1_ = this.m_Pool.pop();
            --this.m_PoolSize;
         }
         else if(this.m_HistoryIndex < this.m_History.length)
         {
            _loc1_ = this.m_History[this.m_HistoryIndex];
            ++this.m_HistoryIndex;
         }
         else
         {
            _loc1_ = this.GetNewObjectInstance();
            this.m_History.push(_loc1_);
            ++this.m_HistoryIndex;
         }
         _loc1_.Reset();
         return _loc1_;
      }
      
      protected function GetNewObjectInstance() : IPoolObject
      {
         return null;
      }
      
      protected function FreeObject(param1:IPoolObject) : void
      {
         param1.Reset();
         this.m_Pool.push(param1);
         ++this.m_PoolSize;
      }
      
      protected function PreAllocate(param1:int) : void
      {
         var _loc3_:IPoolObject = null;
         var _loc2_:int = 0;
         while(_loc2_ < param1)
         {
            _loc3_ = this.GetNewObjectInstance();
            this.m_History.push(_loc3_);
            _loc2_++;
         }
      }
   }
}
