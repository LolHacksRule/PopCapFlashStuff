package com.popcap.flash.games.bej3.blitz
{
   public interface ILastHurrahLogicHandler
   {
       
      
      function HandleLastHurrahBegin() : void;
      
      function HandleLastHurrahEnd() : void;
      
      function HandlePreCoinHurrah() : void;
      
      function CanBeginCoinHurrah() : Boolean;
   }
}
