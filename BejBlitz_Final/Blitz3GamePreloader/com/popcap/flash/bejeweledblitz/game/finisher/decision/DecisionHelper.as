package com.popcap.flash.bejeweledblitz.game.finisher.decision
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.leaderboard.LeaderboardWidget;
   import com.popcap.flash.bejeweledblitz.leaderboard.PlayersData;
   import com.popcap.flash.bejeweledblitz.logic.raregems.RGLogic;
   
   public class DecisionHelper
   {
      
      private static var instance:DecisionHelper;
       
      
      public function DecisionHelper()
      {
         super();
      }
      
      public static function Get() : DecisionHelper
      {
         if(instance == null)
         {
            instance = new DecisionHelper();
         }
         return instance;
      }
      
      public function GetCoinBalance() : int
      {
         return Blitz3App.app.sessionData.userData.currencyManager.GetCurrencyByType(CurrencyManager.TYPE_COINS);
      }
      
      public function GetCurrency3Balance() : int
      {
         return Blitz3App.app.sessionData.userData.currencyManager.GetCurrencyByType(CurrencyManager.TYPE_SHARDS);
      }
      
      public function GetCurrentHighScore() : int
      {
         return Blitz3App.app.logic.GetScoreKeeper().GetScore();
      }
      
      public function GetCurrentMultiplier() : int
      {
         return Blitz3App.app.logic.multiLogic.multiplier;
      }
      
      public function GetScoreDelta() : int
      {
         var _loc1_:int = this.GetCurrentLeaderboardScore();
         var _loc2_:int = _loc1_ > 0 ? int(_loc1_) : 1;
         var _loc3_:Number = this.GetCurrentHighScore() / _loc2_;
         _loc3_ = _loc3_ > 1 ? Number(1) : Number(_loc3_);
         return _loc3_ * 100;
      }
      
      public function IsGemUsed() : Boolean
      {
         return Blitz3App.app.logic.rareGemsLogic.hasCurrentRareGem();
      }
      
      public function CurrentPlatform() : String
      {
         return "canvas";
      }
      
      public function GetFinisherDisplayPercent() : Number
      {
         return Utils.randomRange(0,100);
      }
      
      public function GetGameMode() : String
      {
         if(Blitz3App.app.isDailyChallengeGame())
         {
            return "dc";
         }
         if(Blitz3App.app.isMultiplayerGame())
         {
            return "party";
         }
         return "standard";
      }
      
      public function CurrentRareGemName() : String
      {
         if(this.IsGemUsed())
         {
            return Blitz3App.app.logic.rareGemsLogic.currentRareGem.getStringID();
         }
         return "";
      }
      
      public function GetGemColorDestroyedCount(param1:int) : int
      {
         var _loc2_:Vector.<int> = Blitz3App.app.logic.board.GetColoredGemCleared();
         return _loc2_[param1];
      }
      
      public function GetGemsDestroyed() : int
      {
         var _loc1_:RGLogic = Blitz3App.app.logic.rareGemsLogic.currentRareGem;
         if(_loc1_ == null)
         {
            return 0;
         }
         if(_loc1_.isTokenRareGem())
         {
            return Blitz3App.app.logic.rareGemTokenLogic.getTokensCollectedInGame();
         }
         return Blitz3App.app.logic.flameGemLogic.GetNumRareGemDestroyed();
      }
      
      public function IsBoostUsed() : Boolean
      {
         return Blitz3App.app.sessionData.boostV2Manager.IsAnyBoostEquipped();
      }
      
      public function IsSpender() : Boolean
      {
         return false;
      }
      
      public function GetCurrentLeaderboardScore() : int
      {
         var _loc1_:Blitz3Game = Blitz3App.app as Blitz3Game;
         var _loc2_:LeaderboardWidget = _loc1_.mainmenuLeaderboard;
         if(_loc2_.isLoaded())
         {
            return PlayersData.getPlayerData(_loc2_.currentPlayerFUID).curTourneyData.score;
         }
         return 0;
      }
   }
}
