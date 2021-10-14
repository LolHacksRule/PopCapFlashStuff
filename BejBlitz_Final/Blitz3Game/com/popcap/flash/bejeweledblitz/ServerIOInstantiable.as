package com.popcap.flash.bejeweledblitz
{
   public class ServerIOInstantiable implements IServerIO
   {
      
      private static var instance:ServerIOInstantiable;
      
      private static var instantiated:Boolean = false;
       
      
      public function ServerIOInstantiable()
      {
         super();
         if(instantiated)
         {
            throw new Error("ServerIOInstantiable already instantiated");
         }
         instantiated = true;
      }
      
      public static function getInstance() : ServerIOInstantiable
      {
         if(!instance)
         {
            instance = new ServerIOInstantiable();
         }
         return instance;
      }
      
      public function registerCallback(param1:String, param2:Function, param3:* = null) : void
      {
         ServerIO.registerCallback(param1,param2,param3);
      }
      
      public function sendToServer(param1:String, param2:Object = null, param3:Object = null) : void
      {
         ServerIO.sendToServer(param1,param2,param3);
      }
      
      public function cheatReceiveFromServer(param1:Object) : void
      {
         ServerIO.cheatReceiveFromServer(param1);
      }
      
      public function testReceiveFromServer(param1:* = null) : void
      {
         ServerIO.testReceiveFromServer(param1);
      }
   }
}
