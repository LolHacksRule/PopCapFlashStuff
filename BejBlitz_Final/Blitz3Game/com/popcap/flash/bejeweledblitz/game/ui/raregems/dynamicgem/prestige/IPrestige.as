package com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.prestige
{
   import flash.display.MovieClip;
   
   public interface IPrestige
   {
       
      
      function getPrizeSelector(param1:String) : MovieClip;
      
      function runsPrizes() : Boolean;
      
      function forceOutro() : Boolean;
      
      function prizeTextUpdated() : Boolean;
      
      function setPrizeTextUpdated() : void;
      
      function timePrizeTextUpdated() : Boolean;
      
      function setTimePrizeTextUpdated() : void;
      
      function onShowPrizesFrame(param1:String) : void;
   }
}
