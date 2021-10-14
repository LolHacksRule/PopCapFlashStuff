package com.popcap.flash.bejeweledblitz.dailychallenge
{
   import com.popcap.flash.bejeweledblitz.game.session.raregem.RareGemManager;
   import com.popcap.flash.bejeweledblitz.logic.DailyChallengeLogicConfig;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.GemColors;
   import com.popcap.flash.bejeweledblitz.logic.IDailyChallengeReward;
   
   public class DailyChallengeConfigReader implements IDailyChallengeConfigReader
   {
       
      
      private var _rareGemManager:RareGemManager;
      
      private var _gemColors:GemColors;
      
      public function DailyChallengeConfigReader(param1:RareGemManager, param2:GemColors)
      {
         super();
         this._rareGemManager = param1;
         this._gemColors = param2;
      }
      
      public function ReadConfig(param1:Object) : DailyChallengeLogicConfig
      {
         var _loc3_:int = 0;
         var _loc4_:Vector.<Number> = null;
         var _loc5_:int = 0;
         var _loc6_:Vector.<String> = null;
         var _loc7_:Vector.<int> = null;
         var _loc8_:int = 0;
         var _loc9_:Vector.<int> = null;
         var _loc10_:* = null;
         var _loc11_:int = 0;
         var _loc12_:Number = NaN;
         var _loc2_:DailyChallengeLogicConfig = new DailyChallengeLogicConfig();
         if(param1.data != null)
         {
            if(param1.data.colors != null)
            {
               _loc6_ = new Vector.<String>();
               _loc3_ = 0;
               while(_loc3_ < param1.data.colors.length)
               {
                  _loc6_.push(param1.data.colors[_loc3_]);
                  _loc3_++;
               }
               _loc7_ = new Vector.<int>();
               _loc3_ = 0;
               while(_loc3_ < _loc6_.length)
               {
                  _loc7_.push(this._gemColors.getIndex(_loc6_[_loc3_]));
                  _loc3_++;
               }
               _loc2_.gemColors = _loc7_;
            }
            if(param1.data.gameDurationSeconds != null)
            {
               _loc2_.timerLogicBaseGameDuration = param1.data.gameDurationSeconds * Blitz3Game.TICK_MULTIPLIER;
            }
            if(param1.data.blazingSpeedLengthSeconds != null)
            {
               _loc2_.blazingSpeedLogicBonusTime = param1.data.blazingSpeedLengthSeconds * Blitz3Game.TICK_MULTIPLIER;
            }
            if(param1.data.blazingSpeedGrowthPercent != null)
            {
               _loc2_.blazingSpeedLogicGrowthPercent = param1.data.blazingSpeedGrowthPercent;
            }
            if(param1.data.blazingSpeedGrowthCap != null)
            {
               _loc2_.blazingSpeedLogicGrowthCap = param1.data.blazingSpeedGrowthCap;
            }
            if(param1.data.boardSeed != null)
            {
               _loc2_.startingGameBoardPattern = param1.data.boardSeed;
            }
            if(param1.data.retryCost != null)
            {
               _loc2_.retryCost = param1.data.retryCost;
            }
            if(param1.data.multiplierGemLogicPointValue != null)
            {
               _loc2_.multiplierGemLogicPointValue = param1.data.multiplierGemLogicPointValue;
            }
            if(param1.data.multiplierGemLogicStartThreshold != null)
            {
               _loc2_.multiplierGemLogicStartThreshold = param1.data.multiplierGemLogicStartThreshold;
            }
            if(param1.data.multiplierGemLogicMaxMultipliersDefault != null)
            {
               _loc2_.multiplierGemLogicMaxMultipliersDefault = param1.data.multiplierGemLogicMaxMultipliersDefault;
            }
            if(param1.data.multiplierGemLogicMaxThreshold != null)
            {
               _loc2_.multiplierGemLogicMaxThreshold = param1.data.multiplierGemLogicMaxThreshold;
            }
            if(param1.data.multiplierGemLogicMinThreshold != null)
            {
               _loc2_.multiplierGemLogicMinThreshold = param1.data.multiplierGemLogicMinThreshold;
            }
            if(param1.data.multiplierGemLogicThresholdMaxMultiplier != null)
            {
               _loc2_.multiplierGemLogicThresholdMaxMultiplier = param1.data.multiplierGemLogicThresholdMaxMultiplier;
            }
            if(param1.data.multiplierGemLogicMaxMultipliersDefault != null)
            {
               _loc2_.multiplierGemLogicMaxMultipliersDefault = param1.data.multiplierGemLogicMaxMultipliersDefault;
            }
            if(param1.data.multiplierGemLogicThresholdDelta != null)
            {
               _loc2_.multiplierGemLogicThresholdDelta = param1.data.multiplierGemLogicThresholdDelta;
            }
            if(param1.data.multiplierGemLogicDeltaRate != null)
            {
               _loc2_.multiplierGemLogicDeltaRate = param1.data.multiplierGemLogicDeltaRate;
            }
            if(param1.data.multiplierGemLogicThresholdReset != null)
            {
               _loc2_.multiplierGemLogicThresholdReset = param1.data.multiplierGemLogicThresholdReset;
            }
            if(param1.data.blitzScoreKeeperMatchPoints != null)
            {
               _loc8_ = 0;
               while(_loc8_ < param1.data.blitzScoreKeeperMatchPoints.length)
               {
                  _loc2_.blitzScoreKeeperMatchPoints[_loc8_] = param1.data.blitzScoreKeeperMatchPoints[_loc8_];
                  _loc8_++;
               }
            }
            if(param1.data.starCatType != null)
            {
               if(param1.data.starCatGoals != null)
               {
                  _loc9_ = new Vector.<int>();
                  _loc3_ = 0;
                  while(_loc3_ < param1.data.starCatGoals.length)
                  {
                     _loc9_.push(param1.data.starCatGoals[_loc3_]);
                     _loc3_++;
                  }
                  _loc2_.starCatType = param1.data.starCatType;
                  _loc2_.starCatGoals = _loc9_;
               }
               if(param1.data.starCatRewards != null)
               {
                  _loc2_.starCatRewards = this.getStarcatRewards(param1);
               }
            }
            _loc4_ = new Vector.<Number>();
            _loc5_ = Gem.COLOR_NONE;
            while(_loc5_ < Gem.COLOR_ANY)
            {
               _loc4_[_loc5_] = 1;
               _loc5_++;
            }
            if(param1.data.colorMultipliers != null)
            {
               for(_loc10_ in param1.data.colorMultipliers)
               {
                  if(this._gemColors.isValidColorString(_loc10_))
                  {
                     _loc11_ = this._gemColors.getIndex(_loc10_);
                     _loc12_ = param1.data.colorMultipliers[_loc10_];
                     _loc4_[_loc11_] = _loc12_;
                  }
               }
            }
            _loc2_.gemColorMultipliers = _loc4_;
            if(param1.data.challengeTitle != null)
            {
               _loc2_.challengeTitle = param1.data.challengeTitle;
            }
            if(param1.data.id != null)
            {
               _loc2_.id = param1.data.id;
            }
            if(param1.data.challengeBody != null)
            {
               _loc2_.challengeBody = param1.data.challengeBody;
            }
            if(param1.data.rareGem != null)
            {
               _loc2_.rareGem = param1.data.rareGem;
            }
            if(param1.data.endTime != null)
            {
               _loc2_.dailyChallengeEndTime = param1.data.endTime;
            }
            if(param1.data.startTime != null)
            {
               _loc2_.dailyChallengeStartTime = param1.data.startTime;
            }
            if(param1.data.ttl != null)
            {
               _loc2_.timeToLiveMilliseconds = param1.data.ttl * 1000;
               _loc2_.timeHasLivedMilliseconds = 0;
            }
            if(param1.data.boostsV2 != null)
            {
               _loc2_.boosts = param1.data.boostsV2;
            }
            else
            {
               _loc2_.boosts = new Array();
            }
            return _loc2_;
         }
         return null;
      }
      
      private function getStarcatRewards(param1:Object) : Vector.<IDailyChallengeReward>
      {
         var _loc5_:IDailyChallengeReward = null;
         var _loc2_:Vector.<IDailyChallengeReward> = new Vector.<IDailyChallengeReward>();
         var _loc3_:DailyChallengeRewardFactory = new DailyChallengeRewardFactory(this._rareGemManager);
         var _loc4_:int = 0;
         while(_loc4_ < param1.data.starCatRewards.length)
         {
            if((_loc5_ = _loc3_.createRewardFromArray(param1.data.starCatRewards[_loc4_])) != null)
            {
               _loc2_.push(_loc5_);
            }
            _loc4_++;
         }
         return _loc2_;
      }
   }
}
