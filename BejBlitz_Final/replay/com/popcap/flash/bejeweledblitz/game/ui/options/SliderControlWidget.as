package com.popcap.flash.bejeweledblitz.game.ui.options
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   import flash.display.PixelSnapping;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class SliderControlWidget extends Sprite
   {
       
      
      private var m_App:Blitz3App;
      
      private var m_LeftCap:Bitmap;
      
      private var m_RightCap:Bitmap;
      
      private var m_Bar:Bitmap;
      
      private var m_Slider:Bitmap;
      
      private var m_StartX:int;
      
      private var m_EndX:int;
      
      public function SliderControlWidget(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_LeftCap = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_SLIDER_LEFT_CAP));
         this.m_RightCap = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_SLIDER_RIGHT_CAP));
         this.m_Bar = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_SLIDER_FILL));
         this.m_Slider = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_SLIDER_BUTTON));
         this.m_LeftCap.pixelSnapping = PixelSnapping.ALWAYS;
         this.m_RightCap.pixelSnapping = PixelSnapping.ALWAYS;
         this.m_Bar.pixelSnapping = PixelSnapping.ALWAYS;
         this.m_Slider.pixelSnapping = PixelSnapping.ALWAYS;
         addChild(this.m_LeftCap);
         addChild(this.m_Bar);
         addChild(this.m_RightCap);
         addChild(this.m_Slider);
      }
      
      public function Init(width:int) : void
      {
         this.m_Bar.width = width - (this.m_LeftCap.width + this.m_RightCap.width);
         this.m_LeftCap.y -= this.m_LeftCap.height >> 1;
         this.m_Bar.x += this.m_LeftCap.width;
         this.m_Bar.y -= this.m_Bar.height >> 1;
         this.m_RightCap.x += this.m_LeftCap.width + this.m_Bar.width;
         this.m_RightCap.y -= this.m_RightCap.height >> 1;
         this.m_StartX = this.m_LeftCap.x;
         this.m_EndX = this.m_RightCap.x - (this.m_Slider.width >> 1) - (this.m_RightCap.width >> 1);
         this.m_Slider.y -= this.m_Slider.height >> 1;
         this.SetValue(this.m_App.sessionData.configManager.GetInt(ConfigManager.INT_VOLUME) * 0.01);
         buttonMode = true;
         useHandCursor = true;
         this.OnVolumeChange();
         addEventListener(MouseEvent.MOUSE_DOWN,this.OnMouseDown);
      }
      
      public function SetValue(val:Number) : void
      {
         val = val < 0 || val > 1 ? Number(1) : Number(val);
         this.m_Slider.x = (this.m_EndX - this.m_StartX) * val;
      }
      
      public function GetValue() : Number
      {
         return (this.m_Slider.x - this.m_StartX) / (this.m_EndX - this.m_StartX);
      }
      
      private function OnVolumeChange() : void
      {
         this.m_App.SoundManager.setVolume(this.GetValue());
      }
      
      private function CheckSliderBounds(xPos:Number) : Number
      {
         if(xPos < this.m_StartX)
         {
            return this.m_StartX;
         }
         if(xPos > this.m_EndX)
         {
            return this.m_EndX;
         }
         return xPos;
      }
      
      private function OnMouseDown(e:MouseEvent) : void
      {
         removeEventListener(MouseEvent.MOUSE_DOWN,this.OnMouseDown);
         addEventListener(MouseEvent.MOUSE_MOVE,this.OnMouseMove);
         addEventListener(MouseEvent.MOUSE_UP,this.OnMouseUp);
         this.m_App.stage.addEventListener(Event.MOUSE_LEAVE,this.OnMouseUp);
         this.OnMouseMove(e);
      }
      
      private function OnMouseMove(e:MouseEvent) : void
      {
         this.m_Slider.x = this.CheckSliderBounds(e.stageX - this.x - (this.m_Slider.width >> 1));
      }
      
      private function OnMouseUp(e:Event) : void
      {
         removeEventListener(MouseEvent.MOUSE_UP,this.OnMouseUp);
         removeEventListener(MouseEvent.MOUSE_MOVE,this.OnMouseMove);
         this.m_App.stage.removeEventListener(Event.MOUSE_LEAVE,this.OnMouseUp);
         addEventListener(MouseEvent.MOUSE_DOWN,this.OnMouseDown);
         this.OnVolumeChange();
         this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_BUTTON_RELEASE);
      }
   }
}
