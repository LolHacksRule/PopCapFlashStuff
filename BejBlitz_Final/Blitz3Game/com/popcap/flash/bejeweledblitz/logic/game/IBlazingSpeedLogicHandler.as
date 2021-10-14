package com.popcap.flash.bejeweledblitz.logic.game
{
   public interface IBlazingSpeedLogicHandler
   {
       
      
      function HandleBlazingSpeedBegin() : void;
      
      function HandleBlazingSpeedEnd() : void;
      
      function HandleBlazingSpeedReset() : void;
      
      function HandleBlazingSpeedPercentChanged(param1:Number) : void;
   }
}
