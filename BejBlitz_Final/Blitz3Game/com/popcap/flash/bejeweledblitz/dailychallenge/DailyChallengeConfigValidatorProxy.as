package com.popcap.flash.bejeweledblitz.dailychallenge
{
   import com.popcap.flash.bejeweledblitz.logic.DailyChallengeConfigValidator;
   import com.popcap.flash.bejeweledblitz.logic.IErrorLogger;
   import com.popcap.flash.framework.utils.VectorFactory;
   
   public class DailyChallengeConfigValidatorProxy implements IDailyChallengeConfigValidator
   {
       
      
      private var _dailyChallengeConfigValidator:DailyChallengeConfigValidator;
      
      private var _errorLogger:IErrorLogger;
      
      public function DailyChallengeConfigValidatorProxy(param1:DailyChallengeConfigValidator, param2:IErrorLogger)
      {
         super();
         this._dailyChallengeConfigValidator = param1;
         this._errorLogger = param2;
      }
      
      public function ValidateData(param1:Object) : Boolean
      {
         var _loc2_:Vector.<String> = null;
         var _loc3_:Vector.<String> = null;
         var _loc4_:Vector.<Number> = null;
         var _loc5_:* = null;
         if(param1 == null || param1.data == null)
         {
            this._errorLogger.LogError("Daily Challenge object data is null");
            return false;
         }
         if(param1.data.colors != null)
         {
            _loc2_ = VectorFactory.createForString(param1.data.colors);
            if(!this._dailyChallengeConfigValidator.ValidateColorData(_loc2_))
            {
               return false;
            }
         }
         if(param1.data.gameDurationSeconds != null)
         {
            if(!this._dailyChallengeConfigValidator.ValidateGameDurationData(param1.data.gameDurationSeconds))
            {
               return false;
            }
         }
         if(param1.data.blazingSpeedLengthSeconds != null)
         {
            if(!this._dailyChallengeConfigValidator.ValidateBlazingSpeedLengthSecondsData(param1.data.blazingSpeedLengthSeconds))
            {
               return false;
            }
         }
         if(param1.data.blazingSpeedGrowthPercent != null)
         {
            if(!this._dailyChallengeConfigValidator.ValidateBlazingSpeedGrowthPercentData(param1.data.blazingSpeedGrowthPercent))
            {
               return false;
            }
         }
         if(param1.data.blazingSpeedGrowthCap != null)
         {
            if(!this._dailyChallengeConfigValidator.ValidateBlazingSpeedGrowthCapData(param1.data.blazingSpeedGrowthCap))
            {
               return false;
            }
         }
         if(param1.data.boardSeed != null)
         {
            if(!this._dailyChallengeConfigValidator.ValidateBoardSeedData(param1.data.boardSeed))
            {
               return false;
            }
         }
         if(param1.data.retryCost != null)
         {
            if(!this._dailyChallengeConfigValidator.ValidateRetryCostData(param1.data.retryCost))
            {
               return false;
            }
         }
         if(!this.ValidateStarcatData(param1))
         {
            return false;
         }
         if(param1.data.colorMultipliers != null)
         {
            _loc3_ = new Vector.<String>();
            _loc4_ = new Vector.<Number>();
            for(_loc5_ in param1.data.colorMultipliers)
            {
               _loc3_.push(_loc5_);
               _loc4_.push(param1.data.colorMultipliers[_loc5_]);
            }
            if(!this._dailyChallengeConfigValidator.ValidateColorData(_loc3_))
            {
               return false;
            }
            if(!this._dailyChallengeConfigValidator.validateColorMultipliers(_loc4_))
            {
               return false;
            }
         }
         return true;
      }
      
      private function ValidateStarcatData(param1:Object) : Boolean
      {
         var _loc2_:Vector.<int> = null;
         var _loc3_:int = 0;
         if(param1.data.starcatType != null)
         {
            if(!this._dailyChallengeConfigValidator.ValidateStarcatGoalTypeData(param1.data.starCatType))
            {
               return false;
            }
            if(param1.data.starCatGoals != null)
            {
               _loc2_ = VectorFactory.createForInt(param1.data.starCatGoals);
               if(!this._dailyChallengeConfigValidator.ValidateStarcatGoalsData(_loc2_))
               {
                  return false;
               }
            }
            if(param1.data.starCatRewards == null)
            {
               this._errorLogger.LogError("*ERROR* NO STAR CAT REWARD IN DC CONFIG");
               return false;
            }
            _loc3_ = 0;
            while(_loc3_ < param1.data.starCatRewards.length)
            {
               if(!this._dailyChallengeConfigValidator.ValidateStarcatRewardsDataPair(param1.data.starCatRewards[_loc3_]["type"],param1.data.starCatRewards[_loc3_]["value"]))
               {
                  return false;
               }
               _loc3_++;
            }
         }
         return true;
      }
   }
}
