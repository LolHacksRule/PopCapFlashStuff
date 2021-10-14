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
      
      public function KeyframeData(_frameNum:Number = 0, _x:Number = 0, _y:Number = 0, _scaleX:Number = 1, _scaleY:Number = 1)
      {
         super();
         this.frameNum = _frameNum;
         this.x = _x;
         this.y = _y;
         this.scaleX = _scaleX;
         this.scaleY = _scaleY;
      }
   }
}
