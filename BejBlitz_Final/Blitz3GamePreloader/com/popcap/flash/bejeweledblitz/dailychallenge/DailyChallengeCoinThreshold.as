package com.popcap.flash.bejeweledblitz.dailychallenge
{
   public class DailyChallengeCoinThreshold
   {
       
      
      private var _label:String;
      
      private var _thresholdMin:int;
      
      private var _thresholdMax:int;
      
      public function DailyChallengeCoinThreshold(param1:String, param2:int, param3:int)
      {
         super();
         this._label = param1;
         this._thresholdMin = param2;
         this._thresholdMax = param3;
      }
      
      public function get label() : String
      {
         return this._label;
      }
      
      public function inRange(param1:int) : Boolean
      {
         return param1 >= this._thresholdMin && param1 < this._thresholdMax;
      }
   }
}
