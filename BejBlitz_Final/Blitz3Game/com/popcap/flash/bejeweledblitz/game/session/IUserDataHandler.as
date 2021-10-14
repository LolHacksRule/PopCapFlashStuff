package com.popcap.flash.bejeweledblitz.game.session
{
   public interface IUserDataHandler
   {
       
      
      function HandleXPTotalChanged(param1:Number, param2:int) : void;
      
      function HandleBalanceChangedByType(param1:Number, param2:String) : void;
   }
}
