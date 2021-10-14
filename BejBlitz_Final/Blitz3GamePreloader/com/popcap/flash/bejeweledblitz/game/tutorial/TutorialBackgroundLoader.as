package com.popcap.flash.bejeweledblitz.game.tutorial
{
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
   
   public class TutorialBackgroundLoader
   {
       
      
      private var m_App:Blitz3Game;
      
      private var m_ImageData:BitmapData;
      
      private var m_Handlers:Vector.<ITutorialBackgroundLoaderHandler>;
      
      public function TutorialBackgroundLoader(param1:Blitz3Game)
      {
         super();
         this.m_App = param1;
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
      
      public function AddHandler(param1:ITutorialBackgroundLoaderHandler) : void
      {
         this.m_Handlers.push(param1);
      }
      
      private function LoadBackground() : void
      {
         var _loc1_:* = this.m_App.network.GetFlashPath() + "images/tutorial/tutorial_welcome.jpg";
         var _loc2_:Loader = new Loader();
         _loc2_.contentLoaderInfo.addEventListener(Event.INIT,this.HandleLoadComplete);
         _loc2_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.HandleLoadError);
         _loc2_.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.HandleLoadError);
         var _loc3_:URLRequest = new URLRequest(_loc1_);
         _loc2_.load(_loc3_,new LoaderContext(true));
      }
      
      private function DispatchImageLoaded() : void
      {
         var _loc1_:ITutorialBackgroundLoaderHandler = null;
         for each(_loc1_ in this.m_Handlers)
         {
            _loc1_.HandleTutorialBackgroundImageLoaded(this.m_ImageData);
         }
      }
      
      private function HandleLoadComplete(param1:Event) : void
      {
         var _loc2_:LoaderInfo = param1.target as LoaderInfo;
         if(_loc2_ == null)
         {
            this.m_App.network.ForceNetworkError();
            return;
         }
         var _loc3_:Bitmap = _loc2_.content as Bitmap;
         if(_loc3_ == null || _loc3_.bitmapData == null)
         {
            this.m_App.network.ForceNetworkError();
            return;
         }
         this.m_ImageData = _loc3_.bitmapData;
         this.DispatchImageLoaded();
      }
      
      private function HandleLoadError(param1:Event) : void
      {
         ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"TutorialBackgroundLoader failure: " + param1.toString());
         this.m_App.network.ForceNetworkError();
      }
   }
}
