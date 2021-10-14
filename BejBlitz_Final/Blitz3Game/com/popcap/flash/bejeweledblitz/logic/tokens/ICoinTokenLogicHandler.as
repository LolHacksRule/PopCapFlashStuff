package com.popcap.flash.bejeweledblitz.logic.tokens
{
   public interface ICoinTokenLogicHandler
   {
       
      
      function HandleCoinCreated(param1:CoinToken) : void;
      
      function HandleCoinCollected(param1:CoinToken) : void;
      
      function HandleMultiCoinCollectionSkipped(param1:int) : void;
   }
}
