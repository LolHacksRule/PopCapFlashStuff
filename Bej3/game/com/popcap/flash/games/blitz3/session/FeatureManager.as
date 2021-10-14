package com.popcap.flash.games.blitz3.session
{
   public class FeatureManager
   {
      
      public static const FEATURE_ADMIN:int = 0;
      
      public static const FEATURE_FB_CREDITS:int = 1;
      
      public static const FEATURE_SOCIAL_GOLD:int = 2;
      
      public static const FEATURE_RARE_GEMS:int = 3;
      
      public static const FEATURE_REPLAYS:int = 4;
      
      public static const FEATURE_STATS_TRACKING:int = 5;
      
      public static const FEATURE_EXTERNAL_CART:int = 6;
      
      public static const FEATURE_BOOST_SELECTION:int = 7;
      
      public static const NUM_FEATURES:int = 8;
      
      protected static const FV_ADMIN:String = "a";
      
      protected static const FV_FB_CREDITS:String = "fbCredits";
      
      protected static const FV_RARE_GEMS:String = "RareGems";
      
      protected static const FV_REPLAYS:String = "AllowReplays";
      
      protected static const FV_STATS_TRACKING:String = "ss";
      
      protected static const FV_EXTERNAL_CART:String = "universalCart";
      
      protected static const FV_BOOST_SELECTION:String = "BoostSelection";
       
      
      protected var m_Throttles:Vector.<Boolean>;
      
      public function FeatureManager()
      {
         super();
         this.m_Throttles = new Vector.<Boolean>(NUM_FEATURES);
         this.m_Throttles[FEATURE_ADMIN] = false;
         this.m_Throttles[FEATURE_FB_CREDITS] = true;
         this.m_Throttles[FEATURE_SOCIAL_GOLD] = false;
         this.m_Throttles[FEATURE_RARE_GEMS] = false;
         this.m_Throttles[FEATURE_REPLAYS] = false;
         this.m_Throttles[FEATURE_STATS_TRACKING] = false;
         this.m_Throttles[FEATURE_EXTERNAL_CART] = false;
         this.m_Throttles[FEATURE_BOOST_SELECTION] = true;
         this.m_Throttles[FEATURE_RARE_GEMS] = true;
         this.m_Throttles[FEATURE_REPLAYS] = true;
         this.m_Throttles[FEATURE_STATS_TRACKING] = true;
      }
      
      public function Init(params:Object) : void
      {
         if(FV_ADMIN in params)
         {
            this.m_Throttles[FEATURE_ADMIN] = params[FV_ADMIN] == "1";
         }
         if(FV_FB_CREDITS in params)
         {
            this.m_Throttles[FEATURE_FB_CREDITS] = params[FV_FB_CREDITS] != "0";
         }
         this.m_Throttles[FEATURE_SOCIAL_GOLD] = "sgSignature" in params && "offer_id" in params;
         if(FV_RARE_GEMS in params)
         {
            this.m_Throttles[FEATURE_RARE_GEMS] = params[FV_RARE_GEMS] == "1";
         }
         if(FV_REPLAYS in params)
         {
            this.m_Throttles[FEATURE_REPLAYS] = params[FV_REPLAYS] == "1";
         }
         if(FV_STATS_TRACKING in params)
         {
            this.m_Throttles[FEATURE_STATS_TRACKING] = params[FV_STATS_TRACKING] == "1";
         }
         if(FV_EXTERNAL_CART in params)
         {
            this.m_Throttles[FEATURE_EXTERNAL_CART] = params[FV_EXTERNAL_CART] == "1";
         }
         if(FV_BOOST_SELECTION in params)
         {
            this.m_Throttles[FEATURE_BOOST_SELECTION] = params[FV_BOOST_SELECTION] != "0";
         }
         if(this.m_Throttles[FEATURE_ADMIN])
         {
            this.PrettyPrintFeatureInfo();
         }
      }
      
      public function IsEnabled(feature:int) : Boolean
      {
         if(feature < 0 || feature > NUM_FEATURES)
         {
            return false;
         }
         return this.m_Throttles[feature];
      }
      
      public function SetEnabled(feature:int, value:Boolean = true) : void
      {
         if(feature < 0 || feature > NUM_FEATURES)
         {
            return;
         }
         this.m_Throttles[feature] = value;
      }
      
      public function PrettyPrintFeatureInfo() : void
      {
         trace("FEATURE THROTTLES:");
         trace(" Admin: " + this.m_Throttles[FEATURE_ADMIN]);
         trace(" FB credits: " + this.m_Throttles[FEATURE_FB_CREDITS]);
         trace(" SocialGold: " + this.m_Throttles[FEATURE_SOCIAL_GOLD]);
         trace(" Rare gems: " + this.m_Throttles[FEATURE_RARE_GEMS]);
         trace(" Replays: " + this.m_Throttles[FEATURE_REPLAYS]);
         trace(" Stats tracking: " + this.m_Throttles[FEATURE_STATS_TRACKING]);
         trace(" External cart: " + this.m_Throttles[FEATURE_EXTERNAL_CART]);
         trace(" Boost selection: " + this.m_Throttles[FEATURE_BOOST_SELECTION]);
      }
   }
}
