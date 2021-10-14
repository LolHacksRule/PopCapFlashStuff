package com.popcap.flash.bejeweledblitz.navigation
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   
   public class NavigationBadgeCounter extends NavigationBadge
   {
       
      
      private var _value:int = 0;
      
      public function NavigationBadgeCounter(param1:Blitz3App)
      {
         super(param1);
      }
      
      public function set value(param1:int) : void
      {
         this._value = param1;
         setStringValue(this._value.toString());
         visible = this._value > 0;
      }
      
      public function get value() : int
      {
         return this._value;
      }
      
      override public function empty() : Boolean
      {
         return this.value <= 0;
      }
   }
}
