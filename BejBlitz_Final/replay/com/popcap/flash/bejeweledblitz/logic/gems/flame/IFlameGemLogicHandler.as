package com.popcap.flash.bejeweledblitz.logic.gems.flame
{
   public interface IFlameGemLogicHandler
   {
       
      
      function HandleFlameGemCreated(param1:FlameGemCreateEvent) : void;
      
      function HandleFlameGemExploded(param1:FlameGemExplodeEvent) : void;
   }
}
