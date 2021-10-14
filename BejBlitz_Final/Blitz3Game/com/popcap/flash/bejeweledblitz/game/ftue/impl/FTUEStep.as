package com.popcap.flash.bejeweledblitz.game.ftue.impl
{
   public class FTUEStep
   {
      
      private static var FTUE_STEP_BLOCK_ON_ENUM_VALUES:int = -1;
      
      public static const BLOCK_ON_MESSAGE_NODE_TAP:int = FTUE_STEP_BLOCK_ON_ENUM_VALUES + 1;
      
      public static const BLOCK_ON_NODE_TAP:int = FTUE_STEP_BLOCK_ON_ENUM_VALUES + 2;
      
      public static const BLOCK_ON_CUSTOM_STEP_END_MESSAGE:int = FTUE_STEP_BLOCK_ON_ENUM_VALUES + 3;
      
      public static const BLOCK_ON_BJB_MESSAGE:int = FTUE_STEP_BLOCK_ON_ENUM_VALUES + 4;
      
      public static const FTUE_STEP_BLOCK_ON_NONE:int = FTUE_STEP_BLOCK_ON_ENUM_VALUES + 5;
       
      
      private var _firstStepTriggerMessageId:String;
      
      private var _firstStepTriggerRunnable:Function;
      
      private var _triggerMessageId:String;
      
      private var _blockUntilUserAction:int;
      
      private var _blockUntilMessageId:String;
      
      private var _triggerRunnable:Function;
      
      private var _exitRunnable:Function;
      
      private var _preRunnable:Function;
      
      private var _checkPreRequisitesRunnable:Function;
      
      public function FTUEStep(param1:String, param2:Function, param3:String, param4:int, param5:String, param6:Function, param7:Function, param8:Function, param9:Function)
      {
         super();
         this._firstStepTriggerMessageId = param1;
         this._firstStepTriggerRunnable = param2;
         this._triggerMessageId = param3;
         this._blockUntilUserAction = param4;
         this._blockUntilMessageId = param5;
         this._triggerRunnable = param6;
         this._exitRunnable = param7;
         this._preRunnable = param8;
         this._checkPreRequisitesRunnable = param9;
      }
      
      public function getFirstTriggerStartMessage() : String
      {
         return this._firstStepTriggerMessageId;
      }
      
      public function getFirstTriggerRunnable() : Function
      {
         return this._firstStepTriggerRunnable;
      }
      
      public function getTriggerStartMessage() : String
      {
         return this._triggerMessageId;
      }
      
      public function getBlockUntilUserAction() : int
      {
         return this._blockUntilUserAction;
      }
      
      public function getBlockUntilMessageId() : String
      {
         return this._blockUntilMessageId;
      }
      
      public function getTriggerRunnable() : Function
      {
         return this._triggerRunnable;
      }
      
      public function getExitRunnable() : Function
      {
         return this._exitRunnable;
      }
      
      public function getPreRunnable() : Function
      {
         return this._preRunnable;
      }
      
      public function getPreRequisitesRunnable() : Function
      {
         return this._checkPreRequisitesRunnable;
      }
   }
}
