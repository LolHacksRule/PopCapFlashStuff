package com.popcap.flash.bejeweledblitz.logic
{
   import com.popcap.flash.framework.math.PseudoRandomNumberGenerator;
   
   public class BlitzRandom
   {
       
      
      private var m_PRNG:PseudoRandomNumberGenerator;
      
      private var count:int;
      
      public function BlitzRandom(param1:PseudoRandomNumberGenerator)
      {
         super();
         this.m_PRNG = param1;
         this.count = 0;
      }
      
      public function SetSeed(param1:int) : void
      {
         this.Reset();
         this.m_PRNG.SetSeed(param1);
      }
      
      public function Next() : Number
      {
         var _loc1_:Number = this.m_PRNG.Next();
         ++this.count;
         return _loc1_;
      }
      
      public function Float(param1:Number, param2:Number) : Number
      {
         return this.Next() * (param2 - param1) + param1;
      }
      
      public function Bool(param1:Number) : Boolean
      {
         return this.Next() < param1;
      }
      
      public function Int(param1:Number, param2:Number) : int
      {
         return Math.floor(this.Float(param1,param2));
      }
      
      public function Reset() : void
      {
         this.count = 0;
      }
   }
}
