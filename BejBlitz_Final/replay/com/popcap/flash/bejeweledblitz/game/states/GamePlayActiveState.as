package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.game.session.IBlitz3NetworkHandler;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class GamePlayActiveState extends Sprite implements IAppState, IBlitz3NetworkHandler
   {
      
      public static const IDLE_TIME:int = 175;
      
      public static const TIME_UP_TIME:int = 175;
       
      
      private var m_App:Blitz3Game;
      
      private var mTimer:int = 0;
      
      private var mTimerStarted:Boolean = false;
      
      private var mIsTimeUp:Boolean = false;
      
      private var mIsActive:Boolean = false;
      
      public function GamePlayActiveState(app:Blitz3Game)
      {
         super();
         this.m_App = app;
         app.network.AddHandler(this);
      }
      
      public function Reset() : void
      {
         this.mTimerStarted = false;
         this.mIsTimeUp = false;
      }
      
      public function IsActive() : Boolean
      {
         return this.mIsActive;
      }
      
      public function update() : void
      {
         if(!this.m_App.logic.isActive && !this.m_App.tutorial.IsEnabled())
         {
            this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_VOICE_GO);
            this.m_App.ui.game.board.broadcast.PlayGo();
         }
         this.m_App.logic.isActive = true;
         try
         {
            this.m_App.logic.Update();
            this.m_App.tutorial.Update();
            if(Blitz3Game.AUTOPLAY)
            {
               this.m_App.tester.Update();
            }
         }
         catch(err:Error)
         {
            trace(err.getStackTrace());
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
         this.mIsActive = true;
         if(!this.mTimerStarted)
         {
            this.mTimer = IDLE_TIME;
            this.mTimerStarted = true;
         }
         this.m_App.logic.Resume();
         (this.m_App.ui as MainWidgetGame).PlayMode(true);
         this.m_App.leaderboard.isActive = false;
         this.m_App.friendscore.isActive = false;
      }
      
      public function onExit() : void
      {
         this.mIsActive = false;
         (this.m_App.ui as MainWidgetGame).PlayMode(false);
         this.m_App.leaderboard.isActive = true;
         this.m_App.friendscore.isActive = true;
      }
      
      public function onKeyUp(keyCode:int) : void
      {
      }
      
      public function onKeyDown(keyCode:int) : void
      {
      }
      
      public function HandleNetworkError() : void
      {
      }
      
      public function HandleNetworkSuccess(response:XML) : void
      {
      }
      
      public function HandleBuyCoinsCallback(success:Boolean) : void
      {
      }
      
      public function HandleExternalPause(isPaused:Boolean) : void
      {
         if(this.mIsActive)
         {
            this.SetPaused(isPaused);
         }
      }
      
      public function HandleCartClosed(coinsPurchased:Boolean) : void
      {
      }
      
      public function HandleNetworkGameStart() : void
      {
      }
      
      private function SetPaused(isPaused:Boolean) : void
      {
         if(isPaused)
         {
            dispatchEvent(new Event(GamePlayState.SIGNAL_GAME_PLAY_PAUSE));
         }
         else
         {
            dispatchEvent(new Event(GamePlayState.SIGNAL_GAME_PLAY_RESUME));
         }
      }
   }
}
