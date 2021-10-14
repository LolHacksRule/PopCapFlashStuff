package com.popcap.flash.bejeweledblitz.dailyspin.app.button
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import flash.display.Bitmap;
   import flash.display.PixelSnapping;
   
   public class SlicedAssetManager
   {
      
      public static var BUTTON_TYPE_BLACK_SLICES:String = "IMAGE_DAILYSPIN_SLICE_BLACK_";
      
      public static var BUTTON_TYPE_GREEN_SLICES:String = "IMAGE_DAILYSPIN_SLICE_GREEN_";
      
      public static var TOOL_TIP_SLICES:String = "IMAGE_DAILYSPIN_TOOL_TIP_SLICE_";
       
      
      public function SlicedAssetManager()
      {
         super();
      }
      
      public static function getAssetSlices(dsMgr:DailySpinManager, assetType:String) : Vector.<Vector.<Bitmap>>
      {
         var v:Vector.<Bitmap> = null;
         var j:int = 0;
         var bm:Bitmap = null;
         var sliceAssets:Vector.<Vector.<Bitmap>> = new Vector.<Vector.<Bitmap>>();
         var count:int = 0;
         for(var i:int = 1; i < 4; i++)
         {
            v = new Vector.<Bitmap>();
            sliceAssets.push(v);
            for(j = 0; j < 3; j++)
            {
               bm = dsMgr.getBitmapAsset(assetType + String(i) + String(j));
               bm.pixelSnapping = PixelSnapping.NEVER;
               v.push(bm);
               count++;
            }
         }
         return sliceAssets;
      }
   }
}
