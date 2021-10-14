package com.popcap.flash.bejeweledblitz.dailyspin2
{
   import com.popcap.flash.bejeweledblitz.Globals;
   import com.popcap.flash.bejeweledblitz.UrlParameters;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.utils.Dictionary;
   
   public class SpinBoardCatalogue
   {
       
      
      public const SPINBOARD_CONFIG_URL:String = "/facebook/bj2/getSpinBoards.php";
      
      private var mHighlightTimeInMilliSeconds:int;
      
      private var mPremiumBoardSku:String;
      
      private var mLastFetchedCatalogueTimestamp:Number;
      
      private var mCatalogueState:int;
      
      private var mSpinBoardInfoMap:Dictionary;
      
      private var mCatalogueFetchStatusCallbacks:Vector.<Function>;
      
      private var mNormalTileShareAmount:uint;
      
      private var mSpecialTileShareAmount:uint;
      
      private var mFtueSpinReward:uint;
      
      public function SpinBoardCatalogue()
      {
         super();
         this.mHighlightTimeInMilliSeconds = 300;
         this.mPremiumBoardSku = "";
         this.mLastFetchedCatalogueTimestamp = 0;
         this.mCatalogueState = SpinBoardCatalogueState.CatalogueNotFetched;
         this.mSpinBoardInfoMap = new Dictionary();
         this.mCatalogueFetchStatusCallbacks = new Vector.<Function>();
         this.mNormalTileShareAmount = 0;
         this.mSpecialTileShareAmount = 0;
         this.mFtueSpinReward = 0;
      }
      
      public function GetPremiumBoardSku() : String
      {
         return this.mPremiumBoardSku;
      }
      
      public function GetHighlightTimeInMilliSeconds() : int
      {
         return this.mHighlightTimeInMilliSeconds;
      }
      
      public function GetLastFetchedCatalogueTimestamp() : Number
      {
         return this.mLastFetchedCatalogueTimestamp;
      }
      
      public function GetCatalogueState() : int
      {
         return this.mCatalogueState;
      }
      
      public function GetAllBoards() : Dictionary
      {
         return this.mSpinBoardInfoMap;
      }
      
      public function GetSpinBoardInfo(param1:String) : SpinBoardInfo
      {
         return this.mSpinBoardInfoMap[param1];
      }
      
      public function GetNormalTileShareAmount() : uint
      {
         return this.mNormalTileShareAmount;
      }
      
      public function GetSpecialTileShareAmount() : uint
      {
         return this.mSpecialTileShareAmount;
      }
      
      public function RegisterCallbackForStateChanges(param1:Function) : void
      {
         this.mCatalogueFetchStatusCallbacks.push(param1);
      }
      
      public function ClearCallbacksForStateChange() : void
      {
         this.mCatalogueFetchStatusCallbacks = new Vector.<Function>();
      }
      
      public function FetchSpinBoardConfig() : Boolean
      {
         var _loc2_:URLRequest = null;
         var _loc3_:URLVariables = null;
         var _loc4_:URLLoader = null;
         if(this.mCatalogueState != SpinBoardCatalogueState.CatalogueFetching)
         {
            this.SetCatalogueState(SpinBoardCatalogueState.CatalogueFetching);
            _loc2_ = new URLRequest(Globals.labsPath + this.SPINBOARD_CONFIG_URL);
            _loc2_.method = URLRequestMethod.POST;
            _loc3_ = Blitz3App.app.network.GetSecureVariables();
            UrlParameters.Get().InjectParams(_loc3_);
            _loc2_.data = _loc3_;
            (_loc4_ = new URLLoader()).addEventListener(Event.COMPLETE,this.OnSpinBoardConfigFetched);
            _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this.OnSpinBoardConfigFetchFailed);
            _loc4_.load(_loc2_);
         }
         return true;
      }
      
      private function OnSpinBoardConfigFetched(param1:Event) : void
      {
         var _loc4_:Object = null;
         var _loc2_:Boolean = true;
         var _loc3_:URLLoader = param1.currentTarget as URLLoader;
         _loc3_.removeEventListener(Event.COMPLETE,this.OnSpinBoardConfigFetched,false);
         _loc3_.removeEventListener(IOErrorEvent.IO_ERROR,this.OnSpinBoardConfigFetchFailed,false);
         if(_loc3_ && _loc3_.data)
         {
            if(!this.ParseSpinBoardData(_loc3_.data))
            {
               _loc2_ = false;
            }
         }
         if(_loc2_)
         {
            this.SetCatalogueState(SpinBoardCatalogueState.CatalogueFetched);
         }
         else
         {
            Utils.log(this,"[SpiBoardCatalogue] Parsing Error");
            _loc4_ = {
               "ErrorType":"SpinBoardConfigParsingFailed",
               "ErrorLocation":"SpinBoard"
            };
            SpinBoardController.GetInstance().GetTelemetryTracker().TrackEvent(SpinBoardTelemetryEventType.Error,_loc4_);
            this.SetCatalogueState(SpinBoardCatalogueState.CatalogueFetchFailed);
         }
      }
      
      public function GetFTUESpinReward() : uint
      {
         return this.mFtueSpinReward;
      }
      
      public function ParseSpinBoardData(param1:String) : Boolean
      {
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:SpinBoardInfo = null;
         var _loc2_:Boolean = true;
         var _loc3_:Object = JSON.parse(param1);
         if(_loc3_ != null)
         {
            this.mHighlightTimeInMilliSeconds = Utils.getUintFromObjectKey(_loc3_,"tileHighlightMSec",300);
            _loc4_ = Utils.getStringFromObjectKey(_loc3_,"premiumBoardSku","");
            this.mNormalTileShareAmount = Utils.getIntFromObjectKey(_loc3_,"normalTileShareAmount",0);
            this.mFtueSpinReward = Utils.getIntFromObjectKey(_loc3_,"ftueSpinReward",0);
            this.mSpecialTileShareAmount = Utils.getIntFromObjectKey(_loc3_,"specialTileShareAmount",0);
            if((_loc5_ = Utils.getArrayFromObjectKey(_loc3_,"boards")) != null)
            {
               _loc6_ = 0;
               while(_loc6_ < _loc5_.length)
               {
                  if((_loc7_ = new SpinBoardInfo()).SetInfo(_loc5_[_loc6_]))
                  {
                     this.mSpinBoardInfoMap[_loc7_.GetId()] = _loc7_;
                  }
                  _loc6_++;
               }
            }
         }
         else
         {
            _loc2_ = false;
         }
         return _loc2_;
      }
      
      public function SetCatalogueState(param1:uint) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this.mCatalogueState != param1)
         {
            this.mCatalogueState = param1;
            _loc2_ = this.mCatalogueFetchStatusCallbacks.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               if(this.mCatalogueFetchStatusCallbacks[_loc3_] != null)
               {
                  this.mCatalogueFetchStatusCallbacks[_loc3_]();
               }
               _loc3_++;
            }
         }
      }
      
      private function OnSpinBoardConfigFetchFailed(param1:Event) : void
      {
         var _loc2_:URLLoader = param1.currentTarget as URLLoader;
         _loc2_.removeEventListener(Event.COMPLETE,this.OnSpinBoardConfigFetched,false);
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.OnSpinBoardConfigFetchFailed,false);
         Utils.log(this,"[SpiBoardCatalogue] Config Fetch Failed");
         this.SetCatalogueState(SpinBoardCatalogueState.CatalogueFetchFailed);
         var _loc3_:Object = {
            "ErrorType":"SpinBoardConfigFetchFailed",
            "ErrorLocation":"SpinBoard"
         };
         SpinBoardController.GetInstance().GetTelemetryTracker().TrackEvent(SpinBoardTelemetryEventType.Error,_loc3_);
      }
   }
}
