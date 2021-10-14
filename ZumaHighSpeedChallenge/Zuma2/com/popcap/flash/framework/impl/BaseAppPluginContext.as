package com.popcap.flash.framework.impl
{
   import com.popcap.flash.framework.BaseApp;
   import com.popcap.flash.framework.IAppPlugin;
   import com.popcap.flash.framework.IAppPluginContext;
   import com.popcap.flash.framework.IAppService;
   import flash.events.Event;
   
   public class BaseAppPluginContext implements IAppPluginContext
   {
       
      
      private var mPlugin:BaseAppPlugin;
      
      private var mApp:BaseApp;
      
      public function BaseAppPluginContext(param1:BaseApp, param2:BaseAppPlugin)
      {
         super();
         this.mApp = param1;
         this.mPlugin = param2;
      }
      
      public function getPlugins() : Vector.<IAppPlugin>
      {
         return this.mApp.getPlugins();
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this.mApp.hasEventListener(param1);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this.mApp.willTrigger(param1);
      }
      
      public function getPlugin() : IAppPlugin
      {
         return this.mPlugin;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this.mApp.removeEventListener(param1,param2,param3);
      }
      
      public function getServices(param1:String) : Vector.<IAppService>
      {
         return this.mApp.getServices(param1);
      }
      
      public function registerService(param1:Vector.<String>, param2:Object, param3:XML) : IAppService
      {
         return this.mApp.registerService(this.mPlugin,param1,param2,param3);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this.mApp.dispatchEvent(param1);
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this.mApp.addEventListener(param1,param2,param3,param4,param5);
      }
   }
}
