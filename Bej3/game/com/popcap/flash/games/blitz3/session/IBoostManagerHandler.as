package com.popcap.flash.games.blitz3.session
{
   import flash.utils.Dictionary;
   
   public interface IBoostManagerHandler
   {
       
      
      function HandleBoostCatalogChanged(param1:Dictionary) : void;
      
      function HandleActiveBoostsChanged(param1:Dictionary) : void;
      
      function HandleBoostAutorenew(param1:Vector.<String>) : void;
   }
}
