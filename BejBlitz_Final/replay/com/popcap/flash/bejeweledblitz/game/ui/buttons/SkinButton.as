package com.popcap.flash.bejeweledblitz.game.ui.buttons
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   
   public class SkinButton extends Sprite
   {
      
      public static const DEFAULT_ALPHA_DECAY:Number = 0.05;
      
      public static const PULSE_SPEED:Number = 2.5 * 0.01;
      
      private static var FILTERS_EMPTY:Array = [];
      
      private static var FILTERS_DISABLED:Array = [new ColorMatrixFilter([0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0])];
       
      
      private var m_App:Blitz3App;
      
      public var alphaDecay:Number = 0.05;
      
      public var background:Sprite;
      
      public var up:Sprite;
      
      public var over:Sprite;
      
      private var m_OverAlpha:Number = 0.0;
      
      private var m_IsOver:Boolean = false;
      
      private var m_IsPulsing:Boolean = false;
      
      private var m_PulseTimer:int = 0;
      
      private var m_PulseSpeed:Number = 0.025;
      
      private var m_IsEnabled:Boolean = true;
      
      public function SkinButton(app:Blitz3App)
      {
         super();
         this.m_App = app;
         tabEnabled = false;
         tabChildren = false;
         mouseChildren = false;
         buttonMode = true;
         useHandCursor = true;
         this.background = new Sprite();
         this.up = new Sprite();
         this.over = new Sprite();
         this.over.alpha = 0;
         addChild(this.background);
         addChild(this.up);
         addChild(this.over);
         this.SetEnabled(true);
         addEventListener(Event.ENTER_FRAME,this.HandleFrame);
         addEventListener(MouseEvent.ROLL_OVER,this.HandleMouseOver);
         addEventListener(MouseEvent.ROLL_OUT,this.HandleMouseOut);
         addEventListener(MouseEvent.MOUSE_DOWN,this.HandleMouseDown);
         addEventListener(MouseEvent.MOUSE_UP,this.HandleMouseUp);
      }
      
      public function StartPulsing(pulseTime:int, speed:Number = 0.025) : void
      {
         this.m_IsPulsing = true;
         this.m_PulseTimer = pulseTime;
         this.m_PulseSpeed = speed;
      }
      
      public function StopPulsing() : void
      {
         this.m_IsPulsing = false;
      }
      
      public function IsPulsing() : Boolean
      {
         return this.m_IsPulsing;
      }
      
      public function IsEnabled() : Boolean
      {
         return this.m_IsEnabled;
      }
      
      public function SetEnabled(enabled:Boolean) : void
      {
         this.m_IsEnabled = enabled;
         mouseEnabled = this.m_IsEnabled;
         mouseChildren = this.m_IsEnabled;
         buttonMode = this.m_IsEnabled;
         useHandCursor = this.m_IsEnabled;
         if(this.background)
         {
            this.background.filters = !!this.m_IsEnabled ? FILTERS_EMPTY : FILTERS_DISABLED;
         }
         if(this.over)
         {
            this.over.filters = !!this.m_IsEnabled ? FILTERS_EMPTY : FILTERS_DISABLED;
         }
         if(this.up)
         {
            this.up.filters = !!this.m_IsEnabled ? FILTERS_EMPTY : FILTERS_DISABLED;
         }
      }
      
      public function Center() : void
      {
         if(this.background is DisplayObjectContainer)
         {
            this.CenterChildren(this.background as DisplayObjectContainer);
         }
         if(this.up is DisplayObjectContainer)
         {
            this.CenterChildren(this.up as DisplayObjectContainer);
         }
         if(this.over is DisplayObjectContainer)
         {
            this.CenterChildren(this.over as DisplayObjectContainer);
         }
      }
      
      private function CenterChild(child:DisplayObject) : void
      {
         if(child is DisplayObjectContainer)
         {
            this.CenterChildren(child as DisplayObjectContainer);
         }
         child.x = -(child.width * 0.5);
         child.y = -(child.height * 0.5);
      }
      
      private function CenterChildren(parent:DisplayObjectContainer) : void
      {
         var child:DisplayObject = null;
         var len:int = parent.numChildren;
         for(var i:int = 0; i < len; i++)
         {
            child = parent.getChildAt(i);
            this.CenterChild(child);
         }
      }
      
      protected function HandleFrame(e:Event) : void
      {
         if(!this.m_IsEnabled)
         {
            return;
         }
         if(this.m_IsPulsing)
         {
            --this.m_PulseTimer;
            this.m_OverAlpha += this.m_PulseSpeed;
            if(this.m_OverAlpha >= 1 || this.m_OverAlpha <= 0)
            {
               this.m_PulseSpeed *= -1;
            }
            if(this.m_PulseTimer <= 0)
            {
               this.StopPulsing();
            }
         }
         else if(!this.m_IsOver)
         {
            if(this.m_OverAlpha > 0)
            {
               this.m_OverAlpha -= this.alphaDecay;
               this.m_OverAlpha = Math.max(this.m_OverAlpha,0);
            }
         }
         if(this.over != null)
         {
            this.over.alpha = this.m_OverAlpha;
         }
      }
      
      private function HandleMouseOver(e:MouseEvent) : void
      {
         this.m_IsOver = true;
         this.m_OverAlpha = 1;
         this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_BUTTON_OVER);
      }
      
      private function HandleMouseOut(e:MouseEvent) : void
      {
         this.m_IsOver = false;
      }
      
      private function HandleMouseDown(e:MouseEvent) : void
      {
         this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_BUTTON_PRESS);
      }
      
      private function HandleMouseUp(e:MouseEvent) : void
      {
         this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_BUTTON_RELEASE);
      }
   }
}
