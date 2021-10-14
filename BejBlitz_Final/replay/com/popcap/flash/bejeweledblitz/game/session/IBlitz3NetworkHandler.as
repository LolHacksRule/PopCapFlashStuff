package com.popcap.flash.bejeweledblitz.game.session
{
   public interface IBlitz3NetworkHandler
   {
       
      
      function HandleNetworkError() : void;
      
      function HandleNetworkSuccess(param1:XML) : void;
      
      function HandleBuyCoinsCallback(param1:Boolean) : void;
      
      function HandleExternalPause(param1:Boolean) : void;
      
      function HandleCartClosed(param1:Boolean) : void;
      
      function HandleNetworkGameStart() : void;
   }
}
