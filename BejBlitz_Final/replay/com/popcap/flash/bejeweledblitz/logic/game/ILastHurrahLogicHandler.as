package com.popcap.flash.bejeweledblitz.logic.game
{
   public interface ILastHurrahLogicHandler
   {
       
      
      function HandleLastHurrahBegin() : void;
      
      function HandleLastHurrahEnd() : void;
      
      function HandlePreCoinHurrah() : void;
      
      function CanBeginCoinHurrah() : Boolean;
   }
}
