package com.popcap.flash.bejeweledblitz.game.tournament.data
{
   public interface TournamentCriterion
   {
       
      
      function getType() : int;
      
      function doesSatisfy(param1:String, param2:int) : Boolean;
      
      function setInfo(param1:Object) : void;
      
      function getText() : String;
   }
}
