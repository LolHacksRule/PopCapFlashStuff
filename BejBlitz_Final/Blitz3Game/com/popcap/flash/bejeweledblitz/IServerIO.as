package com.popcap.flash.bejeweledblitz
{
   public interface IServerIO
   {
       
      
      function registerCallback(param1:String, param2:Function, param3:* = null) : void;
      
      function sendToServer(param1:String, param2:Object = null, param3:Object = null) : void;
      
      function cheatReceiveFromServer(param1:Object) : void;
      
      function testReceiveFromServer(param1:* = null) : void;
   }
}
