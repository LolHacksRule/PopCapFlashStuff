package
{
   import br.com.stimuli.loading.BulkLoader;
   import br.com.stimuli.loading.BulkProgressEvent;
   import com.popcap.flash.games.blitz3.ui.PreloaderFrame;
   import com.popcap.flash.games.blitz3.ui.PreloaderPopCapLogo;
   import com.popcap.flash.games.blitz3.ui.PreloaderProgressBar;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.ui.ContextMenu;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   [SWF(backgroundColor="#C7C7C7",width="510",height="419")]
   public class Blitz3GamePreloader extends Sprite
   {
      
      [Embed(fontName="BlitzStandard",unicodeRange="U+0027,U+003F,U+002C-U+002E,U+0030-U+0039,U+0078,U+0053,U+0050,U+0045,U+0044,U+002B,U+003A,U+0047,U+0041,U+004D,U+0045,U+0020,U+004F,U+0056,U+0052, U+0041-U+005A,U+0024,U+0061-U+007A,U+0021",source="/../common/resources/fonts/KozGoPro-Heavy_0.otf",mimeType="application/x-font")]
      private static const BLITZ_STANDARD_CLASS:Class = Blitz3GamePreloader_BLITZ_STANDARD_CLASS;
      
      private static const SCREEN_WIDTH:int = 510;
      
      private static const SCREEN_HEIGHT:int = 419;
      
      private static const MIN_LOAD_TIME:Number = 3000;
      
      private static const LOGO_FADE_TIME:Number = 500;
      
      private static const CROSS_FADE_TIME:Number = 500;
      
      public static const SWFID_GAME:String = "game";
      
      public static const SWFID_SEQUENCER:String = "sequencer";
      
      private static const PATH_DICT:Dictionary = new Dictionary();
      
      {
         PATH_DICT[SWFID_GAME] = "game.swf";
         PATH_DICT[SWFID_SEQUENCER] = "sequencer.swf";
      }
      
      private var m_Preloader:Sprite;
      
      private var m_Frame:PreloaderFrame;
      
      private var m_PopCapLogo:PreloaderPopCapLogo;
      
      private var m_ProgressBar:PreloaderProgressBar;
      
      private var m_BulkLoader:BulkLoader;
      
      private var m_SWFDict:Dictionary;
      
      private var mLastTime:int = 0;
      
      private var mTimer:int = 0;
      
      private var mThrottlePercent:Number = 0;
      
      private var mCurrentPercent:Number = 0;
      
      private var mMaxPercent:Number = 0;
      
      private var mCapPercent:Number = 0;
      
      private var mActualPercent:Number = 0;
      
      private var mCurrentVelo:Number = 0;
      
      private var mIsFadingIn:Boolean = true;
      
      private var mIsLerping:Boolean = false;
      
      private var mIsFadingOut:Boolean = false;
      
      private var mIsDoneLoading:Boolean = false;
      
      private var mGame:Sprite;
      
      public function Blitz3GamePreloader()
      {
         super();
         this.m_SWFDict = new Dictionary();
         addEventListener(Event.ADDED_TO_STAGE,this.HandleAdded);
      }
      
      private function HandleAdded(e:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.HandleAdded);
         this.Init();
      }
      
      public function Init() : void
      {
         var key:String = null;
         var otherSwfs:Object = null;
         for(key in PATH_DICT)
         {
            this.m_SWFDict[key] = PATH_DICT[key];
         }
         try
         {
            if(ExternalInterface.available)
            {
               otherSwfs = ExternalInterface.call("getPreloaderConfig");
               for(key in otherSwfs)
               {
                  if(key)
                  {
                     this.m_SWFDict[key] = otherSwfs[key];
                  }
               }
            }
         }
         catch(err:Error)
         {
            trace(err.getStackTrace());
         }
         this.m_Frame = new PreloaderFrame();
         this.m_Preloader = new Sprite();
         this.m_Preloader.graphics.beginFill(16777215,1);
         this.m_Preloader.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
         this.m_Preloader.graphics.endFill();
         this.m_Preloader.alpha = 0;
         this.m_PopCapLogo = new PreloaderPopCapLogo();
         this.m_ProgressBar = new PreloaderProgressBar();
         tabEnabled = false;
         stage.tabChildren = false;
         this.mGame = new Sprite();
         this.mGame.alpha = 1;
         addChild(this.mGame);
         this.m_PopCapLogo.x = stage.stageWidth / 2;
         this.m_PopCapLogo.y = stage.stageHeight / 2;
         this.m_Preloader.addChild(this.m_PopCapLogo);
         this.m_ProgressBar.x = stage.stageWidth / 2;
         var barOffset:int = this.m_PopCapLogo.height / 2 + stage.stageHeight / 2;
         this.m_ProgressBar.y = Math.min(barOffset + (stage.stageHeight - barOffset) / 2,stage.stageHeight - this.m_ProgressBar.height / 2);
         this.m_ProgressBar.fill.scaleX = 0;
         this.m_ProgressBar.width = stage.stageWidth * 0.8;
         this.m_Preloader.addChild(this.m_ProgressBar);
         addChild(this.m_Preloader);
         addChild(this.m_Frame);
         this.m_Frame.topLeft.x = 0;
         this.m_Frame.topLeft.y = 0;
         this.m_Frame.topRight.x = stage.stageWidth;
         this.m_Frame.topRight.y = 0;
         this.m_Frame.bottomLeft.x = 0;
         this.m_Frame.bottomLeft.y = stage.stageHeight;
         this.m_Frame.bottomRight.x = stage.stageWidth;
         this.m_Frame.bottomRight.y = stage.stageHeight;
         stage.frameRate = 64;
         this.mLastTime = getTimer();
         addEventListener(Event.ENTER_FRAME,this.HandleFrame);
         var menu:ContextMenu = new ContextMenu();
         menu.hideBuiltInItems();
         contextMenu = menu;
         this.LoadGame();
      }
      
      public function GetPathToFlash() : String
      {
         var val:String = loaderInfo.parameters.pathToFlash;
         if(val == null)
         {
            val = "";
         }
         return val;
      }
      
      private function LoadGame() : void
      {
         var key:* = null;
         var ctx:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         this.m_BulkLoader = new BulkLoader("blitz3");
         for(key in this.m_SWFDict)
         {
            this.m_BulkLoader.add(this.GetPathToFlash() + this.m_SWFDict[key],{
               "id":key,
               "priority":0,
               "type":BulkLoader.TYPE_MOVIECLIP,
               "context":ctx
            });
         }
         this.m_BulkLoader.addEventListener(BulkLoader.ERROR,this.HandleError);
         this.m_BulkLoader.addEventListener(BulkLoader.COMPLETE,this.HandleComplete);
         this.m_BulkLoader.addEventListener(BulkLoader.PROGRESS,this.HandleProgress);
      }
      
      private function UpdateFade() : void
      {
         var percent:Number = this.mTimer / CROSS_FADE_TIME;
         this.m_Preloader.alpha = 1 - percent;
         if(percent >= 1)
         {
            this.Done();
         }
      }
      
      private function UpdateLoad() : void
      {
         var logoTime:Number = NaN;
         var half:Number = NaN;
         var diff:Number = NaN;
         var s:Sprite = null;
         var sequencer:Blitz3Sequencer = null;
         if(this.mIsFadingIn)
         {
            logoTime = Math.min(1,this.mTimer / LOGO_FADE_TIME);
            this.DoLogoFadeIn(logoTime);
         }
         if(logoTime == 1)
         {
            this.mIsFadingIn = false;
            this.mIsLerping = true;
            this.m_BulkLoader.start(3);
         }
         this.mThrottlePercent = this.mTimer / MIN_LOAD_TIME;
         this.mCapPercent = Math.min(1,Math.min(this.mThrottlePercent,this.mActualPercent));
         if(this.mCapPercent == 1)
         {
            this.mCurrentVelo += 0.001;
         }
         else
         {
            half = this.mCurrentPercent / 2;
            diff = this.mCapPercent - this.mCurrentPercent;
            this.mCurrentVelo = Math.min(this.mCurrentVelo + 0.001,diff * 0.01);
         }
         this.mCurrentPercent += this.mCurrentVelo;
         this.m_ProgressBar.fill.scaleX = this.mCurrentPercent;
         if(this.mCurrentPercent >= 1 && this.mIsDoneLoading)
         {
            s = this.m_BulkLoader.getSprite(SWFID_SEQUENCER);
            this.mGame.addChild(s);
            sequencer = s as Blitz3Sequencer;
            if(sequencer)
            {
               sequencer.HandleLoadComplete(this.m_BulkLoader,this.m_SWFDict);
            }
            this.mLastTime = getTimer();
            this.mTimer = 0;
            this.mIsFadingOut = true;
            this.mIsLerping = false;
         }
      }
      
      private function DoLogoFadeIn(time:Number) : void
      {
         this.m_Preloader.alpha = time;
      }
      
      private function Done() : void
      {
         removeEventListener(Event.ENTER_FRAME,this.HandleFrame);
         removeChild(this.m_Preloader);
      }
      
      private function HandleProgress(e:BulkProgressEvent) : void
      {
         this.mActualPercent = e.bytesLoaded / e.bytesTotal;
         if(this.mActualPercent == Number.POSITIVE_INFINITY)
         {
            this.mActualPercent = 0;
         }
         if(isNaN(this.mActualPercent))
         {
            this.mActualPercent = 0;
         }
      }
      
      private function HandleComplete(e:BulkProgressEvent) : void
      {
         this.mIsDoneLoading = true;
         try
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("preloaderFinished");
            }
         }
         catch(error:Error)
         {
         }
      }
      
      private function HandleError(e:Event) : void
      {
         this.mIsDoneLoading = false;
      }
      
      private function HandleFrame(e:Event) : void
      {
         var thisTime:int = getTimer();
         var elapsed:int = thisTime - this.mLastTime;
         this.mLastTime = thisTime;
         this.mTimer += elapsed;
         if(this.mIsFadingOut)
         {
            this.UpdateFade();
         }
         else
         {
            this.UpdateLoad();
         }
      }
   }
}
