package com.popcap.flash.bejeweledblitz.logic.gems.hypercube
{
   public interface IHypercubeLogicHandler
   {
       
      
      function HandleHypercubeCreated(param1:HypercubeCreateEvent) : void;
      
      function HandleHypercubeExploded(param1:HypercubeExplodeEvent) : void;
   }
}
