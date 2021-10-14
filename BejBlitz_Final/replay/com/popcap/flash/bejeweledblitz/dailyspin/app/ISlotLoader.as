package com.popcap.flash.bejeweledblitz.dailyspin.app
{
   public interface ISlotLoader
   {
       
      
      function getSymbolLoader() : ISymbolLoader;
      
      function getPrizeDefinitions() : Vector.<IPrizeDefinition>;
      
      function getNumSlots() : int;
   }
}
