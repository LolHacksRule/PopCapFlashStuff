package com.popcap.flash.bejeweledblitz.replay.states
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class GamePlayActiveState extends Sprite implements IAppState
   {
      
      public static const IDLE_TIME:int = 175;
      
      public static const TIME_UP_TIME:int = 175;
       
      
      private var m_App:Blitz3App;
      
      private var mTimer:int = 0;
      
      private var mTimerStarted:Boolean = false;
      
      private var mIsTimeUp:Boolean = false;
      
      public function GamePlayActiveState(app:Blitz3App)
      {
         super();
         this.m_App = app;
      }
      
      public function Reset() : void
      {
         this.mTimerStarted = false;
         this.mIsTimeUp = false;
      }
      
      public function update() : void
      {
         if(!this.m_App.logic.isActive)
         {
            this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_VOICE_GO);
            this.m_App.ui.game.board.broadcast.PlayGo();
         }
         if(this.m_App.logic.hadReplayError)
         {
            dispatchEvent(new Event(GamePlayState.SIGNAL_GAME_PLAY_ERROR));
            return;
         }
         this.m_App.logic.isActive = true;
         try
         {
            this.m_App.logic.Update();
         }
         catch(err:Error)
         {
            trace(err.getStackTrace());
            m_App.logic.hadReplayError = true;
         }
         if(this.m_App.logic.timerLogic.GetTimeRemaining() == 0 && this.mIsTimeUp == false)
         {
            this.mIsTimeUp = true;
            this.m_App.ui.game.board.broadcast.PlayTimeUp();
         }
         if(this.m_App.logic.timerLogic.GetTimeRemaining() == 0)
         {
            if(this.mTimer > 0)
            {
               --this.mTimer;
            }
         }
         if(this.m_App.logic.IsGameOver() && this.mTimer == 0)
         {
            dispatchEvent(new Event(GamePlayState.SIGNAL_GAME_PLAY_STOP));
            this.mTimerStarted = false;
         }
         this.m_App.ui.game.board.frame.Update();
      }
      
      public function draw(elapsed:int) : void
      {
         this.m_App.ui.game.board.frame.Draw();
      }
      
      public function onEnter() : void
      {
         if(!this.mTimerStarted)
         {
            this.mTimer = IDLE_TIME;
            this.mTimerStarted = true;
         }
         this.m_App.logic.Resume();
      }
      
      public function onExit() : void
      {
         this.m_App.logic.Pause();
      }
      
      public function onKeyUp(keyCode:int) : void
      {
      }
      
      public function onKeyDown(keyCode:int) : void
      {
      }
   }
}
