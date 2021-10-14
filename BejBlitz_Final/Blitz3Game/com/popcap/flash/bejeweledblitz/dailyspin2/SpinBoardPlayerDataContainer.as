package com.popcap.flash.bejeweledblitz.dailyspin2
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import flash.utils.Dictionary;
   
   public class SpinBoardPlayerDataContainer
   {
       
      
      private var mLastSeenRegularBoardId:String;
      
      private var mLastSeenPremiumBoardId:String;
      
      private var mAdRewardSpinAvailable:Boolean;
      
      private var mPaidSpinBalance:int;
      
      private var mIsFreeSpinAvailable:Boolean;
      
      private var mNextFreeSpinAvailableTime:Number;
      
      private var mBoardProgressMap:Dictionary;
      
      public function SpinBoardPlayerDataContainer()
      {
         super();
         this.mAdRewardSpinAvailable = false;
         this.mIsFreeSpinAvailable = false;
         this.mBoardProgressMap = new Dictionary();
      }
      
      public function GetLastSeenRegularBoardId() : String
      {
         return this.mLastSeenRegularBoardId;
      }
      
      public function GetLastSeenPremiumBoardId() : String
      {
         return this.mLastSeenPremiumBoardId;
      }
      
      public function GetPaidSpinBalance() : int
      {
         return this.mPaidSpinBalance;
      }
      
      public function AdRewardSpinAvailable() : Boolean
      {
         return this.mAdRewardSpinAvailable;
      }
      
      public function IsFreeSpinAvailable() : Boolean
      {
         return this.mIsFreeSpinAvailable;
      }
      
      public function SetAdRewardSpinAvailable(param1:Boolean) : void
      {
         this.mAdRewardSpinAvailable = param1;
      }
      
      public function SetFreeSpinAvailable(param1:Boolean) : void
      {
         this.mIsFreeSpinAvailable = param1;
      }
      
      public function GetNextFreeSpinAvailableTime() : Number
      {
         return this.mNextFreeSpinAvailableTime;
      }
      
      public function GetBoardProgress(param1:int) : SpinBoardPlayerProgress
      {
         if(this.mBoardProgressMap[param1] == null)
         {
            this.mBoardProgressMap[param1] = new SpinBoardPlayerProgress();
         }
         return this.mBoardProgressMap[param1];
      }
      
      public function SetPaidSpinBalance(param1:int) : void
      {
         this.mPaidSpinBalance = param1;
      }
      
      public function SetInfoFromInitialConfig(param1:Object) : void
      {
         this.mNextFreeSpinAvailableTime = Utils.getNumberFromObjectKey(param1.dailySpin,"nextSpinV2",this.mNextFreeSpinAvailableTime);
         this.mIsFreeSpinAvailable = Utils.getBoolFromObjectKey(param1,"hasDailySpin",this.mIsFreeSpinAvailable);
         var _loc2_:uint = Utils.getIntFromObjectKey(param1,"freeAdSpin",0);
         if(_loc2_ == 0)
         {
            this.mAdRewardSpinAvailable = false;
         }
         else if(_loc2_ > 0)
         {
            this.mAdRewardSpinAvailable = true;
         }
         this.mPaidSpinBalance = Utils.getNumberFromObjectKey(param1,"spinCount",this.mPaidSpinBalance);
      }
      
      public function SetInfoFromProgressObject(param1:Object, param2:Boolean) : Boolean
      {
         var _loc4_:String = null;
         var _loc5_:SpinBoardPlayerProgress = null;
         var _loc6_:SpinBoardPlayerProgress = null;
         var _loc7_:String = null;
         var _loc3_:Boolean = false;
         if(param1 != null)
         {
            _loc3_ = true;
            if(param1.regular != null)
            {
               _loc4_ = Utils.getStringFromObjectKey(param1.regular,"boardId","");
               if((_loc5_ = this.mBoardProgressMap[SpinBoardType.RegularBoard]) == null || _loc5_.GetBoardId() != _loc4_)
               {
                  _loc5_ = new SpinBoardPlayerProgress();
               }
               _loc5_.SetInfo(param1.regular,param2);
            }
            if(param1.premium != null)
            {
               _loc6_ = this.mBoardProgressMap[SpinBoardType.PremiumBoard];
               _loc7_ = Utils.getStringFromObjectKey(param1.premium,"boardId","");
               if(_loc6_ == null || _loc6_.GetBoardId() != _loc7_)
               {
                  _loc6_ = new SpinBoardPlayerProgress();
               }
               _loc6_.SetInfo(param1.premium,param2);
            }
            this.mBoardProgressMap[SpinBoardType.RegularBoard] = _loc5_;
            this.mBoardProgressMap[SpinBoardType.PremiumBoard] = _loc6_;
         }
         return _loc3_;
      }
      
      public function SetInfo(param1:Object, param2:Boolean) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:Boolean = false;
         if(param1 != null)
         {
            this.mPaidSpinBalance = Utils.getIntFromObjectKey(param1,"paidBalance",this.mPaidSpinBalance);
            this.mIsFreeSpinAvailable = Utils.getBoolFromObjectKey(param1,"hasDailySpin",this.mIsFreeSpinAvailable);
            if((_loc4_ = Utils.getIntFromObjectKey(param1,"freeBalance",-1)) == 0)
            {
               this.mIsFreeSpinAvailable = false;
            }
            else if(_loc4_ > 0)
            {
               this.mIsFreeSpinAvailable = true;
            }
            if((_loc5_ = Utils.getIntFromObjectKey(param1,"freeAdSpin",-1)) == 0)
            {
               this.mAdRewardSpinAvailable = false;
            }
            else if(_loc5_ > 0)
            {
               this.mAdRewardSpinAvailable = true;
            }
            this.mNextFreeSpinAvailableTime = Utils.getNumberFromObjectKey(param1,"nextFree",this.mNextFreeSpinAvailableTime);
            this.SetInfoFromProgressObject(param1.progress,param2);
            _loc3_ = true;
         }
         return _loc3_;
      }
   }
}
