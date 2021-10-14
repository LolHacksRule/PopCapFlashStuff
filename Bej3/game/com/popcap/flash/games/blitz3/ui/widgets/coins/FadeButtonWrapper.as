package com.popcap.flash.games.blitz3.ui.widgets.coins
{
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class FadeButtonWrapper
   {
      
      public static const DEFAULT_ALPHA_DECAY:Number = 0.05;
       
      
      public var alphaDecay:Number = 0.05;
      
      private var m_App:Blitz3App;
      
      private var m_Clip:MovieClip;
      
      private var m_OverAlpha:Number = 0.0;
      
      private var m_IsOver:Boolean = false;
      
      private var m_IsEnabled:Boolean = true;
      
      public function FadeButtonWrapper(app:Blitz3App, clip:MovieClip)
      {
         super();
         this.m_App = app;
         this.m_Clip = clip;
         this.m_App.OnFixedUpdate(this.Update);
         this.m_Clip.tabEnabled = false;
         this.m_Clip.tabChildren = false;
         this.m_Clip.mouseChildren = false;
         this.m_Clip.buttonMode = true;
         this.m_Clip.useHandCursor = true;
         this.m_Clip.overClip.alpha = 0;
         this.m_Clip.addEventListener(MouseEvent.MOUSE_OVER,this.HandleMouseOver);
         this.m_Clip.addEventListener(MouseEvent.MOUSE_OUT,this.HandleMouseOut);
         this.m_Clip.addEventListener(MouseEvent.MOUSE_DOWN,this.HandleMouseDown);
         this.m_Clip.addEventListener(MouseEvent.MOUSE_UP,this.HandleMouseUp);
      }
      
      public function IsEnabled() : Boolean
      {
         return this.m_IsEnabled;
      }
      
      public function SetEnabled(enabled:Boolean) : void
      {
         this.m_IsEnabled = enabled;
         this.m_Clip.mouseEnabled = this.m_IsEnabled;
         this.m_Clip.mouseChildren = this.m_IsEnabled;
      }
      
      public function Update() : void
      {
         if(!this.m_IsOver)
         {
            if(this.m_OverAlpha > 0)
            {
               this.m_OverAlpha -= this.alphaDecay;
               this.m_OverAlpha = Math.max(this.m_OverAlpha,0);
            }
         }
         if(this.m_Clip.overClip != null)
         {
            this.m_Clip.overClip.alpha = this.m_OverAlpha;
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
      }
      
      private function HandleMouseDown(e:MouseEvent) : void
      {
         this.m_App.soundManager.playSound(Blitz3Sounds.SOUND_BUTTON_PRESS);
      }
      
      private function HandleMouseUp(e:MouseEvent) : void
      {
         this.m_App.soundManager.playSound(Blitz3Sounds.SOUND_BUTTON_release);
      }
   }
}
