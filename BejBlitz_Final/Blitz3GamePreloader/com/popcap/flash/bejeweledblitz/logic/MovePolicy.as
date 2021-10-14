package com.popcap.flash.bejeweledblitz.logic
{
   public class MovePolicy
   {
       
      
      public var canSwap:Boolean;
      
      public var canSwapNorth:Boolean;
      
      public var canSwapEast:Boolean;
      
      public var canSwapSouth:Boolean;
      
      public var canSwapWest:Boolean;
      
      public var hasMoves:Boolean;
      
      public var hasMoveNorth:Boolean;
      
      public var hasMoveEast:Boolean;
      
      public var hasMoveSouth:Boolean;
      
      public var hasMoveWest:Boolean;
      
      public function MovePolicy()
      {
         super();
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.canSwap = true;
         this.canSwapNorth = true;
         this.canSwapEast = true;
         this.canSwapSouth = true;
         this.canSwapWest = true;
         this.hasMoves = true;
         this.hasMoveNorth = false;
         this.hasMoveEast = false;
         this.hasMoveSouth = false;
         this.hasMoveWest = false;
      }
      
      public function IsSwapAllowed(param1:int, param2:int) : Boolean
      {
         if(param1 < 0 && !this.canSwapWest && !this.hasMoveWest)
         {
            return false;
         }
         if(param1 > 0 && !this.canSwapEast && !this.hasMoveEast)
         {
            return false;
         }
         if(param2 < 0 && !this.canSwapSouth && !this.hasMoveSouth)
         {
            return false;
         }
         if(param2 > 0 && !this.canSwapNorth && !this.hasMoveNorth)
         {
            return false;
         }
         return true;
      }
   }
}
