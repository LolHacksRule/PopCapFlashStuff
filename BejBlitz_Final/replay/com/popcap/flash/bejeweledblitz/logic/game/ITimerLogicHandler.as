package com.popcap.flash.bejeweledblitz.logic.game
{
   public interface ITimerLogicHandler
   {
       
      
      function HandleTimePhaseBegin() : void;
      
      function HandleTimePhaseEnd() : void;
      
      function HandleGameTimeChange(param1:int) : void;
      
      function HandleGameDurationChange(param1:int, param2:int) : void;
   }
}
