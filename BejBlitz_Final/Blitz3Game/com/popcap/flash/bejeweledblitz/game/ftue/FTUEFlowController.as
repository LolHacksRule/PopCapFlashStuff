package com.popcap.flash.bejeweledblitz.game.ftue
{
   import com.popcap.flash.bejeweledblitz.BJBDataEvent;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ftue.impl.FTUEEvents;
   import com.popcap.flash.bejeweledblitz.game.ftue.impl.FTUEFlow;
   import com.popcap.flash.bejeweledblitz.game.ftue.impl.FTUEStep;
   
   public class FTUEFlowController
   {
      
      private static var STEP_STATE_ENUM_VALUES:int = -1;
      
      private static const START:int = STEP_STATE_ENUM_VALUES + 1;
      
      private static const WAIT_FOR_TRIGGER:int = STEP_STATE_ENUM_VALUES + 2;
      
      private static const WAIT_FOR_NODE_TOUCH:int = STEP_STATE_ENUM_VALUES + 3;
      
      private static const WAIT_FOR_MESSAGE_NODE_TOUCH:int = STEP_STATE_ENUM_VALUES + 4;
      
      private static const WAIT_FOR_CUSTOM_STEP_END:int = STEP_STATE_ENUM_VALUES + 5;
      
      private static const WAIT_FOR_END_TRIGGER:int = STEP_STATE_ENUM_VALUES + 6;
      
      private static const WAIT_FOR_FIRST_TRIGGER:int = STEP_STATE_ENUM_VALUES + 7;
      
      private static const DONE:int = STEP_STATE_ENUM_VALUES + 8;
       
      
      private var _app:Blitz3App;
      
      private var _currentFlow:FTUEFlow;
      
      private var _stepState:int;
      
      public function FTUEFlowController(param1:Blitz3App)
      {
         super();
         this._app = param1;
         this._currentFlow = null;
      }
      
      public function StartFlow(param1:FTUEFlow, param2:Boolean = false) : void
      {
         this._currentFlow = param1;
         this._currentFlow.resetCurrentStepId();
         var _loc3_:Function = this._currentFlow.GetSetupFlowRunnable();
         if(_loc3_ != null)
         {
            _loc3_();
         }
         this.processInitialStep(param2);
      }
      
      public function StartNonBlockingFlow(param1:FTUEFlow) : void
      {
         this._currentFlow = param1;
         this._currentFlow.resetCurrentStepId();
         this.RunStepTriggerSequence(true);
      }
      
      public function OnFTUEViewLoaded() : void
      {
      }
      
      public function HandleMessage(param1:BJBDataEvent) : void
      {
         var _loc2_:String = param1 != null ? param1["type"] : "";
         if(this._stepState == WAIT_FOR_FIRST_TRIGGER && this._currentFlow != null && _loc2_ == this._currentFlow.getStep().getFirstTriggerStartMessage())
         {
            this.RunStepTriggerSequence(true);
         }
         else if(this._stepState == WAIT_FOR_TRIGGER && this._currentFlow != null && _loc2_ == this._currentFlow.getStep().getTriggerStartMessage())
         {
            this.RunStepTriggerSequence();
         }
         else if(_loc2_ == FTUEEvents.FTUE_STEP_END && this._stepState == WAIT_FOR_CUSTOM_STEP_END)
         {
            this.RunStepExitSequence();
         }
         else if(this._stepState == WAIT_FOR_END_TRIGGER && this._currentFlow != null && _loc2_ == this._currentFlow.getStep().getBlockUntilMessageId())
         {
            this.RunStepExitSequence();
         }
      }
      
      private function processInitialStep(param1:Boolean) : void
      {
         var preReqfunc:Function = null;
         var func:Function = null;
         var isQueuedFlow:Boolean = param1;
         this._stepState = START;
         try
         {
            if(!isQueuedFlow && this._currentFlow.getStep().getFirstTriggerStartMessage() != "")
            {
               this._stepState = WAIT_FOR_FIRST_TRIGGER;
               this.startListeningToMessage(this._currentFlow.getStep().getFirstTriggerStartMessage());
            }
            else if(isQueuedFlow && this._currentFlow.getStep().getTriggerStartMessage() != "")
            {
               this._stepState = WAIT_FOR_FIRST_TRIGGER;
               this.startListeningToMessage(this._currentFlow.getStep().getTriggerStartMessage());
            }
            if(isQueuedFlow)
            {
               preReqfunc = this._currentFlow.getStep().getPreRequisitesRunnable();
               if(preReqfunc != null)
               {
                  preReqfunc();
               }
               if(this._currentFlow.IsPreRequisiteConditionMet())
               {
                  func = this._currentFlow.getStep().getPreRunnable();
                  if(func != null)
                  {
                     func();
                  }
               }
               else if(this._currentFlow.getStep().getFirstTriggerStartMessage() != "")
               {
                  this._stepState = WAIT_FOR_FIRST_TRIGGER;
                  this.startListeningToMessage(this._currentFlow.getStep().getFirstTriggerStartMessage());
               }
            }
            if(this._stepState != WAIT_FOR_FIRST_TRIGGER)
            {
               this.RunStepTriggerSequence(!isQueuedFlow);
            }
         }
         catch(e:Error)
         {
            throw new Error("crashed on ftueflow: " + _currentFlow.getFlowName() + _currentFlow.getNumberOfSteps());
         }
      }
      
      private function processStep() : void
      {
         this._stepState = START;
         if(this._currentFlow.getStep().getTriggerStartMessage() != "")
         {
            this._stepState = WAIT_FOR_TRIGGER;
            this.startListeningToMessage(this._currentFlow.getStep().getTriggerStartMessage());
         }
         var _loc1_:Function = this._currentFlow.getStep().getPreRunnable();
         if(_loc1_ != null)
         {
            _loc1_();
         }
         if(this._stepState != WAIT_FOR_TRIGGER)
         {
            this.RunStepTriggerSequence();
         }
      }
      
      private function reset(param1:Boolean = true) : void
      {
         this._currentFlow = null;
         if(param1)
         {
            this._app.sessionData.ftueManager.markCurrentFlowAsDone();
         }
      }
      
      private function setupNextStep() : void
      {
         if(!this._currentFlow.advanceStep())
         {
            this.reset();
         }
         else
         {
            this.processStep();
         }
      }
      
      private function startListeningToMessage(param1:String) : void
      {
         this._app.bjbEventDispatcher.addEventListener(param1,this.HandleMessage);
      }
      
      private function stopListeningToMessage(param1:String) : void
      {
         this._app.bjbEventDispatcher.removeEventListener(param1,this.HandleMessage);
      }
      
      private function RunStepTriggerSequence(param1:Boolean = false) : void
      {
         if(param1)
         {
            if(this._currentFlow.getStep().getFirstTriggerStartMessage() != "")
            {
               this.stopListeningToMessage(this._currentFlow.getStep().getFirstTriggerStartMessage());
            }
         }
         else if(this._currentFlow.getStep().getTriggerStartMessage() != "")
         {
            this.stopListeningToMessage(this._currentFlow.getStep().getTriggerStartMessage());
         }
         if(this._currentFlow.getStep().getBlockUntilUserAction() == FTUEStep.BLOCK_ON_MESSAGE_NODE_TAP)
         {
            this._stepState = WAIT_FOR_MESSAGE_NODE_TOUCH;
         }
         else if(this._currentFlow.getStep().getBlockUntilUserAction() == FTUEStep.BLOCK_ON_NODE_TAP)
         {
            this._stepState = WAIT_FOR_NODE_TOUCH;
         }
         else if(this._currentFlow.getStep().getBlockUntilUserAction() == FTUEStep.BLOCK_ON_CUSTOM_STEP_END_MESSAGE)
         {
            this._stepState = WAIT_FOR_CUSTOM_STEP_END;
            this.startListeningToMessage(FTUEEvents.FTUE_STEP_END);
         }
         else if(this._currentFlow.getStep().getBlockUntilUserAction() == FTUEStep.BLOCK_ON_BJB_MESSAGE && this._currentFlow.getStep().getBlockUntilMessageId() != "")
         {
            this._stepState = WAIT_FOR_END_TRIGGER;
            this.startListeningToMessage(this._currentFlow.getStep().getBlockUntilMessageId());
         }
         var _loc2_:Function = null;
         if(param1)
         {
            _loc2_ = this._currentFlow.getStep().getFirstTriggerRunnable();
            if(_loc2_ != null)
            {
               _loc2_();
            }
         }
         else
         {
            _loc2_ = this._currentFlow.getStep().getTriggerRunnable();
            if(_loc2_ != null)
            {
               _loc2_();
            }
         }
         if(this._currentFlow.getStep().getBlockUntilUserAction() == FTUEStep.FTUE_STEP_BLOCK_ON_NONE)
         {
            this.RunStepExitSequence();
         }
      }
      
      private function RunStepExitSequence() : void
      {
         var _loc1_:Function = this._currentFlow.getStep().getExitRunnable();
         if(_loc1_ != null)
         {
            _loc1_();
         }
         if(this._stepState == WAIT_FOR_CUSTOM_STEP_END)
         {
            this.stopListeningToMessage(FTUEEvents.FTUE_STEP_END);
         }
         this._stepState = DONE;
         this.setupNextStep();
      }
   }
}
