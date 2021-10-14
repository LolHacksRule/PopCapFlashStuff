package com.popcap.flash.bejeweledblitz
{
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.media.Sound;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class BoostAssetLoaderInterface
   {
      
      public static const TIMER_INTERVAL:Number = 30;
      
      private static var _timers:Dictionary = new Dictionary();
      
      private static var _loadedBoosts:Dictionary = new Dictionary();
      
      private static var _onProgressCallbacks:Dictionary = new Dictionary();
      
      private static var _onCompleteCallbacks:Dictionary = new Dictionary();
       
      
      private var _app:Blitz3App;
      
      public function BoostAssetLoaderInterface(param1:Blitz3App)
      {
         super();
         this._app = param1;
      }
      
      public static function getBitmap(param1:String, param2:Boolean) : Bitmap
      {
         var pBoostID:String = param1;
         var sendError:Boolean = param2;
         try
         {
            return AssetLoader.getBitmap(pBoostID);
         }
         catch(e:Error)
         {
            if(sendError)
            {
               ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"getBitmap failed to load image: boost ID: " + pBoostID + " image in the server");
            }
            return null;
         }
      }
      
      public static function getImage(param1:String, param2:String, param3:Boolean = true) : Bitmap
      {
         var dynamicMC:MovieClip = null;
         var pBoostID:String = param1;
         var pID:String = param2;
         var sendError:Boolean = param3;
         try
         {
            dynamicMC = getBoostMC(pBoostID);
            return dynamicMC.getImage("Image" + pID) as Bitmap;
         }
         catch(e:Error)
         {
            if(sendError)
            {
               ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"getImage failed to load image: " + pID + " for boost ID: " + pBoostID);
            }
            return null;
         }
      }
      
      public static function getSound(param1:String, param2:String) : Sound
      {
         var _loc3_:MovieClip = null;
         try
         {
            _loc3_ = getBoostMC(param1);
            return _loc3_.getSound("Sound" + param2) as Sound;
         }
         catch(e:Error)
         {
            return null;
         }
      }
      
      public static function attachBitmap(param1:String, param2:String, param3:MovieClip, param4:Number = 1, param5:Number = 1, param6:Boolean = true) : void
      {
         var dynamicBitmap:Bitmap = null;
         var pBoostID:String = param1;
         var pID:String = param2;
         var pTargetContainer:MovieClip = param3;
         var scalex:Number = param4;
         var scaley:Number = param5;
         var sendError:Boolean = param6;
         try
         {
            dynamicBitmap = new Bitmap();
            dynamicBitmap.bitmapData = getImage(pBoostID,pID,sendError).bitmapData.clone();
            dynamicBitmap.smoothing = true;
            dynamicBitmap.scaleX = scalex;
            dynamicBitmap.scaleY = scaley;
            while(pTargetContainer.numChildren > 0)
            {
               pTargetContainer.removeChildAt(0);
            }
            pTargetContainer.addChild(dynamicBitmap);
         }
         catch(e:Error)
         {
            if(sendError)
            {
               ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"attachBitmap failed to load image for ID: " + pID + " for RareGemID: " + pBoostID);
            }
         }
      }
      
      public static function getClonedMovieClip(param1:String, param2:String) : MovieClip
      {
         var _loc3_:MovieClip = getBoostMC(param1);
         return Utils.duplicateObject(_loc3_.getMovieClip("MovieClip" + param2));
      }
      
      public static function getMovieClip(param1:String, param2:String, param3:Function) : void
      {
         var _loc4_:MovieClip;
         var _loc5_:MovieClip = (_loc4_ = getBoostMC(param1)).getMovieClip("MovieClip" + param2);
         if(param3 != null)
         {
            param3(Utils.duplicateObject(_loc5_));
         }
      }
      
      public static function attachMovieClip(param1:String, param2:String, param3:MovieClip) : void
      {
         var dynamicMC:MovieClip = null;
         var loader:Loader = null;
         var info:LoaderInfo = null;
         var pBoostID:String = param1;
         var pID:String = param2;
         var pTargetContainer:MovieClip = param3;
         if(pTargetContainer == null)
         {
            return;
         }
         try
         {
            dynamicMC = getBoostMC(pBoostID);
            loader = dynamicMC.getMovieClip("MovieClip" + pID).getChildAt(0) as Loader;
            info = loader.contentLoaderInfo;
            info.addEventListener(Event.COMPLETE,onComplete(pTargetContainer));
         }
         catch(e:Error)
         {
            attachBitmap(pBoostID,pID,pTargetContainer);
         }
      }
      
      private static function getBoostMC(param1:String) : MovieClip
      {
         return AssetLoader.getMovieClip("Boost_" + param1);
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
      
      public function load(param1:String, param2:Function, param3:Function) : void
      {
         if(param1 in _loadedBoosts && _loadedBoosts[param1])
         {
            param3();
         }
         else if(this.isStillLoading(param1))
         {
            this.addCallbacks(param1,param2,param3);
         }
         else
         {
            _loadedBoosts[param1] = false;
            this.startTimer(param1);
            this.initiateLoad(param1);
            this.addCallbacks(param1,param2,param3);
         }
      }
      
      private function startTimer(param1:String) : void
      {
         var boostId:String = param1;
         _timers[boostId] = new Timer(TIMER_INTERVAL,0);
         _timers[boostId].addEventListener(TimerEvent.TIMER,function(param1:TimerEvent):void
         {
            onTimer(boostId,param1);
         });
         _timers[boostId].start();
      }
      
      private function initiateLoad(param1:String) : void
      {
         var _loc2_:String = ServerURLResolver.resolveUrl(this._app.network.GetDLCPath() + "asset_bundles/boosts/" + param1 + "Assets.swf");
         var _loc3_:String = this._app.network.GetMediaPath() + _loc2_;
         AssetLoader.load(["Boost_" + param1],_loc3_);
      }
      
      private function addCallbacks(param1:String, param2:Function, param3:Function) : void
      {
         if(!(param1 in _onProgressCallbacks))
         {
            _onProgressCallbacks[param1] = new Vector.<Function>(0);
         }
         if(!(param1 in _onCompleteCallbacks))
         {
            _onCompleteCallbacks[param1] = new Vector.<Function>(0);
         }
         var _loc4_:Vector.<Function>;
         (_loc4_ = _onProgressCallbacks[param1]).push(param2);
         var _loc5_:Vector.<Function>;
         (_loc5_ = _onCompleteCallbacks[param1]).push(param3);
      }
      
      public function onTimer(param1:String, param2:TimerEvent) : void
      {
         if(this.isLoaded(param1))
         {
            _loadedBoosts[param1] = true;
            _timers[param1].stop();
            this.executeAllCallbacksInList(_onCompleteCallbacks[param1],[]);
         }
         else
         {
            this.executeAllCallbacksInList(_onProgressCallbacks[param1],[this.getPercentLoaded(param1)]);
         }
      }
      
      private function getPercentLoaded(param1:String) : Number
      {
         return AssetLoader.getSpecificPercentLoaded("Boost_" + param1);
      }
      
      private function executeAllCallbacksInList(param1:Vector.<Function>, param2:Array) : void
      {
         var _loc3_:Function = null;
         for each(_loc3_ in param1)
         {
            _loc3_.apply(null,param2);
         }
      }
      
      private function isStillLoading(param1:String) : Boolean
      {
         return param1 in _timers;
      }
      
      private function isLoaded(param1:String) : Boolean
      {
         return AssetLoader.isAssetLoaded("Boost_" + param1);
      }
   }
}
