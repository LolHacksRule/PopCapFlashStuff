package com.popcap.flash.bejeweledblitz.logic.finisher
{
   import com.popcap.flash.bejeweledblitz.logic.finisher.interfaces.IFinisherIndicator;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   
   public class FinisherIndicatorLogic
   {
       
      
      private var _finisherIndicatorHandlers:Vector.<IFinisherIndicator>;
      
      private var _timer:Number = 0;
      
      private var _triggered:Boolean = false;
      
      private var _logic:BlitzLogic = null;
      
      private var _duration:Number = 0;
      
      public function FinisherIndicatorLogic(param1:BlitzLogic)
      {
         super();
         this._finisherIndicatorHandlers = new Vector.<IFinisherIndicator>();
         this._logic = param1;
      }
      
      public function AddIndicatorHandler(param1:IFinisherIndicator) : void
      {
         this._finisherIndicatorHandlers.push(param1);
      }
      
      public function RemoveIndicatorHandler(param1:IFinisherIndicator) : void
      {
         var _loc2_:int = this._finisherIndicatorHandlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._finisherIndicatorHandlers.splice(_loc2_,1);
      }
      
      public function Update() : void
      {
         if(!this._triggered)
         {
            return;
         }
         if(this._timer < 0)
         {
            this._triggered = false;
            this.DispatchFinisherIndicatorEnd();
            return;
         }
         --this._timer;
      }
      
      private function DispatchFinisherIndicatorBegin() : void
      {
         var _loc1_:IFinisherIndicator = null;
         for each(_loc1_ in this._finisherIndicatorHandlers)
         {
            _loc1_.HandleFinisherIndicatorBegin();
         }
      }
      
      private function DispatchFinisherIndicatorEnd() : void
      {
         var _loc1_:IFinisherIndicator = null;
         for each(_loc1_ in this._finisherIndicatorHandlers)
         {
            _loc1_.HandleFinisherIndicatorEnd();
         }
      }
      
      private function DispatchFinisherIndicatorReset() : void
      {
         var _loc1_:IFinisherIndicator = null;
         for each(_loc1_ in this._finisherIndicatorHandlers)
         {
            _loc1_.HandleFinisherIndicatorReset();
         }
      }
      
      private function DispatchFinisherIndicatorPercentChanged(param1:Number) : void
      {
         var _loc2_:IFinisherIndicator = null;
         for each(_loc2_ in this._finisherIndicatorHandlers)
         {
            _loc2_.HandleFinisherIndicatorPercentChanged(1);
         }
      }
      
      public function SetDuration(param1:Number) : void
      {
         this._duration = param1;
         this._timer = param1;
      }
      
      public function GetDuration() : Number
      {
         return this._duration;
      }
      
      public function GetTimeLeft() : Number
      {
         return this._timer;
      }
      
      public function Init() : void
      {
      }
      
      public function Reset() : void
      {
         this._triggered = false;
         this._timer = this._duration;
      }
      
      public function Start() : void
      {
         if(this._triggered)
         {
            return;
         }
         this.DispatchFinisherIndicatorBegin();
         this._triggered = true;
      }
      
      public function End() : void
      {
         if(!this._triggered)
         {
            return;
         }
         this.DispatchFinisherIndicatorEnd();
         this._triggered = false;
      }
   }
}
