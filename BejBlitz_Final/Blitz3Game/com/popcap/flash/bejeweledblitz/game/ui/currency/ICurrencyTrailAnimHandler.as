package com.popcap.flash.bejeweledblitz.game.ui.currency
{
   public interface ICurrencyTrailAnimHandler
   {
       
      
      function HandleCurrencyCreated(param1:CurrencyAnimToken) : void;
      
      function HandleCurrencyCollected(param1:CurrencyAnimToken) : void;
   }
}
