package com.popcap.flash.bejeweledblitz.game.tournament.data
{
   import com.adobe.utils.StringUtil;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import flash.utils.Dictionary;
   
   public class TournamentRewardTierInfo
   {
       
      
      public var minRank:int;
      
      public var maxRank:int;
      
      public var assetType:String;
      
      public var imageUrl:String;
      
      public var rewards:Vector.<TournamentRewardType>;
      
      public var tier:uint;
      
      private var _imageLoader:Loader;
      
      private var _assetBitmapData:BitmapData;
      
      private var _bitmapDataConsumers:Vector.<Bitmap>;
      
      private var _isLoading:Boolean = false;
      
      private var _isLoaded:Boolean = false;
      
      private var _imageRetryLoad:Boolean = true;
      
      private var _imageRedirectLoad:Boolean = true;
      
      private var _assetBitmap:Bitmap;
      
      public function TournamentRewardTierInfo(param1:Object)
      {
         super();
         this.minRank = 0;
         this.maxRank = 0;
         this.assetType = "";
         this.imageUrl = "";
         this.rewards = new Vector.<TournamentRewardType>();
         this._assetBitmapData = null;
         this._assetBitmap = new Bitmap();
         this._assetBitmap.smoothing = true;
         this._bitmapDataConsumers = new Vector.<Bitmap>();
         this._imageLoader = new Loader();
         this._imageLoader.contentLoaderInfo.addEventListener(Event.INIT,this.handleAssetImageComplete);
         this._imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.handleAssetImageIOError);
         this._imageLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.handleAssetImageSecurityError);
         this.setRewardInfo(param1);
      }
      
      public function setRewardInfo(param1:Object) : void
      {
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:TournamentRewardType = null;
         this.minRank = Utils.getIntFromObjectKey(param1,"minRank");
         this.maxRank = Utils.getIntFromObjectKey(param1,"maxRank");
         this.assetType = Utils.getStringFromObjectKey(param1.reward,"assetType");
         this.tier = Utils.getIntFromObjectKey(param1,"tier");
         this.imageUrl = Utils.getStringFromObjectKey(param1.reward,"image");
         this.imageUrl = StringUtil.trim(this.imageUrl);
         if(this.imageUrl != "")
         {
            this.LoadAssetImage();
         }
         var _loc2_:Array = Utils.getArrayFromObjectKey(param1.reward.rewards,"guaranteed");
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            _loc5_ = Utils.getStringFromObjectKey(_loc4_,"type");
            _loc6_ = Utils.getStringFromObjectKey(_loc4_,"name");
            _loc7_ = Utils.getIntFromObjectKey(_loc4_,"value");
            _loc8_ = new TournamentRewardType(_loc5_,_loc6_,_loc7_);
            this.rewards.push(_loc8_);
            _loc3_++;
         }
         this.accumulateRewards();
      }
      
      private function accumulateRewards() : void
      {
         var _loc4_:* = null;
         var _loc1_:Dictionary = new Dictionary();
         var _loc2_:String = "";
         var _loc3_:uint = 0;
         while(_loc3_ < this.rewards.length)
         {
            _loc2_ = this.rewards[_loc3_].Type;
            if(_loc2_ != "gem")
            {
               if(_loc1_[_loc2_] == null)
               {
                  _loc1_[_loc2_] = this.rewards[_loc3_];
               }
               else
               {
                  (_loc1_[_loc2_] as TournamentRewardType).amount = (_loc1_[_loc2_] as TournamentRewardType).Amount + this.rewards[_loc3_].Amount;
               }
            }
            if(_loc2_ == "gem")
            {
               _loc2_ = this.rewards[_loc3_].Data;
               if(_loc1_[_loc2_] == null)
               {
                  _loc1_[_loc2_] = this.rewards[_loc3_];
               }
               else
               {
                  (_loc1_[_loc2_] as TournamentRewardType).amount = (_loc1_[_loc2_] as TournamentRewardType).Amount + this.rewards[_loc3_].Amount;
               }
            }
            _loc3_++;
         }
         this.rewards.splice(0,this.rewards.length);
         for(_loc4_ in _loc1_)
         {
            this.rewards.push(_loc1_[_loc4_]);
         }
      }
      
      public function LoadAssetImage() : void
      {
         this.copyBitmapDataTo(this._assetBitmap);
         this._assetBitmap.smoothing = true;
      }
      
      public function copyBitmapDataTo(param1:Bitmap) : void
      {
         if(this._isLoaded && this._assetBitmapData != null)
         {
            param1.bitmapData = this._assetBitmapData.clone();
         }
         else
         {
            this._bitmapDataConsumers.push(param1);
            if(!this._isLoading)
            {
               this.loadImage();
            }
         }
      }
      
      private function loadImage() : void
      {
         if(this.imageUrl != "")
         {
            this.doLoad();
         }
      }
      
      private function doLoad() : void
      {
         if(!this._isLoaded && !this._isLoading && this.imageUrl != "")
         {
            this._isLoading = true;
            this._imageRetryLoad = true;
            this._imageLoader.load(new URLRequest(this.imageUrl),new LoaderContext(true));
         }
      }
      
      private function makeImageConsumerCallbacks() : void
      {
         var _loc1_:Bitmap = null;
         for each(_loc1_ in this._bitmapDataConsumers)
         {
            _loc1_.bitmapData = this._assetBitmapData.clone();
         }
      }
      
      private function handleAssetImageComplete(param1:Event) : void
      {
         var event:Event = param1;
         this._isLoading = false;
         this._isLoaded = true;
         var info:LoaderInfo = event.target as LoaderInfo;
         if(info == null)
         {
            return;
         }
         try
         {
            this._assetBitmapData = (this._imageLoader.content as Bitmap).bitmapData.clone();
         }
         catch(e:Error)
         {
            _isLoaded = false;
            if(_imageRedirectLoad)
            {
               _imageRedirectLoad = false;
               if(_imageLoader.contentLoaderInfo.isURLInaccessible)
               {
                  Security.allowDomain(_imageLoader.contentLoaderInfo.url);
                  Security.allowInsecureDomain(_imageLoader.contentLoaderInfo.url);
                  Security.loadPolicyFile(_imageLoader.contentLoaderInfo.url + "crossdomain.xml");
               }
               else
               {
                  imageUrl = _imageLoader.contentLoaderInfo.url;
               }
               _isLoading = true;
               _imageLoader.load(new URLRequest(imageUrl),new LoaderContext(true));
            }
            return;
         }
         if(this._assetBitmapData != null)
         {
            this._imageLoader.contentLoaderInfo.removeEventListener(Event.INIT,this.handleAssetImageComplete);
            this._imageLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.handleAssetImageIOError);
            this._imageLoader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.handleAssetImageSecurityError);
            this.makeImageConsumerCallbacks();
         }
      }
      
      private function handleAssetImageIOError(param1:IOErrorEvent) : void
      {
         if(this._imageRetryLoad)
         {
            this._imageRetryLoad = false;
            this._imageLoader.load(new URLRequest(this.imageUrl),new LoaderContext(true));
         }
         else
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"Error loading tournament reward asset image: " + this.imageUrl + " " + param1.toString());
            this._isLoading = false;
         }
      }
      
      private function handleAssetImageSecurityError(param1:SecurityErrorEvent) : void
      {
         if(this._imageRetryLoad)
         {
            this._imageRetryLoad = false;
            this._imageLoader.load(new URLRequest(this.imageUrl),new LoaderContext(true));
         }
         else
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_SECURITY,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"Security error loading Sale Tag image: " + this.imageUrl + " " + param1.toString());
            this._isLoading = false;
         }
      }
      
      public function getAllRareGems() : Vector.<TournamentRewardType>
      {
         var _loc1_:Vector.<TournamentRewardType> = new Vector.<TournamentRewardType>();
         var _loc2_:uint = 0;
         while(_loc2_ < this.rewards.length)
         {
            if(this.rewards[_loc2_].Type == "gem")
            {
               _loc1_.push(this.rewards[_loc2_]);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getAllCurrencies() : Vector.<TournamentRewardType>
      {
         var _loc1_:Vector.<TournamentRewardType> = new Vector.<TournamentRewardType>();
         var _loc2_:uint = 0;
         while(_loc2_ < this.rewards.length)
         {
            if(this.rewards[_loc2_].Type != "gem")
            {
               _loc1_.push(this.rewards[_loc2_]);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function validRewards() : Boolean
      {
         if(this.rewards.length == 0)
         {
            return false;
         }
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < this.rewards.length)
         {
            if(this.rewards[_loc2_].Amount <= 0)
            {
               return false;
            }
            if(this.rewards[_loc2_].Type == "gem" && this.rewards[_loc2_].Data.length == 0)
            {
               return false;
            }
            if(this.rewards[_loc2_].Type != "gem")
            {
               _loc1_++;
            }
            _loc2_++;
         }
         if(_loc1_ > 4)
         {
            return false;
         }
         return true;
      }
   }
}
