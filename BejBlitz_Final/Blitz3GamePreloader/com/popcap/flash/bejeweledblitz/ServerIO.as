package com.popcap.flash.bejeweledblitz
{
   import flash.external.ExternalInterface;
   
   public class ServerIO
   {
      
      private static const _JS_COMMAND_SEND:String = "sendCommand";
      
      private static var _isInited:Boolean = false;
      
      private static var _receiveCallbackHash:Object;
      
      private static var _receiveParamsHash:Object;
      
      private static var _catchCallbackHash:Object;
      
      private static var _catchParamsHash:Object;
       
      
      public function ServerIO()
      {
         super();
      }
      
      public static function registerCallback(param1:String, param2:Function, param3:* = null) : void
      {
         init();
         _receiveCallbackHash[param1] = param2;
         _receiveParamsHash[param1] = param3;
      }
      
      public static function sendToServer(param1:String, param2:Object = null, param3:Object = null) : void
      {
         var _loc5_:* = undefined;
         var _loc6_:Object = null;
         init();
         var _loc4_:Object;
         (_loc4_ = new Object()).command = param1;
         _loc4_.data = param2;
         _loc4_.passthrough = param3;
         if(ExternalInterface.available)
         {
            try
            {
               if((_loc5_ = ExternalInterface.call(_JS_COMMAND_SEND,_loc4_)) != null)
               {
                  (_loc6_ = new Object()).command = param1;
                  _loc6_.data = _loc5_;
                  _loc6_.passthrough = param3;
                  receiveFromServer(_loc6_);
               }
            }
            catch(e:Error)
            {
            }
         }
      }
      
      private static function init() : void
      {
         if(_isInited)
         {
            return;
         }
         _isInited = true;
         _receiveCallbackHash = new Object();
         _receiveParamsHash = new Object();
         if(ExternalInterface.available)
         {
            try
            {
               ExternalInterface.addCallback(_JS_COMMAND_SEND,receiveFromServer);
            }
            catch(e:Error)
            {
            }
         }
      }
      
      public static function cheatReceiveFromServer(param1:Object) : void
      {
         receiveFromServer(param1);
      }
      
      public static function testReceiveFromServer(param1:* = null) : void
      {
         receiveFromServer(param1);
      }
      
      private static function receiveFromServer(param1:* = null) : void
      {
         if(param1 == null || param1 is Number)
         {
            return;
         }
         var _loc2_:Object = param1;
         var _loc3_:String = "";
         if(_loc2_.command != null)
         {
            _loc3_ = _loc2_.command;
         }
         var _loc4_:Object = new Object();
         if(_loc2_.data != null)
         {
            _loc4_.data = _loc2_.data;
         }
         else
         {
            _loc4_.data = new Object();
         }
         if(_loc3_ != "" && _receiveParamsHash[_loc3_] != null)
         {
            _loc4_.params = _receiveParamsHash[_loc3_];
         }
         else
         {
            _loc4_.params = new Object();
         }
         if(_loc2_.passthrough != null)
         {
            _loc4_.passthrough = _loc2_.passthrough;
         }
         else
         {
            _loc4_.passthrough = new Object();
         }
         if(_loc3_ != "" && _receiveCallbackHash[_loc3_] != null)
         {
            _receiveCallbackHash[_loc3_].call(null,_loc4_);
         }
      }
   }
}
