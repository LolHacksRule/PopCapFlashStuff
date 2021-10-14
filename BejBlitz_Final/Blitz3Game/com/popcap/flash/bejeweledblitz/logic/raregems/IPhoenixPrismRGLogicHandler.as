package com.popcap.flash.bejeweledblitz.logic.raregems
{
   import com.popcap.flash.bejeweledblitz.logic.gems.phoenixprism.PhoenixPrismHurrahExplodeEvent;
   
   public interface IPhoenixPrismRGLogicHandler
   {
       
      
      function HandlePhoenixPrismHurrahExploded(param1:PhoenixPrismHurrahExplodeEvent) : void;
      
      function HandlePhoenixPrismPrestigeInit() : void;
      
      function HandlePhoenixPrismPrestigeBegin() : void;
      
      function HandlePhoenixPrismPrestigeComplete() : void;
      
      function AllowPhoenixPrismPrestigeComplete() : Boolean;
      
      function HandlePhoenixPrismPointsAwarded(param1:int, param2:int) : void;
   }
}
