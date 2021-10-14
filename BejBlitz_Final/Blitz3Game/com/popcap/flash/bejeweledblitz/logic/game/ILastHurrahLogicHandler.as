package com.popcap.flash.bejeweledblitz.logic.game
{
   public interface ILastHurrahLogicHandler
   {
       
      
      function handleLastHurrahBegin() : void;
      
      function handleLastHurrahEnd() : void;
      
      function handlePreCoinHurrah() : void;
      
      function canBeginCoinHurrah() : Boolean;
   }
}
