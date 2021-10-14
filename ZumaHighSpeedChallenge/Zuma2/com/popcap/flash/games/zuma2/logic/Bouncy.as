package com.popcap.flash.games.zuma2.logic
{
   public class Bouncy
   {
       
      
      public var mStartingRate:Number;
      
      public var mDone:Boolean;
      
      public var mRateDivFactor:Number;
      
      public var mFinalPct:Number;
      
      public var mStartingPct:Number;
      
      public var mCount:int;
      
      public var mMaxPct:Number;
      
      public var mRate:Number;
      
      public var mStartInc:Boolean;
      
      public var mInc:Boolean;
      
      public var mPct:Number;
      
      public var mMaxBounces:int;
      
      public var mMinPct:Number;
      
      public function Bouncy()
      {
         super();
         this.mCount = 0;
         this.mMaxBounces = 0;
         this.mPct = 0;
         this.mRate = 0;
         this.mStartingPct = 0;
         this.mStartInc = true;
         this.mInc = true;
         this.mDone = false;
         this.mRateDivFactor = 2;
         this.mStartingRate = 0;
      }
      
      public function Update() : void
      {
         var _loc1_:Number = NaN;
         if(this.mDone)
         {
            return;
         }
         this.mPct += !!this.mInc ? this.mRate : -this.mRate;
         if(this.mCount == this.mMaxBounces)
         {
            _loc1_ = this.mFinalPct;
         }
         else
         {
            _loc1_ = !!this.mInc ? Number(this.mMaxPct) : Number(this.mMinPct);
         }
         if(this.mInc && this.mPct >= _loc1_)
         {
            this.mPct = _loc1_;
            this.mInc = false;
            ++this.mCount;
            this.mRate /= this.mRateDivFactor;
         }
         else if(!this.mInc && this.mPct <= _loc1_)
         {
            this.mPct = _loc1_;
            this.mInc = true;
            ++this.mCount;
            this.mRate /= this.mRateDivFactor;
         }
         if(this.mCount > this.mMaxBounces)
         {
            this.mDone = true;
         }
      }
      
      public function SetRate(param1:Number) : void
      {
         this.mRate = this.mStartingRate = param1;
      }
      
      public function SetTargetPercents(param1:Number, param2:Number, param3:Number) : void
      {
         this.mMinPct = param1;
         this.mMaxPct = param2;
         this.mFinalPct = param3;
      }
      
      public function GetPct() : Number
      {
         return this.mPct;
      }
      
      public function SetRateDivFactor(param1:Number) : void
      {
         this.mRateDivFactor = param1;
      }
      
      public function SetNumBounces(param1:int) : void
      {
         this.mMaxBounces = param1;
      }
      
      public function IsDone() : Boolean
      {
         return this.mDone;
      }
      
      public function Reset() : void
      {
         this.mCount = 0;
         this.mPct = this.mStartingPct;
         this.mInc = this.mStartInc;
         this.mDone = false;
         this.mRate = this.mStartingRate;
      }
      
      public function GetCount() : int
      {
         return this.mCount;
      }
      
      public function SetPct(param1:Number, param2:Boolean = true) : void
      {
         this.mPct = this.mStartingPct = param1;
         this.mInc = this.mStartInc = param2;
      }
   }
}
