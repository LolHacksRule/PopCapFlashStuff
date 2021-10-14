package com.popcap.flash.games.blitz3.ui.widgets.levels
{
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.utils.Dictionary;
   
   public class LevelCrestCache
   {
      
      protected static const MIN_TO_LOAD:int = 3;
      
      protected static const MAX_IMAGE_LEVEL:int = 100;
       
      
      protected var m_App:Blitz3App;
      
      protected var m_Loaders:Dictionary;
      
      public function LevelCrestCache(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_Loaders = new Dictionary();
      }
      
      public function SetNextLevel(level:Number) : void
      {
         this.LoadLevels(level,MIN_TO_LOAD);
      }
      
      public function LoadLevels(levelStart:Number, numLevels:int = 1) : void
      {
         for(var i:int = 0; i < numLevels; i++)
         {
         }
      }
      
      public function GetCrest(level:Number) : LevelCrestLoader
      {
         var actualLevel:Number = Math.min(level,MAX_IMAGE_LEVEL);
         var loader:LevelCrestLoader = this.m_Loaders[actualLevel];
         if(!loader)
         {
            loader = this.m_Loaders[actualLevel];
         }
         return loader;
      }
      
      protected function LoadCrest(level:Number) : void
      {
         var actualLevel:Number = Math.min(level,MAX_IMAGE_LEVEL);
         var loader:LevelCrestLoader = this.m_Loaders[actualLevel];
         if(loader)
         {
            if(loader.loadState != LevelCrestLoader.STATE_LOAD_ERROR)
            {
               return;
            }
         }
         loader = new LevelCrestLoader(actualLevel);
         loader.contentLoaderInfo.addEventListener(Event.INIT,this.HandleLoadComplete);
         loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.HandleIOError);
         var levelString:String = "" + actualLevel;
         if(actualLevel < 100)
         {
            levelString = "0" + levelString;
         }
         if(actualLevel < 10)
         {
            levelString = "0" + levelString;
         }
         var url:String = this.m_App.network.parameters.pathToFlash + "level_crests/" + levelString + ".png";
         trace("loading crest image: " + url);
         loader.load(new URLRequest(url),new LoaderContext(true));
         loader.loadState = LevelCrestLoader.STATE_LOAD_BEGUN;
         this.m_Loaders[actualLevel] = loader;
      }
      
      protected function HandleLoadComplete(event:Event) : void
      {
         var loader:LevelCrestLoader = event.target as LevelCrestLoader;
         if(!loader)
         {
            return;
         }
         loader.loadState = LevelCrestLoader.STATE_LOAD_COMPLETE;
         (loader.content as Bitmap).smoothing = true;
      }
      
      protected function HandleIOError(event:IOErrorEvent) : void
      {
         var loader:LevelCrestLoader = event.target as LevelCrestLoader;
         if(!loader)
         {
            return;
         }
         loader.loadState = LevelCrestLoader.STATE_LOAD_ERROR;
      }
   }
}
