package com.popcap.flash.bejeweledblitz.leaderboard
{
   public interface ILeaderboardUpdateEvents
   {
       
      
      function HandleScoreUpdated(param1:int) : void;
      
      function HandleBasicLoadComplete() : void;
      
      function updatePokeAndRivalStatus() : void;
      
      function showTourneyRefresh() : void;
      
      function showLeaderboardRefresh() : void;
      
      function validatePokeAndFlagButtonsForPlayer(param1:PlayerData) : void;
   }
}
