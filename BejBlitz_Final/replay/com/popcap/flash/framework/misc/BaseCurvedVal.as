package com.popcap.flash.framework.misc
{
   public class BaseCurvedVal implements CurvedVal
   {
       
      
      protected var mInMin:Number;
      
      protected var mInMax:Number;
      
      protected var mOutMin:Number;
      
      protected var mOutMax:Number;
      
      public function BaseCurvedVal()
      {
         super();
         this.mInMin = 0;
         this.mInMax = 1;
         this.mOutMin = 0;
         this.mOutMax = 1;
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
