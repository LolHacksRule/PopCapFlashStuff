package com.popcap.flash.bejeweledblitz.game.tournament.data
{
   public class TournamentCommonInfo
   {
      
      public static const TOUR_CATALOGUE_NOT_FETCHED:int = 0;
      
      public static const TOUR_CATALOGUE_FETCHING:int = 1;
      
      public static const TOUR_CATALOGUE_FETCHED:int = 2;
      
      public static const TOUR_CATALOGUE_FETCH_FAILED:int = 3;
      
      public static const TOUR_LEADERBOARD_STATUS_AVAILABLE:int = 0;
      
      public static const TOUR_LEADERBOARD_STATUS_FETCHING:int = 1;
      
      public static const TOUR_LEADERBOARD_STATUS_NOT_AVAILABLE:int = 2;
      
      public static const LAST_SCORE_SERVER_STATUS_INITIATED:int = 0;
      
      public static const LAST_SCORE_SERVER_STATUS_ACCEPTED:int = 1;
      
      public static const LAST_SCORE_SERVER_STATUS_REJECTED:int = 2;
      
      public static const TOUR_STATUS_NOT_STARTED:int = 0;
      
      public static const TOUR_STATUS_RUNNING:int = 1;
      
      public static const TOUR_STATUS_COMPUTING_RESULTS:int = 2;
      
      public static const TOUR_STATUS_ENDED:int = 3;
      
      public static const TOUR_STATUS_EXPIRED:int = 4;
      
      public static const TOUR_CATEGORY_VIP:int = 3;
      
      public static const TOUR_CATEGORY_RARE:int = 2;
      
      public static const TOUR_CATEGORY_COMMON:int = 1;
      
      public static const TOUR_CRITERIA_RAREGEM:int = 0;
      
      public static const TOUR_CRITERIA_BOOST:int = 1;
      
      public static const TOUR_RG_CRITERION_NO_RG:int = 0;
      
      public static const TOUR_RG_CRITERION_ANY_RG:int = 1;
      
      public static const TOUR_RG_CRITERION_SPECIFIC_RG:int = 2;
      
      public static const TOUR_RG_CRITERION_DOES_NOT_MATTER:int = 3;
      
      public static const TOUR_BOOST_CRITERION_SPECIFICBOOST_MINIMUMLEVEL:int = 0;
      
      public static const TOUR_BOOST_CRITERION_SPECIFICBOOST:int = 1;
      
      public static const TOUR_BOOST_CRITERION_MINIMUMLEVEL:int = 2;
      
      public static const TOUR_BOOST_CRITERION_ANY:int = 3;
      
      public static const TOUR_BOOST_CRITERION_INVALID:int = 4;
      
      public static const TOUR_BOOST_CRITERION_MAX_COUNT:int = 5;
      
      public static const NETWORK_ERROR_NONE:int = 0;
      
      public static const NETWORK_ERROR_NO_INTERNET:int = 1;
      
      public static const NETWORK_ERROR_SERVER_ERROR:int = 2;
      
      public static const NETWORK_ERROR_SECURITY_ERROR:int = 3;
      
      public static const OBJECTIVE_GEMS_DESTROYED:int = 0;
      
      public static const OBJECTIVE_COLORED_GEMS_DESTROYED:int = 1;
      
      public static const OBJECTIVE_SPECIAL_GEMS_DESTROYED:int = 2;
      
      public static const OBJECTIVE_RARE_GEMS_DESTROYED:int = 3;
      
      public static const OBJECTIVE_SCORE:int = 4;
      
      public static const CLAIM_REWARD_STATE_KEY:int = 10000;
      
      public static const COMPUTING_RESULTS_STATE_KEY:int = 1000;
      
      public static const NOT_PARTICIPATED_STATE_KEY:int = 100;
      
      public static const PARTICIPATED_STATE_KEY:int = 10;
      
      public static const FROM_LOBBY:String = "from_lobby";
      
      public static const FROM_HISTORY:String = "from_history";
      
      public static const FROM_POSTGAME:String = "from_postgame";
      
      public static const FROM_BOOSTDIALOG:String = "from_boostdialog";
       
      
      public function TournamentCommonInfo()
      {
         super();
      }
   }
}
