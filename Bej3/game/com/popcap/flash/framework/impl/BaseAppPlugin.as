package com.popcap.flash.framework.impl
{
   import com.popcap.flash.framework.BaseApp;
   import com.popcap.flash.framework.IAppPlugin;
   import com.popcap.flash.framework.IAppPluginActivator;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   
   public class BaseAppPlugin implements IAppPlugin
   {
       
      
      private var mApp:BaseApp;
      
      private var mContext:BaseAppPluginContext;
      
      private var mActivator:IAppPluginActivator;
      
      private var mLoader:Loader;
      
      private var mProperties:XML;
      
      private var mLoaded:Boolean = false;
      
      public function BaseAppPlugin(app:BaseApp, properties:XML)
      {
         super();
         this.mApp = app;
         this.mLoader = new Loader();
         var info:LoaderInfo = this.mLoader.contentLoaderInfo;
         info.addEventListener(IOErrorEvent.IO_ERROR,this.handleLoadFailure);
         info.addEventListener(Event.COMPLETE,this.handleLoadSuccess);
         this.mProperties = properties;
      }
      
      public function isLoaded() : Boolean
      {
         return this.mLoaded;
      }
      
      public function load() : void
      {
         var url:URLRequest = new URLRequest(this.mProperties.@source);
         this.mLoader.load(url);
      }
      
      public function getProperties() : XML
      {
         return this.mProperties;
      }
      
      private function handleLoadSuccess(e:Event) : void
      {
         var loader:LoaderInfo = e.target as LoaderInfo;
         this.mContext = new BaseAppPluginContext(this.mApp,this);
         this.mActivator = loader.content as IAppPluginActivator;
         this.mActivator.start(this.mContext);
         this.mLoaded = true;
      }
      
      private function handleLoadFailure(e:IOErrorEvent) : void
      {
         this.mLoaded = true;
      }
   }
}
