package com.popcap.flash.framework.math
{
   public class §_-fO§
   {
       
      
      private var §_-QT§:§_-bo§;
      
      public function §_-fO§(param1:§_-bo§)
      {
         super();
         this.§_-QT§ = param1;
      }
      
      public function §_-eZ§(param1:Number = 0.5) : Boolean
      {
         return this.§_-QI§() < param1;
      }
      
      public function §_-QI§() : Number
      {
         return this.§_-QT§.§_-QI§();
      }
      
      public function §_-9H§(param1:Number) : void
      {
         this.§_-QT§.§_-9H§(param1);
      }
      
      public function §_-U§(param1:Number = 0.5, param2:uint = 0) : int
      {
         return this.§_-QI§() < param1 ? 1 << param2 : 0;
      }
      
      public function Reset() : void
      {
         this.§_-QT§.Reset();
      }
      
      public function §_-Hx§(param1:Number, param2:Number = NaN) : Number
      {
         if(isNaN(param2))
         {
            param2 = param1;
            param1 = 0;
         }
         return this.§_-QI§() * (param2 - param1) + param1;
      }
      
      public function §_-nQ§(param1:Number = 0.5) : int
      {
         return this.§_-QI§() < param1 ? 1 : -1;
      }
      
      public function §_-Nn§(param1:Number, param2:Number = NaN) : int
      {
         if(isNaN(param2))
         {
            param2 = param1;
            param1 = 0;
         }
         return int(this.§_-Hx§(param1,param2));
      }
   }
}
