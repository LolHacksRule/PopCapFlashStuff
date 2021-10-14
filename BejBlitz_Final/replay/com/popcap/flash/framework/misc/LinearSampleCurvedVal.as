package com.popcap.flash.framework.misc
{
   public class LinearSampleCurvedVal extends BaseCurvedVal
   {
       
      
      protected var m_Values:Vector.<Vector.<Number>>;
      
      protected var m_EndcapsCreated:Boolean = false;
      
      public function LinearSampleCurvedVal()
      {
         super();
         this.m_Values = new Vector.<Vector.<Number>>();
      }
      
      public function prettyPrint() : void
      {
         var val:Vector.<Number> = null;
         var test:Number = NaN;
         var tests:Vector.<Number> = new Vector.<Number>();
         tests.push(mInMin);
         tests.push(mInMin + 0.25 * (mInMax - mInMin));
         tests.push(mInMin + 0.5 * (mInMax - mInMin));
         tests.push(mInMin + 0.75 * (mInMax - mInMin));
         tests.push(mInMax);
         trace("In range: " + mInMin + " - " + mInMax);
         trace("Out range: " + mOutMin + " - " + mOutMax);
         trace("Values:");
         for each(val in this.m_Values)
         {
            trace(" " + val[0] + " -> " + val[1]);
         }
         trace("Tests:");
         for each(test in tests)
         {
            trace(" " + test + " -> " + this.getOutValue(test));
         }
      }
      
      public function addPoint(inVal:Number, outVal:Number) : void
      {
         if(inVal <= mInMin || inVal >= mInMax)
         {
            return;
         }
         var data:Vector.<Number> = new Vector.<Number>(2);
         data[0] = inVal;
         data[1] = outVal;
         var numVals:int = this.m_Values.length;
         for(var i:int = 0; i < numVals - 1; i++)
         {
            if(inVal < this.m_Values[i + 1][0])
            {
               this.m_Values.splice(i + 1,0,data);
            }
         }
      }
      
      override public function setInRange(min:Number, max:Number) : void
      {
         var bottom:Vector.<Number> = null;
         var top:Vector.<Number> = null;
         super.setInRange(min,max);
         if(!this.m_EndcapsCreated)
         {
            bottom = new Vector.<Number>(2);
            bottom[1] = 0;
            top = new Vector.<Number>(2);
            top[1] = 0;
            this.m_Values.unshift(bottom);
            this.m_Values.push(top);
            this.m_EndcapsCreated = true;
         }
         this.m_Values[0][0] = min;
         this.m_Values[this.m_Values.length - 1][0] = max;
      }
      
      override public function setOutRange(min:Number, max:Number) : void
      {
         var bottom:Vector.<Number> = null;
         var top:Vector.<Number> = null;
         super.setOutRange(min,max);
         if(!this.m_EndcapsCreated)
         {
            bottom = new Vector.<Number>(2);
            bottom[0] = 0;
            top = new Vector.<Number>(2);
            top[0] = 0;
            this.m_Values.unshift(bottom);
            this.m_Values.push(top);
            this.m_EndcapsCreated = true;
         }
         this.m_Values[0][1] = min;
         this.m_Values[this.m_Values.length - 1][1] = max;
      }
      
      override public function getOutValue(inVal:Number) : Number
      {
         var inValue:Number = Math.min(Math.max(inVal,mInMin),mInMax);
         var numVals:int = this.m_Values.length;
         var lowData:Vector.<Number> = this.m_Values[numVals - 2];
         var highData:Vector.<Number> = this.m_Values[numVals - 1];
         for(var i:int = 0; i < numVals - 1; i++)
         {
            if(inValue <= this.m_Values[i + 1][0])
            {
               lowData = this.m_Values[i];
               highData = this.m_Values[i + 1];
               break;
            }
         }
         var pos:Number = (inValue - lowData[0]) / (highData[0] - lowData[0]);
         return Number(lowData[1] + pos * (highData[1] - lowData[1]));
      }
   }
}
