package com.popcap.flash.framework.input.keyboard
{
   import flash.events.KeyboardEvent;
   
   public class §_-pA§ implements KeyboardCheck
   {
       
      
      private var §_-cD§:Boolean = false;
      
      private var §_-Cq§:int = 0;
      
      private var §_-Li§:Vector.<KeyboardCheck>;
      
      public function §_-pA§(param1:Boolean = false)
      {
         super();
         this.§_-cD§ = param1;
         this.§_-Li§ = new Vector.<KeyboardCheck>();
      }
      
      public function §_-m6§(param1:KeyboardEvent) : Boolean
      {
         if(this.§_-Cq§ >= this.§_-Li§.length)
         {
            return false;
         }
         var _loc2_:KeyboardCheck = this.§_-Li§[this.§_-Cq§];
         if(_loc2_.§_-m6§(param1))
         {
            ++this.§_-Cq§;
            if(this.§_-Cq§ >= this.§_-Li§.length)
            {
               this.Reset();
               return true;
            }
            return false;
         }
         if(this.§_-cD§)
         {
            if(this.§_-Cq§ == 0)
            {
               return false;
            }
            this.Reset();
            this.§_-m6§(param1);
            return false;
         }
         return false;
      }
      
      public function Reset() : void
      {
         this.§_-Cq§ = 0;
      }
      
      public function Clear() : void
      {
         this.§_-Li§.length = 0;
         this.§_-Cq§ = 0;
      }
      
      public function §_-Vv§(param1:KeyboardCheck) : void
      {
         this.§_-Li§.push(param1);
      }
   }
}
