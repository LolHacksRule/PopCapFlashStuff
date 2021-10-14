package com.popcap.flash.games.zuma2.logic
{
   public class CurveDesc
   {
       
      
      public var mDangerDistance:int;
      
      public var mCurAcceleration:Number;
      
      public var mApp:Zuma2App;
      
      public var mCutoffPoint:int;
      
      public var mMergeSpeed:Number;
      
      public var mVals:BasicCurveVals;
      
      public function CurveDesc(param1:Zuma2App)
      {
         super();
         this.mApp = param1;
         this.mMergeSpeed = 0.025;
         this.mDangerDistance = 600;
      }
      
      public function GetValuesFrom(param1:CurveData) : void
      {
         this.mVals = param1.mVals;
      }
   }
}
