package com.popcap.flash.games.blitz3.leaderboard
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class InGameLeaderboardViewWidget extends MovieClip
   {
       
      
      public var btnRefreshWhoops:MovieClip;
      
      public var txtReset:TextField;
      
      public var loadingClip:MovieClip;
      
      public var printBoundaries:MovieClip;
      
      public var btnUp:MovieClip;
      
      public var btnDown:MovieClip;
      
      public var leaderboardContainer:MovieClip;
      
      public var btnRefreshTournament:MovieClip;
      
      public var txtWeekly:TextField;
      
      public function InGameLeaderboardViewWidget()
      {
         super();
      }
   }
}
