package com.popcap.flash.games.bej3.blitz
{
   public interface ITimerLogicHandler
   {
       
      
      function HandleTimePhaseBegin() : void;
      
      function HandleTimePhaseEnd() : void;
      
      function HandleGameTimeChange(param1:int) : void;
      
      function HandleGameDurationChange(param1:int) : void;
   }
}
