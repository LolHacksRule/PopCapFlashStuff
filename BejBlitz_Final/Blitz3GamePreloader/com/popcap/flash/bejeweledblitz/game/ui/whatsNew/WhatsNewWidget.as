package com.popcap.flash.bejeweledblitz.game.ui.whatsNew
{
   import com.caurina.transitions.Tweener;
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.games.blitz3.BejeweledBlitzViewWhatsNew;
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
   
   public class WhatsNewWidget extends BejeweledBlitzViewWhatsNew
   {
       
      
      private var _close:GenericButtonClip;
      
      private var _btnUp:GenericButtonClip;
      
      private var _btnDown:GenericButtonClip;
      
      private var _startY:Number;
      
      private var _containerHeight:Number = 433.95;
      
      private var _containerWidth:Number = 530.95;
      
      private var _targetY:Array;
      
      private var _totalPages:int;
      
      private var _currentStep:int = 0;
      
      private var _app:Blitz3App;
      
      private var _isOpen:Boolean;
      
      private var _configName:String = "";
      
      private var _imageUrl:String = "";
      
      private var _imageLoader:Loader;
      
      private var _imageBitmapData:BitmapData;
      
      private var _bitmapDataConsumers:Vector.<Bitmap>;
      
      private var _isLoading:Boolean = false;
      
      private var _isLoaded:Boolean = false;
      
      private var _imageRetryLoad:Boolean = true;
      
      private var _imageRedirectLoad:Boolean = true;
      
      private var _imageBitmap:Bitmap;
      
      public function WhatsNewWidget(param1:Blitz3App)
      {
         super();
         this._app = param1;
         this._isOpen = false;
      }
      
      public function Init() : void
      {
         this._close = new GenericButtonClip(this._app,this.WhatsNewCloseButton);
         this._close.setRelease(this.HandleCloseClicked);
         this._close.activate();
         this._btnDown = new GenericButtonClip(this._app,this.btnDown);
         this._btnDown.setRelease(this.HandleButtonDown);
         this._btnDown.activate();
         this._btnUp = new GenericButtonClip(this._app,this.btnUp);
         this._btnUp.setRelease(this.HandleButtonUp);
         this._btnUp.activate();
         this._startY = this.ScrollContainer.y;
         this._bitmapDataConsumers = new Vector.<Bitmap>();
         this._imageBitmapData = null;
         this._imageBitmap = new Bitmap();
         this._imageBitmap.smoothing = true;
         Utils.removeAllChildrenFrom(this.ScrollContainer);
         this.ScrollContainer.addChild(this._imageBitmap);
         this.ScrollContainer.cacheAsBitmap = true;
         this._app.bjbEventDispatcher.addEventListener(Blitz3App.SHOW_WHATS_NEW,this.Show);
      }
      
      public function loadScrollContent(param1:String, param2:String) : void
      {
         this._configName = param1;
         this._imageUrl = param2;
         if(this._imageUrl != "")
         {
            this.LoadContent();
         }
      }
      
      public function setupScroll() : void
      {
         this._totalPages = Math.ceil(this.ScrollContainer.height / this._containerHeight);
         this._targetY = new Array();
         var _loc1_:Number = this._startY;
         var _loc2_:int = 0;
         while(_loc2_ < this._totalPages)
         {
            this._targetY.push(_loc1_);
            _loc1_ -= this._containerHeight;
            _loc2_++;
         }
      }
      
      public function Show(param1:Event) : void
      {
         if(this._configName == "")
         {
            this._app.bjbEventDispatcher.SendEvent(Blitz3App.CLOSE_WHATS_NEW,null);
            return;
         }
         if(this._isOpen)
         {
            return;
         }
         this._isOpen = true;
         visible = true;
         (this._app as Blitz3Game).metaUI.highlight.showPopUp(this,true,true,0.55);
         this.x = Dimensions.PRELOADER_WIDTH / 2 - 275;
         this.y = Dimensions.PRELOADER_HEIGHT / 2 - 290;
      }
      
      private function HandleCloseClicked() : void
      {
         this._isOpen = false;
         visible = false;
         this._app.network.onWhatsNewSeen(this._configName);
         this._app.bjbEventDispatcher.SendEvent(Blitz3App.CLOSE_WHATS_NEW,null);
         (this._app as Blitz3Game).metaUI.highlight.hidePopUp();
      }
      
      private function HandleButtonDown() : void
      {
         if(this._currentStep >= 0 && this._currentStep < this._totalPages - 1)
         {
            ScrollContainer.y = this._targetY[this._currentStep++];
            Tweener.removeTweens(this.ScrollContainer);
            Tweener.addTween(this.ScrollContainer,{
               "y":this._targetY[this._currentStep],
               "time":0.5
            });
         }
      }
      
      private function HandleButtonUp() : void
      {
         if(this._currentStep > 0 && this._currentStep <= this._totalPages)
         {
            ScrollContainer.y = this._targetY[this._currentStep--];
            Tweener.removeTweens(this.ScrollContainer);
            Tweener.addTween(this.ScrollContainer,{
               "y":this._targetY[this._currentStep],
               "time":0.5
            });
         }
      }
      
      public function LoadContent() : void
      {
         this._imageLoader = new Loader();
         this._imageLoader.contentLoaderInfo.addEventListener(Event.INIT,this.handleImageLoadComplete);
         this._imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.handleImageLoadIOError);
         this._imageLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.handleImageLoadSecurityError);
         this.copyBitmapDataTo(this._imageBitmap);
         this._imageBitmap.smoothing = true;
      }
      
      public function copyBitmapDataTo(param1:Bitmap) : void
      {
         if(this._isLoaded && this._imageBitmapData != null)
         {
            param1.bitmapData = this._imageBitmapData.clone();
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
         if(this._imageUrl != "")
         {
            this.doLoad();
         }
      }
      
      private function doLoad() : void
      {
         if(!this._isLoaded && !this._isLoading && this._imageUrl != "")
         {
            this._isLoading = true;
            this._imageRetryLoad = true;
            this._imageLoader.load(new URLRequest(this._imageUrl),new LoaderContext(true));
         }
      }
      
      private function makeImageConsumerCallbacks() : void
      {
         var _loc1_:Bitmap = null;
         for each(_loc1_ in this._bitmapDataConsumers)
         {
            _loc1_.bitmapData = this._imageBitmapData.clone();
         }
         this.setupScroll();
      }
      
      private function handleImageLoadComplete(param1:Event) : void
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
            this._imageBitmapData = (this._imageLoader.content as Bitmap).bitmapData.clone();
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
                  _imageUrl = _imageLoader.contentLoaderInfo.url;
               }
               _isLoading = true;
               _imageLoader.load(new URLRequest(_imageUrl),new LoaderContext(true));
            }
            return;
         }
         if(this._imageBitmapData != null)
         {
            this._imageLoader.contentLoaderInfo.removeEventListener(Event.INIT,this.handleImageLoadComplete);
            this._imageLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.handleImageLoadIOError);
            this._imageLoader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.handleImageLoadSecurityError);
            this.makeImageConsumerCallbacks();
         }
      }
      
      private function handleImageLoadIOError(param1:IOErrorEvent) : void
      {
         if(this._imageRetryLoad)
         {
            this._imageRetryLoad = false;
            this._imageLoader.load(new URLRequest(this._imageUrl),new LoaderContext(true));
         }
         else
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"Error loading whats new image: " + this._imageUrl + " " + param1.toString());
            this._isLoading = false;
         }
      }
      
      private function handleImageLoadSecurityError(param1:SecurityErrorEvent) : void
      {
         if(this._imageRetryLoad)
         {
            this._imageRetryLoad = false;
            this._imageLoader.load(new URLRequest(this._imageUrl),new LoaderContext(true));
         }
         else
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_SECURITY,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"Security error loading whats new image: " + this._imageUrl + " " + param1.toString());
            this._isLoading = false;
         }
      }
      
      public function handleWhatsNewSeen(param1:Event) : void
      {
         this._configName = "";
         this._imageUrl = "";
      }
      
      public function isWhatsNewAvailable() : Boolean
      {
         var _loc1_:Boolean = true;
         if(this._configName == "")
         {
            _loc1_ = false;
         }
         return _loc1_;
      }
      
      public function isWhatsNewShown() : Boolean
      {
         return this._isOpen;
      }
   }
}
