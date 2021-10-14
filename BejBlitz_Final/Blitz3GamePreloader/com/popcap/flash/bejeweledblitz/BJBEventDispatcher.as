package com.popcap.flash.bejeweledblitz
{
   import flash.events.EventDispatcher;
   
   public class BJBEventDispatcher extends EventDispatcher
   {
       
      
      public function BJBEventDispatcher()
      {
         super();
      }
      
      public function SendEvent(param1:String, param2:Object) : void
      {
         dispatchEvent(new BJBDataEvent(param1,param2,false,false));
      }
   }
}
