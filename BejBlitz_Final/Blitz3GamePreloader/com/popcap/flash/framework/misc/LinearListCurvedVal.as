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
      
      override public function getOutValue(param1:Number) : Number
      {
         if(this.values == null)
         {
            return this.CalcRangeOut(param1);
         }
         var _loc2_:Number = Math.min(Math.max(param1,mInMin),mInMax);
         var _loc3_:Number = mInMax - mInMin;
         var _loc4_:Number;
         if((_loc4_ = (_loc2_ - mInMin) / _loc3_) >= 1)
         {
            _loc4_ = 0;
         }
         var _loc5_:Number = this.values.length * _loc4_;
         var _loc6_:int = int(_loc5_);
         var _loc7_:Number = _loc5_ - _loc6_;
         var _loc8_:int = _loc6_;
         var _loc9_:int;
         if((_loc9_ = _loc6_ + 1) >= this.values.length)
         {
            _loc9_ = 0;
         }
         var _loc10_:Number = this.values[_loc8_];
         var _loc12_:Number;
         var _loc11_:Number;
         return Number((_loc12_ = (_loc11_ = this.values[_loc9_]) - _loc10_) * _loc7_ + _loc10_);
      }
      
      private function CalcRangeOut(param1:Number) : Number
      {
         var _loc2_:Number = Math.min(Math.max(param1,mInMin),mInMax);
         var _loc3_:Number = mInMax - mInMin;
         var _loc4_:Number = (_loc2_ - mInMin) / _loc3_;
         var _loc5_:Number;
         return Number((_loc5_ = mOutMax - mOutMin) * _loc4_ + mOutMin);
      }
   }
}
