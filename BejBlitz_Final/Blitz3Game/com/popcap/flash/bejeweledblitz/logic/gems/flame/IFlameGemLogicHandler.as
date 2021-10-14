package com.popcap.flash.bejeweledblitz.logic.gems.flame
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   
   public interface IFlameGemLogicHandler
   {
       
      
      function handleFlameGemCreated(param1:FlameGemCreateEvent) : void;
      
      function handleFlameGemExploded(param1:FlameGemExplodeEvent) : void;
      
      function handleFlameGemExplosionRange(param1:Gem, param2:Vector.<Gem>) : void;
   }
}
