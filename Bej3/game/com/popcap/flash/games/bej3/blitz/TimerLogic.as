package com.popcap.flash.games.bej3.blitz
{
   import com.popcap.flash.games.blitz3.Blitz3App;
   
   public class TimerLogic
   {
       
      
      protected var m_App:Blitz3App;
      
      protected var m_Handlers:Vector.<ITimerLogicHandler>;
      
      protected var m_GameTime:int = 0;
      
      protected var m_GameDuration:int;
      
      protected var m_ExtraGameTime:int = 0;
      
      protected var m_FreezeTime:int = 0;
      
      protected var m_HasStarted:Boolean = false;
      
      protected var m_IsPaused:Boolean = false;
      
      protected var m_IsDone:Boolean = false;
      
      public function TimerLogic(app:Blitz3App)
      {
         this.m_GameDuration = BlitzLogic.BASE_GAME_DURATION;
         super();
         this.m_App = app;
         this.m_Handlers = new Vector.<ITimerLogicHandler>();
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
      }
      
      public function AddHandler(handler:ITimerLogicHandler) : void
      {
         this.m_Handlers.push(handler);
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
         this.m_IsDone = true;
      }
      
      public function DispatchTimePhaseBegin() : void
      {
         var handler:ITimerLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
         }
      }
      
      public function DispatchTimePhaseEnd() : void
      {
         var handler:ITimerLogicHandler = null;
         for each(var _loc4_ in this.m_Handlers)
         {
            handler = _loc4_;
            _loc4_;
         }
      }
      
      public function DispatchGameTimeChange() : void
      {
         var handler:ITimerLogicHandler = null;
         for each(var _loc4_ in this.m_Handlers)
         {
            handler = _loc4_;
            _loc4_;
         }
      }
      
      public function DispatchGameDurationChange() : void
      {
         var handler:ITimerLogicHandler = null;
         for each(var _loc4_ in this.m_Handlers)
         {
            handler = _loc4_;
            _loc4_;
         }
      }
   }
}
