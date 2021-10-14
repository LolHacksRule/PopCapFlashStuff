package com.popcap.flash.framework.events
{
   public class EventContext
   {
       
      
      private var §_-Hc§:§_-3D§ = null;
      
      private var §_-Jj§:String = null;
      
      private var §_-Ys§:Object = null;
      
      private var §_-Ww§:Boolean = false;
      
      private var §_-Bf§:Boolean = false;
      
      public function EventContext()
      {
         super();
      }
      
      public function §_-fw§() : Object
      {
         return this.§_-Ys§;
      }
      
      public function §_-mD§() : void
      {
         this.§_-Ww§ = true;
      }
      
      public function §_-lW§() : void
      {
         this.§_-Bf§ = true;
      }
      
      public function §_-Cl§() : Boolean
      {
         return this.§_-Ww§;
      }
      
      public function Reset(param1:§_-3D§, param2:String, param3:Object) : void
      {
         this.§_-Hc§ = param1;
         this.§_-Jj§ = param2;
         this.§_-Ys§ = param3;
         this.§_-Ww§ = false;
         this.§_-Bf§ = false;
      }
      
      public function §_-Y6§() : String
      {
         return this.§_-Jj§;
      }
      
      public function §_-8E§() : Boolean
      {
         return this.§_-Bf§;
      }
      
      public function §_-id§() : §_-3D§
      {
         return this.§_-Hc§;
      }
   }
}
