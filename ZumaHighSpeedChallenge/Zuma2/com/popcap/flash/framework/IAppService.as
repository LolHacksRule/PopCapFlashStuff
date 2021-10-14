package com.popcap.flash.framework
{
   public interface IAppService
   {
       
      
      function getImplementation() : Object;
      
      function getProperties() : XML;
      
      function getPlugin() : IAppPlugin;
   }
}
