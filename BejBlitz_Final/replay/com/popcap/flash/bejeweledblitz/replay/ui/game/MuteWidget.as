package com.popcap.flash.bejeweledblitz.replay.ui.game
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.SkinButton;
   import com.popcap.flash.games.blitz3replay.resources.Blitz3ReplayImages;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MuteWidget extends Sprite
   {
       
      
      protected var m_App:Blitz3App;
      
      protected var m_ButtonMute:SkinButton;
      
      protected var m_ButtonUnmute:SkinButton;
      
      public function MuteWidget(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_ButtonMute = new SkinButton(app);
         this.m_ButtonMute.up.addChild(new Bitmap(app.ImageManager.getBitmapData(Blitz3ReplayImages.IMAGE_REPLAY_SOUND_ON)));
         this.m_ButtonMute.over.addChild(new Bitmap(app.ImageManager.getBitmapData(Blitz3ReplayImages.IMAGE_REPLAY_SOUND_ON_OVER)));
         this.m_ButtonMute.addEventListener(MouseEvent.CLICK,this.OnMuteClicked);
         this.m_ButtonUnmute = new SkinButton(app);
         this.m_ButtonUnmute.up.addChild(new Bitmap(app.ImageManager.getBitmapData(Blitz3ReplayImages.IMAGE_REPLAY_SOUND_OFF)));
         this.m_ButtonUnmute.over.addChild(new Bitmap(app.ImageManager.getBitmapData(Blitz3ReplayImages.IMAGE_REPLAY_SOUND_OFF_OVER)));
         this.m_ButtonUnmute.addEventListener(MouseEvent.CLICK,this.OnUnmuteClicked);
      }
      
      public function Init() : void
      {
         addChild(this.m_ButtonMute);
         addChild(this.m_ButtonUnmute);
         this.UpdateButtonState();
      }
      
      public function Reset() : void
      {
         this.UpdateButtonState();
      }
      
      protected function UpdateButtonState() : void
      {
         if(this.m_App.SoundManager.isMuted())
         {
            this.m_ButtonMute.visible = false;
            this.m_ButtonUnmute.visible = true;
         }
         else
         {
            this.m_ButtonMute.visible = true;
            this.m_ButtonUnmute.visible = false;
         }
      }
      
      protected function OnMuteClicked(event:MouseEvent) : void
      {
         this.m_App.sessionData.configManager.SetFlag(ConfigManager.FLAG_MUTE,true);
         this.m_App.sessionData.configManager.CommitChanges();
         this.m_App.SoundManager.mute();
         this.UpdateButtonState();
      }
      
      protected function OnUnmuteClicked(event:MouseEvent) : void
      {
         this.m_App.sessionData.configManager.SetFlag(ConfigManager.FLAG_MUTE,false);
         this.m_App.sessionData.configManager.CommitChanges();
         this.m_App.SoundManager.unmute();
         this.UpdateButtonState();
      }
   }
}
