package com.popcap.flash.framework.resources.localization
{
   import flash.utils.Dictionary;
   
   public class §_-lD§ implements §true §
   {
      
      public static const ITALIAN:String = "ITALIAN";
      
      public static const KOREAN:String = "KOREAN";
      
      public static const GERMAN:String = "GERMAN";
      
      public static const DUTCH:String = "DUTCH";
      
      public static const ENGLISH:String = "ENGLISH";
      
      public static const JAPANESE:String = "JAPANESE";
      
      public static const CHINESE_TRADITIONAL:String = "CHINESE_TRADITIONAL";
      
      public static const CHINESE_SIMPLIFIED:String = "CHINESE_SIMPLIFIED";
      
      public static const FRENCH:String = "FRENCH";
      
      public static const SPANISH:String = "SPANISH";
       
      
      protected var §_-g8§:Dictionary;
      
      protected var §_-lP§:String;
      
      protected var §_-Q-§:Dictionary;
      
      public function §_-lD§()
      {
         super();
         this.§_-Q-§ = new Dictionary();
         this.§_-lP§ = "";
         this.§_-g8§ = null;
         this.Init();
      }
      
      protected static function §_-40§(param1:String) : String
      {
         var _loc2_:* = param1 + "";
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = _loc2_.replace("&quot;","\"").replace("&lt;","<").replace("&rt;",">");
            _loc3_++;
         }
         return _loc2_;
      }
      
      protected static function §_-l5§(param1:String) : String
      {
         var _loc2_:* = param1 + "";
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = _loc2_.replace("\"","&quot;").replace("<","&lt;").replace(">","&rt;");
            _loc3_++;
         }
         return _loc2_;
      }
      
      protected function §get §(param1:XML) : void
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
         var xml:XML = param1;
         try
         {
            idNodes = xml.children();
            numIdNodes = idNodes.length();
            i = 0;
            while(i < numIdNodes)
            {
               idNode = idNodes[i];
               id = idNode.name().toString();
               langNodes = idNode.children();
               numLangNodes = langNodes.length();
               j = 0;
               while(j < numLangNodes)
               {
                  langNode = langNodes[j];
                  langName = langNode.name().toString();
                  if(!(langName in this.§_-Q-§))
                  {
                     this.§_-Q-§[langName] = new Dictionary();
                  }
                  this.§_-Q-§[langName][id] = §_-40§(langNode.toString());
                  j++;
               }
               i++;
            }
         }
         catch(error:Error)
         {
            trace("Error while parsing loc string XML:");
            trace(error.getStackTrace());
         }
      }
      
      protected function Init() : void
      {
         this.§_-Y2§(ENGLISH);
      }
      
      public function §_-T3§() : String
      {
         return this.§_-lP§;
      }
      
      public function GetLocString(param1:String) : String
      {
         if(!this.§_-g8§)
         {
            return "";
         }
         if(!(param1 in this.§_-g8§))
         {
            return "";
         }
         return this.§_-g8§[param1];
      }
      
      public function §_-Y2§(param1:String) : void
      {
         this.§_-lP§ = param1;
         if(param1 in this.§_-Q-§)
         {
            this.§_-g8§ = this.§_-Q-§[param1];
         }
         else
         {
            this.§_-lP§ = null;
         }
      }
   }
}
