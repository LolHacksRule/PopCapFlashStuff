package com.popcap.flash.bejeweledblitz.replay.ui.game
{
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.SkinButton;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import com.popcap.flash.games.blitz3replay.resources.Blitz3ReplayImages;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ReplayControlWidget extends Sprite implements IBlitzLogicHandler
   {
      
      public static const FFWD_SPEED:int = 2;
      
      public static const NORMAL_SPEED:int = 1;
       
      
      protected var m_App:Blitz3Replay;
      
      protected var m_IsFFWD:Boolean;
      
      protected var m_PlayButton:SkinButton;
      
      protected var m_PauseButton:SkinButton;
      
      protected var m_RestartButton:SkinButton;
      
      protected var m_FFWDButton:SkinButton;
      
      public function ReplayControlWidget(app:Blitz3Replay)
      {
         super();
         this.m_App = app;
         this.m_PlayButton = new SkinButton(this.m_App);
         this.m_PlayButton.over.addChild(new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3ReplayImages.IMAGE_REPLAY_PLAY_OVER)));
         this.m_PlayButton.up.addChild(new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3ReplayImages.IMAGE_REPLAY_PLAY)));
         this.m_PlayButton.addEventListener(MouseEvent.CLICK,this.OnPlayClicked);
         this.m_PauseButton = new SkinButton(this.m_App);
         this.m_PauseButton.over.addChild(new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3ReplayImages.IMAGE_REPLAY_PAUSE_OVER)));
         this.m_PauseButton.up.addChild(new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3ReplayImages.IMAGE_REPLAY_PAUSE)));
         this.m_PauseButton.addEventListener(MouseEvent.CLICK,this.OnPauseClicked);
         this.m_RestartButton = new SkinButton(this.m_App);
         this.m_RestartButton.over.addChild(new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3ReplayImages.IMAGE_REPLAY_RESTART_OVER)));
         this.m_RestartButton.up.addChild(new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3ReplayImages.IMAGE_REPLAY_RESTART)));
         this.m_RestartButton.addEventListener(MouseEvent.CLICK,this.OnRestartClicked);
         this.m_FFWDButton = new SkinButton(this.m_App);
         this.m_FFWDButton.over.addChild(new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3ReplayImages.IMAGE_REPLAY_FFWD_OVER)));
         this.m_FFWDButton.up.addChild(new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3ReplayImages.IMAGE_REPLAY_FFWD)));
         this.m_FFWDButton.addEventListener(MouseEvent.CLICK,this.OnFFWDClicked);
      }
      
      public function Init() : void
      {
         this.m_PlayButton.x = 76;
         this.m_PauseButton.x = this.m_PlayButton.x;
         this.m_PauseButton.y = this.m_PlayButton.y;
         this.m_FFWDButton.x = this.m_PlayButton.x + 40;
         addChild(this.m_RestartButton);
         addChild(this.m_FFWDButton);
         addChild(this.m_PlayButton);
         addChild(this.m_PauseButton);
         this.m_App.logic.AddHandler(this);
      }
      
      public function Reset() : void
      {
         this.m_PlayButton.visible = false;
         this.m_PauseButton.visible = true;
         this.m_IsFFWD = false;
         this.m_FFWDButton.StopPulsing();
      }
      
      public function HandleGameBegin() : void
      {
      }
      
      public function HandleGameEnd() : void
      {
         this.m_IsFFWD = false;
         this.m_FFWDButton.StopPulsing();
         this.m_FFWDButton.SetEnabled(false);
         this.m_PlayButton.SetEnabled(false);
         this.m_PauseButton.SetEnabled(false);
         this.m_App.updatesPerTick = NORMAL_SPEED;
      }
      
      public function HandleGameAbort() : void
      {
      }
      
      public function HandleGamePaused() : void
      {
         this.m_PlayButton.visible = true;
         this.m_PauseButton.visible = false;
      }
      
      public function HandleGameResumed() : void
      {
         this.m_PlayButton.visible = false;
         this.m_PauseButton.visible = true;
      }
      
      public function HandleScore(score:ScoreValue) : void
      {
      }
      
      protected function OnPlayClicked(event:MouseEvent) : void
      {
         this.m_App.mainState.game.play.Unpause();
      }
      
      protected function OnPauseClicked(event:MouseEvent) : void
      {
         this.m_App.mainState.game.play.Pause();
      }
      
      protected function OnRestartClicked(event:MouseEvent) : void
      {
         this.m_FFWDButton.SetEnabled(true);
         this.m_PlayButton.SetEnabled(true);
         this.m_PauseButton.SetEnabled(true);
         this.m_App.mainState.game.play.Pause();
         this.m_App.Reset();
      }
      
      protected function OnFFWDClicked(event:MouseEvent) : void
      {
         if(this.m_IsFFWD)
         {
            this.m_App.updatesPerTick = NORMAL_SPEED;
            this.m_FFWDButton.StopPulsing();
            this.m_IsFFWD = false;
         }
         else
         {
            this.m_App.updatesPerTick = FFWD_SPEED;
            this.m_FFWDButton.StartPulsing(int.MAX_VALUE);
            this.m_IsFFWD = true;
         }
      }
   }
}
