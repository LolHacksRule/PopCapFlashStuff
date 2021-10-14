package com.popcap.flash.bejeweledblitz.game.ui.finisher
{
   import com.popcap.flash.bejeweledblitz.AssetLoader;
   import com.popcap.flash.bejeweledblitz.ServerURLResolver;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class FinisherItemLoader
   {
      
      public static const TIMER_INTERVAL:Number = 30;
      
      private static var _timers:Dictionary = new Dictionary();
      
      private static var _loadedGems:Dictionary = new Dictionary();
      
      private static var _onProgressCallbacks:Dictionary = new Dictionary();
      
      private static var _onCompleteCallbacks:Dictionary = new Dictionary();
       
      
      private var _app:Blitz3App;
      
      public function FinisherItemLoader(param1:Blitz3App)
      {
         super();
         this._app = param1;
      }
      
      public static function attachBitmap(param1:String, param2:String, param3:MovieClip, param4:Number = 1, param5:Number = 1) : void
      {
         var dynamicBitmap:Bitmap = null;
         var pFinisherID:String = param1;
         var pID:String = param2;
         var pTargetContainer:MovieClip = param3;
         var scalex:Number = param4;
         var scaley:Number = param5;
         try
         {
            dynamicBitmap = new Bitmap();
            dynamicBitmap.bitmapData = getImage(pFinisherID,pID).bitmapData.clone();
            dynamicBitmap.smoothing = true;
            dynamicBitmap.scaleX = scaley;
            dynamicBitmap.scaleY = scaley;
            dynamicBitmap.x = -dynamicBitmap.width / 2;
            dynamicBitmap.y = -dynamicBitmap.height / 2;
            Utils.removeAllChildrenFrom(pTargetContainer);
            pTargetContainer.addChild(dynamicBitmap);
         }
         catch(e:Error)
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"attachBitmap failed to load image for ID: " + pID + " for finisher: " + pFinisherID);
         }
      }
      
      public static function getImage(param1:String, param2:String) : Bitmap
      {
         var dynamicMC:MovieClip = null;
         var pFinisherID:String = param1;
         var pImageID:String = param2;
         try
         {
            dynamicMC = getFinisherMC(pFinisherID);
            return dynamicMC.getImage("Image" + pImageID) as Bitmap;
         }
         catch(e:Error)
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"getImage failed to load image: " + pImageID + " for finisher: " + pFinisherID);
            return null;
         }
      }
      
      private static function getFinisherMC(param1:String) : MovieClip
      {
         return AssetLoader.getMovieClip("Finisher_" + param1);
      }
      
      public function load(param1:String, param2:Function, param3:Function) : void
      {
         if(param1 in _loadedGems && _loadedGems[param1])
         {
            param3();
         }
         else if(this.isStillLoading(param1))
         {
            this.addCallbacks(param1,param2,param3);
         }
         else
         {
            _loadedGems[param1] = false;
            this.startTimer(param1);
            this.initiateLoad(param1);
            this.addCallbacks(param1,param2,param3);
         }
      }
      
      private function startTimer(param1:String) : void
      {
         var rareGemId:String = param1;
         _timers[rareGemId] = new Timer(TIMER_INTERVAL,0);
         _timers[rareGemId].addEventListener(TimerEvent.TIMER,function(param1:TimerEvent):void
         {
            onTimer(rareGemId,param1);
         });
         _timers[rareGemId].start();
      }
      
      private function initiateLoad(param1:String) : void
      {
         var _loc2_:String = ServerURLResolver.resolveUrl(this._app.network.GetDLCPath() + "asset_bundles/finishers/" + param1 + "Assets.swf");
         var _loc3_:String = this._app.network.GetMediaPath() + _loc2_;
         AssetLoader.load(["Finisher_" + param1],_loc3_);
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
            _loadedGems[param1] = true;
            _timers[param1].stop();
            this.parseRareGem(param1);
            this.executeAllCallbacksInList(_onCompleteCallbacks[param1],[]);
         }
         else
         {
            this.executeAllCallbacksInList(_onProgressCallbacks[param1],[this.getPercentLoaded(param1)]);
         }
      }
      
      private function getPercentLoaded(param1:String) : Number
      {
         return AssetLoader.getSpecificPercentLoaded("Finisher_" + param1);
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
         return AssetLoader.isAssetLoaded("Finisher_" + param1);
      }
      
      private function parseRareGem(param1:String) : void
      {
      }
      
      public function getFinisherWidget(param1:String) : FinisherWidget
      {
         return new FinisherWidget(this._app,param1,AssetLoader.getMovieClip("Finisher_" + param1));
      }
   }
}
