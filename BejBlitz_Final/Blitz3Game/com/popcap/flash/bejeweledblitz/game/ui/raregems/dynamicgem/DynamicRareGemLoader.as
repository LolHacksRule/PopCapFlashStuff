package com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem
{
   import com.popcap.flash.bejeweledblitz.AssetLoader;
   import com.popcap.flash.bejeweledblitz.ServerURLResolver;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class DynamicRareGemLoader
   {
      
      public static const TIMER_INTERVAL:Number = 30;
      
      private static var _timers:Dictionary = new Dictionary();
      
      private static var _loadedGems:Dictionary = new Dictionary();
      
      private static var _onProgressCallbacks:Dictionary = new Dictionary();
      
      private static var _onCompleteCallbacks:Dictionary = new Dictionary();
       
      
      private var _app:Blitz3App;
      
      public function DynamicRareGemLoader(param1:Blitz3App)
      {
         super();
         this._app = param1;
      }
      
      public function load(param1:String, param2:Function, param3:Function) : void
      {
         if(param1 in _loadedGems && _loadedGems[param1])
         {
            param3();
            return;
         }
         if(this.isStillLoading(param1))
         {
            this.addCallbacks(param1,param2,param3);
            return;
         }
         _loadedGems[param1] = false;
         this.startTimer(param1);
         this.initiateLoad(param1);
         this.addCallbacks(param1,param2,param3);
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
         var _loc2_:String = ServerURLResolver.resolveUrl(this._app.network.GetDLCPath() + "asset_bundles/dynamicraregems/" + param1 + "Assets.swf");
         var _loc3_:String = this._app.network.GetMediaPath() + _loc2_;
         AssetLoader.load([DynamicRareGemParser.RARE_GEM_LOADING_PREFIX + param1],_loc3_);
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
         return AssetLoader.getSpecificPercentLoaded(DynamicRareGemParser.RARE_GEM_LOADING_PREFIX + param1);
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
         return AssetLoader.isAssetLoaded(DynamicRareGemParser.RARE_GEM_LOADING_PREFIX + param1);
      }
      
      private function parseRareGem(param1:String) : void
      {
         var _loc2_:DynamicRareGemParser = new DynamicRareGemParser(param1,Blitz3App.app.logic.rareGemsLogic,Blitz3App.app.flameGemFactory,new DynamicRareGemSound());
         _loc2_.parse();
      }
   }
}
