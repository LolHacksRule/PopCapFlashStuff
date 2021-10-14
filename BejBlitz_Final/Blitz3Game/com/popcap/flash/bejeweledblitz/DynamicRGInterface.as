package com.popcap.flash.bejeweledblitz
{
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.media.Sound;
   
   public class DynamicRGInterface
   {
       
      
      public function DynamicRGInterface()
      {
         super();
      }
      
      public static function getConfig(param1:String) : Object
      {
         var dynamicMC:MovieClip = null;
         var pRareGemID:String = param1;
         try
         {
            dynamicMC = getDynamicRareGemMC(pRareGemID);
            return dynamicMC.getConfig() as Object;
         }
         catch(e:Error)
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"getConfig failed to load for rare gem ID: " + pRareGemID);
            return null;
         }
      }
      
      public static function getBitmap(param1:String) : Bitmap
      {
         var pRareGemID:String = param1;
         try
         {
            return AssetLoader.getBitmap(pRareGemID);
         }
         catch(e:Error)
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"getBitmap failed to load image: rare gem ID: " + pRareGemID + " image in the server");
            return null;
         }
      }
      
      public static function getImage(param1:String, param2:String) : Bitmap
      {
         var dynamicMC:MovieClip = null;
         var pRareGemID:String = param1;
         var pID:String = param2;
         try
         {
            dynamicMC = getDynamicRareGemMC(pRareGemID);
            return dynamicMC.getImage("Image" + pID) as Bitmap;
         }
         catch(e:Error)
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"getImage failed to load image: " + pID + " for rare gem ID: " + pRareGemID);
            return null;
         }
      }
      
      public static function getSound(param1:String, param2:String) : Sound
      {
         var _loc3_:MovieClip = null;
         try
         {
            _loc3_ = getDynamicRareGemMC(param1);
            return _loc3_.getSound("Sound" + param2) as Sound;
         }
         catch(e:Error)
         {
            return null;
         }
      }
      
      public static function attachBitmap(param1:String, param2:String, param3:MovieClip) : void
      {
         var dynamicBitmap:Bitmap = null;
         var pRareGemID:String = param1;
         var pID:String = param2;
         var pTargetContainer:MovieClip = param3;
         try
         {
            dynamicBitmap = new Bitmap();
            dynamicBitmap.bitmapData = getImage(pRareGemID,pID).bitmapData.clone();
            dynamicBitmap.smoothing = true;
            dynamicBitmap.x = -dynamicBitmap.width / 2;
            dynamicBitmap.y = -dynamicBitmap.height / 2;
            pTargetContainer.addChild(dynamicBitmap);
         }
         catch(e:Error)
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"attachBitmap failed to load image for ID: " + pID + " for RareGemID: " + pRareGemID);
         }
      }
      
      public static function getMovieClip(param1:String, param2:String, param3:Function) : void
      {
         var pRareGemID:String = param1;
         var mcName:String = param2;
         var callback:Function = param3;
         var dynamicMC:MovieClip = getDynamicRareGemMC(pRareGemID);
         var loader:Loader = dynamicMC.getMovieClip("MovieClip" + mcName).getChildAt(0) as Loader;
         var info:LoaderInfo = loader.contentLoaderInfo;
         info.addEventListener(Event.COMPLETE,function(param1:Event):void
         {
            var _loc2_:LoaderInfo = param1.target as LoaderInfo;
            _loc2_.removeEventListener(Event.COMPLETE,onComplete);
            var _loc3_:MovieClip = _loc2_.loader.content as MovieClip;
            callback(_loc3_);
         });
      }
      
      public static function attachMovieClip(param1:String, param2:String, param3:MovieClip) : void
      {
         var dynamicMC:MovieClip = null;
         var loader:Loader = null;
         var info:LoaderInfo = null;
         var pRareGemID:String = param1;
         var pID:String = param2;
         var pTargetContainer:MovieClip = param3;
         if(pTargetContainer == null)
         {
            return;
         }
         try
         {
            dynamicMC = getDynamicRareGemMC(pRareGemID);
            loader = dynamicMC.getMovieClip("MovieClip" + pID).getChildAt(0) as Loader;
            info = loader.contentLoaderInfo;
            info.addEventListener(Event.COMPLETE,onComplete(pTargetContainer));
         }
         catch(e:Error)
         {
            attachBitmap(pRareGemID,pID,pTargetContainer);
         }
      }
      
      private static function getDynamicRareGemMC(param1:String) : MovieClip
      {
         return AssetLoader.getMovieClip("raregem_" + param1);
      }
      
      private static function onComplete(param1:MovieClip) : Function
      {
         var pTargetContainer:MovieClip = param1;
         return function(param1:Event):void
         {
            var _loc2_:* = param1.target as LoaderInfo;
            _loc2_.removeEventListener(Event.COMPLETE,onComplete);
            var _loc3_:* = _loc2_.loader.content as MovieClip;
            if(!_loc3_)
            {
               throw new Error("Tell the artists to export this asset in AS3 NOT AS1 or AS2");
            }
            pTargetContainer.addChild(_loc3_);
         };
      }
   }
}
