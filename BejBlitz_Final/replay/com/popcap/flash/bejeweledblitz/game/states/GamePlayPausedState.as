package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.pause.IPauseMenuHandler;
   import com.popcap.flash.framework.IAppState;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class GamePlayPausedState extends Sprite implements IAppState, IPauseMenuHandler
   {
      
      public static const FADE_TIME:int = 25;
       
      
      private var m_App:Blitz3Game;
      
      private var m_IsActive:Boolean = false;
      
      public function GamePlayPausedState(app:Blitz3Game)
      {
         super();
         this.m_App = app;
         var mainWidget:MainWidgetGame = this.m_App.ui as MainWidgetGame;
         mainWidget.pause.AddHandler(this);
      }
      
      public function update() : void
      {
         var gemLayer:DisplayObject = this.m_App.ui.game.board.gemLayer;
         if(this.m_App.logic.timerLogic.IsPaused() && gemLayer.alpha > 0)
         {
            gemLayer.alpha -= FADE_TIME * 0.01;
         }
      }
      
      public function draw(elapsed:int) : void
      {
      }
      
      public function onEnter() : void
      {
         (this.m_App.ui as MainWidgetGame).pause.Show();
         this.m_App.logic.Pause();
         this.m_IsActive = true;
      }
      
      public function onExit() : void
      {
         this.m_App.ui.game.board.gemLayer.alpha = 1;
         this.m_App.logic.Resume();
         this.m_App.ui.stage.focus = this.m_App.ui.stage;
         this.m_IsActive = false;
         var mainWidget:MainWidgetGame = this.m_App.ui as MainWidgetGame;
         mainWidget.pause.Hide();
         mainWidget.options.Hide();
      }
      
      public function onKeyUp(keyCode:int) : void
      {
      }
      
      public function onKeyDown(keyCode:int) : void
      {
      }
      
      public function HandlePauseMenuOpened() : void
      {
      }
      
      public function HandlePauseMenuCloseClicked() : void
      {
         if(!this.m_IsActive)
         {
            return;
         }
         dispatchEvent(new Event(GamePlayState.SIGNAL_GAME_PLAY_RESUME));
      }
      
      public function HandlePauseMenuResetClicked() : void
      {
         dispatchEvent(new Event(GamePlayState.SIGNAL_GAME_PLAY_QUIT));
      }
   }
}
