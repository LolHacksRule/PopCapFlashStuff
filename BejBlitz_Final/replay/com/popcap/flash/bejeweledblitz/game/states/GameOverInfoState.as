package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.game.session.IBlitz3NetworkHandler;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.GameOverWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.IPostGameStatsHandler;
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class GameOverInfoState extends Sprite implements IAppState, IBlitz3NetworkHandler, IPostGameStatsHandler
   {
       
      
      protected var m_App:Blitz3Game;
      
      protected var m_IsShowing:Boolean = false;
      
      private var m_HasLoggedRareGemEvent:Boolean = false;
      
      private var m_HasBoughtCoins:Boolean = false;
      
      public function GameOverInfoState(app:Blitz3Game)
      {
         super();
         this.m_App = app;
         this.m_App.network.AddHandler(this);
         (this.m_App.ui as MainWidgetGame).gameOver.AddHandler(this);
         (this.m_App.ui as MainWidgetGame).gameOver.visible = false;
      }
      
      public function update() : void
      {
         (this.m_App.ui as MainWidgetGame).gameOver.Update();
      }
      
      public function draw(elapsed:int) : void
      {
      }
      
      public function onEnter() : void
      {
         this.m_App.network.HandleGameOver();
         this.m_HasLoggedRareGemEvent = false;
         this.m_HasBoughtCoins = false;
         (this.m_App.ui as MainWidgetGame).optionsButton.visible = true;
         this.ShowScreen();
      }
      
      public function onExit() : void
      {
         this.HideScreen();
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
         if(success)
         {
            this.m_HasBoughtCoins = true;
         }
      }
      
      public function HandleExternalPause(isPaused:Boolean) : void
      {
      }
      
      public function HandleCartClosed(coinsPurchased:Boolean) : void
      {
      }
      
      public function HandleNetworkGameStart() : void
      {
      }
      
      public function HandlePostGameContinueClicked() : void
      {
         dispatchEvent(new Event(GameOverState.SIGNAL_GAME_OVER_INFO_CONTINUE));
      }
      
      protected function HideScreen() : void
      {
         if(!this.m_IsShowing)
         {
            return;
         }
         var stats:GameOverWidget = (this.m_App.ui as MainWidgetGame).gameOver;
         stats.ResetButtonState();
         stats.visible = false;
         this.m_IsShowing = false;
      }
      
      protected function ShowScreen() : void
      {
         var stats:GameOverWidget = null;
         if(this.m_IsShowing)
         {
            return;
         }
         if(this.m_App.sessionData.userData.NewHighScore)
         {
            this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_VOICE_NEW_HIGH_SCORE);
         }
         stats = (this.m_App.ui as MainWidgetGame).gameOver;
         stats.visible = true;
         this.m_App.ui.game.board.visible = false;
         this.m_App.ui.game.sidebar.visible = false;
         stats.SetPowerGemCounts(this.m_App.logic.flameGemLogic.GetNumCreated(),this.m_App.logic.starGemLogic.GetNumDestroyed(),this.m_App.logic.hypercubeLogic.GetNumDestroyed());
         stats.SetScores(this.m_App.logic.scoreKeeper.scores,this.m_App.logic.timerLogic.GetGameDuration());
         stats.Reset();
         this.m_IsShowing = true;
      }
   }
}
