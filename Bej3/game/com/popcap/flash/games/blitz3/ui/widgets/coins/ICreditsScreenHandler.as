package com.popcap.flash.games.blitz3.ui.widgets.coins
{
   public interface ICreditsScreenHandler
   {
       
      
      function HandleCreditsScreenShow() : void;
      
      function HandleCreditsScreenHide() : void;
      
      function HandleCreditsScreenCancel() : void;
      
      function HandleCreditsScreenAccept() : void;
      
      function HandleCreditsScreenTransactionComplete(param1:Boolean) : void;
   }
}
