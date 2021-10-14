package
{
   import com.popcap.flash.bejeweledblitz.AssetLoader;
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.ServerURLResolver;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.SingleButtonDialog;
   import com.popcap.flash.bejeweledblitz.preloader.PreloaderProgressBar;
   import com.popcap.flash.framework.App;
   import com.popcap.flash.framework.resources.IResourceLibrary;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameErrorMessages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.Sprite;
   import flash.display.StageScaleMode;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.UncaughtErrorEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.system.Security;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.utils.getTimer;
   
   public class Blitz3GamePreloader extends App
   {
      
      private static const _STATE_LOADING_MAIN:uint = 0;
      
      private static const _STATE_LOADING_CONFIG:uint = 1;
      
      private static const _STATE_LOADING_RGS:uint = 2;
      
      private static const _STATE_FADING_OUT:uint = 3;
      
      private static const _STATE_DONE:uint = 4;
      
      private static const VERSION_NAME:String = "Bejeweled Blitz Preloader";
      
      private static const GAME:String = "Game";
      
      private static const GAME_ASSETS:String = "GameAssets";
      
      private static const DAILYSPIN:String = "DailySpin";
      
      private static const DAILYSPIN_ASSETS:String = "DailySpinAssets";
      
      private static const MIN_LOAD_TIME:Number = 1000;
      
      private static const FADE_TIME:Number = 500;
       
      
      private var _currentState:uint = 0;
      
      private var _progressBar:PreloaderProgressBar;
      
      private var _promo:PreloaderAppleAndroid;
      
      private var _popcapLogo:PreloaderPopCapLogo;
      
      private var _startTime:int = 0;
      
      private var _lastTime:int = 0;
      
      private var _timer:int = 0;
      
      private var _retryCount:int = 0;
      
      private var _throttlePercent:Number = 0;
      
      private var _currentPercent:Number = 0;
      
      private var _maxPercent:Number = 0;
      
      private var _capPercent:Number = 0;
      
      private var _currentVelo:Number = 0;
      
      private var _isFadingIn:Boolean = true;
      
      private var _isDoneLoading:Boolean = false;
      
      private var _basePath:String;
      
      private var _mediaPath:String;
      
      private var _localeCode:String;
      
      private var _game:Object;
      
      private var _isFools:Boolean = false;
      
      public function Blitz3GamePreloader()
      {
         var _loc1_:String = null;
         super(VERSION_NAME);
         for each(_loc1_ in ALLOW_DOMAINS)
         {
            Security.allowDomain(_loc1_);
         }
         this._basePath = "";
         if("pathToFlash" in stage.loaderInfo.parameters)
         {
            this._basePath = stage.loaderInfo.parameters["pathToFlash"];
         }
         this._mediaPath = "";
         if("mediaPath" in stage.loaderInfo.parameters)
         {
            this._mediaPath = stage.loaderInfo.parameters["mediaPath"];
         }
         this._localeCode = "en-US";
         loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,this.uncaughtErrorHandler);
         addEventListener(Event.ADDED_TO_STAGE,this.onAdded,false,0,true);
      }
      
      private function uncaughtErrorHandler(param1:UncaughtErrorEvent) : void
      {
         var tempError:Error = null;
         var stackTrace:String = null;
         var _app:Blitz3Game = null;
         var _errorPopup:SingleButtonDialog = null;
         var errorEvent:ErrorEvent = null;
         var event:UncaughtErrorEvent = param1;
         event.preventDefault();
         event.stopImmediatePropagation();
         event.stopPropagation();
         if(Blitz3App.app)
         {
            tempError = new Error();
            stackTrace = tempError.getStackTrace();
            Blitz3App.app.network.LogOnBrowser("uncaughtErrorHandler : " + stackTrace);
            _app = Blitz3App.app as Blitz3Game;
            _errorPopup = new SingleButtonDialog(_app,16);
            _errorPopup.Init();
            _errorPopup.SetDimensions(420,200);
            _errorPopup.SetContent(_app.TextManager.GetLocString(Blitz3GameLoc.LOC_CRASH_DIALOG_TITLE),_app.TextManager.GetLocString(Blitz3GameLoc.LOC_CRASH_DIALOG_DESC),_app.TextManager.GetLocString(Blitz3GameLoc.LOC_CRASH_DIALOG_BUTTON));
            _errorPopup.AddContinueButtonHandler(function(param1:MouseEvent):void
            {
               _app.network.Refresh();
            });
            _errorPopup.x = Dimensions.GAME_WIDTH / 2 - _errorPopup.width / 2;
            _errorPopup.y = Dimensions.GAME_HEIGHT / 2 - _errorPopup.height / 2 + 12;
            _app.metaUI.highlight.showPopUp(_errorPopup,true,true,0.55);
         }
         if(event.error is Error)
         {
            ErrorReporting.logRuntimeError(event.error);
         }
         else if(event.error is ErrorEvent)
         {
            errorEvent = event.error as ErrorEvent;
            ErrorReporting.logRuntimeError(new Error(errorEvent.type,errorEvent.errorID));
         }
         else
         {
            ErrorReporting.logRuntimeError(new Error(event.error.toString(),-1));
         }
      }
      
      public function Init() : void
      {
         stage.scaleMode = StageScaleMode.SHOW_ALL;
         graphics.beginFill(13092807,1);
         graphics.drawRect(0,0,Dimensions.PRELOADER_WIDTH,Dimensions.PRELOADER_HEIGHT);
         graphics.endFill();
         this._progressBar = new PreloaderProgressBar(this._isFools);
         this._progressBar.alpha = 0;
         this._progressBar.Init(Dimensions.PRELOADER_WIDTH,Dimensions.PRELOADER_HEIGHT);
         addChild(this._progressBar);
         this._promo = new PreloaderAppleAndroid();
         this._promo.x = Dimensions.PRELOADER_WIDTH / 2;
         this._promo.y = this._progressBar.getBottomY() - 10;
         addChild(this._promo);
         this._popcapLogo = new PreloaderPopCapLogo();
         this._popcapLogo.x += 20;
         this._popcapLogo.y = Dimensions.PRELOADER_HEIGHT - this._popcapLogo.height / 2;
         addChild(this._popcapLogo);
         this._promo.btnAndroid.addEventListener(MouseEvent.CLICK,this.onPromoAndroidPress);
         this._promo.btnApple.addEventListener(MouseEvent.CLICK,this.onPromoApplePress);
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame,false,0,true);
         this.LoadGame();
      }
      
      private function LoadGame() : void
      {
         this._isDoneLoading = false;
         this._startTime = getTimer();
         this._lastTime = getTimer();
         this._timer = 0;
         var _loc1_:* = this._basePath + "asset_bundles/";
         var _loc2_:* = "Resources_" + this._localeCode + ".swf";
         AssetLoader.load([GAME],this._mediaPath + ServerURLResolver.resolveUrl(this._basePath + "Blitz3Game.swf"));
         AssetLoader.load([GAME_ASSETS],this._mediaPath + ServerURLResolver.resolveUrl(_loc1_ + "Blitz3Game" + _loc2_));
         AssetLoader.load([DAILYSPIN_ASSETS],this._mediaPath + ServerURLResolver.resolveUrl(_loc1_ + "Blitz3DailySpin" + _loc2_),44);
      }
      
      private function onEnterFrame(param1:Event = null) : void
      {
         var _loc2_:int = getTimer();
         var _loc3_:int = _loc2_ - this._lastTime;
         this._lastTime = _loc2_;
         this._timer += _loc3_;
         switch(this._currentState)
         {
            case _STATE_LOADING_MAIN:
               if(this.updateLoadMain(_loc3_))
               {
                  this._currentState = _STATE_LOADING_CONFIG;
               }
               break;
            case _STATE_LOADING_CONFIG:
               if(this.updateLoadingConfig(_loc3_))
               {
                  this._currentState = _STATE_LOADING_RGS;
               }
               break;
            case _STATE_LOADING_RGS:
               if(this.updateLoadingRGs(_loc3_))
               {
                  this._currentState = _STATE_FADING_OUT;
               }
               break;
            case _STATE_FADING_OUT:
               if(this.updateFadingOut())
               {
                  this._currentState = _STATE_DONE;
               }
               break;
            case _STATE_DONE:
               this.updateDone();
         }
      }
      
      private function updateLoadMain(param1:int) : Boolean
      {
         if(AssetLoader.isLoaded() && !this._isDoneLoading)
         {
            this._isDoneLoading = true;
            if(AssetLoader.isError())
            {
               if(this._retryCount < 3)
               {
                  ++this._retryCount;
                  this.LoadGame();
               }
               else
               {
                  this.DisplayAssetError("1");
               }
            }
            else
            {
               this._game = AssetLoader.getSprite(GAME);
               this._game.Resources.AddLibrary(AssetLoader.getSprite(GAME_ASSETS) as IResourceLibrary);
               this._game.Resources.AddLibrary(AssetLoader.getSprite(DAILYSPIN_ASSETS) as IResourceLibrary);
            }
         }
         var _loc2_:Number = Math.min(1,this._timer / FADE_TIME);
         if(this._isFadingIn)
         {
            this._progressBar.alpha = _loc2_;
            if(_loc2_ == 1)
            {
               this._isFadingIn = false;
               AssetLoader.start(3);
            }
         }
         this._throttlePercent = this._timer / MIN_LOAD_TIME;
         this._capPercent = Math.min(1,Math.min(this._throttlePercent,AssetLoader.getPercentLoaded()));
         if(this._capPercent == 1)
         {
            this._currentVelo += 0.001;
         }
         else
         {
            this._currentVelo = Math.min(this._currentVelo + 0.001,(this._capPercent - this._currentPercent) * 0.01);
         }
         this._currentPercent += this._currentVelo;
         this._progressBar.SetValue(this._currentPercent,param1);
         if(this._currentPercent >= 1 && this._isDoneLoading && this._progressBar.isDone() && this._game != null)
         {
            this._game.visible = false;
            addChildAt(this._game as Sprite,0);
            return true;
         }
         return false;
      }
      
      private function updateLoadingConfig(param1:Number) : Boolean
      {
         this._progressBar.SetValue(this._currentPercent,param1);
         return this._game.isConfigLoaded();
      }
      
      private function updateLoadingRGs(param1:Number) : Boolean
      {
         this._progressBar.SetValue(this._currentPercent,param1);
         if(AssetLoader.isLoaded())
         {
            this._lastTime = getTimer();
            this._timer = 0;
            this._game.visible = true;
            removeChild(this._progressBar);
            removeChild(this._promo);
            removeChild(this._popcapLogo);
            return true;
         }
         return false;
      }
      
      private function updateFadingOut() : Boolean
      {
         var _loc1_:Number = Math.min(1,this._timer / FADE_TIME);
         this._progressBar.alpha = 1 - _loc1_;
         return _loc1_ == 1;
      }
      
      private function updateDone() : void
      {
         var _loc1_:Blitz3Game = Blitz3App.app as Blitz3Game;
         _loc1_.loadTime = this._startTime;
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this._progressBar.destroy();
         this._promo = null;
         this._popcapLogo = null;
         this._game.visible = true;
         this._game.StartNow();
      }
      
      private function DisplayAssetError(param1:String) : void
      {
         var _loc2_:TextField = new TextField();
         var _loc3_:TextFormat = new TextFormat();
         _loc3_.font = "Arial";
         _loc3_.align = TextFormatAlign.CENTER;
         _loc3_.size = 18;
         _loc3_.bold = true;
         _loc3_.color = 0;
         _loc2_.defaultTextFormat = _loc3_;
         _loc2_.autoSize = TextFieldAutoSize.CENTER;
         _loc2_.selectable = false;
         _loc2_.mouseEnabled = false;
         _loc2_.multiline = true;
         var _loc4_:String;
         if((_loc4_ = Blitz3GameErrorMessages.ASSET_ERROR_MESSAGE[this._localeCode]) != null && _loc4_.length > 0)
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,_loc4_ + " (" + param1 + ")");
            _loc2_.htmlText = _loc4_ + " (" + param1 + ")";
            addChild(_loc2_);
            _loc2_.x = Dimensions.PRELOADER_WIDTH * 0.5 - _loc2_.width * 0.5;
            _loc2_.y = Dimensions.PRELOADER_HEIGHT * 0.15 - _loc2_.height * 0.5;
         }
      }
      
      private function onPromoApplePress(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://itunes.apple.com/us/app/bejeweled-blitz/id469960709"),"_blank");
      }
      
      private function onPromoAndroidPress(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest("http://smarturl.it/BJB-Android"),"_blank");
      }
      
      private function onAdded(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAdded);
         this.Init();
      }
   }
}
