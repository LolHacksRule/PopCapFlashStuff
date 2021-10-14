package com.popcap.flash.framework.resources.localization
{
   import com.popcap.flash.framework.resources.ResourceManager;
   
   public class BaseLocalizationManager
   {
      
      public static const ENGLISH:String = "en-US";
      
      public static const GERMAN:String = "de-DE";
      
      public static const DEFAULT_LANGUAGE:String = ENGLISH;
       
      
      protected var m_ResourceManager:ResourceManager;
      
      public function BaseLocalizationManager(resourceManager:ResourceManager)
      {
         super();
         this.m_ResourceManager = resourceManager;
      }
      
      public function GetLocString(id:String) : String
      {
         var obj:Object = this.m_ResourceManager.GetResource(id);
         var locString:String = obj as String;
         if(locString == null)
         {
            throw new Error("Could not find loc id " + id);
         }
         return locString;
      }
   }
}
