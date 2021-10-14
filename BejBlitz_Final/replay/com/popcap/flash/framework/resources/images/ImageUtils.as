package com.popcap.flash.framework.resources.images
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BitmapDataChannel;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ImageUtils
   {
      
      public static var gScratchRect:Rectangle = new Rectangle();
      
      public static var gScratchPoint:Point = new Point();
       
      
      public function ImageUtils()
      {
         super();
      }
      
      public static function MergeRGBAlpha(rgbData:BitmapData, alphaData:BitmapData) : BitmapData
      {
         var imgData:BitmapData = null;
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
            return null;
         }
         var srcRect:Rectangle = gScratchRect;
         srcRect.width = imgData.width;
         srcRect.height = imgData.height;
         var destPt:Point = gScratchPoint;
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
      
      public static function setColor(transform:ColorTransform, color:int) : void
      {
         transform.alphaOffset = (color & 4278190080) >> 24;
         transform.redOffset = (color & 16711680) >> 16;
         transform.greenOffset = (color & 65280) >> 8;
         transform.blueOffset = color & 255;
      }
      
      public static function modColor(transform:ColorTransform, color:int) : void
      {
         transform.alphaMultiplier = ((color & 4278190080) >> 24) / 255;
         transform.redMultiplier = ((color & 16711680) >> 16) / 255;
         transform.greenMultiplier = ((color & 65280) >> 8) / 255;
         transform.blueMultiplier = ((color & 255) >> 0) / 255;
      }
      
      public static function ResizeBitmap(image:Bitmap, width:Number, height:Number) : void
      {
         image.scaleX = 1;
         image.scaleY = 1;
         image.scaleX = width / image.width;
         image.scaleY = height / image.height;
      }
   }
}
