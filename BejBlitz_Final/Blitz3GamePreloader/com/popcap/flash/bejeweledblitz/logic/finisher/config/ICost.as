package com.popcap.flash.bejeweledblitz.logic.finisher.config
{
   public interface ICost
   {
       
      
      function GetValue() : int;
      
      function IsCurrencyPurchase() : Boolean;
      
      function GetDisplayCost() : String;
      
      function GetType() : String;
   }
}
