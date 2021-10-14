package com.popcap.flash.framework.resources.images
{
   import flash.display.BitmapData;
   import flash.display.BitmapDataChannel;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class §_-e§
   {
      
      public static var §_-Xj§:Rectangle = new Rectangle();
      
      public static var §_-Xp§:Point = new Point();
       
      
      public function §_-e§()
      {
         super();
      }
      
      public static function §_-Xt§(param1:ColorTransform, param2:int) : void
      {
         param1.alphaOffset = (param2 & 4278190080) >> 24;
         param1.redOffset = (param2 & 16711680) >> 16;
         param1.greenOffset = (param2 & 65280) >> 8;
         param1.blueOffset = param2 & 255;
      }
      
      public static function §_-eY§(param1:ColorTransform, param2:int) : void
      {
         param1.alphaMultiplier = ((param2 & 4278190080) >> 24) / 255;
         param1.redMultiplier = ((param2 & 16711680) >> 16) / 255;
         param1.greenMultiplier = ((param2 & 65280) >> 8) / 255;
         param1.blueMultiplier = ((param2 & 255) >> 0) / 255;
      }
      
      public static function §_-ow§(param1:BitmapData, param2:BitmapData) : BitmapData
      {
         var _loc3_:BitmapData = null;
         if(param1 != null)
         {
            _loc3_ = new BitmapData(param1.width,param1.height,true,0);
         }
         else if(param2 != null)
         {
            _loc3_ = new BitmapData(param2.width,param2.height,true,0);
         }
         if(_loc3_ == null)
         {
            return null;
         }
         var _loc4_:Rectangle;
         (_loc4_ = §_-Xj§).width = _loc3_.width;
         _loc4_.height = _loc3_.height;
         var _loc5_:Point = §_-Xp§;
         if(param1 != null)
         {
            _loc3_.copyPixels(param1,_loc4_,_loc5_);
         }
         if(param2 != null)
         {
            if(param1 == null)
            {
               _loc3_.copyPixels(param2,_loc4_,_loc5_);
            }
            _loc3_.copyChannel(param2,_loc4_,_loc5_,BitmapDataChannel.RED,BitmapDataChannel.ALPHA);
         }
         return _loc3_;
      }
   }
}
