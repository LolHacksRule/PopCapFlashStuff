package com.popcap.flash.bejeweledblitz.game.tutorial
{
   public interface ITutorialWatcherHandler
   {
       
      
      function HandleTutorialComplete(param1:Boolean) : void;
      
      function HandleTutorialRestarted() : void;
   }
}
