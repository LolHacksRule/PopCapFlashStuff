package com.popcap.flash.framework.math
{
   public class MersenneTwister implements PseudoRandomNumberGenerator
   {
      
      public static const MT_RAND_N:int = 624;
      
      public static const MT_RAND_M:int = 397;
      
      public static const MATRIX_A:uint = 2567483615;
      
      public static const UPPER_MASK:uint = 2147483648;
      
      public static const LOWER_MASK:uint = 2147483647;
      
      public static const TEMPERING_MASK_B:uint = 2636928640;
      
      public static const TEMPERING_MASK_C:uint = 4022730752;
      
      public static const MAG01:Vector.<uint> = new Vector.<uint>(2);
      
      {
         MAG01[0] = 0;
         MAG01[1] = MATRIX_A;
      }
      
      private var mt:Vector.<uint>;
      
      private var y:uint;
      
      private var z:int;
      
      private var mSeed:int;
      
      public function MersenneTwister()
      {
         super();
         this.mt = new Vector.<uint>();
         this.y = 0;
         this.z = 0;
         this.mSeed = 0;
      }
      
      public function SetSeed(param1:uint) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         if(param1 == 0)
         {
            param1 = 4357;
         }
         this.mSeed = param1;
         this.mt.length = 0;
         this.mt.push(param1 & 4294967295);
         this.z = 1;
         while(this.z < MT_RAND_N)
         {
            _loc2_ = this.mt[this.z - 1] ^ this.mt[this.z - 1] >>> 30;
            _loc3_ = (1812433253 * ((_loc2_ & 4294901760) >>> 16) << 16) + 1812433253 * (_loc2_ & 65535) + this.z;
            _loc3_ &= 4294967295;
            this.mt.push(_loc3_);
            ++this.z;
         }
      }
      
      public function Next() : Number
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this.z >= MT_RAND_N)
         {
            _loc1_ = 0;
            _loc2_ = MT_RAND_N - MT_RAND_M;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               this.y = this.mt[_loc1_] & UPPER_MASK | this.mt[_loc1_ + 1] & LOWER_MASK;
               this.mt[_loc1_] = this.mt[_loc1_ + MT_RAND_M] ^ this.y >>> 1 ^ MAG01[this.y & 1];
               _loc1_++;
            }
            _loc3_ = MT_RAND_N - 1;
            _loc1_ = _loc1_;
            while(_loc1_ < _loc3_)
            {
               this.y = this.mt[_loc1_] & UPPER_MASK | this.mt[_loc1_ + 1] & LOWER_MASK;
               this.mt[_loc1_] = this.mt[_loc1_ + (MT_RAND_M - MT_RAND_N)] ^ this.y >>> 1 ^ MAG01[this.y & 1];
               _loc1_++;
            }
            this.y = this.mt[MT_RAND_N - 1] & UPPER_MASK | this.mt[0] & LOWER_MASK;
            this.mt[MT_RAND_N - 1] = this.mt[MT_RAND_M - 1] ^ this.y >>> 1 ^ MAG01[this.y & 1];
            this.z = 0;
         }
         this.y = this.mt[this.z++];
         this.y ^= this.y >>> 11;
         this.y ^= this.y << 7 & TEMPERING_MASK_B;
         this.y ^= this.y << 15 & TEMPERING_MASK_C;
         this.y ^= this.y >>> 18;
         this.y &= 2147483647;
         return this.y / 2147483647;
      }
      
      public function Reset() : void
      {
         this.SetSeed(this.mSeed);
      }
   }
}
