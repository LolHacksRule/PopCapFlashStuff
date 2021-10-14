package com.popcap.flash.bejeweledblitz.party
{
   import flash.display.MovieClip;
   
   public interface IPartyState
   {
       
      
      function getClip() : MovieClip;
      
      function enterState() : void;
      
      function exitState() : void;
   }
}
