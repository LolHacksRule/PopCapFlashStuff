package com.popcap.flash.framework.resources.images
{
   import flash.display.BitmapData;
   
   public interface ImageManager
   {
       
      
      function getImageInst(param1:String) : ImageInst;
      
      function getBitmapData(param1:String) : BitmapData;
   }
}
