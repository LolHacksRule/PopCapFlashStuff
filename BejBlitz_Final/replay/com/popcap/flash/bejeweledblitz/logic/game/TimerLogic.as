package com.popcap.flash.bejeweledblitz.logic.game
{
   public class TimerLogic
   {
       
      
      private var m_Logic:BlitzLogic;
      
      private var m_Handlers:Vector.<ITimerLogicHandler>;
      
      private var m_GameTime:int;
      
      private var m_GameDuration:int;
      
      private var m_ExtraGameTime:int;
      
      private var m_FreezeTime:int;
      
      private var m_HasStarted:Boolean;
      
      private var m_IsPaused:Boolean;
      
      private var m_IsDone:Boolean;
      
      public function TimerLogic(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
         this.m_Handlers = new Vector.<ITimerLogicHandler>();
         this.m_GameTime = 0;
         this.m_GameDuration = BlitzLogic.BASE_GAME_DURATION;
         this.m_ExtraGameTime = 0;
         this.m_FreezeTime = 0;
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
         this.m_FreezeTime = 0;
         this.m_GameDuration = BlitzLogic.BASE_GAME_DURATION;
         this.m_GameTime = this.m_GameDuration;
      }
      
      public function Update() : void
      {
         if(this.m_IsPaused)
         {
            return;
         }
         this.DispatchTimePhaseBegin();
         if(this.m_GameTime > 0)
         {
            if(this.m_FreezeTime <= 0)
            {
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
            if(this.m_FreezeTime > 0)
            {
               --this.m_FreezeTime;
            }
         }
         this.DispatchTimePhaseEnd();
      }
      
      public function AddHandler(handler:ITimerLogicHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function SetGameDuration(duration:int) : void
      {
         var prevDuration:int = this.m_GameDuration;
         this.m_GameDuration = duration;
         if(this.m_GameDuration < this.m_GameTime)
         {
            this.m_GameTime = this.m_GameDuration;
         }
         this.DispatchGameDurationChange(prevDuration);
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
      
      public function AddExtraTime(extraTime:int) : void
      {
         this.m_ExtraGameTime += extraTime;
      }
      
      public function SetGameTime(time:int) : void
      {
         this.m_GameTime = time;
      }
      
      public function FreezeTime(duration:int) : void
      {
         this.m_FreezeTime = duration;
      }
      
      public function SetPaused(paused:Boolean) : void
      {
         this.m_IsPaused = paused;
      }
      
      public function ForceGameEnd() : void
      {
         this.m_GameTime = 0;
         this.m_ExtraGameTime = 0;
         this.m_IsDone = true;
      }
      
      private function DispatchTimePhaseBegin() : void
      {
         var handler:ITimerLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleTimePhaseBegin();
         }
      }
      
      private function DispatchTimePhaseEnd() : void
      {
         var handler:ITimerLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleTimePhaseEnd();
         }
      }
      
      private function DispatchGameTimeChange() : void
      {
         var handler:ITimerLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleGameTimeChange(this.m_GameTime);
         }
      }
      
      private function DispatchGameDurationChange(prevDuration:int) : void
      {
         var handler:ITimerLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleGameDurationChange(prevDuration,this.m_GameDuration);
         }
      }
   }
}
