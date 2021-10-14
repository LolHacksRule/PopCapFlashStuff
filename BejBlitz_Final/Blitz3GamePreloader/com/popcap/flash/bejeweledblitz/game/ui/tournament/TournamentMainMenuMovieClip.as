package com.popcap.flash.bejeweledblitz.game.ui.tournament
{
   import flash.display.MovieClip;
   
   public class TournamentMainMenuMovieClip extends MovieClip
   {
      
      public static const _MAX_ENTRIES:int = 20;
      
      public static const _SECONDS_PER_MINUTE:Number = 60;
      
      public static const _SECONDS_PER_HOUR:Number = _SECONDS_PER_MINUTE * 60;
      
      public static const _SECONDS_PER_DAY:Number = _SECONDS_PER_HOUR * 24;
      
      public static const _SECONDS_PER_WEEK:Number = _SECONDS_PER_DAY * 7;
       
      
      protected var _app:Blitz3Game;
      
      protected var _boxContainer:MovieClip;
      
      protected var _loadingClip:MovieClip;
      
      public function TournamentMainMenuMovieClip(param1:Blitz3Game)
      {
         super();
         this._app = param1;
      }
   }
}
