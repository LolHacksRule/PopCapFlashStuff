package com.popcap.flash.games.zuma2.logic
{
   public class Component
   {
       
      
      public var mValue:Number;
      
      public var mTargetValue:Number;
      
      public var mValueDelta:Number;
      
      public var mStartFrame:int;
      
      public var mOriginalValue:Number;
      
      public var mEndFrame:int;
      
      public function Component(param1:Number, param2:Number, param3:int = 0, param4:int = 0)
      {
         super();
         this.mValue = param1;
         this.mOriginalValue = param1;
         this.mTargetValue = param2;
         this.mStartFrame = param3;
         this.mEndFrame = param4;
         this.mValueDelta = param4 - param3 == 0 ? Number(0) : Number((param2 - param1) / Number(param4 - param3));
      }
      
      public function Update() : void
      {
         this.mValue += this.mValueDelta;
         if(this.mValueDelta > 0 && this.mValue > this.mTargetValue || this.mValueDelta < 0 && this.mValue < this.mTargetValue)
         {
            this.mValue = this.mTargetValue;
         }
      }
      
      public function Active(param1:int) : Boolean
      {
         return param1 >= this.mStartFrame && param1 <= this.mEndFrame;
      }
   }
}
