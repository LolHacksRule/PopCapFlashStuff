package com.popcap.flash.bejeweledblitz.logic.boosts
{
   public interface IBoostHandler
   {
       
      
      function HandleBoostActivated(param1:String) : void;
      
      function HandleBoostFailed(param1:String) : void;
   }
}
