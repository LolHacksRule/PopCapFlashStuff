package com.popcap.flash.bejeweledblitz
{
   public class Version
   {
      
      public static const BUILD_DATE:String = "17.02.2020 11:35";
       
      
      public function Version()
      {
         super();
      }
      
      public static function get version() : String
      {
         return BUILD_DATE;
      }
   }
}
