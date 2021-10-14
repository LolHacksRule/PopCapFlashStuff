package com.popcap.flash.bejeweledblitz.leaderboard
{
   import com.popcap.flash.bejeweledblitz.ServerURLResolver;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   
   public class InstantFriendDataFactory
   {
      
      public static const BJORN_IMAGE_URL:String = "images/instant_friends/bjorn.jpg";
      
      public static const DJMOJO_IMAGE_URL:String = "images/instant_friends/drmojo.jpg";
      
      public static const ZOMBIE_IMAGE_URL:String = "images/instant_friends/zombie.jpg";
       
      
      private var m_App:Blitz3App;
      
      public function InstantFriendDataFactory(param1:Blitz3App)
      {
         super();
         this.m_App = param1;
      }
      
      public function GetFriendData(param1:int) : Vector.<PlayerData>
      {
         var _loc2_:Vector.<PlayerData> = new Vector.<PlayerData>();
         _loc2_.push(this.BuildZombie(param1));
         _loc2_.push(this.BuildDrMojo(param1));
         _loc2_.push(this.BuildBjorn(param1));
         return _loc2_;
      }
      
      private function BuildZombie(param1:int) : PlayerData
      {
         return this.BuildPlayerData("ZOMBIE","PopCap Zombie",ZOMBIE_IMAGE_URL,0,param1,1000,5,1000,1000,0,1000,0,1000);
      }
      
      private function BuildDrMojo(param1:int) : PlayerData
      {
         return this.BuildPlayerData("DRMOJO","PopCap Dr. Mojo",DJMOJO_IMAGE_URL,800000,param1,10000,50,20000,10000,20000,10000,1,100);
      }
      
      private function BuildBjorn(param1:int) : PlayerData
      {
         return this.BuildPlayerData("BJORN","PopCap Bjorn",BJORN_IMAGE_URL,10000000,param1,25000,5000,70000,25000,70000,20000,199,0);
      }
      
      private function BuildPlayerData(param1:String, param2:String, param3:String, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int, param10:int, param11:int, param12:int, param13:int = 0) : PlayerData
      {
         var _loc14_:PlayerData = null;
         var _loc17_:MedalData = null;
         var _loc18_:int = 0;
         var _loc19_:TourneyData = null;
         (_loc14_ = new PlayerData(this.m_App)).playerFuid = param1;
         _loc14_.playerName = param2;
         _loc14_.imageUrl = this.m_App.network.GetMediaPath() + ServerURLResolver.resolveUrl(this.m_App.network.GetFlashPath() + param3);
         _loc14_.isFakePlayer = true;
         _loc14_.curTourneyData.date = new Date();
         _loc14_.curTourneyData.score = param6;
         _loc14_.curTourneyData.id = param5;
         _loc14_.xp = param4;
         _loc14_.recalcLevel();
         _loc14_.allTimeHighScore = param8;
         _loc14_.maxLastFiveWeeksScore = param9;
         _loc14_.maxRareGemScore = param10;
         _loc14_.highNonBoostedScore = param11;
         _loc14_.perfectPartiesWon = param12;
         _loc14_.totalCatPresses = param13;
         var _loc15_:int = 0;
         while(_loc15_ < PlayerData.NUM_MEDALS)
         {
            (_loc17_ = new MedalData("",param7)).CalculateTier();
            _loc14_.medalHistory[_loc15_] = _loc17_;
            _loc15_++;
         }
         var _loc16_:int = 0;
         while(_loc16_ < PlayerData.NUM_TOURNEYS)
         {
            _loc18_ = param5 - 1 - _loc16_;
            _loc19_ = new TourneyData(_loc18_,param6);
            _loc14_.tourneyHistory.push(_loc19_);
            _loc16_++;
         }
         return _loc14_;
      }
   }
}
