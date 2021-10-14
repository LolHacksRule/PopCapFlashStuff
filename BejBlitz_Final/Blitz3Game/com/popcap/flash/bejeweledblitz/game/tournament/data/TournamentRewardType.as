package com.popcap.flash.bejeweledblitz.game.tournament.data
{
   public class TournamentRewardType
   {
       
      
      private var _type:String;
      
      private var _data:String;
      
      private var _amount:int;
      
      public function TournamentRewardType(param1:String, param2:String, param3:int)
      {
         super();
         this._type = param1;
         this._data = param2;
         this._amount = param3;
      }
      
      public function get Type() : String
      {
         return this._type;
      }
      
      public function get Data() : String
      {
         return this._data;
      }
      
      public function get Amount() : int
      {
         return this._amount;
      }
      
      public function set amount(param1:int) : void
      {
         this._amount = param1;
      }
   }
}
