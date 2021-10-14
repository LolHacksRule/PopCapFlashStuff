package com.popcap.flash.games.blitz3.leaderboard
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class TournamentLeaderboardViewWidget extends MovieClip
   {
       
      
      public var loadingClip:MovieClip;
      
      public var TieBreakerAnimation:TieBreakerAnimation;
      
      public var btnUp:MovieClip;
      
      public var TournamentLBItemContainer:MovieClip;
      
      public var btnDown:MovieClip;
      
      public var Info:TextField;
      
      public function TournamentLeaderboardViewWidget()
      {
         super();
      }
   }
}
