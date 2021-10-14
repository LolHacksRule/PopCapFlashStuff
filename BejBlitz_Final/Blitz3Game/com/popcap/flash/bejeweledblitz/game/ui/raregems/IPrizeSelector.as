package com.popcap.flash.bejeweledblitz.game.ui.raregems
{
   public interface IPrizeSelector
   {
       
      
      function isEnded() : Boolean;
      
      function showMe(param1:String) : void;
      
      function prizePress(param1:uint) : void;
      
      function showRain(param1:String) : void;
      
      function hideRain() : void;
   }
}
