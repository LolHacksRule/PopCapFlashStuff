package com.popcap.flash.bejeweledblitz.game.boostV2.parser
{
   import com.popcap.flash.bejeweledblitz.Utils;
   
   public class BoostUpgradeInfo
   {
       
      
      var mBoostLevelUpgrades:Vector.<BoostUpgradeLevelInfo> = null;
      
      var _primaryKey:String = "";
      
      public function BoostUpgradeInfo(param1:Object, param2:String)
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:BoostUpgradeLevelInfo = null;
         var _loc6_:Object = null;
         var _loc7_:Array = null;
         var _loc8_:Object = null;
         var _loc9_:Array = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:Object = null;
         var _loc13_:String = null;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:Object = null;
         var _loc17_:BoostUpgradeRewardInfo = null;
         super();
         this._primaryKey = param2;
         this.mBoostLevelUpgrades = new Vector.<BoostUpgradeLevelInfo>();
         if(param1.Array)
         {
            _loc3_ = Utils.getArrayFromObjectKey(param1.Array,"value");
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               _loc5_ = new BoostUpgradeLevelInfo();
               if(_loc6_ = _loc3_[_loc4_].UpgradeLevel)
               {
                  if(_loc7_ = Utils.getArrayFromObjectKey(_loc6_.value.Array,"value"))
                  {
                     _loc10_ = _loc7_.length;
                     _loc11_ = 0;
                     while(_loc11_ < _loc10_)
                     {
                        if(_loc12_ = _loc7_[_loc11_].ActionSetValue)
                        {
                           if(_loc12_.val1 && _loc12_.val1.LocalProperties && _loc12_.val2 && _loc12_.val2.Number)
                           {
                              if((_loc13_ = Utils.getStringFromObjectKey(_loc12_.val1.LocalProperties,"value")) == this._primaryKey)
                              {
                                 _loc5_.mUpgradeValue = Utils.getNumberFromObjectKey(_loc12_.val2.Number,"value",0);
                                 break;
                              }
                           }
                        }
                        _loc11_++;
                     }
                  }
                  if(_loc8_ = _loc6_.cost.Cost)
                  {
                     _loc5_.mCostCurrencyType = Utils.getStringFromObjectKey(_loc8_.type.CurrencyType,"value","");
                     _loc5_.mCost = Utils.getNumberFromObjectKey(_loc8_.value.Number,"value",0);
                  }
                  if(_loc9_ = Utils.getArrayFromObjectKey(_loc6_.reward.Array,"value"))
                  {
                     _loc14_ = _loc9_.length;
                     _loc15_ = 0;
                     while(_loc15_ < _loc9_.length)
                     {
                        if(_loc16_ = _loc9_[_loc15_].RewardItem)
                        {
                           (_loc17_ = new BoostUpgradeRewardInfo()).mRewardCurrencyType = Utils.getStringFromObjectKey(_loc16_.type.CurrencyType,"value","");
                           _loc17_.mRewardAmount = Utils.getNumberFromObjectKey(_loc16_.value.Number,"value",0);
                           _loc5_.addReward(_loc17_);
                        }
                        _loc15_++;
                     }
                  }
               }
               this.mBoostLevelUpgrades.push(_loc5_);
               _loc4_++;
            }
         }
      }
      
      public function getUpgradeLevel(param1:int) : BoostUpgradeLevelInfo
      {
         if(param1 > 0 && param1 <= this.mBoostLevelUpgrades.length + 1)
         {
            return this.mBoostLevelUpgrades[param1 - 1];
         }
         return null;
      }
      
      public function getMaxLevelUpgrades() : uint
      {
         return this.mBoostLevelUpgrades.length;
      }
   }
}
