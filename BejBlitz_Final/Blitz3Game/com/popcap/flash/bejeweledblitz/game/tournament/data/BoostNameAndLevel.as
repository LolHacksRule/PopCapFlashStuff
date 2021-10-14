package com.popcap.flash.bejeweledblitz.game.tournament.data
{
   public class BoostNameAndLevel
   {
       
      
      private var _name:String;
      
      private var _level:int;
      
      private var _extraInfo:String;
      
      public function BoostNameAndLevel()
      {
         super();
         this._name = "";
         this._level = 0;
         this._extraInfo = "";
      }
      
      public function get Name() : String
      {
         return this._name;
      }
      
      public function set Name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function get Level() : int
      {
         return this._level;
      }
      
      public function set Level(param1:int) : void
      {
         this._level = param1;
      }
      
      public function get ExtraInfo() : String
      {
         return this._extraInfo;
      }
      
      public function set ExtraInfo(param1:String) : void
      {
         this._extraInfo = param1;
      }
      
      public function compare(param1:BoostNameAndLevel) : Boolean
      {
         return this._name == param1._name && this._level == param1._level;
      }
   }
}
