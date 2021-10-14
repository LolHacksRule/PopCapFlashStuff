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
      
      public function setInRange(param1:Number, param2:Number) : void
      {
         this.mInMin = param1;
         this.mInMax = param2;
      }
      
      public function setOutRange(param1:Number, param2:Number) : void
      {
         this.mOutMin = param1;
         this.mOutMax = param2;
      }
      
      public function getOutValue(param1:Number) : Number
      {
         return this.mOutMax;
      }
   }
}
