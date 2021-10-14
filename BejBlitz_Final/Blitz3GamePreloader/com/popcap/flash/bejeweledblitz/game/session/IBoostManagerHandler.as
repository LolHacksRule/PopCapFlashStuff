package com.popcap.flash.bejeweledblitz.game.session
{
   import flash.utils.Dictionary;
   
   public interface IBoostManagerHandler
   {
       
      
      function HandleBoostCatalogChanged(param1:Dictionary) : void;
      
      function HandleActiveBoostsChanged(param1:Dictionary) : void;
      
      function HandleBoostAutorenew(param1:Vector.<String>) : void;
      
      function HandleBoostAutonewFailedPricesChanged() : void;
   }
}
