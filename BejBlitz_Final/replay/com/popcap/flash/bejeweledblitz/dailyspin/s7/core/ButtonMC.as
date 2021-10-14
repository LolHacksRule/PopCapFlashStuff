package com.popcap.flash.bejeweledblitz.dailyspin.s7.core
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ButtonMC extends DynMC
   {
       
      
      private var m_fnOut:Function;
      
      private var m_fnOver:Function;
      
      private var m_fnPress:Function;
      
      private var m_fnRelease:Function;
      
      private var m_fnIgnoreEvent:Function;
      
      private var m_pressed:Boolean;
      
      protected var m_active:Boolean;
      
      protected var m_fnExtOut:Function;
      
      protected var m_fnExtOver:Function;
      
      protected var m_fnExtPress:Function;
      
      protected var m_fnExtRelease:Function;
      
      public function ButtonMC()
      {
         super();
         this.m_fnOver = null;
         this.m_fnOut = null;
         this.m_fnPress = null;
         this.m_fnRelease = null;
         this.m_fnIgnoreEvent = null;
         this.m_pressed = false;
         this.active = false;
         this.mouseChildren = false;
      }
      
      public function get active() : Boolean
      {
         return this.m_active;
      }
      
      public function set active(new_active:Boolean) : void
      {
         this.m_active = new_active;
         this.buttonMode = this.m_active;
         this.mouseEnabled = this.m_active;
         this.useHandCursor = this.m_active;
         if(this.m_active)
         {
            this.addEventListener(MouseEvent.ROLL_OVER,this.btnOver);
            this.addEventListener(MouseEvent.ROLL_OUT,this.btnOut);
            this.addEventListener(MouseEvent.MOUSE_DOWN,this.btnPress);
         }
         else
         {
            this.removeEventListener(MouseEvent.ROLL_OVER,this.btnOver);
            this.removeEventListener(MouseEvent.ROLL_OUT,this.btnOut);
            this.removeEventListener(MouseEvent.MOUSE_DOWN,this.btnPress);
         }
      }
      
      protected function activateButton(fnOut:Function, fnOver:Function, fnPress:Function, fnRelease:Function, fnIgnoreEvent:Function, allowChildEventBubble:Boolean) : void
      {
         this.m_fnOut = fnOut;
         this.m_fnOver = fnOver;
         this.m_fnPress = fnPress;
         this.m_fnRelease = fnRelease;
         this.m_fnIgnoreEvent = fnIgnoreEvent;
         this.m_pressed = false;
         this.mouseChildren = allowChildEventBubble;
         this.active = true;
      }
      
      protected function deactivateButton() : void
      {
         this.active = false;
      }
      
      private function btnOut(e:MouseEvent) : void
      {
         if(this.m_pressed || this.m_fnIgnoreEvent != null && this.m_fnIgnoreEvent(this,false))
         {
            return;
         }
         this.notifyIgnoreReset();
         if(this.m_fnOut != null)
         {
            this.m_fnOut(e);
         }
         removeEventListener(MouseEvent.MOUSE_DOWN,this.btnPress);
         removeEventListener(MouseEvent.MOUSE_UP,this.btnRelease);
         removeEventListener(MouseEvent.ROLL_OUT,this.btnOut);
      }
      
      private function btnOver(e:MouseEvent) : void
      {
         if(this.m_pressed || this.m_fnIgnoreEvent != null && this.m_fnIgnoreEvent(this,false))
         {
            return;
         }
         if(this.m_fnOver != null)
         {
            this.m_fnOver(e);
         }
         addEventListener(MouseEvent.MOUSE_DOWN,this.btnPress);
         addEventListener(MouseEvent.ROLL_OUT,this.btnOut);
      }
      
      private function btnPress(e:MouseEvent) : void
      {
         this.m_pressed = true;
         if(this.m_fnPress != null)
         {
            this.m_fnPress(e);
         }
         if(this.m_fnIgnoreEvent != null)
         {
            this.m_fnIgnoreEvent(this,true);
         }
         removeEventListener(MouseEvent.MOUSE_DOWN,this.btnPress);
         addEventListener(MouseEvent.MOUSE_UP,this.btnRelease);
         stage.addEventListener(Event.MOUSE_LEAVE,this.stageOut);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.stageRelease);
      }
      
      private function btnRelease(e:MouseEvent) : void
      {
         this.m_pressed = false;
         this.removeRelease();
         addEventListener(MouseEvent.MOUSE_DOWN,this.btnPress);
         if(this.m_fnRelease != null)
         {
            this.m_fnRelease(e);
         }
      }
      
      private function stageRelease(e:MouseEvent) : void
      {
         if(this.m_pressed)
         {
            this.m_pressed = false;
            this.removeRelease();
            this.notifyIgnoreReset();
            if(this.m_fnOut != null)
            {
               this.m_fnOut(e);
            }
         }
      }
      
      private function stageOut(e:Event) : void
      {
         if(this.m_pressed)
         {
            this.m_pressed = false;
            this.removeRelease();
            this.notifyIgnoreReset();
            if(this.m_fnOut != null)
            {
               this.m_fnOut(e);
            }
         }
      }
      
      private function removeRelease() : void
      {
         removeEventListener(MouseEvent.MOUSE_UP,this.btnRelease);
         stage.removeEventListener(Event.MOUSE_LEAVE,this.stageOut);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.stageRelease);
      }
      
      private function notifyIgnoreReset() : void
      {
         if(this.m_fnIgnoreEvent != null)
         {
            this.m_fnIgnoreEvent(null,true);
         }
      }
   }
}
