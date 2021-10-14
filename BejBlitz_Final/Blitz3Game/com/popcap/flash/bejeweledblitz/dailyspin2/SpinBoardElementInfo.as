package com.popcap.flash.bejeweledblitz.dailyspin2
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import flash.trace.Trace;
   
   public class SpinBoardElementInfo
   {
       
      
      private var mDefaultTileInfo:SpinBoardTileInfo;
      
      private var mUpgradedTileInfo:SpinBoardTileInfo;
      
      private var mUpgradeWeight:uint;
      
      public function SpinBoardElementInfo()
      {
         super();
         this.mDefaultTileInfo = null;
         this.mUpgradedTileInfo = null;
         this.mUpgradeWeight = 0;
      }
      
      public function GetTileInfo(param1:Boolean) : SpinBoardTileInfo
      {
         if(param1)
         {
            return this.mUpgradedTileInfo;
         }
         return this.mDefaultTileInfo;
      }
      
      public function GetDefaultTileInfo() : SpinBoardTileInfo
      {
         return this.mDefaultTileInfo;
      }
      
      public function GetUpgradedTileInfo() : SpinBoardTileInfo
      {
         return this.mUpgradedTileInfo;
      }
      
      public function GetUpgradeWeight() : uint
      {
         return this.mUpgradeWeight;
      }
      
      public function IsExclusive(param1:Boolean) : Boolean
      {
         if(param1)
         {
            return this.mUpgradedTileInfo.IsExclusive();
         }
         return this.mDefaultTileInfo.IsExclusive();
      }
      
      public function GetRewards(param1:Boolean) : Vector.<SpinBoardRewardInfo>
      {
         if(param1)
         {
            return this.mUpgradedTileInfo.GetRewards();
         }
         return this.mDefaultTileInfo.GetRewards();
      }
      
      public function GetHighlightWeight(param1:Boolean) : uint
      {
         if(param1)
         {
            return this.mUpgradedTileInfo.GetHighlightWeight();
         }
         return this.mDefaultTileInfo.GetHighlightWeight();
      }
      
      public function SetInfo(param1:Object) : Boolean
      {
         var _loc2_:Boolean = true;
         this.mUpgradeWeight = Utils.getUintFromObjectKey(param1,"upgradeWeight",0);
         this.mDefaultTileInfo = new SpinBoardTileInfo();
         this.mUpgradedTileInfo = new SpinBoardTileInfo();
         if(!this.mDefaultTileInfo.SetInfo(param1.§default§))
         {
            this.mDefaultTileInfo = null;
         }
         if(!this.mUpgradedTileInfo.SetInfo(param1.upgraded))
         {
            this.mUpgradedTileInfo = null;
         }
         if(this.mUpgradedTileInfo == null || this.mDefaultTileInfo == null)
         {
            _loc2_ = false;
            Trace("[SpinBoardElementInfo] Invalid Upgraded or Default TileInfo, deleting ElementInfo.");
         }
         return _loc2_;
      }
   }
}
