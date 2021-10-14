package com.popcap.flash.framework.resources.images
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BitmapDataChannel;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ImageDescriptor
   {
       
      
      public var mRGBClass:Class = null;
      
      public var mAlphaClass:Class = null;
      
      public var mRows:int = 1;
      
      public var mCols:int = 1;
      
      private var mResource:ImageResource = null;
      
      public function ImageDescriptor(rgbClass:Class, alphaClass:Class, rows:int, cols:int)
      {
         super();
         this.mRGBClass = rgbClass;
         this.mAlphaClass = alphaClass;
         this.mRows = rows;
         this.mCols = cols;
      }
      
      public function getResource() : ImageResource
      {
         if(this.mResource != null)
         {
            return this.mResource;
         }
         this.mResource = new ImageResource();
         this.mResource.mRows = this.mRows;
         this.mResource.mCols = this.mCols;
         this.mResource.mNumFrames = this.mRows * this.mCols;
         this.mResource.mFrames = this.sliceFrames(this.mergeData());
         this.mResource.mSrcRect.width = this.mResource.mFrames[0].width;
         this.mResource.mSrcRect.height = this.mResource.mFrames[0].height;
         return this.mResource;
      }
      
      private function mergeData() : BitmapData
      {
         var imgData:BitmapData = null;
         var rgbData:BitmapData = null;
         var alphaData:BitmapData = null;
         if(this.mRGBClass != null)
         {
            rgbData = (new this.mRGBClass() as Bitmap).bitmapData;
         }
         if(this.mAlphaClass != null)
         {
            alphaData = (new this.mAlphaClass() as Bitmap).bitmapData;
         }
         if(rgbData != null)
         {
            imgData = new BitmapData(rgbData.width,rgbData.height,true,0);
         }
         else if(alphaData != null)
         {
            imgData = new BitmapData(alphaData.width,alphaData.height,true,0);
         }
         if(imgData == null)
         {
            throw new Error("Image is empty.");
         }
         var srcRect:Rectangle = new Rectangle();
         srcRect.width = imgData.width;
         srcRect.height = imgData.height;
         var destPt:Point = new Point();
         if(rgbData != null)
         {
            imgData.copyPixels(rgbData,srcRect,destPt);
         }
         if(alphaData != null)
         {
            if(rgbData == null)
            {
               imgData.copyPixels(alphaData,srcRect,destPt);
            }
            imgData.copyChannel(alphaData,srcRect,destPt,BitmapDataChannel.RED,BitmapDataChannel.ALPHA);
         }
         return imgData;
      }
      
      private function sliceFrames(bd:BitmapData) : Vector.<BitmapData>
      {
         var row:Number = NaN;
         var col:Number = NaN;
         var subPixels:BitmapData = null;
         var srcRect:Rectangle = null;
         var frameWidth:Number = bd.width / this.mCols;
         var frameHeight:Number = bd.height / this.mRows;
         var frameRect:Rectangle = new Rectangle(0,0,frameWidth,frameHeight);
         var destPt:Point = new Point(0,0);
         var frames:Vector.<BitmapData> = new Vector.<BitmapData>();
         var numFrames:int = this.mRows * this.mCols;
         for(var i:int = 0; i < numFrames; i++)
         {
            row = int(i / this.mCols);
            col = i % this.mCols;
            subPixels = new BitmapData(frameWidth,frameHeight);
            srcRect = new Rectangle(col * frameWidth,row * frameHeight,frameWidth,frameHeight);
            subPixels.copyPixels(bd,srcRect,destPt);
            frames[i] = subPixels;
         }
         bd.dispose();
         return frames;
      }
   }
}
