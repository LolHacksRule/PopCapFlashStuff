package com.popcap.flash.framework.resources.localization
{
   import flash.utils.Dictionary;
   
   public class BaseLocalizationManager implements LocalizationManager
   {
      
      public static const ENGLISH:String = "ENGLISH";
      
      public static const FRENCH:String = "FRENCH";
      
      public static const ITALIAN:String = "ITALIAN";
      
      public static const GERMAN:String = "GERMAN";
      
      public static const SPANISH:String = "SPANISH";
      
      public static const DUTCH:String = "DUTCH";
      
      public static const JAPANESE:String = "JAPANESE";
      
      public static const CHINESE_TRADITIONAL:String = "CHINESE_TRADITIONAL";
      
      public static const CHINESE_SIMPLIFIED:String = "CHINESE_SIMPLIFIED";
      
      public static const KOREAN:String = "KOREAN";
       
      
      protected var m_LocStrings:Dictionary;
      
      protected var m_CurLocDict:Dictionary;
      
      protected var m_Locale:String;
      
      public function BaseLocalizationManager()
      {
         super();
         this.m_LocStrings = new Dictionary();
         this.m_Locale = "";
         this.m_CurLocDict = null;
         this.Init();
      }
      
      protected static function ProtectSpecialCharacters(str:String) : String
      {
         var result:String = str + "";
         for(var i:int = 0; i < str.length; i++)
         {
            result = result.replace("\"","&quot;").replace("<","&lt;").replace(">","&rt;");
         }
         return result;
      }
      
      protected static function UnprotectSpecialCharacters(str:String) : String
      {
         var result:String = str + "";
         for(var i:int = 0; i < str.length; i++)
         {
            result = result.replace("&quot;","\"").replace("&lt;","<").replace("&rt;",">");
         }
         return result;
      }
      
      public function SetXML(xml:XML) : void
      {
         this.ParseXML(xml);
         this.Init();
      }
      
      public function GetLocale() : String
      {
         return this.m_Locale;
      }
      
      public function SetLocale(locale:String) : void
      {
         this.m_Locale = locale;
         if(locale in this.m_LocStrings)
         {
            this.m_CurLocDict = this.m_LocStrings[locale];
         }
         else
         {
            this.m_Locale = null;
         }
      }
      
      public function GetLocString(id:String) : String
      {
         if(!this.m_CurLocDict)
         {
            return "";
         }
         if(!(id in this.m_CurLocDict))
         {
            return "";
         }
         return this.m_CurLocDict[id];
      }
      
      protected function ParseXML(xml:XML) : void
      {
         var idNodes:XMLList = null;
         var numIdNodes:int = 0;
         var i:int = 0;
         var idNode:XML = null;
         var id:String = null;
         var langNodes:XMLList = null;
         var numLangNodes:int = 0;
         var j:int = 0;
         var langNode:XML = null;
         var langName:String = null;
         try
         {
            idNodes = xml.children();
            numIdNodes = idNodes.length();
            for(i = 0; i < numIdNodes; i++)
            {
               idNode = idNodes[i];
               id = idNode.name().toString();
               langNodes = idNode.children();
               numLangNodes = langNodes.length();
               for(j = 0; j < numLangNodes; j++)
               {
                  langNode = langNodes[j];
                  langName = langNode.name().toString();
                  if(!(langName in this.m_LocStrings))
                  {
                     this.m_LocStrings[langName] = new Dictionary();
                  }
                  this.m_LocStrings[langName][id] = UnprotectSpecialCharacters(langNode.toString());
               }
            }
         }
         catch(error:Error)
         {
         }
      }
      
      protected function Init() : void
      {
         this.SetLocale(ENGLISH);
      }
   }
}
