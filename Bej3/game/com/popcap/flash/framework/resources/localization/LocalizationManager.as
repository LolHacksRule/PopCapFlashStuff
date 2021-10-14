package com.popcap.flash.framework.resources.localization
{
   public interface LocalizationManager
   {
       
      
      function GetLocale() : String;
      
      function SetLocale(param1:String) : void;
      
      function GetLocString(param1:String) : String;
      
      function SetXML(param1:XML) : void;
   }
}
