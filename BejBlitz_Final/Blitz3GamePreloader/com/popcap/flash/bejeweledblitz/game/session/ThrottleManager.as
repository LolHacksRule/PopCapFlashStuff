package com.popcap.flash.bejeweledblitz.game.session
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import flash.utils.Dictionary;
   
   public class ThrottleManager
   {
      
      public static const THROTTLE_STATS_TRACKING:String = "ss";
      
      public static const THROTTLE_DIRECT_TO_CART:String = "directToCart";
      
      public static const THROTTLE_DAILY_CHALLENGES:String = "dailyChallenge";
      
      public static const THROTTLE_ENABLE_FINISHER:String = "enableFinisher";
      
      public static const THROTTLE_ENABLE_SEASONAL_SALE:String = "enableCanvasSeasonalSale";
      
      public static const THROTTLE_ENABLE_LTO:String = "enableCanvasLTO";
      
      public static const THROTTLE_ENABLE_POST_GAME_2X_AD:String = "enableCanvas2XCoinsByAd";
      
      public static const THROTTLE_ENABLE_CLAIM_FREE_CHEST:String = "FBFreeChestBanner";
      
      public static const THROTTLE_ENABLE_REPLAY:String = "enableReplay";
      
      public static const THROTTLE_ENABLE_TOURNAMENT:String = "enableTournament";
      
      public static const THROTTLE_ENABLE_PREMIUMBOARD:String = "enablePremiumBoard";
       
      
      private var app:Blitz3App;
      
      private var throttles:Dictionary;
      
      private var throttleList:Vector.<String>;
      
      public function ThrottleManager(param1:Blitz3App)
      {
         super();
         this.app = param1;
         this.throttles = new Dictionary();
         this.throttleList = new <String>[THROTTLE_STATS_TRACKING,THROTTLE_DIRECT_TO_CART,THROTTLE_DAILY_CHALLENGES,THROTTLE_ENABLE_FINISHER,THROTTLE_ENABLE_SEASONAL_SALE,THROTTLE_ENABLE_LTO,THROTTLE_ENABLE_POST_GAME_2X_AD,THROTTLE_ENABLE_CLAIM_FREE_CHEST,THROTTLE_ENABLE_REPLAY,THROTTLE_ENABLE_TOURNAMENT,THROTTLE_ENABLE_PREMIUMBOARD];
         this.setDefaults();
      }
      
      private function setDefaults() : void
      {
         this.throttles[THROTTLE_STATS_TRACKING] = false;
         this.throttles[THROTTLE_DIRECT_TO_CART] = false;
         this.throttles[THROTTLE_DAILY_CHALLENGES] = false;
         this.throttles[THROTTLE_ENABLE_FINISHER] = false;
         this.throttles[THROTTLE_ENABLE_SEASONAL_SALE] = false;
         this.throttles[THROTTLE_ENABLE_LTO] = false;
         this.throttles[THROTTLE_ENABLE_POST_GAME_2X_AD] = false;
         this.throttles[THROTTLE_ENABLE_CLAIM_FREE_CHEST] = false;
         this.throttles[THROTTLE_ENABLE_REPLAY] = false;
         this.throttles[THROTTLE_ENABLE_TOURNAMENT] = false;
         this.throttles[THROTTLE_ENABLE_PREMIUMBOARD] = false;
      }
      
      public function Init() : void
      {
         var _loc2_:String = null;
         var _loc1_:Object = this.app.network.parameters;
         for each(_loc2_ in this.throttleList)
         {
            if(_loc2_ in _loc1_)
            {
               this.throttles[_loc2_] = _loc1_[_loc2_] == "1";
            }
         }
      }
      
      public function IsEnabled(param1:String) : Boolean
      {
         if(param1 in this.throttles)
         {
            return this.throttles[param1];
         }
         return false;
      }
   }
}
