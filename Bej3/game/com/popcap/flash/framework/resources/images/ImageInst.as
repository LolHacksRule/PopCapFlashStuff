package com.popcap.flash.framework.resources.images
{
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public class ImageInst
   {
       
      
      public var mSource:ImageResource = null;
      
      public var mIsColored:Boolean = false;
      
      public var mIsSmoothed:Boolean = false;
      
      public var mIsAdditive:Boolean = false;
      
      public var mIsTransformed:Boolean = false;
      
      public var mPos:Point;
      
      public var mOffset:Point;
      
      public var mMatrix:Matrix;
      
      public var mColor:ColorTransform;
      
      public var mFrame:int = 0;
      
      public function ImageInst()
      {
         this.mPos = new Point();
         this.mOffset = new Point();
         this.mMatrix = new Matrix();
         this.mColor = new ColorTransform();
         super();
      }
      
      public function get pixels() : BitmapData
      {
         return this.mSource.mFrames[this.mFrame];
      }
      
      public function get x() : Number
      {
         return this.mPos.x;
      }
      
      public function get y() : Number
      {
         return this.mPos.y;
      }
      
      public function get width() : Number
      {
         return this.mSource.mSrcRect.width;
      }
      
      public function get height() : Number
      {
         return this.mSource.mSrcRect.height;
      }
      
      public function set x(value:Number) : void
      {
         this.mPos.x = value;
         this.mMatrix.tx = value;
      }
      
      public function set y(value:Number) : void
      {
         this.mPos.y = value;
         this.mMatrix.ty = value;
      }
   }
}
