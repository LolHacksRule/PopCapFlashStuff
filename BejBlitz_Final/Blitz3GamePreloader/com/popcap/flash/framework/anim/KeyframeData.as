package com.popcap.flash.framework.anim
{
   public class KeyframeData
   {
      
      public static const IGNORE_VALUE:Number = Number.NaN;
       
      
      public var frameNum:Number = 0;
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public var scaleX:Number = 1;
      
      public var scaleY:Number = 1;
      
      public function KeyframeData(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 1, param5:Number = 1)
      {
         super();
         this.frameNum = param1;
         this.x = param2;
         this.y = param3;
         this.scaleX = param4;
         this.scaleY = param5;
      }
   }
}
