package preloader
{
   import br.com.stimuli.loading.BulkLoader;
   import com.popcap.flash.framework.ads.MSNAdAPI;
   import com.popcap.flash.games.bej3.blitz.IBej3Game;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.system.Security;
   
   public class Bej3Preloader extends Sprite
   {
       
      
      private var mMenuLoader:Loader;
      
      private var mGameLoader:Loader;
      
      private var mBytesTotal:int;
      
      private var mBytesLoaded:int;
      
      private var mPercentLoaded:Number;
      
      private var mPreloader:Preloader;
      
      private var mIsMenuLoaded:Boolean;
      
      private var mIsGameLoaded:Boolean;
      
      private var mBulkLoader:BulkLoader;
      
      public var mGame:IBej3Game;
      
      public var mMainMenu:MovieClip;
      
      public var mBackgrounds:MovieClip;
      
      public var mDataXML:XML;
      
      public var mAdAPI:MSNAdAPI;
      
      public var mLocXML:XML;
      
      public function Bej3Preloader()
      {
         super();
         this.Init();
      }
      
      private function Init() : void
      {
         Security.allowDomain("*");
         this.mAdAPI = new MSNAdAPI();
         this.mAdAPI.init();
         this.mPreloader = new Preloader();
         addChild(this.mPreloader);
         this.mPreloader.mcGlow.gotoAndStop(1);
         this.mBulkLoader = new BulkLoader("bej3");
         this.mBulkLoader.add("game.swf");
         this.mBulkLoader.add("menu.swf");
         this.mBulkLoader.add("LocStrings.xml");
         this.mBulkLoader.add("backgrounds.swf");
         this.mBulkLoader.add("data.xml");
         this.mBulkLoader.addEventListener(BulkLoader.ERROR,this.handleError);
         this.mBulkLoader.addEventListener(BulkLoader.COMPLETE,this.handleComplete);
         this.mBulkLoader.addEventListener(BulkLoader.PROGRESS,this.handleProgress);
         this.mBulkLoader.start(5);
      }
      
      private function handleProgress(param1:ProgressEvent) : void
      {
         this.mBytesTotal = this.mBulkLoader._bytesTotal;
         this.mBytesLoaded = this.mBulkLoader._bytesLoaded;
         this.mPercentLoaded = this.mBytesLoaded / this.mBytesTotal;
         var _loc2_:int = this.mPercentLoaded * 100;
         if(_loc2_ <= 0)
         {
            _loc2_ = 1;
         }
         if(_loc2_ >= 100)
         {
            _loc2_ = 100;
         }
         this.mPreloader.mcGlow.gotoAndStop(_loc2_);
         this.mAdAPI.SetLoadPercent(int(this.mPercentLoaded * 100));
      }
      
      private function handleError(param1:Event) : void
      {
      }
      
      private function handleComplete(param1:Event) : void
      {
         removeChild(this.mPreloader);
         this.mBulkLoader.removeEventListener(BulkLoader.ERROR,this.handleError);
         this.mBulkLoader.removeEventListener(BulkLoader.COMPLETE,this.handleComplete);
         this.mBulkLoader.removeEventListener(BulkLoader.PROGRESS,this.handleProgress);
         this.mGame = this.mBulkLoader.getSprite("game.swf") as IBej3Game;
         this.mMainMenu = this.mBulkLoader.getMovieClip("menu.swf");
         this.mLocXML = this.mBulkLoader.getXML("LocStrings.xml");
         this.mBackgrounds = this.mBulkLoader.getMovieClip("backgrounds.swf");
         this.mDataXML = this.mBulkLoader.getXML("data.xml");
         addChild(this.mMainMenu);
      }
   }
}
