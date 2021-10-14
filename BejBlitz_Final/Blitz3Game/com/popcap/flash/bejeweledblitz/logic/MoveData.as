package com.popcap.flash.bejeweledblitz.logic
{
   import com.popcap.flash.framework.pool.IPoolObject;
   
   public class MoveData implements IPoolObject
   {
       
      
      public var type:int;
      
      public var time:int;
      
      public var id:int;
      
      public var isActive:Boolean;
      
      public var sourceGem:Gem;
      
      public var sourcePos:Point2D;
      
      public var isSwap:Boolean;
      
      public var swapGem:Gem;
      
      public var swapDir:Point2D;
      
      public var swapPos:Point2D;
      
      public var isSuccessful:Boolean;
      
      public var cascades:int;
      
      public var gemsCleared:int;
      
      public var largestMatch:int;
      
      public var flamesMade:int;
      
      public var starsMade:int;
      
      public var hypersMade:int;
      
      public var flamesUsed:int;
      
      public var starsUsed:int;
      
      public var hypersUsed:int;
      
      public function MoveData()
      {
         super();
         this.sourcePos = new Point2D();
         this.swapDir = new Point2D();
         this.swapPos = new Point2D();
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.type = -1;
         this.time = -1;
         this.id = -1;
         this.isActive = true;
         this.sourceGem = null;
         this.isSwap = false;
         this.swapGem = null;
         this.sourcePos.Reset();
         this.swapDir.Reset();
         this.swapPos.Reset();
         this.isSuccessful = false;
         this.cascades = 0;
         this.gemsCleared = 0;
         this.largestMatch = 0;
         this.flamesMade = 0;
         this.starsMade = 0;
         this.hypersMade = 0;
         this.flamesUsed = 0;
         this.starsUsed = 0;
         this.hypersUsed = 0;
      }
   }
}
