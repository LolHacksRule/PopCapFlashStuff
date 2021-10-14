package com.popcap.flash.bejeweledblitz.game.replay
{
   public class BoostReplayData
   {
       
      
      public var _name:String;
      
      public var _level:int;
      
      public var _checkSum:String;
      
      public function BoostReplayData()
      {
         super();
      }
      
      public function CleanUp() : void
      {
         this._name = "";
         this._level = -1;
         this._checkSum = "";
      }
   }
}
