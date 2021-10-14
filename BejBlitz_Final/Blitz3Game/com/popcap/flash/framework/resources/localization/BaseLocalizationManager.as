package com.popcap.flash.framework.resources.localization
{
   import com.popcap.flash.framework.resources.ResourceManager;
   
   public class BaseLocalizationManager
   {
      
      public static const ENGLISH:String = "en-US";
      
      public static const GERMAN:String = "de-DE";
      
      public static const DEFAULT_LANGUAGE:String = ENGLISH;
       
      
      protected var m_ResourceManager:ResourceManager;
      
      public function BaseLocalizationManager(param1:ResourceManager)
      {
         super();
         this.m_ResourceManager = param1;
      }
      
      public function GetLocString(param1:String) : String
      {
         var _loc2_:Object = this.m_ResourceManager.GetResource(param1);
         var _loc3_:String = _loc2_ as String;
         if(_loc3_ == null)
         {
            trace("Could not find loc id " + param1);
            return "";
         }
         return _loc3_;
      }
   }
}
