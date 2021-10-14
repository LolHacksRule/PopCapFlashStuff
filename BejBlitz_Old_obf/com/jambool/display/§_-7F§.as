package com.jambool.display
{
   import §_-G2§.§_-eH§;
   import com.jambool.net.§_-7i§;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.LocalConnection;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.setTimeout;
   
   public class §_-7F§ extends Sprite
   {
      
      private static var §_-Ga§:Class = ModalWindow_CloseButtonUp;
      
      private static const §_-8q§:int = 0;
      
      private static const §_-DV§:int = 4500;
       
      
      private var §_-bJ§:DisplayObjectContainer;
      
      private var closeButton:SimpleButton;
      
      private var request:URLRequest;
      
      private var loader:Loader;
      
      private var options:Object;
      
      private var action:String;
      
      private var originalRequest:§_-7i§;
      
      public function §_-7F§(param1:URLRequest, param2:§_-7i§, param3:DisplayObjectContainer)
      {
         super();
         this.request = param1;
         this.originalRequest = param2;
         this.§_-bJ§ = param3;
         §_-kj§();
      }
      
      private function §_-b9§() : void
      {
         loader = new Loader();
         addChild(loader);
         loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,§_-9e§);
         loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,§_-jp§);
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,completeHandler);
         var _loc1_:LoaderContext = new LoaderContext();
         _loc1_.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
         loader.load(request,_loc1_);
      }
      
      private function §_-jp§(param1:ErrorEvent) : void
      {
         trace(">> [ERROR] ModalWindow encountered a Security Error with: " + param1);
         §_-pM§(param1);
      }
      
      private function §_-kj§() : void
      {
         focusRect = false;
         addEventListener(Event.ADDED,§_-5l§);
         addEventListener(Event.REMOVED,§_-46§);
         §_-C7§();
      }
      
      private function completeHandler(param1:Event) : void
      {
         var self:Sprite = null;
         var event:Event = param1;
         self = this;
         setTimeout(function():void
         {
            if(stage)
            {
               stage.focus = self;
            }
            originalRequest.dispatchEvent(new §_-eH§(§_-eH§.§_-9L§));
            setTimeout(function():void
            {
               addChild(closeButton);
               closeButton.x = 401;
               closeButton.y = -15;
            },§_-DV§);
         },100);
      }
      
      private function §_-46§(param1:Event) : void
      {
         if(param1.target === this)
         {
            §_-50§();
         }
      }
      
      private function §_-C7§() : void
      {
         closeButton = new SimpleButton();
         closeButton.upState = new §_-Ga§();
         closeButton.overState = new §_-Ga§();
         closeButton.downState = new §_-Ga§();
         closeButton.hitTestState = new §_-Ga§();
         closeButton.useHandCursor = true;
         closeButton.addEventListener(MouseEvent.CLICK,§_-Kd§);
      }
      
      private function §_-pM§(param1:Event) : void
      {
         var _loc2_:§_-eH§ = new §_-eH§(§_-eH§.§_-Kt§);
         dispatchEvent(_loc2_);
      }
      
      private function §_-9e§(param1:ErrorEvent) : void
      {
         trace(">> [ERROR] ModalWindow was unable to display the loaded UI SWF with: " + param1);
         §_-pM§(param1);
      }
      
      private function §_-5l§(param1:Event) : void
      {
         if(param1.target === this)
         {
            §_-b9§();
         }
      }
      
      private function §_-50§() : void
      {
         if(loader)
         {
            loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,§_-9e§);
            loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,§_-jp§);
            loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,completeHandler);
            loader.unload();
            removeChild(loader);
            loader = null;
            try
            {
               new LocalConnection().connect("foo");
               new LocalConnection().connect("foo");
            }
            catch(e:*)
            {
            }
         }
      }
      
      public function get pendingRequest() : §_-7i§
      {
         return originalRequest;
      }
      
      private function §_-Kd§(param1:MouseEvent) : void
      {
         closeButton.removeEventListener(MouseEvent.CLICK,§_-Kd§);
         dispatchEvent(new Event(Event.CLOSE,true));
      }
      
      public function get windowRequest() : URLRequest
      {
         return request;
      }
   }
}
