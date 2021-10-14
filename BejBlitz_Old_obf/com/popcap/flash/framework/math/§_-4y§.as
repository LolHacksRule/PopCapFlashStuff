package com.popcap.flash.framework.math
{
   public class §_-4y§ implements §_-bo§
   {
      
      private static const §_-HY§:Number = 2567483615;
      
      private static const §_-RS§:Number = 2147483648;
      
      private static const §_-KP§:Number = 624;
      
      private static const §_-UU§:Number = 2636928640;
      
      private static const §_-Jt§:Number = 4022730752;
      
      private static const §_-Uy§:Number = 2147483647;
      
      private static const §_-OH§:Number = 397;
       
      
      private var z:Number = 0;
      
      private var §_-g0§:Vector.<Number>;
      
      private var y:Number = 0;
      
      private var §_-CN§:Number = 0;
      
      public function §_-4y§()
      {
         this.§_-g0§ = new Vector.<Number>();
         super();
      }
      
      public function §_-QI§() : Number
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:Array = [0,§_-HY§];
         if(this.z >= §_-KP§)
         {
            _loc2_ = 0;
            _loc3_ = §_-KP§ - §_-OH§;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               this.y = this.§_-g0§[_loc2_] & §_-RS§ | this.§_-g0§[_loc2_ + 1] & §_-Uy§;
               this.§_-g0§[_loc2_] = this.§_-g0§[_loc2_ + §_-OH§] ^ this.y >> 1 ^ _loc1_[this.y & 1];
               _loc2_++;
            }
            _loc4_ = §_-KP§ - 1;
            while(_loc2_ < _loc4_)
            {
               this.y = this.§_-g0§[_loc2_] & §_-RS§ | this.§_-g0§[_loc2_ + 1] & §_-Uy§;
               this.§_-g0§[_loc2_] = this.§_-g0§[_loc2_ + (§_-OH§ - §_-KP§)] ^ this.y >> 1 ^ _loc1_[this.y & 1];
               _loc2_++;
            }
            this.y = this.§_-g0§[§_-KP§ - 1] & §_-RS§ | this.§_-g0§[0] & §_-Uy§;
            this.§_-g0§[§_-KP§ - 1] = this.§_-g0§[§_-OH§ - 1] ^ this.y >> 1 ^ _loc1_[this.y & 1];
            this.z = 0;
         }
         this.y = this.§_-g0§[this.z++];
         this.y ^= this.y >> 11;
         this.y ^= this.y << 7 & §_-UU§;
         this.y ^= this.y << 15 & §_-Jt§;
         this.y ^= this.y >> 18;
         this.y &= 2147483647;
         return this.y / 2147483647;
      }
      
      public function §_-9H§(param1:Number) : void
      {
         if(param1 == 0)
         {
            param1 = 4357;
         }
         this.§_-CN§ = param1;
         this.§_-g0§[0] = param1 & 4294967295;
         this.z = 1;
         while(this.z < §_-KP§)
         {
            this.§_-g0§[this.z] = 1812433253 * (this.§_-g0§[this.z - 1] ^ this.§_-g0§[this.z - 1] >> 30) + this.z;
            this.§_-g0§[this.z] &= 4294967295;
            ++this.z;
         }
      }
      
      public function Reset() : void
      {
         this.§_-9H§(this.§_-CN§);
      }
   }
}
