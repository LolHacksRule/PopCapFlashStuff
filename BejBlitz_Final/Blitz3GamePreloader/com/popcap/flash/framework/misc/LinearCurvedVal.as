package com.popcap.flash.framework.misc
{
   public class LinearCurvedVal extends BaseCurvedVal
   {
       
      
      public function LinearCurvedVal()
      {
         super();
      }
      
      override public function getOutValue(param1:Number) : Number
      {
         var _loc2_:Number = Math.min(Math.max(param1,mInMin),mInMax);
         var _loc3_:Number = mInMax - mInMin;
         var _loc4_:Number = (_loc2_ - mInMin) / _loc3_;
         var _loc5_:Number;
         return Number((_loc5_ = mOutMax - mOutMin) * _loc4_ + mOutMin);
      }
   }
}
