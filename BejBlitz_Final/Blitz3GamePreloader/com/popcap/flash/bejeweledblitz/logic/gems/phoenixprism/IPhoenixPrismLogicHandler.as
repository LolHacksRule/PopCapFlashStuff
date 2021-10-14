package com.popcap.flash.bejeweledblitz.logic.gems.phoenixprism
{
   public interface IPhoenixPrismLogicHandler
   {
       
      
      function HandlePhoenixPrismCreated(param1:PhoenixPrismCreateEvent) : void;
      
      function HandlePhoenixPrismExploded(param1:PhoenixPrismExplodeEvent) : void;
   }
}
