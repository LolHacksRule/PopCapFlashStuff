package com.popcap.flash.bejeweledblitz.logic.game
{
   public class ColumnData
   {
       
      
      public var moveId:int;
      
      public var matchId:int;
      
      public function ColumnData()
      {
         super();
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.moveId = -1;
         this.matchId = -1;
      }
   }
}
