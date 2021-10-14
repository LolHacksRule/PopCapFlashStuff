package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.Utils;
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
      
      private var m_IsGotoMainMenu:Boolean = false;
      
      public function GamePlayPausedState(param1:Blitz3Game)
      {
         super();
         this.m_App = param1;
         var _loc2_:MainWidgetGame = this.m_App.ui as MainWidgetGame;
         _loc2_.pause.AddHandler(this);
      }
      
      public function update() : void
      {
         var _loc1_:DisplayObject = (this.m_App.ui as MainWidgetGame).game.board.gemLayer;
         if(this.m_App.logic.timerLogic.IsPaused() && _loc1_.alpha > 0)
         {
            _loc1_.alpha -= FADE_TIME * 0.01;
         }
      }
      
      public function draw(param1:int) : void
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
         (this.m_App.ui as MainWidgetGame).game.board.gemLayer.alpha = 1;
         this.m_IsGotoMainMenu = false;
         this.m_App.logic.Resume();
         this.m_App.ui.stage.focus = this.m_App.ui.stage;
         this.m_IsActive = false;
         var _loc1_:MainWidgetGame = this.m_App.ui as MainWidgetGame;
         _loc1_.pause.Hide();
         _loc1_.menu.options.Hide();
      }
      
      public function set GotoMainMenu(param1:Boolean) : void
      {
         this.m_IsGotoMainMenu = param1;
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
         this.m_App.mainState.game.play.forceResume();
      }
      
      public function HandlePauseMenuResetClicked() : void
      {
         if(this.m_App.tutorial.IsActive())
         {
            return;
         }
         dispatchEvent(new Event(GamePlayState.SIGNAL_GAME_PLAY_QUIT));
      }
      
      public function HandlePauseMenuMainClicked() : void
      {
         Utils.log(this,"HandlePauseMenuMainClicked called.");
         if(this.m_App.tutorial.IsActive())
         {
            return;
         }
         dispatchEvent(new Event(GamePlayState.SIGNAL_GAME_PLAY_GOTO_MAIN));
      }
   }
}
