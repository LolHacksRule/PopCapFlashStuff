package com.popcap.flash.bejeweledblitz.game.tournament.data
{
   public class SearchableTournamentData
   {
       
      
      public var _id:String;
      
      public var _tournamentInfo:TournamentConfigData;
      
      public function SearchableTournamentData()
      {
         super();
         this._tournamentInfo = new TournamentConfigData();
      }
   }
}
