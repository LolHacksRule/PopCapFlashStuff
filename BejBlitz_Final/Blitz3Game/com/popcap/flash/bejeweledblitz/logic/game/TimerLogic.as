package com.popcap.flash.bejeweledblitz.logic.game
{
   public class TimerLogic
   {
       
      
      private var _logic:BlitzLogic;
      
      private var _timeChangeHandlers:Vector.<ITimerLogicTimeChangeHandler>;
      
      private var _timePhaseEndHandlers:Vector.<ITimerLogicTimePhaseEndHandler>;
      
      private var _timeGameDurationChangeHandlers:Vector.<ITimerLogicTimeDurationChangeHandler>;
      
      private var m_GameTime:int;
      
      private var m_GameDuration:int;
      
      private var m_ExtraGameTime:int;
      
      private var m_HasStarted:Boolean;
      
      private var m_IsPaused:Boolean;
      
      private var m_IsDone:Boolean;
      
      private var _m_UITimer:int;
      
      public function TimerLogic(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
         this._timeChangeHandlers = new Vector.<ITimerLogicTimeChangeHandler>();
         this._timePhaseEndHandlers = new Vector.<ITimerLogicTimePhaseEndHandler>();
         this._timeGameDurationChangeHandlers = new Vector.<ITimerLogicTimeDurationChangeHandler>();
         this.m_GameTime = 0;
         this.m_UITimer = 0;
         this.m_GameDuration = this._logic.config.timerLogicBaseGameDuration;
         this.m_ExtraGameTime = 0;
         this.m_HasStarted = false;
         this.m_IsPaused = false;
         this.m_IsDone = false;
      }
      
      public function Init() : void
      {
         this.m_HasStarted = false;
         this.m_IsPaused = false;
         this.m_IsDone = false;
      }
      
      public function Reset() : void
      {
         this.m_HasStarted = false;
         this.m_IsPaused = false;
         this.m_IsDone = false;
         this.m_ExtraGameTime = 0;
         this.m_GameDuration = this._logic.config.timerLogicBaseGameDuration;
         this.m_UITimer = this._logic.config.timerLogicBaseGameDuration;
         this.SetGameTime(this.m_GameDuration);
      }
      
      public function Update() : void
      {
         if(this.m_IsPaused)
         {
            return;
         }
         if(this.m_GameTime > 0)
         {
            this.m_IsDone = false;
            --this.m_GameTime;
            if(this.m_GameTime <= 0)
            {
               if(this.m_ExtraGameTime > 0)
               {
                  this.m_GameTime += this.m_ExtraGameTime;
                  this.SetGameDuration(this.m_GameDuration + this.m_ExtraGameTime);
                  this.m_ExtraGameTime = 0;
               }
               else
               {
                  this.m_IsDone = true;
               }
            }
            this.DispatchGameTimeChange();
         }
         this.DispatchTimePhaseEnd();
      }
      
      public function AddTimeChangeHandler(param1:ITimerLogicTimeChangeHandler) : void
      {
         this._timeChangeHandlers.push(param1);
      }
      
      public function RemoveTimeChangeHandler(param1:ITimerLogicTimeChangeHandler) : void
      {
         var _loc2_:int = this._timeChangeHandlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._timeChangeHandlers.splice(_loc2_,1);
      }
      
      public function AddTimePhaseEndHandler(param1:ITimerLogicTimePhaseEndHandler) : void
      {
         this._timePhaseEndHandlers.push(param1);
      }
      
      public function RemoveTimePhaseEndHandler(param1:ITimerLogicTimePhaseEndHandler) : void
      {
         var _loc2_:int = this._timePhaseEndHandlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._timePhaseEndHandlers.splice(_loc2_,1);
      }
      
      public function AddGameDurationChangeHandler(param1:ITimerLogicTimeDurationChangeHandler) : void
      {
         this._timeGameDurationChangeHandlers.push(param1);
      }
      
      public function RemoveGameDurationChangeHandler(param1:ITimerLogicTimeDurationChangeHandler) : void
      {
         var _loc2_:int = this._timeGameDurationChangeHandlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._timeGameDurationChangeHandlers.splice(_loc2_,1);
      }
      
      public function SetGameDuration(param1:int) : void
      {
         var _loc2_:int = this.m_GameDuration;
         this.m_GameDuration = param1;
         if(this.m_GameDuration < this.m_GameTime)
         {
            this.SetGameTime(this.m_GameDuration);
         }
         this.DispatchGameDurationChange(_loc2_);
      }
      
      public function GetGameDuration() : int
      {
         return this.m_GameDuration;
      }
      
      public function GetTimeRemaining() : int
      {
         return this.m_GameTime;
      }
      
      public function GetTimeElapsed() : int
      {
         return this.m_GameDuration - this.m_GameTime;
      }
      
      public function getExtraGameTime() : int
      {
         return this.m_ExtraGameTime;
      }
      
      public function IsDone() : Boolean
      {
         return this.m_IsDone;
      }
      
      public function IsPaused() : Boolean
      {
         return this.m_IsPaused;
      }
      
      public function IsRunning() : Boolean
      {
         return !this.m_IsDone && this.m_GameTime > 0;
      }
      
      public function AddExtraTimeAtGameEnd(param1:int) : void
      {
         this.m_ExtraGameTime += param1;
      }
      
      public function AddExtraTimeDuringGame(param1:int, param2:Boolean = false) : void
      {
         this.m_GameTime += param1;
         if(param2)
         {
            this.DispatchGameDurationChange(param1);
         }
      }
      
      public function SetGameTime(param1:int) : void
      {
         this.m_GameTime = param1;
      }
      
      public function SetPaused(param1:Boolean) : void
      {
         this.m_IsPaused = param1;
      }
      
      public function ForceGameEnd() : void
      {
         this.m_GameTime = 0;
         this.m_ExtraGameTime = 0;
         this.m_IsDone = true;
      }
      
      private function DispatchTimePhaseEnd() : void
      {
         var _loc1_:ITimerLogicTimePhaseEndHandler = null;
         for each(_loc1_ in this._timePhaseEndHandlers)
         {
            _loc1_.HandleTimePhaseEnd();
         }
      }
      
      private function DispatchGameTimeChange() : void
      {
         var _loc1_:ITimerLogicTimeChangeHandler = null;
         for each(_loc1_ in this._timeChangeHandlers)
         {
            _loc1_.HandleGameTimeChange(this.m_GameTime);
         }
      }
      
      private function DispatchGameDurationChange(param1:int) : void
      {
         var _loc2_:ITimerLogicTimeDurationChangeHandler = null;
         for each(_loc2_ in this._timeGameDurationChangeHandlers)
         {
            _loc2_.HandleGameDurationChange(param1,this.m_GameDuration);
         }
      }
      
      public function get m_UITimer() : int
      {
         return this._m_UITimer;
      }
      
      public function set m_UITimer(param1:int) : void
      {
         this._m_UITimer = param1;
      }
   }
}
