package com.popcap.flash.games.bej3.raregems
{
   public interface IRareGem
   {
       
      
      function GetStringID() : String;
      
      function GetOrderingID() : int;
      
      function Init() : void;
      
      function OnStartGame() : void;
   }
}
