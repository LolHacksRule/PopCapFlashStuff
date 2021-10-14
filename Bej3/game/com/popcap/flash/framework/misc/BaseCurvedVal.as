package com.popcap.flash.framework.misc
{
   public class BaseCurvedVal implements CurvedVal
   {
       
      
      protected var mInMin:Number = 0.0;
      
      protected var mInMax:Number = 1.0;
      
      protected var mOutMin:Number = 0.0;
      
      protected var mOutMax:Number = 1.0;
      
      public function BaseCurvedVal()
      {
         super();
      }
      
      public function setInRange(min:Number, max:Number) : void
      {
         this.mInMin = min;
         this.mInMax = max;
      }
      
      public function setOutRange(min:Number, max:Number) : void
      {
         this.mOutMin = min;
         this.mOutMax = max;
      }
      
      public function getOutValue(inVal:Number) : Number
      {
         return this.mOutMax;
      }
   }
}
