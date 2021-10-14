package com.popcap.flash.bejeweledblitz
{
   public class Dimensions
   {
      
      public static const PRELOADER_WIDTH:Number = 760;
      
      public static const PRELOADER_HEIGHT:Number = 596;
      
      public static const GAME_WIDTH:int = 517;
      
      public static const GAME_HEIGHT:int = 419;
      
      public static const LEADERBOARD_Y:int = 0;
      
      public static const LEADERBOARD_WIDTH:int = 236;
      
      public static const LEADERBOARD_HEIGHT:int = 419;
      
      public static const FRIENDSCORE_Y:int = GAME_HEIGHT;
      
      public static const FRIENDSCORE_WIDTH:int = 581;
      
      public static const FRIENDSCORE_HEIGHT:int = 117;
      
      public static const TOP_BORDER_WIDTH:Number = 6;
      
      public static const LEFT_BORDER_WIDTH:Number = 7;
      
      public static const FRIENDSCORE_X:int = PRELOADER_WIDTH - LEFT_BORDER_WIDTH - FRIENDSCORE_WIDTH;
      
      public static const LEADERBOARD_X:int = GAME_WIDTH - LEFT_BORDER_WIDTH;
      
      public static const NAVIGATION_WIDTH:Number = 760;
      
      public static const NAVIGATION_HEIGHT:Number = 60;
      
      public static const REPLAYER_WIDTH:int = 370;
      
      public static const REPLAYER_HEIGHT:int = 460;
       
      
      public function Dimensions()
      {
         super();
      }
   }
}
