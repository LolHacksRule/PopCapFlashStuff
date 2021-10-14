package com.popcap.flash.bejeweledblitz
{
   public class Version
   {
      
      public static const MAJOR_VERSION:int = 1;
      
      public static const MINOR_VERSION:int = 7;
      
      public static const BUILD_VERSION:int = 24;
       
      
      public function Version()
      {
         super();
      }
      
      public static function get version() : String
      {
         return MAJOR_VERSION + "." + MINOR_VERSION + "." + BUILD_VERSION;
      }
   }
}
