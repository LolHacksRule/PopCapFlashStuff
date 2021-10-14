package com.popcap.flash.games.bej3
{
   public class MovePool
   {
       
      
      private var mPool:Vector.<MoveData>;
      
      public function MovePool()
      {
         super();
         this.mPool = new Vector.<MoveData>();
      }
      
      public static function allocMove() : MoveData
      {
         return new MoveData();
      }
      
      public static function unallocMove(move:MoveData) : void
      {
      }
   }
}
