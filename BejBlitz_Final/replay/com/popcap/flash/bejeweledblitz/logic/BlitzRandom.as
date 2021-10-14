package com.popcap.flash.bejeweledblitz.logic
{
   import com.popcap.flash.framework.math.PseudoRandomNumberGenerator;
   
   public class BlitzRandom
   {
       
      
      private var m_PRNG:PseudoRandomNumberGenerator;
      
      public function BlitzRandom(prng:PseudoRandomNumberGenerator)
      {
         super();
         this.m_PRNG = prng;
      }
      
      public function SetSeed(seed:int) : void
      {
         this.m_PRNG.SetSeed(seed);
      }
      
      public function Next() : Number
      {
         return this.m_PRNG.Next();
      }
      
      public function Float(min:Number, max:Number) : Number
      {
         return this.Next() * (max - min) + min;
      }
      
      public function Bool(chance:Number) : Boolean
      {
         return this.Next() < chance;
      }
      
      public function Int(min:Number, max:Number) : int
      {
         return Math.floor(this.Float(min,max));
      }
      
      public function Reset() : void
      {
         this.m_PRNG.Reset();
      }
   }
}
