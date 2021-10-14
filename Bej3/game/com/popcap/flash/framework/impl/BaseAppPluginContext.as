package com.popcap.flash.framework.impl
{
   import com.popcap.flash.framework.BaseApp;
   import com.popcap.flash.framework.IAppPlugin;
   import com.popcap.flash.framework.IAppPluginContext;
   import com.popcap.flash.framework.IAppService;
   import flash.events.Event;
   
   public class BaseAppPluginContext implements IAppPluginContext
   {
       
      
      private var mApp:BaseApp;
      
      private var mPlugin:BaseAppPlugin;
      
      public function BaseAppPluginContext(app:BaseApp, plugin:BaseAppPlugin)
      {
         super();
         this.mApp = app;
         this.mPlugin = plugin;
      }
      
      public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         this.mApp.addEventListener(type,listener,useCapture,priority,useWeakReference);
      }
      
      public function dispatchEvent(event:Event) : Boolean
      {
         return this.mApp.dispatchEvent(event);
      }
      
      public function hasEventListener(type:String) : Boolean
      {
         return this.mApp.hasEventListener(type);
      }
      
      public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
      {
         this.mApp.removeEventListener(type,listener,useCapture);
      }
      
      public function willTrigger(type:String) : Boolean
      {
         return this.mApp.willTrigger(type);
      }
      
      public function registerService(ids:Vector.<String>, service:Object, properties:XML) : IAppService
      {
         return this.mApp.registerService(this.mPlugin,ids,service,properties);
      }
      
      public function getServices(id:String) : Vector.<IAppService>
      {
         return this.mApp.getServices(id);
      }
      
      public function getPlugins() : Vector.<IAppPlugin>
      {
         return this.mApp.getPlugins();
      }
      
      public function getPlugin() : IAppPlugin
      {
         return this.mPlugin;
      }
   }
}
