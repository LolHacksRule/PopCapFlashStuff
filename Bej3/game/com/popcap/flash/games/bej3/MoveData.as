package com.popcap.flash.games.bej3
{
   import flash.geom.Point;
   
   public class MoveData
   {
       
      
      public var type:int = -1;
      
      public var time:int = -1;
      
      public var id:int = -1;
      
      public var isActive:Boolean = true;
      
      public var sourceGem:Gem = null;
      
      public var sourcePos:Point;
      
      public var isSwap:Boolean = false;
      
      public var swapGem:Gem = null;
      
      public var swapDir:Point;
      
      public var swapPos:Point;
      
      public var isSuccessful:Boolean = false;
      
      public var cascades:int = 0;
      
      public var gemsCleared:int = 0;
      
      public var largestMatch:int = 0;
      
      public var flamesMade:int = 0;
      
      public var starsMade:int = 0;
      
      public var hypersMade:int = 0;
      
      public var flamesUsed:int = 0;
      
      public var starsUsed:int = 0;
      
      public var hypersUsed:int = 0;
      
      public function MoveData()
      {
         this.sourcePos = new Point();
         this.swapDir = new Point();
         this.swapPos = new Point();
         super();
      }
   }
}
