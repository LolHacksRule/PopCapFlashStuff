package com.popcap.flash.framework.input.keyboard
{
   import flash.events.KeyboardEvent;
   
   public class §_-4Y§ implements KeyboardCheck
   {
       
      
      private var §_-eu§:Boolean = false;
      
      private var §_-Do§:Boolean = false;
      
      private var §_-br§:Boolean = false;
      
      private var §_-ox§:Boolean = false;
      
      private var §_-di§:uint = 0;
      
      public function §_-4Y§(param1:uint, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false)
      {
         super();
         this.§_-di§ = param1;
         this.§_-ox§ = param2;
         this.§_-Do§ = param3;
         this.§_-eu§ = param4;
         this.§_-br§ = param5;
      }
      
      public function §_-m6§(param1:KeyboardEvent) : Boolean
      {
         if(this.§_-ox§)
         {
            if(this.§_-Do§ != param1.shiftKey)
            {
               return false;
            }
            if(this.§_-eu§ != param1.ctrlKey)
            {
               return false;
            }
            if(this.§_-br§ != param1.altKey)
            {
               return false;
            }
         }
         return param1.charCode == this.§_-di§;
      }
   }
}
