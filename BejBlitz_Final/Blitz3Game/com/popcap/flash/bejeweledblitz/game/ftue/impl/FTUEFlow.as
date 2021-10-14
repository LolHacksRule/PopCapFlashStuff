package com.popcap.flash.bejeweledblitz.game.ftue.impl
{
   public class FTUEFlow
   {
      
      private static var CUSTOM_STEPS_ENUM_VALUES:int = -1;
      
      public static const DISABLE_FTUE_SCRIM:int = CUSTOM_STEPS_ENUM_VALUES + 1;
      
      public static const ENABLE_FTUE_SCRIM:int = CUSTOM_STEPS_ENUM_VALUES + 2;
      
      public static const SET_TRANSPARENT_SCRIM:int = CUSTOM_STEPS_ENUM_VALUES + 3;
       
      
      private var _flowName:String;
      
      private var _currentStepId:int;
      
      private var _steps:Vector.<FTUEStep>;
      
      private var _isBlocking:Boolean;
      
      private var _requiredFlowIdComplete:int;
      
      private var _flowId:int;
      
      private var _preRequisiteConditionsMet:Boolean;
      
      private var _setupFlowRunnable:Function;
      
      public function FTUEFlow(param1:String, param2:int)
      {
         super();
         this._flowName = param1;
         this._flowId = param2;
         this._steps = new Vector.<FTUEStep>();
         this._isBlocking = true;
         this._requiredFlowIdComplete = -1;
         this._preRequisiteConditionsMet = true;
         this._setupFlowRunnable = null;
      }
      
      public function SetContextualFlowParams(param1:int) : void
      {
         this._isBlocking = false;
         this._requiredFlowIdComplete = param1;
      }
      
      public function AddStepHelper(param1:Function, param2:Function, param3:String, param4:Function, param5:String, param6:Function, param7:int, param8:String, param9:Function) : void
      {
         var _loc10_:FTUEStep = new FTUEStep(param3,param4,param5,param7,param8,param6,param9,param2,param1);
         this._steps.push(_loc10_);
      }
      
      public function AddStepHelperByStepType(param1:int, param2:String = "") : void
      {
      }
      
      public function AddSetupFlowRunnable(param1:Function) : void
      {
         this._setupFlowRunnable = param1;
      }
      
      public function getStep() : FTUEStep
      {
         if(this._currentStepId < this._steps.length)
         {
            return this._steps[this._currentStepId];
         }
         return null;
      }
      
      public function advanceStep() : Boolean
      {
         var _loc1_:Boolean = true;
         if(++this._currentStepId >= this._steps.length)
         {
            _loc1_ = false;
         }
         return _loc1_;
      }
      
      public function getFlowName() : String
      {
         return this._flowName;
      }
      
      public function getNumberOfSteps() : int
      {
         return this._steps.length;
      }
      
      public function resetCurrentStepId() : void
      {
         this._currentStepId = 0;
      }
      
      public function IsBlocking() : Boolean
      {
         return this._isBlocking;
      }
      
      public function GetRequiredFlowId() : int
      {
         return this._requiredFlowIdComplete;
      }
      
      public function GetFlowId() : int
      {
         return this._flowId;
      }
      
      public function IsPreRequisiteConditionMet() : Boolean
      {
         return this._preRequisiteConditionsMet;
      }
      
      public function SetPreRequisiteConditionMet(param1:Boolean) : void
      {
         this._preRequisiteConditionsMet = param1;
      }
      
      public function GetSetupFlowRunnable() : Function
      {
         return this._setupFlowRunnable;
      }
   }
}
