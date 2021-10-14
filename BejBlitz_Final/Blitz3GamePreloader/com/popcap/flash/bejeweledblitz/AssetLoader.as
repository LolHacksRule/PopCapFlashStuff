package com.popcap.flash.bejeweledblitz
{
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemParser;
   import com.stimuli.loading.BulkLoader;
   import com.stimuli.loading.BulkProgressEvent;
   import com.stimuli.loading.loadingtypes.LoadingItem;
   import flash.display.AVM1Movie;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.media.Sound;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   
   public class AssetLoader
   {
      
      private static const _BULKLOADER_ID:String = "bejeweledblitz";
      
      private static var _isLoaded:Boolean = false;
      
      private static var _isError:Boolean = false;
      
      private static var _percentLoaded:Number = 0;
      
      private static var _loader:BulkLoader;
      
      private static var _idHash:Object;
       
      
      public function AssetLoader()
      {
         super();
      }
      
      public static function getPercentLoaded() : Number
      {
         return _percentLoaded;
      }
      
      public static function isLoaded() : Boolean
      {
         return _isLoaded;
      }
      
      public static function isError() : Boolean
      {
         return _isError;
      }
      
      public static function start(param1:int = -1) : void
      {
         getLoader().start(param1);
      }
      
      public static function load(param1:Array, param2:String, param3:uint = 1) : void
      {
         var _loc4_:String = null;
         if(_idHash == null)
         {
            _idHash = new Object();
         }
         _isLoaded = false;
         _isError = false;
         var _loc5_:int = param1.length;
         var _loc6_:uint = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = param1[_loc6_];
            _idHash[_loc4_] = param2;
            _loc6_++;
         }
         if(!getLoader().hasItem(param2))
         {
            getLoader().add(param2,{
               "type":BulkLoader.guessType(param2),
               "context":getLoaderContext(),
               "weight":param3
            });
         }
      }
      
      public static function isAssetLoaded(param1:String) : Boolean
      {
         return _idHash != null && _idHash[param1] != null && getLoader().get(_idHash[param1]).isLoaded;
      }
      
      public static function getSprite(param1:String) : Sprite
      {
         if(_idHash == null || _idHash[param1] == null)
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"AssetLoader::getSprite ERROR: Could not find asset ID: " + param1 + " in _idHash.");
            return new Sprite();
         }
         return getLoader().getSprite(_idHash[param1]);
      }
      
      public static function getMovieClip(param1:String) : MovieClip
      {
         if(_idHash == null || _idHash[param1] == null)
         {
            return new MovieClip();
         }
         return getLoader().getMovieClip(_idHash[param1]);
      }
      
      public static function getAVM1Movie(param1:String) : AVM1Movie
      {
         if(_idHash == null || _idHash[param1] == null)
         {
            return null;
         }
         return getLoader().getAVM1Movie(_idHash[param1]);
      }
      
      public static function getBitmap(param1:String) : Bitmap
      {
         if(_idHash == null || _idHash[DynamicRareGemParser.RARE_GEM_IMAGE_LOADING_PREFIX + param1] == null)
         {
            return new Bitmap();
         }
         return getLoader().getBitmap(_idHash[DynamicRareGemParser.RARE_GEM_IMAGE_LOADING_PREFIX + param1]);
      }
      
      public static function getNewAssetFromAssetID(param1:String, param2:Boolean = false, param3:String = "") : MovieClip
      {
         var _loc5_:Class = null;
         var _loc7_:Bitmap = null;
         var _loc4_:MovieClip = new MovieClip();
         if(_idHash[param1] == null)
         {
            return _loc4_;
         }
         if(param3 != "")
         {
            _loc5_ = getLoader().getMovieClip(_idHash[param1]).loaderInfo.applicationDomain.getDefinition(param3) as Class;
         }
         else
         {
            _loc5_ = getLoader().getMovieClip(_idHash[param1]).loaderInfo.applicationDomain.getDefinition(param1) as Class;
         }
         var _loc6_:*;
         if((_loc6_ = new _loc5_()) is BitmapData)
         {
            _loc4_ = new MovieClip();
            _loc6_ = new _loc5_(0,0) as BitmapData;
            (_loc7_ = new Bitmap(_loc6_)).smoothing = true;
            _loc4_.addChild(_loc7_);
            _loc4_.cacheAsBitmap = param2;
            return _loc4_;
         }
         (_loc6_ as MovieClip).cacheAsBitmap = param2;
         return _loc6_ as MovieClip;
      }
      
      public static function getNewSoundFromAssetID(param1:String) : Sound
      {
         if(_idHash[param1] == null)
         {
            return null;
         }
         var _loc2_:MovieClip = getMovieClip(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc3_:Class = _loc2_.loaderInfo.applicationDomain.getDefinition(param1) as Class;
         return new _loc3_() as Sound;
      }
      
      public static function getSpecificPercentLoaded(param1:String) : Number
      {
         var _loc2_:LoadingItem = _loader.get(_idHash[param1]);
         return _loc2_._bytesLoaded / _loc2_._bytesTotal;
      }
      
      private static function getLoader() : BulkLoader
      {
         if(_loader == null)
         {
            _loader = new BulkLoader(_BULKLOADER_ID);
            _loader.addEventListener(BulkLoader.ERROR,onLoaderError);
            _loader.addEventListener(BulkProgressEvent.PROGRESS,onLoaderProgress);
            _loader.addEventListener(BulkProgressEvent.COMPLETE,onLoaderComplete);
         }
         return BulkLoader.getLoader(_BULKLOADER_ID);
      }
      
      private static function getLoaderContext() : LoaderContext
      {
         return new LoaderContext(false,new ApplicationDomain(ApplicationDomain.currentDomain));
      }
      
      private static function onLoaderError(param1:Event) : void
      {
         ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"AssetLoader::onLoadError Ending load due to: " + param1.toString());
         _isLoaded = true;
         _isError = true;
      }
      
      private static function onLoaderProgress(param1:BulkProgressEvent) : void
      {
         _percentLoaded = param1.weightPercent;
      }
      
      private static function onLoaderComplete(param1:Event) : void
      {
         _isLoaded = true;
      }
   }
}
