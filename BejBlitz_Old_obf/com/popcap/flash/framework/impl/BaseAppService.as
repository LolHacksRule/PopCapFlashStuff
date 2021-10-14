package com.popcap.flash.framework.impl
{
   import com.popcap.flash.framework.IAppPlugin;
   import com.popcap.flash.framework.IAppService;
   
   public class BaseAppService implements IAppService
   {
       
      
      private var §_-c8§:XML;
      
      private var §_-Z§:§_-IW§;
      
      private var §_-Bb§:Object;
      
      public function BaseAppService(param1:Object, param2:XML, param3:§_-IW§)
      {
         super();
         this.§_-Bb§ = param1;
         this.§_-c8§ = param2;
         this.§_-Z§ = param3;
      }
      
      public function §_-Us§() : XML
      {
         return this.§_-c8§;
      }
      
      public function §_-1u§() : Object
      {
         return this.§_-Bb§;
      }
      
      public function §_-3J§() : IAppPlugin
      {
         return this.§_-Z§;
      }
   }
}
