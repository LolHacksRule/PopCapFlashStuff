package com.popcap.flash.games.blitz3.ui.widgets.boosts
{
   import flash.events.Event;
   
   public class §_-Mc§ extends Event
   {
      
      public static const BOOST_BUTTON_PRESSED:String = "BOOST_BUTTON_PRESSED";
       
      
      public var § get§:String;
      
      public var §_-HB§:§_-Ya§;
      
      public function §_-Mc§(param1:§_-Ya§)
      {
         super(BOOST_BUTTON_PRESSED);
         this.§ get§ = param1.name;
         this.§_-HB§ = param1;
      }
   }
}
