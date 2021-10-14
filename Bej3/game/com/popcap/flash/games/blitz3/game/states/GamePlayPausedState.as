package com.popcap.flash.games.blitz3.game.states
{
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.games.bej3.blitz.IBlitz3NetworkHandler;
   import com.popcap.flash.games.blitz3.ui.widgets.game.pause.IPauseMenuHandler;
   import com.popcap.flash.games.blitz3.ui.widgets.options.IOptionMenuHandler;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class GamePlayPausedState extends Sprite implements IAppState, IPauseMenuHandler, IOptionMenuHandler, IBlitz3NetworkHandler
   {
      
      public static const FADE_TIME:int = 25;
       
      
      private var mApp:Blitz3Game;
      
      private var m_IsActive:Boolean = false;
      
      public function GamePlayPausedState(app:Blitz3Game)
      {
         super();
         this.mApp = app;
         this.mApp.ui.pause.AddHandler(this);
         this.mApp.ui.options.AddHandler(this);
         app.network.AddHandler(this);
      }
      
      public function update() : void
      {
         var gemLayer:DisplayObject = this.mApp.ui.game.board.gemLayer;
         if(this.mApp.logic.timerLogic.IsPaused() && gemLayer.alpha > 0)
         {
            gemLayer.alpha -= FADE_TIME / 100;
         }
      }
      
      public function draw(elapsed:int) : void
      {
      }
      
      public function onEnter() : void
      {
         this.mApp.ui.options.Show();
         this.mApp.logic.Pause();
         this.m_IsActive = true;
         if(this.mApp.mAdAPI._isEnabled)
         {
            this.mApp.mAdAPI.PauseBroadcast();
         }
      }
      
      public function onExit() : void
      {
         this.mApp.ui.game.board.gemLayer.alpha = 1;
         this.mApp.logic.Resume();
         this.mApp.ui.stage.focus = this.mApp.ui.stage;
         this.m_IsActive = false;
         this.mApp.ui.pause.Hide();
         this.mApp.ui.options.Hide();
         if(this.mApp.mAdAPI._isEnabled)
         {
            this.mApp.mAdAPI.ResumeBroadcast();
         }
      }
      
      public function onPush() : void
      {
      }
      
      public function onPop() : void
      {
      }
      
      public function onMouseUp(x:Number, y:Number) : void
      {
      }
      
      public function onMouseDown(x:Number, y:Number) : void
      {
      }
      
      public function onMouseMove(x:Number, y:Number) : void
      {
      }
      
      public function onKeyUp(keyCode:int) : void
      {
      }
      
      public function onKeyDown(keyCode:int) : void
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
      
      public function HandleOptionMenuCloseClicked() : void
      {
         if(!this.m_IsActive)
         {
            return;
         }
         dispatchEvent(new Event(GamePlayState.SIGNAL_GAME_PLAY_RESUME));
      }
      
      public function HandleOptionMenuHelpClicked() : void
      {
         this.mApp.ui.help.backButton.visible = true;
         this.mApp.ui.help.continueButton.visible = false;
      }
      
      public function HandleOptionMenuResetClicked() : void
      {
      }
      
      public function HandleOptionMainMenuClicked() : void
      {
         this.mApp.m_menu.ReturnToMainMenu();
      }
      
      private function HandleSoundsOn(e:MouseEvent) : void
      {
         this.mApp.soundManager.mute();
      }
      
      private function HandleSoundsOff(e:MouseEvent) : void
      {
         this.mApp.soundManager.unmute();
      }
      
      private function HandleMainMenu(e:MouseEvent) : void
      {
         this.ShowConfirm();
      }
      
      private function HandleYes(e:MouseEvent) : void
      {
      }
      
      private function HandleNo(e:MouseEvent) : void
      {
         this.KillConfirm();
      }
      
      private function HandleHideHelp(e:Event) : void
      {
      }
      
      private function HandleMouseOver(e:Event) : void
      {
         this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_BUTTON_OVER);
      }
      
      private function HandleMouseDown(e:Event) : void
      {
         this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_BUTTON_PRESS);
      }
      
      private function HandleMouseUp(e:Event) : void
      {
         this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_BUTTON_release);
      }
      
      private function ShowConfirm() : void
      {
      }
      
      private function KillConfirm() : void
      {
      }
      
      private function ToggleButtons(enabled:Boolean) : void
      {
      }
      
      public function HandleNetworkError() : void
      {
      }
      
      public function HandleNetworkSuccess() : void
      {
      }
      
      public function HandleBuyCoinsCallback(success:Boolean) : void
      {
      }
      
      public function HandleExternalPause(isPaused:Boolean) : void
      {
         if(!this.m_IsActive)
         {
            return;
         }
         if(isPaused)
         {
            trace("Dispatching pause event");
            dispatchEvent(new Event(GamePlayState.SIGNAL_GAME_PLAY_PAUSE));
         }
         else
         {
            trace("Dispatching game play resume event");
            dispatchEvent(new Event(GamePlayState.SIGNAL_GAME_PLAY_RESUME));
         }
      }
      
      public function HandleCartClosed(coinsPurchased:Boolean) : void
      {
      }
      
      public function HandleNetworkGameStart() : void
      {
      }
   }
}
