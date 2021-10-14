package com.popcap.flash.bejeweledblitz.error
{
   import com.popcap.flash.bejeweledblitz.Globals;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   
   public class ErrorReporting
   {
      
      public static const ERROR_LEVEL_TRACE:String = "ERROR_LEVEL_TRACE";
      
      public static const ERROR_LEVEL_DEBUG:String = "ERROR_LEVEL_DEBUG";
      
      public static const ERROR_LEVEL_INFO:String = "ERROR_LEVEL_INFO";
      
      public static const ERROR_LEVEL_WARNING:String = "ERROR_LEVEL_WARNING";
      
      public static const ERROR_LEVEL_ERROR_LOW:String = "ERROR_LEVEL_ERROR_LOW";
      
      public static const ERROR_LEVEL_ERROR_MEDIUM:String = "ERROR_LEVEL_ERROR_MEDIUM";
      
      public static const ERROR_LEVEL_ERROR_HIGH:String = "ERROR_LEVEL_ERROR_HIGH";
      
      public static const ERROR_TYPE_ASSET_LOADING:String = "ERROR_TYPE_ASSET_LOADING";
      
      public static const ERROR_TYPE_ASSET_RENDERING:String = "ERROR_TYPE_ASSET_RENDERING";
      
      public static const ERROR_TYPE_COMMUNICATION_JS:String = "ERROR_TYPE_COMMUNICATION_JS";
      
      public static const ERROR_TYPE_COMMUNICATION_PHP:String = "ERROR_TYPE_COMMUNICATION_PHP";
      
      public static const ERROR_TYPE_RUNTIME:String = "ERROR_TYPE_RUNTIME";
      
      public static const ERROR_TYPE_SECURITY:String = "ERROR_TYPE_SECURITY";
      
      public static const ERROR_TYPE_DYNAMIC:String = "ERROR_TYPE_DYNAMIC";
      
      private static const _ERROR_URL:String = "/bej/ajax/flashError.php";
       
      
      public function ErrorReporting()
      {
         super();
      }
      
      public static function logRuntimeError(param1:Error) : void
      {
         ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_DYNAMIC,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,!!param1.getStackTrace() ? " stack " + param1.getStackTrace().toString() : " message " + param1.message.toString());
      }
      
      public static function sendError(param1:String, param2:String, param3:String) : void
      {
         trace("ErrorReporting::sendError type: " + param1 + " level: " + param2 + " message: " + param3);
         var _loc4_:Object;
         (_loc4_ = new Object()).type = param1;
         _loc4_.severity = param2;
         _loc4_.message = encodeURIComponent(param3);
         _loc4_.userId = Globals.userId;
         var _loc5_:URLRequest;
         (_loc5_ = new URLRequest(Globals.labsPath + _ERROR_URL + "?data=" + JSON.stringify(_loc4_))).method = URLRequestMethod.POST;
         var _loc6_:URLLoader;
         (_loc6_ = new URLLoader()).addEventListener(Event.COMPLETE,onComplete,false,0,true);
         _loc6_.addEventListener(IOErrorEvent.IO_ERROR,onIOError,false,0,true);
         _loc6_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
         _loc6_.load(_loc5_);
      }
      
      private static function onComplete(param1:Event) : void
      {
         trace("ErrorReporting::onComplete REPORTING success.");
      }
      
      private static function onIOError(param1:IOErrorEvent) : void
      {
         trace("ErrorReporting::onIOError REPORTING error: " + param1);
      }
      
      private static function onSecurityError(param1:SecurityErrorEvent) : void
      {
         trace("ErrorReporting::onSecurityError REPORTING error: " + param1);
      }
   }
}
