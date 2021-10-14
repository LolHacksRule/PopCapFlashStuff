package com.popcap.flash.bejeweledblitz.logic.gems.multi
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   
   public interface IMultiplierGemLogicHandler
   {
       
      
      function HandleMultiplierSpawned(param1:Gem) : void;
      
      function HandleMultiplierCollected() : void;
   }
}
