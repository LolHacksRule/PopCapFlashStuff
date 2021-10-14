package com.popcap.flash.bejeweledblitz.game.ui.options
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
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
      
      private var m_touchBar:Bitmap;
      
      private var m_Slider:Bitmap;
      
      private var m_StartX:int;
      
      private var m_EndX:int;
      
      private var m_IsMouseDown:Boolean;
      
      private var m_SliderWidth:Number;
      
      private var m_callBack:Function = null;
      
      public function SliderControlWidget(param1:Blitz3App)
      {
         super();
         this.m_App = param1;
         this.m_IsMouseDown = false;
         this.m_LeftCap = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_SLIDER_LEFT_CAP));
         this.m_RightCap = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_SLIDER_RIGHT_CAP));
         this.m_Bar = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_SLIDER_FILL));
         this.m_touchBar = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_SLIDER_FILL));
         this.m_Slider = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_SLIDER_BUTTON));
         this.m_LeftCap.pixelSnapping = PixelSnapping.ALWAYS;
         this.m_RightCap.pixelSnapping = PixelSnapping.ALWAYS;
         this.m_Bar.pixelSnapping = PixelSnapping.ALWAYS;
         this.m_touchBar.pixelSnapping = PixelSnapping.ALWAYS;
         this.m_Slider.pixelSnapping = PixelSnapping.ALWAYS;
         addChild(this.m_LeftCap);
         addChild(this.m_Bar);
         addChild(this.m_touchBar);
         addChild(this.m_Slider);
      }
      
      public function Init(param1:int) : void
      {
         this.m_SliderWidth = param1;
         this.m_LeftCap.y -= this.m_LeftCap.height >> 1;
         this.m_Bar.x += this.m_LeftCap.width;
         this.m_Bar.y -= this.m_Bar.height >> 1;
         this.m_touchBar.x = this.m_Bar.x;
         this.m_touchBar.y = this.m_Bar.y;
         this.m_touchBar.alpha = 0;
         this.m_StartX = this.m_LeftCap.x;
         this.m_EndX = this.m_SliderWidth - (this.m_Slider.width >> 1) - (this.m_RightCap.width >> 1);
         this.m_Slider.y -= this.m_Slider.height >> 1;
         this.m_touchBar.width = this.m_EndX - this.m_StartX;
         buttonMode = true;
         useHandCursor = true;
         this.OnValueChange();
         addEventListener(MouseEvent.MOUSE_DOWN,this.OnMouseDown);
      }
      
      public function SetValue(param1:Number) : void
      {
         param1 = param1 < 0 || param1 > 1 ? Number(1) : Number(param1);
         this.m_Bar.width = (this.m_EndX - this.m_StartX) * param1;
         this.m_Slider.x = (this.m_EndX - this.m_StartX) * param1;
      }
      
      public function GetValue() : Number
      {
         return (this.m_Slider.x - this.m_StartX) / (this.m_EndX - this.m_StartX);
      }
      
      private function OnValueChange() : void
      {
         if(this.m_callBack != null)
         {
            this.m_callBack();
         }
      }
      
      private function CheckSliderBounds(param1:Number) : Number
      {
         if(param1 < this.m_StartX)
         {
            return this.m_StartX;
         }
         if(param1 > this.m_EndX)
         {
            return this.m_EndX;
         }
         return param1;
      }
      
      private function OnMouseDown(param1:MouseEvent) : void
      {
         removeEventListener(MouseEvent.MOUSE_DOWN,this.OnMouseDown);
         addEventListener(MouseEvent.MOUSE_MOVE,this.OnMouseMove);
         addEventListener(MouseEvent.MOUSE_UP,this.OnMouseUp);
         addEventListener(Event.MOUSE_LEAVE,this.OnMouseUp);
         this.m_IsMouseDown = true;
         this.OnMouseMove(param1);
      }
      
      private function OnMouseMove(param1:MouseEvent) : void
      {
         if(!this.m_IsMouseDown)
         {
            return;
         }
         this.m_Bar.width = this.CheckSliderBounds(mouseX - this.m_Slider.width * 0.5);
         this.m_Slider.x = this.CheckSliderBounds(mouseX - this.m_Slider.width * 0.5);
      }
      
      private function OnMouseUp(param1:MouseEvent) : void
      {
         removeEventListener(MouseEvent.MOUSE_UP,this.OnMouseUp);
         removeEventListener(MouseEvent.MOUSE_MOVE,this.OnMouseMove);
         this.m_App.stage.removeEventListener(Event.MOUSE_LEAVE,this.OnMouseUp);
         addEventListener(MouseEvent.MOUSE_DOWN,this.OnMouseDown);
         if(!this.m_IsMouseDown)
         {
            return;
         }
         this.OnMouseMove(param1);
         this.OnValueChange();
         this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_BUTTON_RELEASE);
         this.m_IsMouseDown = false;
      }
      
      public function SetCallback(param1:Function) : void
      {
         this.m_callBack = param1;
      }
   }
}
