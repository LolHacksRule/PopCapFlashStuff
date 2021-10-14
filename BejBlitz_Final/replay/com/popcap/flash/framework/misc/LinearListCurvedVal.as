package com.popcap.flash.framework.misc
{
   public class LinearListCurvedVal extends BaseCurvedVal
   {
       
      
      public var values:Vector.<int>;
      
      public function LinearListCurvedVal()
      {
         super();
         this.values = new Vector.<int>();
      }
      
      override public function getOutValue(inVal:Number) : Number
      {
         if(this.values == null)
         {
            return this.CalcRangeOut(inVal);
         }
         var inValue:Number = Math.min(Math.max(inVal,mInMin),mInMax);
         var inRange:Number = mInMax - mInMin;
         var t:Number = (inValue - mInMin) / inRange;
         if(t >= 1)
         {
            t = 0;
         }
         var slice:Number = this.values.length * t;
         var index:int = int(slice);
         var subT:Number = slice - index;
         var left:int = index;
         var right:int = index + 1;
         if(right >= this.values.length)
         {
            right = 0;
         }
         var a:Number = this.values[left];
         var b:Number = this.values[right];
         var outRange:Number = b - a;
         return Number(outRange * subT + a);
      }
      
      private function CalcRangeOut(inVal:Number) : Number
      {
         var inValue:Number = Math.min(Math.max(inVal,mInMin),mInMax);
         var inRange:Number = mInMax - mInMin;
         var t:Number = (inValue - mInMin) / inRange;
         var outRange:Number = mOutMax - mOutMin;
         return Number(outRange * t + mOutMin);
      }
   }
}
