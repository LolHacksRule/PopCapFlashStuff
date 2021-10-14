package com.popcap.flash.framework.impl
{
   import com.popcap.flash.framework.IAppPlugin;
   import com.popcap.flash.framework.IAppService;
   
   public class BaseAppService implements IAppService
   {
       
      
      private var mProperties:XML;
      
      private var mPlugin:BaseAppPlugin;
      
      private var mImpl:Object;
      
      public function BaseAppService(param1:Object, param2:XML, param3:BaseAppPlugin)
      {
         super();
         this.mImpl = param1;
         this.mProperties = param2;
         this.mPlugin = param3;
      }
      
      public function getProperties() : XML
      {
         return this.mProperties;
      }
      
      public function getImplementation() : Object
      {
         return this.mImpl;
      }
      
      public function getPlugin() : IAppPlugin
      {
         return this.mPlugin;
      }
   }
}
