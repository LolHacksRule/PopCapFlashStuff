package com.popcap.flash.bejeweledblitz.game.finisher
{
   import com.popcap.flash.bejeweledblitz.Utils;
   
   public class FinisherGlobalProperties
   {
       
      
      private var triggerTime:uint = 0;
      
      public function FinisherGlobalProperties(param1:Object)
      {
         super();
         this.triggerTime = Utils.getUintFromObjectKey(param1,"triggerTime",this.triggerTime);
      }
      
      public function GetTriggerTime() : uint
      {
         return this.triggerTime;
      }
   }
}
