package com.popcap.flash.bejeweledblitz.navigation
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   
   public class NavigationBadgeString extends NavigationBadge
   {
       
      
      private var _value:String = "";
      
      public function NavigationBadgeString(param1:Blitz3App)
      {
         super(param1);
      }
      
      public function set value(param1:String) : void
      {
         this._value = param1;
         setStringValue(this._value);
         visible = param1.length > 0;
      }
      
      public function get value() : String
      {
         return this._value;
      }
      
      override public function empty() : Boolean
      {
         return this.value.length <= 0;
      }
   }
}
