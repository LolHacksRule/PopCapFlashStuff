package com.popcap.flash.bejeweledblitz.dailyspin.app
{
   public interface IPrizeDefinition
   {
       
      
      function getPrizeId() : String;
      
      function getAnimationType() : int;
      
      function getPrizeCount() : int;
      
      function getPrizeWeight() : Number;
      
      function getPrizeSharing() : Boolean;
      
      function getPrizeShouldBeOrdered() : Boolean;
      
      function getPrizeValue() : String;
      
      function getPrizeSound() : String;
      
      function getPrizeSymbols() : Vector.<String>;
   }
}
