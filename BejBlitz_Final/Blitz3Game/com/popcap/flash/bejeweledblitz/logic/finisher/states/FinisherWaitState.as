package com.popcap.flash.bejeweledblitz.logic.finisher.states
{
   import com.popcap.flash.bejeweledblitz.logic.finisher.events.FinisherBlockingEvent;
   import com.popcap.flash.bejeweledblitz.logic.finisher.interfaces.IFinisherUI;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.ITimerLogicTimeChangeHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ITimerLogicTimePhaseEndHandler;
   
   public class FinisherWaitState implements IFinisherState, ITimerLogicTimeChangeHandler, ITimerLogicTimePhaseEndHandler
   {
      
      private static const _clockVisibleTime:Number = 250;
      
      private static const _goVisibleTime:Number = 150;
       
      
      private var waitInterval:int;
      
      private var currentTime:Number;
      
      private var logic:BlitzLogic;
      
      private var blockingEvent:FinisherBlockingEvent;
      
      private var _clockVisibleTimer:int = 0;
      
      private var _goVisibleTimer:int = 0;
      
      private var gameTimeHasCompleted:Boolean = false;
      
      private var gamePhaseHasCompleted:Boolean = false;
      
      private var finisherInterface:IFinisherUI;
      
      public function FinisherWaitState(param1:IFinisherUI, param2:BlitzLogic, param3:FinisherBlockingEvent, param4:int)
      {
         super();
         this.finisherInterface = param1;
         this.logic = param2;
         this.waitInterval = param4;
         this.currentTime = 0;
         this.blockingEvent = param3;
      }
      
      public static function GetStateName() : String
      {
         return "FinisherWaitState";
      }
      
      public function Activate() : void
      {
         this.finisherInterface.AddAsIndicatorHandler();
         this._clockVisibleTimer = _clockVisibleTime;
      }
      
      public function IsStateCompleted() : Boolean
      {
         return this.gameTimeHasCompleted && this.gamePhaseHasCompleted && !this.finisherInterface.ShouldBlockWaitState();
      }
      
      public function IsStateCancelled() : Boolean
      {
         return false;
      }
      
      public function CleanUp() : void
      {
         this.blockingEvent.SetCompleted();
         this.finisherInterface.enableTimeUpSound();
         this.logic.timerLogic.RemoveTimeChangeHandler(this);
         this.logic.timerLogic.RemoveTimePhaseEndHandler(this);
      }
      
      public function Update(param1:Number) : void
      {
         this.currentTime += param1;
         if(this._clockVisibleTimer > 0)
         {
            if(this._clockVisibleTimer == _clockVisibleTime)
            {
               this.finisherInterface.showBonusTime(this.getMinutes(),this.getSeconds());
               this.blockingEvent.SetCompleted();
               this.addAndGetClockTime();
            }
            --this._clockVisibleTimer;
            if(this._clockVisibleTimer <= 0)
            {
               this._goVisibleTimer = _goVisibleTime;
            }
         }
         if(this._goVisibleTimer > 0)
         {
            if(this._goVisibleTimer == _goVisibleTime)
            {
               this.finisherInterface.showGo();
            }
            --this._goVisibleTimer;
            if(this._goVisibleTimer <= 0)
            {
               this.logic.blazingSpeedLogic.UnblockPendingAnimation();
            }
         }
      }
      
      private function getMinutes() : int
      {
         var _loc1_:int = Math.floor(this.waitInterval * 0.01);
         return _loc1_ / 60;
      }
      
      private function getSeconds() : int
      {
         var _loc1_:int = Math.floor(this.waitInterval * 0.01);
         return _loc1_ % 60;
      }
      
      private function addAndGetClockTime() : void
      {
         this.logic.timerLogic.AddTimeChangeHandler(this);
         this.logic.timerLogic.AddTimePhaseEndHandler(this);
         this.logic.timerLogic.AddExtraTimeDuringGame(this.waitInterval,true);
         this.finisherInterface.disableTimeUpSound();
      }
      
      public function HandleGameTimeChange(param1:int) : void
      {
         if(this.gameTimeHasCompleted)
         {
            return;
         }
         if(param1 == 0)
         {
            this.gameTimeHasCompleted = true;
         }
      }
      
      public function HandleTimePhaseEnd() : void
      {
         if(this.gamePhaseHasCompleted)
         {
            return;
         }
         this.gamePhaseHasCompleted = true;
      }
      
      public function GetName() : String
      {
         return FinisherWaitState.GetStateName();
      }
   }
}
