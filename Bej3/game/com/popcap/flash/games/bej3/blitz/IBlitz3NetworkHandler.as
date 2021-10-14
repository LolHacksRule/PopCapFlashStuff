package com.popcap.flash.games.bej3.blitz
{
   public interface IBlitz3NetworkHandler
   {
       
      
      function HandleNetworkError() : void;
      
      function HandleNetworkSuccess() : void;
      
      function HandleBuyCoinsCallback(param1:Boolean) : void;
      
      function HandleExternalPause(param1:Boolean) : void;
      
      function HandleCartClosed(param1:Boolean) : void;
      
      function HandleNetworkGameStart() : void;
   }
}
