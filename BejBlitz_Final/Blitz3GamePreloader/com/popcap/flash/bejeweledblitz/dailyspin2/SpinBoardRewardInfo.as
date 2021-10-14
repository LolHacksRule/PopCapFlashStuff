package com.popcap.flash.bejeweledblitz.dailyspin2
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import flash.utils.Dictionary;
   
   public class SpinBoardRewardInfo
   {
       
      
      private var mRewardType:int;
      
      private var mRewardTypeString:String;
      
      private var mDisplayName:String;
      
      private var mName:String;
      
      private var mAmount:int;
      
      private var mRewardStringToDisplayName:Dictionary;
      
      public function SpinBoardRewardInfo()
      {
         super();
         this.mRewardType = SpinBoardRewardType.RewardTypeInvalid;
         this.mRewardTypeString = "";
         this.mDisplayName = "";
         this.mAmount = 0;
         this.mRewardStringToDisplayName = new Dictionary();
         this.mRewardStringToDisplayName["currency1"] = "GOLD BARS";
         this.mRewardStringToDisplayName["currency2"] = "DIAMONDS";
         this.mRewardStringToDisplayName["currency3"] = "SHARDS";
         this.mRewardStringToDisplayName["coins"] = "COINS";
         this.mRewardStringToDisplayName["spins"] = "SPINS";
      }
      
      public function GetRewardType() : int
      {
         return this.mRewardType;
      }
      
      public function GetRewardTypeString() : String
      {
         return this.mRewardTypeString;
      }
      
      public function GetDisplayName() : String
      {
         return this.mDisplayName;
      }
      
      public function GetName() : String
      {
         return this.mName;
      }
      
      public function GetAmount() : int
      {
         return this.mAmount;
      }
      
      public function SetInfo(param1:Object) : Boolean
      {
         var _loc2_:Boolean = true;
         if(param1 == null)
         {
            _loc2_ = false;
         }
         else
         {
            this.mRewardTypeString = Utils.getStringFromObjectKey(param1,"type","");
            if(this.mRewardTypeString == "spins")
            {
               this.mRewardType = SpinBoardRewardType.RewardTypeSpins;
            }
            else if(this.mRewardTypeString == "gem")
            {
               this.mRewardType = SpinBoardRewardType.RewardTypeGems;
            }
            else if(this.mRewardTypeString == "currency1" || this.mRewardTypeString == "currency2" || this.mRewardTypeString == "currency3" || this.mRewardTypeString == "coins")
            {
               this.mRewardType = SpinBoardRewardType.RewardTypeCurrency;
            }
            else
            {
               this.mRewardType = SpinBoardRewardType.RewardTypeInvalid;
            }
            if(this.mRewardType != SpinBoardRewardType.RewardTypeInvalid)
            {
               this.mName = Utils.getStringFromObjectKey(param1,"name","");
               this.mDisplayName = Utils.getStringFromObjectKey(param1,"displayName","");
               if(this.mRewardType == SpinBoardRewardType.RewardTypeGems)
               {
                  if(this.mDisplayName == "")
                  {
                     this.mDisplayName = Blitz3App.app.sessionData.rareGemManager.GetLocalizedRareGemName(this.mName);
                  }
               }
               else
               {
                  this.mDisplayName = this.mRewardStringToDisplayName[this.mRewardTypeString];
               }
               this.mAmount = Utils.getIntFromObjectKey(param1,"value",0);
            }
            else
            {
               _loc2_ = false;
            }
         }
         return _loc2_;
      }
   }
}
