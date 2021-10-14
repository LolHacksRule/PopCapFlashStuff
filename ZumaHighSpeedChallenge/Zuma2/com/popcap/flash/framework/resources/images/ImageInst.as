package com.popcap.flash.framework.resources.images
{
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public class ImageInst
   {
       
      
      public var mFrame:int = 0;
      
      public var mIsColored:Boolean = false;
      
      public var mIsTransformed:Boolean = false;
      
      public var mMatrix:Matrix;
      
      public var mOffset:Point;
      
      public var mIsAdditive:Boolean = false;
      
      public var mIsSmoothed:Boolean = false;
      
      public var mPos:Point;
      
      public var mSource:ImageResource = null;
      
      public var mColor:ColorTransform;
      
      public function ImageInst()
      {
         this.mPos = new Point();
         this.mOffset = new Point();
         this.mMatrix = new Matrix();
         this.mColor = new ColorTransform();
         super();
      }
      
      public function get width() : Number
      {
         return this.mSource.mSrcRect.width;
      }
      
      public function get pixels() : BitmapData
      {
         return this.mSource.mFrames[this.mFrame];
      }
      
      public function get height() : Number
      {
         return this.mSource.mSrcRect.height;
      }
      
      public function set x(param1:Number) : void
      {
         this.mPos.x = param1;
         this.mMatrix.tx = param1;
      }
      
      public function set y(param1:Number) : void
      {
         this.mPos.y = param1;
         this.mMatrix.ty = param1;
      }
      
      public function get x() : Number
      {
         return this.mPos.x;
      }
      
      public function get y() : Number
      {
         return this.mPos.y;
      }
   }
}
