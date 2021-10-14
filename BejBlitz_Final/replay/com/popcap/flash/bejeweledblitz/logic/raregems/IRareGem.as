package com.popcap.flash.bejeweledblitz.logic.raregems
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   
   public interface IRareGem
   {
       
      
      function GetStringID() : String;
      
      function GetOrderingID() : int;
      
      function Init(param1:BlitzLogic) : void;
      
      function Reset() : void;
      
      function OnStartGame() : void;
   }
}
