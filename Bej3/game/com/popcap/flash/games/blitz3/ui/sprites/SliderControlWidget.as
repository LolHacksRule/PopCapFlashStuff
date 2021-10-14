package com.popcap.flash.games.blitz3.ui.sprites
{
   import flash.display.Bitmap;
   import flash.display.PixelSnapping;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class SliderControlWidget extends Sprite
   {
      
      public static const ON_MOUSE_CLICK:String = "onMouseClick";
      
      public static const ON_MOUSE_release:String = "onMouseRelease";
      
      public static const ON_VALUE_CHANGE:String = "onValueChange";
       
      
      [Embed(source="/../resources/images/slider_widget/slider_bar_middle.png")]
      private var BAR_MIDDLE:Class;
      
      [Embed(source="/../resources/images/slider_widget/left_cap.png")]
      private var BAR_LEFT:Class;
      
      [Embed(source="/../resources/images/slider_widget/right_cap.png")]
      private var BAR_RIGHT:Class;
      
      [Embed(source="/../resources/images/slider_widget/slider.png")]
      private var BAR_SLIDER:Class;
      
      private var m_LeftCap:Bitmap;
      
      private var m_RightCap:Bitmap;
      
      private var m_Bar:Bitmap;
      
      private var m_Slider:Bitmap;
      
      private var m_StartX:int;
      
      private var m_EndX:int;
      
      private var m_ScaleFactor:Number;
      
      public function SliderControlWidget()
      {
         this.BAR_MIDDLE = SliderControlWidget_BAR_MIDDLE;
         this.BAR_LEFT = SliderControlWidget_BAR_LEFT;
         this.BAR_RIGHT = SliderControlWidget_BAR_RIGHT;
         this.BAR_SLIDER = SliderControlWidget_BAR_SLIDER;
         super();
         this.m_LeftCap = new this.BAR_LEFT();
         this.m_RightCap = new this.BAR_RIGHT();
         this.m_Bar = new this.BAR_MIDDLE();
         this.m_Slider = new this.BAR_SLIDER();
         this.m_Slider.smoothing = true;
         this.m_LeftCap.pixelSnapping = PixelSnapping.ALWAYS;
         this.m_RightCap.pixelSnapping = PixelSnapping.ALWAYS;
         this.m_Bar.pixelSnapping = PixelSnapping.ALWAYS;
         this.m_Slider.pixelSnapping = PixelSnapping.ALWAYS;
         addChild(this.m_LeftCap);
         addChild(this.m_Bar);
         addChild(this.m_RightCap);
         addChild(this.m_Slider);
      }
      
      public function Init(width:int, initialVal:Number = 1, scaleFactor:Number = 1) : void
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
         this.SetValue(initialVal);
         this.m_ScaleFactor = scaleFactor;
         addEventListener(MouseEvent.MOUSE_DOWN,this.OnMouseDown);
      }
      
      public function SetValue(val:Number) : void
      {
         val = val < 0 || val > 1 ? Number(1) : Number(val);
         this.m_Slider.x = (this.m_EndX - this.m_StartX) * val;
      }
      
      public function GetValue() : Number
      {
         return this.m_ScaleFactor * (this.m_Slider.x - this.m_StartX) / (this.m_EndX - this.m_StartX);
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
      
      public function OnMouseDown(e:MouseEvent) : void
      {
         removeEventListener(MouseEvent.MOUSE_DOWN,this.OnMouseDown);
         dispatchEvent(new Event(ON_MOUSE_CLICK));
      }
      
      public function OnMouseMove(e:MouseEvent) : void
      {
         this.m_Slider.x = this.CheckSliderBounds(e.stageX - this.x - (this.m_Slider.width >> 1));
         dispatchEvent(new Event(ON_VALUE_CHANGE));
      }
      
      public function OnMouseUp(e:MouseEvent) : void
      {
         addEventListener(MouseEvent.MOUSE_DOWN,this.OnMouseDown);
         dispatchEvent(new Event(ON_MOUSE_release));
      }
   }
}
