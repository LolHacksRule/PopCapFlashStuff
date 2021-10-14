package com.plumbee.stardustplayer
{
   public class ZipFileNames
   {
      
      private static const EMITTER_NAME_PREFIX:String = "stardustEmitter_";
       
      
      public function ZipFileNames()
      {
         super();
      }
      
      public static function getXMLName(param1:int) : String
      {
         return EMITTER_NAME_PREFIX + param1 + ".xml";
      }
      
      public static function getImageName(param1:int) : String
      {
         return "emitterImage_" + param1 + ".png";
      }
      
      public static function isEmitterXMLName(param1:String) : Boolean
      {
         return param1.substr(0,16) == EMITTER_NAME_PREFIX;
      }
      
      public static function getEmitterID(param1:String) : uint
      {
         return parseInt(param1.substr(16).split(".")[0]);
      }
   }
}
