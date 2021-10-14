package com.popcap.flash.bejeweledblitz.logic.raregems
{
   public class RGMaxTokenInfo
   {
       
      
      protected var _value:int = 0;
      
      protected var _weight:int = 0;
      
      public function RGMaxTokenInfo()
      {
         super();
      }
      
      public function getValue() : int
      {
         return this._value;
      }
      
      public function getWeight() : int
      {
         return this._weight;
      }
      
      public function setValue(param1:int) : void
      {
         this._value = param1;
      }
      
      public function setWeight(param1:int) : void
      {
         this._weight = param1;
      }
   }
}
