package com.popcap.flash.bejeweledblitz.game.session
{
   public interface IHandleNetworkAdStateChangeCallback
   {
       
      
      function HandleAdsStateChanged(param1:Boolean) : void;
      
      function HandleAdComplete(param1:String) : void;
      
      function HandleAdCapExhausted(param1:String) : void;
      
      function HandleAdClosed(param1:String) : void;
   }
}
