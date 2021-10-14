package com.popcap.flash.games.bej3.blitz
{
   import flash.events.Event;
   
   public class §_-Rh§ extends Event
   {
      
      public static const §_-fU§:String = "Compliments:OnCompliment";
      
      public static const §_-3E§:String = "Compliments:Reset";
       
      
      private var §_-XI§:int = -1;
      
      public function §_-Rh§(param1:int)
      {
         super(§_-fU§);
         this.§_-XI§ = param1;
      }
      
      public function get level() : int
      {
         return this.§_-XI§;
      }
   }
}
