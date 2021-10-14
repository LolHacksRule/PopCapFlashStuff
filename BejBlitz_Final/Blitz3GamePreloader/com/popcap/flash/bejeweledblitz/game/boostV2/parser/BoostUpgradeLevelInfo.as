package com.popcap.flash.bejeweledblitz.game.boostV2.parser
{
   public class BoostUpgradeLevelInfo
   {
       
      
      public var mCostCurrencyType:String;
      
      public var mCost:Number;
      
      public var mUpgradeValue:Number;
      
      var mRewards:Vector.<BoostUpgradeRewardInfo> = null;
      
      public function BoostUpgradeLevelInfo()
      {
         super();
         this.mRewards = new Vector.<BoostUpgradeRewardInfo>();
      }
      
      public function addReward(param1:BoostUpgradeRewardInfo) : void
      {
         this.mRewards.push(param1);
      }
      
      public function getCostCurrencyType() : String
      {
         return this.mCostCurrencyType;
      }
      
      public function getUpgradeCost() : Number
      {
         return this.mCost;
      }
      
      public function getUpgradeRewards() : Vector.<BoostUpgradeRewardInfo>
      {
         return this.mRewards;
      }
      
      public function getUpgradeValue() : Number
      {
         return this.mUpgradeValue;
      }
   }
}
