package com.popcap.flash.bejeweledblitz.logic.game
{
   public interface IBlitzLogicSpawnHandler
   {
       
      
      function HandleLogicSpawnPhaseBegin() : void;
      
      function HandleLogicSpawnPhaseEnd() : void;
      
      function HandlePostLogicSpawnPhase() : void;
   }
}
