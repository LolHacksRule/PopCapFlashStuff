package com.popcap.flash.framework.misc
{
   import com.popcap.flash.framework.math.HermitePoint;
   
   public class CustomCurvedVal extends BaseCurvedVal
   {
      
      public static const FLAG_NOCLIP:int = 1;
      
      public static const FLAG_HERMITE:int = 8;
      
      public static const CV_NUM_SPLINE_POINTS:int = 8192;
       
      
      private var mIsClipped:Boolean = false;
      
      private var mIsHermite:Boolean = true;
      
      private var mRecord:CurvedValRecord;
      
      public function CustomCurvedVal()
      {
         super();
      }
      
      public function setCurve(isHermite:Boolean, ... points) : void
      {
         var p:CurvedValPoint = null;
         var slope:Number = NaN;
         var hp:HermitePoint = null;
         this.mRecord = new CurvedValRecord();
         this.mRecord.table = this.generateTable();
         this.mRecord.hermite.points.length = 0;
         var numPoints:int = points.length;
         for(var i:int = 0; i < numPoints; i++)
         {
            p = points[i];
            slope = Math.tan(p.angleDegrees / 180 * Math.PI);
            hp = new HermitePoint();
            hp.x = p.x;
            hp.fx = p.y;
            hp.fxp = slope;
            this.mRecord.hermite.points.push(hp);
         }
         this.mRecord.hermite.rebuild();
      }
      
      override public function getOutValue(inVal:Number) : Number
      {
         var anOutVal:Number = NaN;
         if(this.mRecord == null)
         {
            return 0;
         }
         if(mInMax - mInMin == 0)
         {
            return 0;
         }
         var aCheckInVal:Number = Math.min((inVal - mInMin) / (mInMax - mInMin),1);
         if(this.mIsHermite)
         {
            anOutVal = mOutMin + this.mRecord.hermite.evaluate(aCheckInVal) * (mOutMax - mOutMin);
            if(this.mIsClipped)
            {
               if(mOutMin < mOutMax)
               {
                  anOutVal = Math.min(Math.max(anOutVal,mOutMin),mOutMax);
               }
               else
               {
                  anOutVal = Math.max(Math.min(anOutVal,mOutMin),mOutMax);
               }
            }
            return anOutVal;
         }
         var table:Vector.<Number> = this.mRecord.table;
         var aGX:Number = aCheckInVal * (CV_NUM_SPLINE_POINTS - 1);
         var aLeft:int = int(aGX);
         if(aLeft == CV_NUM_SPLINE_POINTS - 1)
         {
            return mOutMin + table[aLeft] * (mOutMax - mOutMin);
         }
         var aFrac:Number = aGX - aLeft;
         anOutVal = mOutMin;
         anOutVal += table[aLeft] * (1 - aFrac) + table[aLeft + 1] * aFrac;
         return Number(anOutVal * (mOutMax - mOutMin));
      }
      
      private function generateTable() : Vector.<Number>
      {
         return null;
      }
   }
}
