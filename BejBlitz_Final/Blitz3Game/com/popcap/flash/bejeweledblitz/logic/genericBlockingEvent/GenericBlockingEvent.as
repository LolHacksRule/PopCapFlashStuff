package com.popcap.flash.bejeweledblitz.logic.genericBlockingEvent
{
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzEvent;
   
   public class GenericBlockingEvent implements IBlitzEvent
   {
       
      
      private var _isDone:Boolean;
      
      public function GenericBlockingEvent()
      {
         super();
         this.Reset();
      }
      
      public function Init() : void
      {
      }
      
      public function Reset() : void
      {
         this._isDone = false;
      }
      
      public function Update(param1:Number) : void
      {
      }
      
      public function IsDone() : Boolean
      {
         return this._isDone;
      }
      
      public function SetDone() : void
      {
         this._isDone = true;
      }
      
      public function isDarkEnabled() : Boolean
      {
         return false;
      }
   }
}
