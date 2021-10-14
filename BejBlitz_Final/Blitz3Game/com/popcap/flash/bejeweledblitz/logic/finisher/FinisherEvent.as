package com.popcap.flash.bejeweledblitz.logic.finisher
{
   import com.popcap.flash.bejeweledblitz.logic.finisher.config.IFinisherConfig;
   import com.popcap.flash.bejeweledblitz.logic.finisher.events.FinisherBlockingEvent;
   import com.popcap.flash.bejeweledblitz.logic.finisher.interfaces.IFinisherUI;
   import com.popcap.flash.bejeweledblitz.logic.finisher.states.FinisherConfirmationState;
   import com.popcap.flash.bejeweledblitz.logic.finisher.states.FinisherEndState;
   import com.popcap.flash.bejeweledblitz.logic.finisher.states.FinisherIntroState;
   import com.popcap.flash.bejeweledblitz.logic.finisher.states.FinisherPlayState;
   import com.popcap.flash.bejeweledblitz.logic.finisher.states.FinisherShowState;
   import com.popcap.flash.bejeweledblitz.logic.finisher.states.FinisherWaitState;
   import com.popcap.flash.bejeweledblitz.logic.finisher.states.IFinisherState;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzEvent;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicDelegate;
   
   public class FinisherEvent implements IBlitzEvent, IBlitzLogicDelegate
   {
       
      
      private var logic:BlitzLogic = null;
      
      private var states:Vector.<IFinisherState>;
      
      private var currentState:Number;
      
      private var blockingEvent:FinisherBlockingEvent = null;
      
      private var finisherUIInterface:IFinisherUI = null;
      
      private var IsEverythingDone:Boolean = false;
      
      private var startState:int;
      
      private var endOverallFinisher:Function = null;
      
      public function FinisherEvent(param1:IFinisherUI, param2:BlitzLogic, param3:IFinisherConfig)
      {
         super();
         this.finisherUIInterface = param1;
         this.logic = param2;
         this.blockingEvent = new FinisherBlockingEvent(false);
         this.states = new Vector.<IFinisherState>();
         this.states.push(new FinisherIntroState(this.finisherUIInterface,param2));
         this.states.push(new FinisherConfirmationState(this.finisherUIInterface,param2,this.blockingEvent,param3));
         this.states.push(new FinisherWaitState(this.finisherUIInterface,param2,this.blockingEvent,param3.GetExtraTime()));
         this.states.push(new FinisherShowState(this.finisherUIInterface,param2));
         this.states.push(new FinisherPlayState(this.finisherUIInterface,param2,param3));
         this.states.push(new FinisherEndState(param2));
         this.currentState = 0;
         this.startState = 0;
         this.logic.AddDelegate(this);
      }
      
      public function SetEndCallback(param1:Function) : void
      {
         this.endOverallFinisher = param1;
      }
      
      public function SetStartState(param1:String) : void
      {
         var _loc4_:IFinisherState = null;
         var _loc2_:int = this.states.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if((_loc4_ = this.states[_loc3_]).GetName() == param1)
            {
               this.startState = _loc3_;
               break;
            }
            _loc3_++;
         }
      }
      
      public function Start() : void
      {
         this.InitilizeCurrentState();
      }
      
      public function Reset() : void
      {
         this.EndCurrentState();
         this.logic.RemoveDelegate(this);
         this.finisherUIInterface.RemoveAsIndicatorHandler();
      }
      
      public function Init() : void
      {
         this.currentState = this.startState;
         this.Start();
      }
      
      public function Update(param1:Number) : void
      {
         var _loc2_:IFinisherState = this.GetCurrentState();
         if(!this.IsEverythingDone && _loc2_ == null)
         {
            this.IsEverythingDone = true;
            return;
         }
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.Update(param1);
         if(_loc2_.IsStateCancelled())
         {
            this.EndCurrentState();
            this.GoToEndState();
            this.InitilizeCurrentState();
         }
         if(_loc2_.IsStateCompleted())
         {
            this.EndCurrentState();
            this.IncrementState();
            this.InitilizeCurrentState();
         }
      }
      
      public function IsDone() : Boolean
      {
         return this.IsEverythingDone;
      }
      
      public function isDarkEnabled() : Boolean
      {
         return false;
      }
      
      private function GetCurrentState() : IFinisherState
      {
         if(this.currentState >= this.states.length)
         {
            return null;
         }
         return this.states[this.currentState];
      }
      
      private function EndCurrentState() : void
      {
         var _loc1_:IFinisherState = this.GetCurrentState();
         if(_loc1_ != null)
         {
            _loc1_.CleanUp();
         }
      }
      
      private function IncrementState() : void
      {
         ++this.currentState;
      }
      
      private function GoToEndState() : void
      {
         this.currentState = this.states.length - 1;
      }
      
      private function InitilizeCurrentState() : void
      {
         var _loc1_:IFinisherState = this.GetCurrentState();
         if(_loc1_ != null)
         {
            _loc1_.Activate();
         }
         else if(this.endOverallFinisher != null)
         {
            this.endOverallFinisher.call();
         }
      }
      
      public function ShouldDelayTimeUp() : Boolean
      {
         return !this.IsDone();
      }
   }
}
