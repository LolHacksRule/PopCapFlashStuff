package com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity
{
   public interface ITournamentEvent
   {
       
      
      function onStatusChanged(param1:int, param2:int) : void;
      
      function onRankChanged(param1:int, param2:int) : void;
   }
}
