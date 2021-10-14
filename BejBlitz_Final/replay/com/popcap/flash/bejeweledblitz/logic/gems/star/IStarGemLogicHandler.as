package com.popcap.flash.bejeweledblitz.logic.gems.star
{
   public interface IStarGemLogicHandler
   {
       
      
      function HandleStarGemCreated(param1:StarGemCreateEvent) : void;
      
      function HandleStarGemExploded(param1:StarGemExplodeEvent) : void;
   }
}
