package com.popcap.flash.framework.math
{
   public class MersenneTwister implements PseudoRandomNumberGenerator
   {
      
      public static const MT_RAND_N:int = 624;
      
      public static const MT_RAND_M:int = 397;
      
      public static const MATRIX_A:int = 2567483615;
      
      public static const UPPER_MASK:int = 2147483648;
      
      public static const LOWER_MASK:int = 2147483647;
      
      public static const TEMPERING_MASK_B:int = 2636928640;
      
      public static const TEMPERING_MASK_C:int = 4022730752;
      
      public static const MAG01:Vector.<int> = new Vector.<int>(2);
      
      {
         MAG01[0] = 0;
         MAG01[1] = MATRIX_A;
      }
      
      private var mt:Vector.<int>;
      
      private var y:int;
      
      private var z:int;
      
      private var mSeed:int;
      
      public function MersenneTwister()
      {
         super();
         this.mt = new Vector.<int>();
         this.y = 0;
         this.z = 0;
         this.mSeed = 0;
      }
      
      public function SetSeed(seed:int) : void
      {
         var tmp:int = 0;
         if(seed == 0)
         {
            seed = 4357;
         }
         this.mSeed = seed;
         this.mt.length = 0;
         this.mt.push(seed & 4294967295);
         for(this.z = 1; this.z < MT_RAND_N; ++this.z)
         {
            tmp = 1812433253 * (this.mt[this.z - 1] ^ this.mt[this.z - 1] >> 30) + this.z;
            tmp &= 4294967295;
            this.mt.push(tmp);
         }
      }
      
      public function Next() : Number
      {
         var i:int = 0;
         var capA:int = 0;
         var capB:int = 0;
         if(this.z >= MT_RAND_N)
         {
            i = 0;
            capA = MT_RAND_N - MT_RAND_M;
            for(i = 0; i < capA; i++)
            {
               this.y = this.mt[i] & UPPER_MASK | this.mt[i + 1] & LOWER_MASK;
               this.mt[i] = this.mt[i + MT_RAND_M] ^ this.y >> 1 ^ MAG01[this.y & 1];
            }
            capB = MT_RAND_N - 1;
            for(i = i; i < capB; i++)
            {
               this.y = this.mt[i] & UPPER_MASK | this.mt[i + 1] & LOWER_MASK;
               this.mt[i] = this.mt[i + (MT_RAND_M - MT_RAND_N)] ^ this.y >> 1 ^ MAG01[this.y & 1];
            }
            this.y = this.mt[MT_RAND_N - 1] & UPPER_MASK | this.mt[0] & LOWER_MASK;
            this.mt[MT_RAND_N - 1] = this.mt[MT_RAND_M - 1] ^ this.y >> 1 ^ MAG01[this.y & 1];
            this.z = 0;
         }
         this.y = this.mt[this.z++];
         this.y ^= this.y >> 11;
         this.y ^= this.y << 7 & TEMPERING_MASK_B;
         this.y ^= this.y << 15 & TEMPERING_MASK_C;
         this.y ^= this.y >> 18;
         this.y &= 2147483647;
         return this.y / 2147483647;
      }
      
      public function Reset() : void
      {
         this.SetSeed(this.mSeed);
      }
   }
}
