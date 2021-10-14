package com.popcap.flash.bejeweledblitz.logic
{
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class MovePool extends ObjectPool
   {
       
      
      public function MovePool()
      {
         super();
         PreAllocate(80);
      }
      
      public function GetMove() : MoveData
      {
         return GetNextObject() as MoveData;
      }
      
      public function FreeMove(param1:MoveData) : void
      {
         FreeObject(param1);
      }
      
      public function FreeMoves(param1:Vector.<MoveData>) : void
      {
         var _loc2_:MoveData = null;
         for each(_loc2_ in param1)
         {
            if(_loc2_ != null)
            {
               FreeObject(_loc2_);
            }
         }
         param1.length = 0;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new MoveData();
      }
   }
}
