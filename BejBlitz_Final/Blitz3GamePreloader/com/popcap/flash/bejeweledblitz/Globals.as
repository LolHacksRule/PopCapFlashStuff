package com.popcap.flash.bejeweledblitz
{
   public class Globals
   {
      
      public static var currentKeyPressed:String = "";
      
      public static var lastKeyPressed:String = "";
      
      private static var _userId:String = "0";
      
      private static var _labsPath:String = "";
       
      
      public function Globals()
      {
         super();
      }
      
      public static function keyPress(param1:String) : void
      {
         lastKeyPressed = currentKeyPressed;
         currentKeyPressed = param1;
      }
      
      public static function set userId(param1:String) : void
      {
         _userId = param1;
      }
      
      public static function get userId() : String
      {
         return _userId;
      }
      
      public static function set labsPath(param1:String) : void
      {
         _labsPath = param1;
      }
      
      public static function get labsPath() : String
      {
         return _labsPath;
      }
   }
}
