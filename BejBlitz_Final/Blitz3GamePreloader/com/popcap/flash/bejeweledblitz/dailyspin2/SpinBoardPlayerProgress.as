package com.popcap.flash.bejeweledblitz.dailyspin2
{
   import com.popcap.flash.bejeweledblitz.Utils;
   
   public class SpinBoardPlayerProgress
   {
       
      
      private var mProgressiveSpinCount:int;
      
      private var mLastBoardResetTime:Number;
      
      private var mBoardId:String;
      
      private var mClaimedBits:int;
      
      private var mUpgradedBits:int;
      
      private var mBoardResetTime:Number;
      
      private var mSpecialTilesClaimed:uint;
      
      private var mPreviousClaimedBits:int;
      
      private var mPreviousUpgradedBits:int;
      
      private var mClaimedBitsDirtyFlag:Boolean;
      
      private var mUpgradedBitsDirtyFlag:Boolean;
      
      private var mIsSettingForTheFirstTime:Boolean;
      
      private var mBoardClaimIterator:int;
      
      public function SpinBoardPlayerProgress()
      {
         super();
         this.mProgressiveSpinCount = 0;
         this.mLastBoardResetTime = 0;
         this.mBoardId = "";
         this.mClaimedBits = 0;
         this.mUpgradedBits = 0;
         this.mBoardResetTime = 0;
         this.mSpecialTilesClaimed = 0;
         this.mClaimedBitsDirtyFlag = false;
         this.mUpgradedBitsDirtyFlag = false;
         this.mIsSettingForTheFirstTime = true;
      }
      
      public function GetProgressiveSpinCount() : int
      {
         return this.mProgressiveSpinCount;
      }
      
      public function GetLastBoardResetTime() : Number
      {
         return this.mLastBoardResetTime;
      }
      
      public function GetBoardId() : String
      {
         return this.mBoardId;
      }
      
      public function GetBoardResetTime() : Number
      {
         return this.mBoardResetTime;
      }
      
      public function GetClaimedBitField() : int
      {
         return this.mClaimedBits;
      }
      
      public function GetSpecialTilesClaimed() : uint
      {
         return this.mSpecialTilesClaimed;
      }
      
      public function GetBitValue(param1:int, param2:int) : Boolean
      {
         return Boolean(param1 & 1 << param2);
      }
      
      public function SetBitValue(param1:int, param2:int, param3:int) : void
      {
         param1 |= param3 << param2;
      }
      
      public function GetClaimStatus(param1:int) : Boolean
      {
         return this.GetBitValue(this.mClaimedBits,param1);
      }
      
      public function GetUpgradeStatus(param1:int) : Boolean
      {
         return this.GetBitValue(this.mUpgradedBits,param1);
      }
      
      public function SetDirtyStateForUpgradedBits(param1:Boolean) : void
      {
         this.mUpgradedBitsDirtyFlag = param1;
      }
      
      public function AreUpgradedBitsDirty() : Boolean
      {
         return this.mUpgradedBitsDirtyFlag;
      }
      
      public function SetDirtyStateForClaimedBits(param1:Boolean) : void
      {
         this.mClaimedBitsDirtyFlag = param1;
      }
      
      public function AreClaimedBitsDirty() : Boolean
      {
         return this.mClaimedBitsDirtyFlag;
      }
      
      public function HasBeenReset() : Boolean
      {
         return this.mBoardResetTime == 0;
      }
      
      public function GetDifferenceBetweenClaimedBits() : int
      {
         var _loc1_:* = 0;
         if(this.mClaimedBitsDirtyFlag)
         {
            _loc1_ = this.mPreviousClaimedBits ^ this.mClaimedBits;
         }
         return _loc1_;
      }
      
      public function GetDifferenceBetweenUpgradeBits() : int
      {
         var _loc1_:* = 0;
         if(this.mUpgradedBitsDirtyFlag)
         {
            _loc1_ = this.mPreviousUpgradedBits ^ this.mUpgradedBits;
         }
         return _loc1_;
      }
      
      public function IsTileEnabled(param1:int) : Boolean
      {
         return !this.GetBitValue(this.mClaimedBits,param1);
      }
      
      public function AreAllTilesClaimed() : Boolean
      {
         return this.mClaimedBits == 33554431;
      }
      
      public function HasTimerExpired() : Boolean
      {
         var _loc1_:Number = NaN;
         if(this.mBoardResetTime <= 0)
         {
            return false;
         }
         _loc1_ = new Date().time / 1000;
         return this.mBoardResetTime <= _loc1_;
      }
      
      public function GetBoardClaimIterator() : int
      {
         return this.mBoardClaimIterator;
      }
      
      public function Reset(param1:Boolean = true) : void
      {
         Utils.logWithStackTrace(this,"[SpinBoardPlayerProgress] : Reset " + this.mBoardId + ": " + param1);
         if(param1)
         {
            this.mLastBoardResetTime = this.mBoardResetTime;
            this.mBoardResetTime = 0;
            this.mPreviousClaimedBits = 0;
            this.mPreviousUpgradedBits = 0;
            this.mClaimedBitsDirtyFlag = false;
            this.mUpgradedBitsDirtyFlag = false;
         }
         this.mClaimedBits = 0;
         this.mUpgradedBits = 0;
         this.mProgressiveSpinCount = 0;
         this.mSpecialTilesClaimed = 0;
      }
      
      public function SetInfo(param1:Object, param2:Boolean) : Boolean
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = 0;
         var _loc9_:int = 0;
         var _loc3_:Boolean = true;
         var _loc4_:int = this.mClaimedBits;
         var _loc5_:int = this.mUpgradedBits;
         this.Reset(false);
         if(param1 != null)
         {
            this.mBoardResetTime = Utils.getNumberFromObjectKey(param1,"boardResetTime",0);
            if(this.mBoardResetTime != 0)
            {
               this.mBoardId = Utils.getStringFromObjectKey(param1,"boardId","");
               _loc6_ = Utils.getIntFromObjectKey(param1,"claimBits",0);
               _loc7_ = Utils.getIntFromObjectKey(param1,"upgradeBits",0);
               this.mClaimedBits = _loc6_;
               this.mUpgradedBits = _loc7_;
               if(_loc6_ != _loc4_ && (!this.mIsSettingForTheFirstTime || param2))
               {
                  this.mPreviousClaimedBits = _loc4_;
                  this.mClaimedBitsDirtyFlag = true;
               }
               if(_loc7_ != _loc5_ && (!this.mIsSettingForTheFirstTime || param2))
               {
                  this.mPreviousUpgradedBits = _loc5_;
                  this.mUpgradedBitsDirtyFlag = true;
               }
               this.mIsSettingForTheFirstTime = false;
               this.mSpecialTilesClaimed = Utils.getIntFromObjectKey(param1,"shareCounter",0);
               _loc8_ = 1;
               _loc9_ = 0;
               while(_loc9_ < SpinBoardInfo.sNumberOfTiles)
               {
                  if(this.mClaimedBits & _loc8_)
                  {
                     ++this.mProgressiveSpinCount;
                  }
                  _loc8_ <<= 1;
                  _loc9_++;
               }
               this.mBoardClaimIterator = Utils.getIntFromObjectKey(param1,"boardIteration",1);
            }
         }
         else
         {
            _loc3_ = false;
         }
         return _loc3_;
      }
   }
}
