package com.popcap.flash.bejeweledblitz.game.finisher.decision.value
{
   import flash.utils.Dictionary;
   
   public class ValueGetter
   {
      
      private static var valueTypes:Dictionary;
      
      {
         Register(HighScoreValue.GetType(),HighScoreValue);
         Register(GemUsedValue.GetType(),GemUsedValue);
         Register(IsSpenderValue.GetType(),IsSpenderValue);
         Register(CurrentRareGemValue.GetType(),CurrentRareGemValue);
         Register(IsBoostUsedValue.GetType(),IsBoostUsedValue);
         Register(ScoreDeltaValue.GetType(),ScoreDeltaValue);
         Register(PlatformValue.GetType(),PlatformValue);
         Register(CurrentMultiplierValue.GetType(),CurrentMultiplierValue);
         Register(GameModeValue.GetType(),GameModeValue);
         Register(DisplayPercentageValue.GetType(),DisplayPercentageValue);
         Register(LeaderboardScoreValue.GetType(),LeaderboardScoreValue);
         Register(GemsDestroyedValue.GetType(),GemsDestroyedValue);
         Register(CoinBalanceValue.GetType(),CoinBalanceValue);
         Register(Currency3BalanceValue.GetType(),Currency3BalanceValue);
      }
      
      public function ValueGetter()
      {
         super();
      }
      
      private static function Register(param1:String, param2:Class) : void
      {
         if(valueTypes == null)
         {
            valueTypes = new Dictionary();
         }
         valueTypes[param1] = param2;
      }
      
      public static function Get(param1:String) : ValueType
      {
         var _loc2_:Class = null;
         var _loc3_:Object = null;
         if(valueTypes.hasOwnProperty(param1))
         {
            _loc2_ = valueTypes[param1];
            _loc3_ = new _loc2_();
            return _loc3_ as ValueType;
         }
         throw new Error("undefined operator type" + param1);
      }
   }
}
