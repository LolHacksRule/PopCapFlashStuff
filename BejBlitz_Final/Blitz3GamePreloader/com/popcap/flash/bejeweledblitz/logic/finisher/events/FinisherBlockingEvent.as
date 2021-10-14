package com.popcap.flash.bejeweledblitz.logic.finisher.events
{
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzEvent;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicDelegate;
   
   public class FinisherBlockingEvent implements IBlitzEvent, IBlitzLogicDelegate
   {
       
      
      private var completed:Boolean;
      
      private var hasDarkBG:Boolean;
      
      public function FinisherBlockingEvent(param1:Boolean)
      {
         super();
         this.completed = false;
         this.hasDarkBG = param1;
      }
      
      public function SetCompleted() : void
      {
         this.completed = true;
      }
      
      public function Init() : void
      {
      }
      
      public function Update(param1:Number) : void
      {
      }
      
      public function IsDone() : Boolean
      {
         return this.completed;
      }
      
      public function isDarkEnabled() : Boolean
      {
         return this.hasDarkBG;
      }
      
      public function Reset() : void
      {
      }
      
      public function ShouldDelayTimeUp() : Boolean
      {
         return !this.completed;
      }
   }
}
