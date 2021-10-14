package com.popcap.flash.games.blitz3.ui.sprites
{
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   
   public class FadeButton extends Sprite
   {
      
      public static const DEFAULT_ALPHA_DECAY:Number = 0.05;
      
      public static const PULSE_SPEED:Number = 2.5 / 100;
      
      private static var FILTERS_EMPTY:Array = new Array();
      
      private static var FILTERS_DISABLED:Array = new Array(new ColorMatrixFilter([0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0]));
       
      
      public var alphaDecay:Number = 0.05;
      
      public var background:Sprite;
      
      public var up:Sprite;
      
      public var over:Sprite;
      
      public var down:Sprite;
      
      private var m_App:Blitz3App;
      
      private var m_Container:Sprite;
      
      private var m_OverAlpha:Number = 0.0;
      
      private var m_IsOver:Boolean = false;
      
      private var m_IsPulsing:Boolean = false;
      
      private var m_PulseTimer:int = 0;
      
      private var m_PulseSpeed:Number = 0.025;
      
      private var m_IsEnabled:Boolean = true;
      
      public function FadeButton(app:Blitz3App)
      {
         super();
         tabEnabled = false;
         tabChildren = false;
         this.m_App = app;
         mouseChildren = false;
         buttonMode = true;
         useHandCursor = true;
         this.background = new Sprite();
         this.up = new Sprite();
         this.over = new Sprite();
         this.down = new Sprite();
         this.over.alpha = 0;
         this.down.alpha = 0;
         this.m_Container = new Sprite();
         this.m_Container.addChild(this.background);
         this.m_Container.addChild(this.up);
         this.m_Container.addChild(this.over);
         this.m_Container.addChild(this.down);
         addChild(this.m_Container);
         this.SetEnabled(true);
         addEventListener(MouseEvent.MOUSE_OVER,this.HandleMouseOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.HandleMouseOut);
         addEventListener(MouseEvent.MOUSE_DOWN,this.HandleMouseDown);
         addEventListener(MouseEvent.MOUSE_UP,this.HandleMouseUp);
         app.OnFixedUpdate(this.Update);
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
         if(this.down is DisplayObjectContainer)
         {
            this.CenterChildren(this.down as DisplayObjectContainer);
         }
      }
      
      protected function Update() : void
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
      
      private function CenterChild(child:DisplayObject) : void
      {
         if(child is DisplayObjectContainer)
         {
            this.CenterChildren(child as DisplayObjectContainer);
         }
         child.x = -(child.width / 2);
         child.y = -(child.height / 2);
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
      
      private function HandleMouseOver(e:MouseEvent) : void
      {
         this.m_IsOver = true;
         this.m_OverAlpha = 1;
      }
      
      private function HandleMouseOut(e:MouseEvent) : void
      {
         this.m_IsOver = false;
         this.down.alpha = 0;
      }
      
      private function HandleMouseDown(e:MouseEvent) : void
      {
         this.over.alpha = 0;
         this.down.alpha = 1;
         this.m_App.soundManager.playSound(Blitz3Sounds.SOUND_BUTTON_PRESS);
      }
      
      private function HandleMouseUp(e:MouseEvent) : void
      {
         this.over.alpha = 1;
         this.down.alpha = 0;
         this.m_App.soundManager.playSound(Blitz3Sounds.SOUND_BUTTON_release);
      }
   }
}
