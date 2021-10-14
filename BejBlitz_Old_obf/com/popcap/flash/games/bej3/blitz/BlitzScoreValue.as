package com.popcap.flash.games.bej3.blitz
{
   import §_-PB§.§_-X4§;
   
   public class BlitzScoreValue
   {
       
      
      public var value:int = 0;
      
      public var §_-NV§:§_-X4§;
      
      public var time:int = 0;
      
      public function BlitzScoreValue()
      {
         super();
         this.§_-NV§ = new §_-X4§();
      }
      
      public function toString() : String
      {
         var _loc1_:* = "";
         var _loc2_:Array = this.§_-NV§.§_-Ac§();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_ += _loc2_[0] + " ";
            _loc3_++;
         }
         _loc1_ = "[" + _loc1_ + "]";
         return this.value.toString() + " " + _loc1_;
      }
      
      public function Reset() : void
      {
         this.value = 0;
         this.time = 0;
         this.§_-NV§.clear();
      }
   }
}
