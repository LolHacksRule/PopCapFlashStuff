package com.popcap.flash.bejeweledblitz.dailyspin2
{
   import com.popcap.flash.bejeweledblitz.Utils;
   
   public class UpgradeLevelInfo
   {
       
      
      private var mNextUpgradeSpinThreshold:int;
      
      public function UpgradeLevelInfo()
      {
         super();
         this.mNextUpgradeSpinThreshold = 0;
      }
      
      public function GetNextUpgradeSpinThreshold() : int
      {
         return this.mNextUpgradeSpinThreshold;
      }
      
      public function SetInfo(param1:Object) : Boolean
      {
         this.mNextUpgradeSpinThreshold = Utils.getUintFromObjectKey(param1,"nextUpgradeSpinThreshold",0);
         if(this.mNextUpgradeSpinThreshold == 0)
         {
            return false;
         }
         return true;
      }
   }
}
