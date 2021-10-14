package com.popcap.flash.bejeweledblitz.game.session
{
   public interface IUserDataHandler
   {
       
      
      function HandleCoinBalanceChanged(param1:int) : void;
      
      function HandleXPTotalChanged(param1:Number, param2:int) : void;
   }
}
