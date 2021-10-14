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
         var obj:IPoolObject = null;
         for each(obj in this.m_History)
         {
            obj.Reset();
         }
         this.m_HistoryIndex = 0;
         this.m_Pool.length = 0;
         this.m_PoolSize = 0;
      }
      
      protected function GetNextObject() : IPoolObject
      {
         var obj:IPoolObject = null;
         if(this.m_PoolSize > 0)
         {
            obj = this.m_Pool.pop();
            --this.m_PoolSize;
         }
         else if(this.m_HistoryIndex < this.m_History.length)
         {
            obj = this.m_History[this.m_HistoryIndex];
            ++this.m_HistoryIndex;
         }
         else
         {
            obj = this.GetNewObjectInstance();
            this.m_History.push(obj);
            ++this.m_HistoryIndex;
         }
         obj.Reset();
         return obj;
      }
      
      protected function GetNewObjectInstance() : IPoolObject
      {
         return null;
      }
      
      protected function FreeObject(obj:IPoolObject) : void
      {
         obj.Reset();
         this.m_Pool.push(obj);
         ++this.m_PoolSize;
      }
      
      protected function PreAllocate(size:int) : void
      {
         var obj:IPoolObject = null;
         for(var i:int = 0; i < size; i++)
         {
            obj = this.GetNewObjectInstance();
            this.m_History.push(obj);
         }
      }
   }
}
