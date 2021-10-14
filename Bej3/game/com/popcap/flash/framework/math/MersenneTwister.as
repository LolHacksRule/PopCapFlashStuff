package com.popcap.flash.framework.math
{
   public class MersenneTwister implements PseudoRandomNumberGenerator
   {
      
      private static const MTRAND_N:Number = 624;
      
      private static const MTRAND_M:Number = 397;
      
      private static const MATRIX_A:Number = 2567483615;
      
      private static const UPPER_MASK:Number = 2147483648;
      
      private static const LOWER_MASK:Number = 2147483647;
      
      private static const TEMPERING_MASK_B:Number = 2636928640;
      
      private static const TEMPERING_MASK_C:Number = 4022730752;
       
      
      private var mt:Vector.<Number>;
      
      private var y:Number = 0;
      
      private var z:Number = 0;
      
      private var mSeed:Number = 0;
      
      public function MersenneTwister()
      {
         this.mt = new Vector.<Number>();
         super();
      }
      
      public function SetSeed(seed:Number) : void
      {
         if(seed == 0)
         {
            seed = 4357;
         }
         this.mSeed = seed;
         this.mt[0] = seed & 4294967295;
         for(this.z = 1; this.z < MTRAND_N; ++this.z)
         {
            this.mt[this.z] = 1812433253 * (this.mt[this.z - 1] ^ this.mt[this.z - 1] >> 30) + this.z;
            this.mt[this.z] &= 4294967295;
         }
      }
      
      public function Next() : Number
      {
         var i:int = 0;
         var capA:int = 0;
         var capB:int = 0;
         var mag01:Array = [0,MATRIX_A];
         if(this.z >= MTRAND_N)
         {
            i = 0;
            capA = MTRAND_N - MTRAND_M;
            for(i = 0; i < capA; i++)
            {
               this.y = this.mt[i] & UPPER_MASK | this.mt[i + 1] & LOWER_MASK;
               this.mt[i] = this.mt[i + MTRAND_M] ^ this.y >> 1 ^ mag01[this.y & 1];
            }
            for(capB = MTRAND_N - 1; i < capB; )
            {
               this.y = this.mt[i] & UPPER_MASK | this.mt[i + 1] & LOWER_MASK;
               this.mt[i] = this.mt[i + (MTRAND_M - MTRAND_N)] ^ this.y >> 1 ^ mag01[this.y & 1];
               i++;
            }
            this.y = this.mt[MTRAND_N - 1] & UPPER_MASK | this.mt[0] & LOWER_MASK;
            this.mt[MTRAND_N - 1] = this.mt[MTRAND_M - 1] ^ this.y >> 1 ^ mag01[this.y & 1];
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
