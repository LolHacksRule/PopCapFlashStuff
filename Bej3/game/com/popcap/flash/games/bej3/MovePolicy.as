package com.popcap.flash.games.bej3
{
   public class MovePolicy
   {
       
      
      public var canSwap:Boolean = true;
      
      public var canSwapNorth:Boolean = true;
      
      public var canSwapEast:Boolean = true;
      
      public var canSwapSouth:Boolean = true;
      
      public var canSwapWest:Boolean = true;
      
      public var hasMoves:Boolean = true;
      
      public var hasMoveNorth:Boolean = false;
      
      public var hasMoveEast:Boolean = false;
      
      public var hasMoveSouth:Boolean = false;
      
      public var hasMoveWest:Boolean = false;
      
      public function MovePolicy()
      {
         super();
      }
   }
}
