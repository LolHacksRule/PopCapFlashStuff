package com.popcap.flash.bejeweledblitz.replay.states
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class GamePlayStartState extends Sprite implements IAppState
   {
      
      public static const START_TIME:int = 250;
       
      
      private var m_App:Blitz3App;
      
      private var mTimer:int = 0;
      
      public function GamePlayStartState(app:Blitz3App)
      {
         super();
         this.m_App = app;
      }
      
      public function Reset() : void
      {
         this.m_App.ui.background.Reset();
         this.m_App.ui.game.Reset();
         this.mTimer = START_TIME;
         this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_VOICE_ONE_MINUTE);
      }
      
      public function update() : void
      {
         this.m_App.logic.isActive = false;
         try
         {
            this.m_App.logic.Update();
         }
         catch(err:Error)
         {
            trace(err.getStackTrace());
            m_App.logic.hadReplayError = true;
         }
         --this.mTimer;
         if(this.mTimer == 0)
         {
            dispatchEvent(new Event(GamePlayState.SIGNAL_GAME_PLAY_START));
         }
      }
      
      public function draw(elapsed:int) : void
      {
      }
      
      public function onEnter() : void
      {
      }
      
      public function onExit() : void
      {
      }
      
      public function onKeyUp(keyCode:int) : void
      {
      }
      
      public function onKeyDown(keyCode:int) : void
      {
      }
   }
}
