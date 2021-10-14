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
      
      public function FreeMove(move:MoveData) : void
      {
         FreeObject(move);
      }
      
      public function FreeMoves(moves:Vector.<MoveData>) : void
      {
         var move:MoveData = null;
         for each(move in moves)
         {
            if(move != null)
            {
               FreeObject(move);
            }
         }
         moves.length = 0;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new MoveData();
      }
   }
}
