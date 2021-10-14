package com.popcap.flash.framework
{
   import flash.events.IEventDispatcher;
   
   public interface IAppPluginContext extends IEventDispatcher
   {
       
      
      function registerService(param1:Vector.<String>, param2:Object, param3:XML) : IAppService;
      
      function getServices(param1:String) : Vector.<IAppService>;
      
      function getPlugins() : Vector.<IAppPlugin>;
      
      function getPlugin() : IAppPlugin;
   }
}
