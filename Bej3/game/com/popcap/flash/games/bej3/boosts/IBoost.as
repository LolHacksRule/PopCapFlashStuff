package com.popcap.flash.games.bej3.boosts
{
   public interface IBoost
   {
       
      
      function GetStringID() : String;
      
      function GetIntID() : int;
      
      function GetOrderingID() : int;
      
      function OnStartGame() : void;
   }
}
