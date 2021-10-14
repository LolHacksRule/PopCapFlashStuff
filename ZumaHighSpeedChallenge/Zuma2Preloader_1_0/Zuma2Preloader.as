package
{
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   
   public class Zuma2Preloader extends Sprite
   {
       
      
      private var mLoader:Loader;
      
      private var mBytesLoaded:int;
      
      private var mPreloader:Preloader;
      
      private var mBytesTotal:int;
      
      private var mPercentLoaded:Number;
      
      private var mGame:Sprite;
      
      public function Zuma2Preloader()
      {
         super();
         this.Init();
      }
      
      private function handleComplete(e:Event) : void
      {
         removeChild(this.mPreloader);
         this.mLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.handleComplete);
         this.mLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.handleProgress);
         addChild(this.mLoader.content);
      }
      
      private function Init() : void
      {
         this.mPreloader = new Preloader();
         addChild(this.mPreloader);
         this.mPreloader.progress.fill.scaleX = 0;
         this.mLoader = new Loader();
         this.mLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.handleComplete);
         this.mLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.handleProgress);
         this.mLoader.load(new URLRequest("Zuma2.swf"));
      }
      
      private function handleProgress(e:ProgressEvent) : void
      {
         this.mBytesTotal = this.mLoader.contentLoaderInfo.bytesTotal;
         this.mBytesLoaded = this.mLoader.contentLoaderInfo.bytesLoaded;
         this.mPercentLoaded = this.mBytesLoaded / this.mBytesTotal;
         trace(this.mPercentLoaded);
         this.mPreloader.progress.fill.scaleX = this.mPercentLoaded;
      }
   }
}
