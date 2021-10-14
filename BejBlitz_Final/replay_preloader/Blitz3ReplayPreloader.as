package
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.preloader.PreloaderProgressBar;
   import com.popcap.flash.framework.App;
   import com.popcap.flash.framework.resources.IResourceLibrary;
   import com.stimuli.loading.BulkLoader;
   import com.stimuli.loading.BulkProgressEvent;
   import flash.display.Sprite;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import flash.utils.getTimer;
   
   [SWF(width="370",height="460")]
   public class Blitz3ReplayPreloader extends App
   {
      
      private static const VERSION_NAME:String = "Bejeweled Blitz Replay Preloader";
      
      private static const REPLAY:String = "Replay";
      
      private static const REPLAY_ASSETS:String = "ReplayAssets";
      
      private static const GAME_ASSETS:String = "GameAssets";
      
      private static const MIN_LOAD_TIME:Number = 2000;
      
      private static const FADE_TIME:Number = 500;
       
      
      private var m_ProgressBar:PreloaderProgressBar;
      
      private var m_BulkLoader:BulkLoader;
      
      private var mLastTime:int = 0;
      
      private var mTimer:int = 0;
      
      private var m_RetryCount:int = 0;
      
      private var mThrottlePercent:Number = 0;
      
      private var mCurrentPercent:Number = 0;
      
      private var mMaxPercent:Number = 0;
      
      private var mCapPercent:Number = 0;
      
      private var mActualPercent:Number = 0;
      
      private var mCurrentVelo:Number = 0;
      
      private var mIsFadingIn:Boolean = true;
      
      private var mIsFadingOut:Boolean = false;
      
      private var mIsDoneLoading:Boolean = false;
      
      private var m_BasePath:String;
      
      private var m_LocaleCode:String;
      
      private var m_Game:Object;
      
      public function Blitz3ReplayPreloader()
      {
         var domain:String = null;
         super(VERSION_NAME);
         for each(domain in ALLOW_DOMAINS)
         {
            Security.allowDomain(domain);
         }
         this.m_BasePath = "";
         if("pathToFlash" in stage.loaderInfo.parameters)
         {
            this.m_BasePath = stage.loaderInfo.parameters["pathToFlash"];
         }
         this.m_LocaleCode = "en-US";
         if("locale" in stage.loaderInfo.parameters)
         {
            this.m_LocaleCode = stage.loaderInfo.parameters["locale"];
         }
         addEventListener(Event.ADDED_TO_STAGE,this.HandleAdded);
      }
      
      private function HandleAdded(e:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.HandleAdded);
         this.Init();
      }
      
      public function Init() : void
      {
         stage.scaleMode = StageScaleMode.SHOW_ALL;
         graphics.beginFill(16777215,1);
         graphics.drawRect(0,0,Dimensions.REPLAYER_WIDTH,Dimensions.REPLAYER_HEIGHT);
         graphics.endFill();
         this.m_ProgressBar = new PreloaderProgressBar();
         this.m_ProgressBar.Init(Dimensions.REPLAYER_WIDTH,Dimensions.REPLAYER_HEIGHT);
         this.m_ProgressBar.alpha = 0;
         addChild(this.m_ProgressBar);
         this.m_BulkLoader = new BulkLoader("blitz3");
         addEventListener(Event.ENTER_FRAME,this.HandleFrame);
         this.LoadGame();
      }
      
      private function LoadGame() : void
      {
         var versionNum:int = 0;
         var resourcesSWF:String = null;
         this.mIsDoneLoading = false;
         this.mLastTime = getTimer();
         this.mTimer = 0;
         var ctx:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         var version:String = "";
         if(loaderInfo.parameters && loaderInfo.parameters.pv)
         {
            version = loaderInfo.parameters.pv;
         }
         var replayerURL:String = "";
         var assetURL:String = "";
         if(version != "")
         {
            replayerURL = root.loaderInfo.url.replace("Blitz3ReplayPreloader.swf","replay/" + version + "/replay.swf");
            replayerURL = replayerURL.replace("Blitz3ReplayPreloader.swf","replay/" + version + "/replay.swf");
            this.m_BulkLoader.add(replayerURL,{
               "id":REPLAY,
               "context":ctx
            });
            versionNum = parseInt(version);
            if(versionNum >= 7 || versionNum < 1)
            {
               assetURL = replayerURL.replace("Blitz3Replay.swf","Blitz3GameResources_en-US.swf");
               if(assetURL != "")
               {
                  this.m_BulkLoader.add(assetURL,{
                     "id":REPLAY_ASSETS,
                     "context":ctx
                  });
               }
            }
         }
         else if(loaderInfo.parameters.replayerURL)
         {
            replayerURL = loaderInfo.parameters.replayerURL;
            assetURL = loaderInfo.parameters.assetURL;
            if(!("replayerURL" in loaderInfo.parameters))
            {
               replayerURL = "Blitz3Replay.swf";
            }
            if(!("assetURL" in loaderInfo.parameters))
            {
               assetURL = "asset_bundles/Blitz3GameResources_en-US.swf";
            }
            if(replayerURL != null && replayerURL.length > 0)
            {
               this.m_BulkLoader.add(replayerURL,{
                  "id":REPLAY,
                  "context":ctx
               });
            }
            if(assetURL != null && assetURL.length > 0)
            {
               this.m_BulkLoader.add(assetURL,{
                  "id":REPLAY_ASSETS,
                  "context":ctx
               });
            }
         }
         else
         {
            resourcesSWF = "Resources_" + this.m_LocaleCode + ".swf";
            this.m_BulkLoader.add(this.m_BasePath + "Blitz3Replay.swf",{
               "id":REPLAY,
               "context":ctx
            });
            this.m_BasePath = "asset_bundles/";
            this.m_BulkLoader.add(this.m_BasePath + "Blitz3Replay" + resourcesSWF,{
               "id":REPLAY_ASSETS,
               "context":ctx
            });
            this.m_BulkLoader.add(this.m_BasePath + "Blitz3Game" + resourcesSWF,{
               "id":GAME_ASSETS,
               "context":ctx
            });
         }
         this.m_BulkLoader.addEventListener(BulkLoader.ERROR,this.HandleError);
         this.m_BulkLoader.addEventListener(BulkLoader.COMPLETE,this.HandleComplete);
         this.m_BulkLoader.addEventListener(BulkLoader.PROGRESS,this.HandleProgress);
      }
      
      private function UpdateLoad(elapsed:int) : void
      {
         var logoTime:Number = NaN;
         if(this.mIsFadingIn)
         {
            logoTime = Math.min(1,this.mTimer / FADE_TIME);
            this.m_ProgressBar.alpha = logoTime;
            if(logoTime == 1)
            {
               this.mIsFadingIn = false;
               this.m_BulkLoader.start(3);
            }
         }
         this.mThrottlePercent = this.mTimer / MIN_LOAD_TIME;
         this.mCapPercent = Math.min(1,Math.min(this.mThrottlePercent,this.mActualPercent));
         if(this.mCapPercent == 1)
         {
            this.mCurrentVelo += 0.001;
         }
         else
         {
            this.mCurrentVelo = Math.min(this.mCurrentVelo + 0.001,(this.mCapPercent - this.mCurrentPercent) * 0.01);
         }
         this.mCurrentPercent += this.mCurrentVelo;
         this.m_ProgressBar.SetValue(this.mCurrentPercent,elapsed);
         if(this.mCurrentPercent >= 1 && this.mIsDoneLoading)
         {
            this.mLastTime = getTimer();
            this.mTimer = 0;
            this.mIsFadingOut = true;
         }
      }
      
      private function UpdateFade() : void
      {
         var fadeTime:Number = Math.min(1,this.mTimer / FADE_TIME);
         this.m_ProgressBar.alpha = 1 - fadeTime;
         if(fadeTime > 0.5 && this.m_Game.visible)
         {
            this.m_Game.visible = false;
            addChildAt(this.m_Game as Sprite,0);
         }
         if(fadeTime >= 1)
         {
            removeChild(this.m_ProgressBar);
            removeEventListener(Event.ENTER_FRAME,this.HandleFrame);
            this.m_Game.visible = true;
            this.m_Game.StartNow();
         }
      }
      
      private function HandleProgress(e:BulkProgressEvent) : void
      {
         this.mActualPercent = e.bytesLoaded / e.bytesTotal;
         if(this.mActualPercent == Number.POSITIVE_INFINITY)
         {
            this.mActualPercent = 0;
         }
         else if(isNaN(this.mActualPercent))
         {
            this.mActualPercent = 0;
         }
         else if(this.mActualPercent > 1)
         {
            this.mActualPercent = 1;
         }
         else if(this.mActualPercent < 0)
         {
            this.mActualPercent = 0;
         }
      }
      
      private function HandleComplete(e:BulkProgressEvent) : void
      {
         this.mIsDoneLoading = true;
         this.m_BulkLoader.removeEventListener(BulkLoader.ERROR,this.HandleError);
         this.m_BulkLoader.removeEventListener(BulkLoader.COMPLETE,this.HandleComplete);
         this.m_BulkLoader.removeEventListener(BulkLoader.PROGRESS,this.HandleProgress);
         this.m_Game = this.m_BulkLoader.getSprite(REPLAY);
         this.m_Game.Resources.AddLibrary(this.m_BulkLoader.getSprite(REPLAY_ASSETS) as IResourceLibrary);
         this.m_Game.Resources.AddLibrary(this.m_BulkLoader.getSprite(GAME_ASSETS) as IResourceLibrary);
      }
      
      private function HandleError(e:Event) : void
      {
         this.mIsDoneLoading = true;
         this.m_BulkLoader.removeEventListener(BulkLoader.ERROR,this.HandleError);
         this.m_BulkLoader.removeEventListener(BulkLoader.COMPLETE,this.HandleComplete);
         this.m_BulkLoader.removeEventListener(BulkLoader.PROGRESS,this.HandleProgress);
         if(this.m_RetryCount < 3)
         {
            ++this.m_RetryCount;
            this.LoadGame();
         }
      }
      
      private function HandleFrame(e:Event = null) : void
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
            this.UpdateLoad(elapsed);
         }
      }
   }
}
