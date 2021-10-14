package com.popcap.flash.framework.math
{
   public class Random
   {
       
      
      private var mPRNG:PseudoRandomNumberGenerator;
      
      public function Random(prng:PseudoRandomNumberGenerator)
      {
         super();
         this.mPRNG = prng;
      }
      
      public function SetSeed(seed:Number) : void
      {
         this.mPRNG.SetSeed(seed);
      }
      
      public function Next() : Number
      {
         return this.mPRNG.Next();
      }
      
      public function Float(min:Number, max:Number = NaN) : Number
      {
         if(isNaN(max))
         {
            max = min;
            min = 0;
         }
         return this.Next() * (max - min) + min;
      }
      
      public function Bool(chance:Number = 0.5) : Boolean
      {
         return this.Next() < chance;
      }
      
      public function Sign(chance:Number = 0.5) : int
      {
         return this.Next() < chance ? int(1) : int(-1);
      }
      
      public function Bit(chance:Number = 0.5, shift:uint = 0) : int
      {
         return this.Next() < chance ? int(1 << shift) : int(0);
      }
      
      public function Int(min:Number, max:Number = NaN) : int
      {
         if(isNaN(max))
         {
            max = min;
            min = 0;
         }
         return int(this.Float(min,max));
      }
      
      public function Reset() : void
      {
         this.mPRNG.Reset();
      }
   }
}
