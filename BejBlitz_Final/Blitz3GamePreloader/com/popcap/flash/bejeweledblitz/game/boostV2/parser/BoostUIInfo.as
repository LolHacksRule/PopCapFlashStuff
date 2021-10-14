package com.popcap.flash.bejeweledblitz.game.boostV2.parser
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   
   public class BoostUIInfo
   {
       
      
      private var mId:String = "";
      
      private var mName:String = "";
      
      private var mDescription:String = "";
      
      private var mUnlocks:BoostUnlockInfo;
      
      private var mUpgrades:BoostUpgradeInfo;
      
      private var mUIParameters:BoostUIParameterInfo;
      
      public function BoostUIInfo(param1:Object)
      {
         var config:Object = param1;
         super();
         try
         {
            this.Parse(config);
         }
         catch(e:Error)
         {
            throw new Error("Boost parsing failed : " + mId + " trace " + e.getStackTrace());
         }
      }
      
      private function Parse(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Array = null;
         this.mId = Utils.getStringFromObjectKey(param1.Root.Id.String,"value","id");
         this.mName = Utils.getStringFromObjectKey(param1.Root.Name.String,"value","name");
         this.mDescription = Utils.getStringFromObjectKey(param1.Root.Description.String,"value","description");
         _loc2_ = param1.Root.Parameters;
         if(_loc2_ && _loc2_.Array)
         {
            _loc3_ = Utils.getArrayFromObjectKey(param1.Root.Parameters.Array,"value");
            if(_loc3_ != null)
            {
               this.mUIParameters = new BoostUIParameterInfo(_loc3_);
            }
            else
            {
               this.mUIParameters = null;
            }
         }
         else
         {
            this.mUIParameters = null;
         }
         _loc2_ = param1.Root.Unlock;
         if(_loc2_)
         {
            this.mUnlocks = new BoostUnlockInfo(param1.Root.Unlock);
         }
         else
         {
            this.mUnlocks = null;
         }
         _loc2_ = param1.Root.Upgrade;
         if(_loc2_)
         {
            this.mUpgrades = new BoostUpgradeInfo(param1.Root.Upgrade,this.getParamKey());
         }
         else
         {
            this.mUpgrades = null;
         }
      }
      
      public function getId() : String
      {
         return this.mId;
      }
      
      public function getBoostName() : String
      {
         return this.mName;
      }
      
      public function getBoostDescription() : String
      {
         return this.mDescription;
      }
      
      public function getUnlockInfo() : BoostUnlockInfo
      {
         return this.mUnlocks;
      }
      
      public function getUpgradeInfo() : BoostUpgradeInfo
      {
         return this.mUpgrades;
      }
      
      public function getUpgradeCostCurrencyTypeByLevel(param1:Number) : String
      {
         if(this.mUpgrades.getUpgradeLevel(param1) == null)
         {
            return "";
         }
         return this.mUpgrades.getUpgradeLevel(param1).getCostCurrencyType();
      }
      
      public function getUpgradeCostByLevel(param1:Number) : Number
      {
         if(this.mUpgrades.getUpgradeLevel(param1) == null)
         {
            return 0;
         }
         return this.mUpgrades.getUpgradeLevel(param1).getUpgradeCost();
      }
      
      public function getUpgradeRewardsCurrencyTypeByLevel(param1:Number) : String
      {
         if(this.mUpgrades.getUpgradeLevel(param1) == null)
         {
            return "";
         }
         if(this.mUpgrades.getUpgradeLevel(param1).getUpgradeRewards() == null)
         {
            return "";
         }
         return this.mUpgrades.getUpgradeLevel(param1).getUpgradeRewards()[0].mRewardCurrencyType;
      }
      
      public function getUpgradeRewardsAmountByLevel(param1:Number) : Number
      {
         if(this.mUpgrades.getUpgradeLevel(param1) == null)
         {
            return 0;
         }
         if(this.mUpgrades.getUpgradeLevel(param1).getUpgradeRewards() == null)
         {
            return 0;
         }
         return this.mUpgrades.getUpgradeLevel(param1).getUpgradeRewards()[0].mRewardAmount;
      }
      
      public function getUpgradeValueByLevel(param1:Number) : Number
      {
         if(this.mUpgrades.getUpgradeLevel(param1) == null)
         {
            return 0;
         }
         return this.mUpgrades.getUpgradeLevel(param1).getUpgradeValue();
      }
      
      public function getParamKey() : String
      {
         if(this.mUIParameters == null)
         {
            return "";
         }
         return this.mUIParameters.getParamKey();
      }
      
      public function getParamDisplayName() : String
      {
         if(this.mUIParameters == null)
         {
            return "";
         }
         return this.mUIParameters.getParamDisplayName();
      }
      
      public function getDefaultValue() : Number
      {
         if(this.mUIParameters == null)
         {
            return 0;
         }
         return this.mUIParameters.getDefaultValue();
      }
      
      public function getDivisionFactor() : Number
      {
         if(this.mUIParameters == null)
         {
            return 1;
         }
         return this.mUIParameters.getDivisionFactor();
      }
      
      public function getParamUnit() : String
      {
         if(this.mUIParameters == null)
         {
            return "";
         }
         return this.mUIParameters.getParamUnit();
      }
      
      public function IsLevelMaxLevel(param1:Number) : Boolean
      {
         var _loc2_:* = false;
         if(this.mUpgrades && this.mUpgrades.mBoostLevelUpgrades)
         {
            _loc2_ = param1 >= this.mUpgrades.mBoostLevelUpgrades.length + 1;
         }
         return _loc2_;
      }
      
      public function IsSpecialUpgradeByLevel(param1:Number) : Boolean
      {
         if(this.getUpgradeCostCurrencyTypeByLevel(param1) == CurrencyManager.TYPE_DIAMONDS)
         {
            return true;
         }
         return false;
      }
      
      public function getMaxLevel() : int
      {
         var _loc1_:int = 0;
         if(this.mUpgrades && this.mUpgrades.mBoostLevelUpgrades)
         {
            _loc1_ = this.mUpgrades.mBoostLevelUpgrades.length + 1;
         }
         return _loc1_;
      }
   }
}
