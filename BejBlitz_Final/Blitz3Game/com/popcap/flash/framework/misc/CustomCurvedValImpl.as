package com.popcap.flash.framework.misc
{
   import com.popcap.flash.framework.math.HermitePoint;
   
   public class CustomCurvedValImpl extends BaseCurvedVal
   {
      
      public static const FLAG_NOCLIP:int = 1;
      
      public static const FLAG_HERMITE:int = 8;
      
      public static const CV_NUM_SPLINE_POINTS:int = 8192;
       
      
      private var mIsClipped:Boolean;
      
      private var mIsHermite:Boolean;
      
      private var mRecord:CurvedValRecord;
      
      public function CustomCurvedValImpl()
      {
         super();
         this.mIsClipped = false;
         this.mIsHermite = true;
      }
      
      public function setCurve(param1:Boolean, param2:Vector.<CurvedValPoint>) : void
      {
         var _loc3_:CurvedValPoint = null;
         var _loc4_:Number = NaN;
         var _loc5_:HermitePoint = null;
         this.mRecord = new CurvedValRecord();
         this.mRecord.hermite.points.length = 0;
         for each(_loc3_ in param2)
         {
            _loc4_ = Math.tan(_loc3_.angleDegrees / 180 * Math.PI);
            (_loc5_ = new HermitePoint()).x = _loc3_.x;
            _loc5_.fx = _loc3_.y;
            _loc5_.fxp = _loc4_;
            this.mRecord.hermite.points.push(_loc5_);
         }
         this.mRecord.hermite.rebuild();
      }
      
      override public function getOutValue(param1:Number) : Number
      {
         var _loc3_:Number = NaN;
         if(this.mRecord == null)
         {
            return 0;
         }
         if(mInMax - mInMin == 0)
         {
            return 0;
         }
         var _loc2_:Number = Math.min((param1 - mInMin) / (mInMax - mInMin),1);
         if(this.mIsHermite)
         {
            _loc3_ = mOutMin + this.mRecord.hermite.evaluate(_loc2_) * (mOutMax - mOutMin);
            if(this.mIsClipped)
            {
               if(mOutMin < mOutMax)
               {
                  _loc3_ = Math.min(Math.max(_loc3_,mOutMin),mOutMax);
               }
               else
               {
                  _loc3_ = Math.max(Math.min(_loc3_,mOutMin),mOutMax);
               }
            }
            return _loc3_;
         }
         var _loc4_:Vector.<Number> = this.mRecord.table;
         var _loc5_:Number = _loc2_ * (CV_NUM_SPLINE_POINTS - 1);
         var _loc6_:int;
         if((_loc6_ = Math.floor(_loc5_)) == CV_NUM_SPLINE_POINTS - 1)
         {
            return mOutMin + _loc4_[_loc6_] * (mOutMax - mOutMin);
         }
         var _loc7_:Number = _loc5_ - _loc6_;
         _loc3_ = mOutMin;
         _loc3_ += _loc4_[_loc6_] * (1 - _loc7_) + _loc4_[_loc6_ + 1] * _loc7_;
         return Number(_loc3_ * (mOutMax - mOutMin));
      }
   }
}
