package com.popcap.flash.bejeweledblitz.logic
{
   public class Config
   {
       
      
      public var version:int = 10;
      
      public var timerLogicBaseGameDuration:int = 6000;
      
      public var swapDataSwapTime:int = 24;
      
      public var swapDataBadSwapTime:int = 36;
      
      public var starGemExplodeEventPointValue:int = 250;
      
      public var starGemExplodeEventStartTime:int = 80;
      
      public var starGemExplodeEventJumpTime:int = 10;
      
      public var starGemCreateEventDuration:Number = 30;
      
      public var scrambleEventSwapTime:int = 40;
      
      public var unScrambleEventSwapTime:int = 20;
      
      public var unScrambleEventPostSwapTime:int = 40;
      
      public var phoenixPrismRGLogicMaxSpawned:int = 6;
      
      public var phoenixPrismRGLogicMinSpawnDelay:int = 400;
      
      public var phoenixPrismRGLogicMaxSpawnDelay:int = 800;
      
      public var phoenixPrismRGLogicPointAwardDelay:int = 200;
      
      public var phoenixPrismRGLogicShowPointAwardDelay:int = 350;
      
      public var phoenixPrismRGLogicBaseBonusPoints:int = 5000;
      
      public var phoenixPrismHurrahExplodeEventPointValue:int = 250;
      
      public var phoenixPrismHurrahExplodeEventStartTime:int = 168;
      
      public var phoenixPrismHurrahExplodeEventJumpTime:int = 10;
      
      public var phoenixPrismExplodeEventPointValue:int = 250;
      
      public var phoenixPrismExplodeEventStartTime:int = 72;
      
      public var phoenixPrismExplodeEventJumpTime:int = 12;
      
      public var phoenixPrismCreateEventDuration:Number = 30;
      
      public var multiplierGemLogicPointValue:int = 1000;
      
      public var multiplierGemLogicFuseTime:int = 5;
      
      public var multiplierGemLogicMinToSpawn:int = 4;
      
      public var multiplierGemLogicStartThreshold:int = 12;
      
      public var multiplierGemLogicMaxThreshold:int = 20;
      
      public var multiplierGemLogicMinThreshold:int = 5;
      
      public var multiplierGemLogicThresholdDelta:int = 5;
      
      public var multiplierGemLogicDeltaRate:int = 400;
      
      public var multiplierGemLogicThresholdReset:int = 8;
      
      public var multiplierGemLogicMaxMultipliersDefault:int = 7;
      
      public var multiplierGemLogicThresholdMaxMultiplier:int = 99;
      
      public var moonstoneRGLogicNumUpgrades:int = 3;
      
      public var matchEventMatchTime:Number = 25;
      
      public var lastHurrahLogicBaseHurrahDelay:int = 175;
      
      public var lastHurrahLogicShortHurrahDelay:int = 25;
      
      public var hypercubeLogicGemsNeeded:int = 5;
      
      public var hypercubeExplodeEventGemPoints:int = 250;
      
      public var hypercubeExplodeEventDestroyDelay:int = 67;
      
      public var hypercubeExplodeEventFinalDelay:int = 25;
      
      public var hypercubeCreateEventDuration:Number = 30;
      
      public var flameGemLogicGemsNeeded:int = 4;
      
      public var flameGemLogicFuseTime:int = 15;
      
      public var flameGemLogicBumpVel:Number = 1.0;
      
      public var flameGemLogicExplosionRange:Number = 1.5;
      
      public var flameGemLogicGemPointValue:int = 100;
      
      public var flameGemLogicMatchPointBonus:int = 100;
      
      public var flameGemCreateEventDuration:Number = 30;
      
      public var complimentLogicThreshold:Vector.<int>;
      
      public var coinTokenLogicMinimumScore:int = 1000;
      
      public var coinTokenLogicCoinColor:int;
      
      public var coinTokenLogicSpawnChance:Number = 0.5;
      
      public var coinTokenLogicCollectCooldown:int = 25;
      
      public var coinTokenLogicCoinValue:int = 100;
      
      public var coinTokenLogicCoinPoints:int = 1250;
      
      public var coinTokenLogicSpawnCooldown:int = 1000;
      
      public var catseyeRGLogicMultiplierScalar:Number = 3;
      
      public var catseyeRGLogicNumLasers:int = 14;
      
      public var catseyeRGLogicFiringDelay:int = 20;
      
      public var catseyeRGLogicAdditionalFiringDelay:Number = 0;
      
      public var catseyeRGLogicExplosionDelay:int = 10;
      
      public var catseyeRGLogicInitialDelay:int = 250;
      
      public var blitzSpeedBonusStartingMoves:int = 3;
      
      public var blitzSpeedBonusInitialThreshold:Number = 300.0;
      
      public var blitzSpeedBonusSpeedThreshold:Number = 137.5;
      
      public var blitzSpeedBonusSpeedThresholdBonus:Number = 12.5;
      
      public var blitzSpeedBonusBonusBase:int = 200;
      
      public var blitzSpeedBonusBonusBonus:int = 100;
      
      public var blitzSpeedBonusLevelBase:int = 1;
      
      public var blitzSpeedBonusLevelBonus:int = 1;
      
      public var blitzSpeedBonusLevelMax:int = 10;
      
      public var blitzSpeedBonusMaxMoveTime:int = 2147483647;
      
      public var blitzScoreKeeperCascadeBonus:int = 250;
      
      public var blitzScoreKeeperMatchPoints:Vector.<int>;
      
      public var blitzLogicMinVeloToHit:Number = 0.015625;
      
      public var blitzLogicGravity:Number = 0.0030078125;
      
      public var blitzLogicBaseSpeed:Number = 1.2;
      
      public var blitzLogicIncreasedSpeed:Number = 2.4;
      
      public var blazingSteedRGLogicStartDuration:int = 1100;
      
      public var blazingSteedRGLogicDuration:int = 800;
      
      public var blazingSteedRGLogicGemExplosionDelay:int = 100;
      
      public var blazingSteedRGLogicGemExplosionDuration:int = 130;
      
      public var blazingSteedRGLogicStampedeDuration:int;
      
      public var blazingSpeedLogicSpeedCap:int = 50;
      
      public var blazingSpeedLogicMinSpeed:int = 100;
      
      public var blazingSpeedLogicMaxSpeed:int = 180;
      
      public var blazingSpeedLogicDecayPercent:Number = 0.007;
      
      public var blazingSpeedLogicGrowthPercent:Number = 0.075;
      
      public var blazingSpeedLogicGrowthCap:Number = 0.1;
      
      public var blazingSpeedLogicBonusTime:int = 800;
      
      public var blazingSpeedLogicSpeedBonus:Number = 0.65;
      
      public var blazingSpeedLogicMinSpeedLevel:int = 9;
      
      public var autoHintLogicHintInterval:int = 500;
      
      public var eternalBlazingSpeed:Boolean = false;
      
      public var gemColors:Vector.<int>;
      
      public var gemColorMultipliers:Vector.<Number>;
      
      public var startingGameBoardPattern:String;
      
      public var rareGemTokenLogicSpawnChance:Number = 0.5;
      
      public var rareGemTokenLogicCollectCooldown:int = 25;
      
      public var rareGemTokenLogicValue:int = 500;
      
      public var rareGemTokenLogicPoints:int = 1250;
      
      public var rareGemTokenLogicSpawnCooldown:int = 1000;
      
      public function Config()
      {
         this.complimentLogicThreshold = new Vector.<int>(6);
         this.coinTokenLogicCoinColor = Gem.COLOR_YELLOW;
         this.blitzScoreKeeperMatchPoints = new Vector.<int>(9);
         this.blazingSteedRGLogicStampedeDuration = this.blazingSteedRGLogicGemExplosionDuration + this.blazingSteedRGLogicGemExplosionDuration + 100;
         this.gemColors = new Vector.<int>();
         this.gemColorMultipliers = new Vector.<Number>(8);
         this.startingGameBoardPattern = new String();
         super();
         this.complimentLogicThreshold[0] = 3;
         this.complimentLogicThreshold[1] = 6;
         this.complimentLogicThreshold[2] = 12;
         this.complimentLogicThreshold[3] = 20;
         this.complimentLogicThreshold[4] = 30;
         this.complimentLogicThreshold[5] = 45;
         this.blitzScoreKeeperMatchPoints[0] = 0;
         this.blitzScoreKeeperMatchPoints[1] = 0;
         this.blitzScoreKeeperMatchPoints[2] = 0;
         this.blitzScoreKeeperMatchPoints[3] = 250;
         this.blitzScoreKeeperMatchPoints[4] = 500;
         this.blitzScoreKeeperMatchPoints[5] = 2500;
         this.blitzScoreKeeperMatchPoints[6] = 4500;
         this.blitzScoreKeeperMatchPoints[7] = 6500;
         this.blitzScoreKeeperMatchPoints[8] = 8500;
         var _loc1_:GemColors = new GemColors();
         this.gemColors = _loc1_.getIndexes();
         var _loc2_:int = 0;
         while(_loc2_ < 8)
         {
            this.gemColorMultipliers[_loc2_] = 1;
            _loc2_++;
         }
      }
      
      public function Reset() : void
      {
         var _loc1_:GemColors = new GemColors();
         this.gemColors = _loc1_.getIndexes();
         this.blitzLogicBaseSpeed = 1.2;
         this.eternalBlazingSpeed = false;
      }
   }
}
