package org.osmf.logging
{
   public class Log
   {
      
      private static var _loggerFactory:LoggerFactory;
       
      
      public function Log()
      {
         super();
      }
      
      public static function get loggerFactory() : LoggerFactory
      {
         return _loggerFactory;
      }
      
      public static function set loggerFactory(param1:LoggerFactory) : void
      {
         _loggerFactory = param1;
      }
      
      public static function getLogger(param1:String) : Logger
      {
         return _loggerFactory == null ? null : _loggerFactory.getLogger(param1);
      }
   }
}
