package com.popcap.flash.bejeweledblitz
{
   import flash.events.Event;
   
   public class BJBDataEvent extends Event
   {
       
      
      public var data:Object;
      
      public function BJBDataEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.data = param2;
      }
      
      override public function clone() : Event
      {
         return new BJBDataEvent(type,this.data,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("BJBEvent","type","data","bubbles","cancelable");
      }
   }
}
