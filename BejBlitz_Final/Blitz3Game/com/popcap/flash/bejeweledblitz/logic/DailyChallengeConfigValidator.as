package com.popcap.flash.bejeweledblitz.logic
{
   public class DailyChallengeConfigValidator
   {
      
      public static const MIN_COLORS:int = 3;
      
      public static const MIN_GAME_DURATION_SECONDS:int = 5;
      
      public static const MAX_GAME_DURATION_SECONDS:int = 120;
      
      public static const MIN_BLAZING_SPEED_DURATION_SECONDS:int = 1;
      
      public static const MAX_BLAZING_SPEED_DURATION_SECONDS:int = 120;
      
      public static const MIN_BLAZING_SPEED_GROWTH_PERCENT:Number = 0;
      
      public static const MAX_BLAZING_SPEED_GROWTH_PERCENT:Number = 1;
      
      public static const MIN_BLAZING_SPEED_GROWTH_CAP:Number = 0;
      
      public static const MAX_BLAZING_SPEED_GROWTH_CAP:Number = 1;
      
      public static const STAR_CAT_TYPE_POINTS:String = "points";
      
      public static const STAR_CAT_TYPES:Vector.<String> = new Vector.<String>();
      
      {
         STAR_CAT_TYPES.push(STAR_CAT_TYPE_POINTS);
      }
      
      private var _gemColors:GemColors;
      
      private var _errorLogger:IErrorLogger;
      
      private var _rewardFactory:IDailyChallengeRewardFactory;
      
      public function DailyChallengeConfigValidator(param1:GemColors, param2:IErrorLogger, param3:IDailyChallengeRewardFactory)
      {
         super();
         this._gemColors = param1;
         this._errorLogger = param2;
         this._rewardFactory = param3;
      }
      
      public function ValidateStarcatGoalTypeData(param1:String) : Boolean
      {
         var _loc2_:String = null;
         if(!this.validateStarCatGoalType(param1))
         {
            _loc2_ = "bad star cat goal type: " + param1;
            this._errorLogger.LogError(_loc2_);
            return false;
         }
         return true;
      }
      
      public function ValidateStarcatGoalsData(param1:Vector.<int>) : Boolean
      {
         var _loc2_:String = null;
         if(!this.validateStarCatGoalValue(param1))
         {
            _loc2_ = "bad star cat goal value: " + param1.toString();
            this._errorLogger.LogError(_loc2_);
            return false;
         }
         return true;
      }
      
      public function ValidateStarcatRewardsDataPair(param1:String, param2:String) : Boolean
      {
         var _loc4_:String = null;
         var _loc3_:IDailyChallengeReward = this._rewardFactory.createReward(param1,param2);
         if(_loc3_ == null)
         {
            _loc4_ = "bad star cat reward type";
            this._errorLogger.LogError(_loc4_);
            return false;
         }
         return true;
      }
      
      public function ValidateColorData(param1:Vector.<String>) : Boolean
      {
         var _loc2_:Vector.<String> = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         if(param1.length != 0)
         {
            _loc2_ = new Vector.<String>();
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               _loc2_.push(param1[_loc3_]);
               _loc3_++;
            }
            if(!this.validateColors(_loc2_))
            {
               _loc4_ = "bad colors: " + param1.toString();
               this._errorLogger.LogError(_loc4_);
               return false;
            }
         }
         return true;
      }
      
      public function validateColors(param1:Vector.<String>) : Boolean
      {
         if(!this.validateNumColors(param1))
         {
            return false;
         }
         if(!this.validateOnlyKnownColors(param1))
         {
            return false;
         }
         return true;
      }
      
      private function validateNumColors(param1:Vector.<String>) : Boolean
      {
         if(param1.length < MIN_COLORS)
         {
            return false;
         }
         return true;
      }
      
      private function validateOnlyKnownColors(param1:Vector.<String>) : Boolean
      {
         var _loc2_:String = null;
         for each(_loc2_ in param1)
         {
            if(!this._gemColors.isValidColorString(_loc2_))
            {
               return false;
            }
         }
         return true;
      }
      
      public function ValidateGameDurationData(param1:int) : Boolean
      {
         var _loc2_:String = null;
         if(!this.validateGameDuration(param1))
         {
            _loc2_ = "bad game duration";
            this._errorLogger.LogError(_loc2_);
            return false;
         }
         return true;
      }
      
      public function validateGameDuration(param1:int) : Boolean
      {
         if(param1 < MIN_GAME_DURATION_SECONDS || param1 > MAX_GAME_DURATION_SECONDS)
         {
            return false;
         }
         return true;
      }
      
      public function ValidateBlazingSpeedLengthSecondsData(param1:int) : Boolean
      {
         var _loc2_:String = null;
         if(!this.validateBlazingSpeedDuration(param1))
         {
            _loc2_ = "bad blazing steed duration";
            this._errorLogger.LogError(_loc2_);
            return false;
         }
         return true;
      }
      
      public function validateBlazingSpeedDuration(param1:int) : Boolean
      {
         if(param1 < MIN_BLAZING_SPEED_DURATION_SECONDS || param1 > MAX_BLAZING_SPEED_DURATION_SECONDS)
         {
            return false;
         }
         return true;
      }
      
      public function ValidateBlazingSpeedGrowthPercentData(param1:Number) : Boolean
      {
         var _loc2_:String = null;
         if(!this.validateBlazingSpeedGrowthPercent(param1))
         {
            _loc2_ = "bad blazing growth percent";
            this._errorLogger.LogError(_loc2_);
            return false;
         }
         return true;
      }
      
      public function validateBlazingSpeedGrowthPercent(param1:Number) : Boolean
      {
         if(param1 < MIN_BLAZING_SPEED_GROWTH_PERCENT || param1 > MAX_BLAZING_SPEED_GROWTH_PERCENT)
         {
            return false;
         }
         return true;
      }
      
      public function ValidateBlazingSpeedGrowthCapData(param1:Number) : Boolean
      {
         var _loc2_:String = null;
         if(!this.validateBlazingSpeedGrowthCap(param1))
         {
            _loc2_ = "bad blazing growth cap";
            this._errorLogger.LogError(_loc2_);
            return false;
         }
         return true;
      }
      
      public function validateBlazingSpeedGrowthCap(param1:Number) : Boolean
      {
         if(param1 < MIN_BLAZING_SPEED_GROWTH_CAP || param1 > MAX_BLAZING_SPEED_GROWTH_CAP)
         {
            return false;
         }
         return true;
      }
      
      public function ValidateBoardSeedData(param1:String) : Boolean
      {
         var _loc2_:String = null;
         if(!this.validateBoardSeed(param1))
         {
            _loc2_ = "bad board seed: " + param1;
            this._errorLogger.LogError(_loc2_);
            return false;
         }
         return true;
      }
      
      public function validateBoardSeed(param1:String) : Boolean
      {
         var _loc2_:Vector.<String> = this._gemColors.getCharNames();
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            if(_loc2_.indexOf(param1.substr(_loc3_,1)) < 0)
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      public function validateStarCatGoalType(param1:String) : Boolean
      {
         var _loc2_:Vector.<String> = STAR_CAT_TYPES;
         if(_loc2_.indexOf(param1) >= 0)
         {
            return true;
         }
         return false;
      }
      
      public function validateStarCatGoalValue(param1:Vector.<int>) : Boolean
      {
         var _loc2_:int = param1[0];
         var _loc3_:int = 1;
         while(_loc3_ < param1.length)
         {
            if(_loc2_ > param1[_loc3_])
            {
               return false;
            }
            _loc2_ = param1[_loc3_];
            _loc3_++;
         }
         return true;
      }
      
      public function ValidateRetryCostData(param1:int) : Boolean
      {
         var _loc2_:String = null;
         if(!this.validateRetryCost(param1))
         {
            _loc2_ = "bad retry cost";
            this._errorLogger.LogError(_loc2_);
            return false;
         }
         return true;
      }
      
      private function validateRetryCost(param1:int) : Boolean
      {
         if(param1 < 0)
         {
            return false;
         }
         return true;
      }
      
      public function validateColorMultipliers(param1:Vector.<Number>) : Boolean
      {
         var _loc3_:String = null;
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            if(param1[_loc2_] < 0 || param1[_loc2_] >= 50)
            {
               _loc3_ = "bad Gem Color Multiplier";
               this._errorLogger.LogError(_loc3_);
               return false;
            }
            _loc2_++;
         }
         return true;
      }
   }
}
