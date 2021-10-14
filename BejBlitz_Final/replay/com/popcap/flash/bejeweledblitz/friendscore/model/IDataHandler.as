package com.popcap.flash.bejeweledblitz.friendscore.model
{
   public interface IDataHandler
   {
       
      
      function HandleFriendscoreDataChanged(param1:TournamentData) : void;
      
      function HandleFriendscoreChanged(param1:int) : void;
   }
}
