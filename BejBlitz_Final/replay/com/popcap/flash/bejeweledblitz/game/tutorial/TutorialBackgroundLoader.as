package com.popcap.flash.bejeweledblitz.game.tutorial
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   
   public class TutorialBackgroundLoader
   {
       
      
      private var m_App:Blitz3Game;
      
      private var m_ImageData:BitmapData;
      
      private var m_Handlers:Vector.<ITutorialBackgroundLoaderHandler>;
      
      public function TutorialBackgroundLoader(app:Blitz3Game)
      {
         super();
         this.m_App = app;
         this.m_ImageData = null;
         this.m_Handlers = new Vector.<ITutorialBackgroundLoaderHandler>();
      }
      
      public function BeginLoad() : void
      {
         this.LoadBackground();
      }
      
      public function GetImageData() : BitmapData
      {
         return this.m_ImageData;
      }
      
      public function AddHandler(handler:ITutorialBackgroundLoaderHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      private function LoadBackground() : void
      {
         var url:String = this.m_App.network.GetFlashPath() + "images/tutorial/tutorial_welcome.jpg";
         var loader:Loader = new Loader();
         loader.contentLoaderInfo.addEventListener(Event.INIT,this.HandleLoadComplete);
         loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.HandleError);
         loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.HandleError);
         var request:URLRequest = new URLRequest(url);
         loader.load(request,new LoaderContext(true));
      }
      
      private function DispatchImageLoaded() : void
      {
         var handler:ITutorialBackgroundLoaderHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleTutorialBackgroundImageLoaded(this.m_ImageData);
         }
      }
      
      private function HandleLoadComplete(event:Event) : void
      {
         var info:LoaderInfo = event.target as LoaderInfo;
         if(info == null)
         {
            this.m_App.network.ForceNetworkError();
            return;
         }
         var image:Bitmap = info.content as Bitmap;
         if(image == null || image.bitmapData == null)
         {
            this.m_App.network.ForceNetworkError();
            return;
         }
         this.m_ImageData = image.bitmapData;
         this.DispatchImageLoaded();
      }
      
      private function HandleError(event:Event) : void
      {
         trace("Error while loading tutorial welcome image:");
         trace(event);
         this.m_App.network.ForceNetworkError();
      }
   }
}
