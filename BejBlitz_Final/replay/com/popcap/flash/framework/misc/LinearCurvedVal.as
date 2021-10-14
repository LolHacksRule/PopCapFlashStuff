package com.popcap.flash.framework.misc
{
   public class LinearCurvedVal extends BaseCurvedVal
   {
       
      
      public function LinearCurvedVal()
      {
         super();
      }
      
      override public function getOutValue(inVal:Number) : Number
      {
         var inValue:Number = Math.min(Math.max(inVal,mInMin),mInMax);
         var inRange:Number = mInMax - mInMin;
         var t:Number = (inValue - mInMin) / inRange;
         var outRange:Number = mOutMax - mOutMin;
         return Number(outRange * t + mOutMin);
      }
   }
}
