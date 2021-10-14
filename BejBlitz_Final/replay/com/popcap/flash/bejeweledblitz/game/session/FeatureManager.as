package com.popcap.flash.bejeweledblitz.game.session
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   
   public class FeatureManager
   {
      
      public static const FEATURE_ADMIN:int = 0;
      
      public static const FEATURE_ALLOW_BUY_COINS:int = 1;
      
      public static const FEATURE_ALLOW_REPLAY:int = 2;
      
      public static const FEATURE_ALLOW_ONE_CLICK:int = 3;
      
      public static const FEATURE_RARE_GEMS:int = 4;
      
      public static const FEATURE_RARE_GEMS_STREAK:int = 5;
      
      public static const FEATURE_STATS_TRACKING:int = 6;
      
      public static const FEATURE_BOOST_SELECTION:int = 7;
      
      public static const FEATURE_TUTORIAL:int = 8;
      
      public static const FEATURE_CHALLENGES:int = 9;
      
      private static const NUM_FEATURE_THROTTLES:int = 10;
      
      private static const FV_ADMIN:String = "a";
      
      private static const FV_ALLOW_BUY_COINS:String = "allowBuyCoins";
      
      private static const FV_ALLOW_REPLAY:String = "allowReplay";
      
      private static const FV_ALLOW_ONE_CLICK:String = "allowOneClick";
      
      private static const FV_RARE_GEMS:String = "RareGems";
      
      private static const FV_RARE_GEMS_STREAK:String = "RareGemsStreak";
      
      private static const FV_STATS_TRACKING:String = "ss";
      
      private static const FV_BOOST_SELECTION:String = "BoostSelection";
      
      private static const FV_TUTORIAL:String = "tutorial";
      
      private static const FV_CHALLENGES:String = "challenges";
      
      private static const FV_NAVIGATION:String = "navItems";
       
      
      private var m_App:Blitz3App;
      
      private var m_Throttles:Vector.<Boolean>;
      
      private var m_NavigationItems:Array;
      
      public function FeatureManager(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_Throttles = new Vector.<Boolean>(NUM_FEATURE_THROTTLES);
         this.m_Throttles[FEATURE_ADMIN] = false;
         this.m_Throttles[FEATURE_ALLOW_BUY_COINS] = true;
         this.m_Throttles[FEATURE_ALLOW_REPLAY] = true;
         this.m_Throttles[FEATURE_ALLOW_ONE_CLICK] = true;
         this.m_Throttles[FEATURE_RARE_GEMS] = false;
         this.m_Throttles[FEATURE_RARE_GEMS_STREAK] = false;
         this.m_Throttles[FEATURE_STATS_TRACKING] = false;
         this.m_Throttles[FEATURE_BOOST_SELECTION] = true;
         this.m_Throttles[FEATURE_TUTORIAL] = true;
         this.m_Throttles[FEATURE_CHALLENGES] = false;
         this.m_Throttles[FEATURE_RARE_GEMS] = true;
         this.m_Throttles[FEATURE_RARE_GEMS_STREAK] = true;
         this.m_Throttles[FEATURE_STATS_TRACKING] = true;
         this.m_Throttles[FEATURE_CHALLENGES] = true;
      }
      
      public function Init() : void
      {
         var params:Object = this.m_App.network.parameters;
         try
         {
            if(FV_ADMIN in params)
            {
               this.m_Throttles[FEATURE_ADMIN] = params[FV_ADMIN] == "1";
            }
            if(FV_ALLOW_BUY_COINS in params)
            {
               this.m_Throttles[FEATURE_ALLOW_BUY_COINS] = params[FV_ALLOW_BUY_COINS] != "0";
            }
            if(FV_ALLOW_REPLAY in params)
            {
               this.m_Throttles[FEATURE_ALLOW_REPLAY] = params[FV_ALLOW_REPLAY] != "0";
            }
            if(FV_ALLOW_ONE_CLICK in params)
            {
               this.m_Throttles[FEATURE_ALLOW_ONE_CLICK] = params[FV_ALLOW_ONE_CLICK] != "0";
            }
            if(FV_RARE_GEMS in params)
            {
               this.m_Throttles[FEATURE_RARE_GEMS] = params[FV_RARE_GEMS] == "1";
            }
            if(FV_RARE_GEMS_STREAK in params)
            {
               this.m_Throttles[FEATURE_RARE_GEMS_STREAK] = params[FV_RARE_GEMS_STREAK] == "1";
            }
            if(FV_STATS_TRACKING in params)
            {
               this.m_Throttles[FEATURE_STATS_TRACKING] = params[FV_STATS_TRACKING] == "1";
            }
            if(FV_BOOST_SELECTION in params)
            {
               this.m_Throttles[FEATURE_BOOST_SELECTION] = params[FV_BOOST_SELECTION] != "0";
            }
            if(FV_TUTORIAL in params)
            {
               this.m_Throttles[FEATURE_TUTORIAL] = params[FV_TUTORIAL] != "0";
            }
            if(FV_CHALLENGES in params)
            {
               this.m_Throttles[FEATURE_CHALLENGES] = params[FV_CHALLENGES] != "0";
            }
            if(FV_NAVIGATION in params)
            {
               this.m_NavigationItems = params[FV_NAVIGATION].toString().split(",");
            }
            if(this.m_Throttles[FEATURE_ADMIN])
            {
               this.PrettyPrintFeatureInfo();
            }
            else
            {
               this.PrettyPrintFeatureInfo();
            }
         }
         catch(e:Error)
         {
            trace("Feature Manager Init Error: " + e.getStackTrace());
         }
      }
      
      public function IsEnabled(feature:int) : Boolean
      {
         if(feature < 0 || feature > NUM_FEATURE_THROTTLES)
         {
            return false;
         }
         return this.m_Throttles[feature];
      }
      
      public function SetEnabled(feature:int, value:Boolean = true) : void
      {
         if(feature < 0 || feature > NUM_FEATURE_THROTTLES)
         {
            return;
         }
         this.m_Throttles[feature] = value;
      }
      
      public function get NavigationItems() : Array
      {
         if(this.m_NavigationItems)
         {
            return this.m_NavigationItems;
         }
         return ["spin","gift","invite","credits","help"];
      }
      
      public function PrettyPrintFeatureInfo() : void
      {
         trace("FEATURE THROTTLES:");
         trace(" Admin: " + this.m_Throttles[FEATURE_ADMIN]);
         trace(" Allow buy coins: " + this.m_Throttles[FEATURE_ALLOW_BUY_COINS]);
         trace(" Allow replay: " + this.m_Throttles[FEATURE_ALLOW_REPLAY]);
         trace(" Allow one click: " + this.m_Throttles[FEATURE_ALLOW_ONE_CLICK]);
         trace(" Rare gems: " + this.m_Throttles[FEATURE_RARE_GEMS]);
         trace(" Rare gems streak: " + this.m_Throttles[FEATURE_RARE_GEMS_STREAK]);
         trace(" Stats tracking: " + this.m_Throttles[FEATURE_STATS_TRACKING]);
         trace(" Boost selection: " + this.m_Throttles[FEATURE_BOOST_SELECTION]);
         trace(" Tutorial: " + this.m_Throttles[FEATURE_TUTORIAL]);
         trace(" Navigation: " + this.m_NavigationItems);
      }
   }
}
