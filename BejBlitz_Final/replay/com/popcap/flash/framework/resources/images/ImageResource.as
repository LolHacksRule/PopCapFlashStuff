package com.popcap.flash.framework.resources.images
{
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   
   public class ImageResource
   {
       
      
      public var mFrames:Vector.<BitmapData>;
      
      public var mRows:int = 1;
      
      public var mCols:int = 1;
      
      public var mNumFrames:int = 1;
      
      public var mSrcRect:Rectangle;
      
      public function ImageResource()
      {
         this.mSrcRect = new Rectangle();
         super();
      }
   }
}
