package com.popcap.flash.bejeweledblitz.logic.boosts
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   
   public interface IBoost
   {
       
      
      function Init(param1:BlitzLogic) : void;
      
      function Reset() : void;
      
      function AddHandler(param1:IBoostHandler) : void;
      
      function GetStringID() : String;
      
      function GetIntID() : int;
      
      function GetOrderingID() : int;
      
      function OnStartGame() : void;
   }
}
