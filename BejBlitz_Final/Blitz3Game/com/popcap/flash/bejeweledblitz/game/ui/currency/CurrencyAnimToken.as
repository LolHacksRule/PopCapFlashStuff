package com.popcap.flash.bejeweledblitz.game.ui.currency
{
   import flash.display.MovieClip;
   
   public class CurrencyAnimToken
   {
       
      
      public var id:int;
      
      public var value:int;
      
      public var container:MovieClip;
      
      public var type:String;
      
      public function CurrencyAnimToken(param1:int, param2:MovieClip, param3:String)
      {
         super();
         this.value = param1;
         this.container = param2;
         this.type = param3;
      }
   }
}
