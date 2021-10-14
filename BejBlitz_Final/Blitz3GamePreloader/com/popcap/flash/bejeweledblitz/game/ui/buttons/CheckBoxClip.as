package com.popcap.flash.bejeweledblitz.game.ui.buttons
{
   import com.popcap.flash.framework.App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class CheckBoxClip
   {
       
      
      protected var m_App:App;
      
      protected var m_IsChecked:Boolean = false;
      
      private var _clipListener:MovieClip;
      
      public function CheckBoxClip(param1:App, param2:MovieClip)
      {
         super();
         this.m_App = param1;
         this._clipListener = param2;
         this._clipListener.useHandCursor = true;
         this._clipListener.buttonMode = true;
         this.UpdateState();
         this._clipListener.addEventListener(MouseEvent.CLICK,this.HandleClick);
      }
      
      public function IsChecked() : Boolean
      {
         return this.m_IsChecked;
      }
      
      public function SetChecked(param1:Boolean) : void
      {
         this.m_IsChecked = param1;
         this.UpdateState();
      }
      
      protected function UpdateState() : void
      {
         if(this.m_IsChecked)
         {
            this._clipListener.gotoAndStop("enable");
         }
         else
         {
            this._clipListener.gotoAndStop("disable");
         }
      }
      
      protected function HandleClick(param1:MouseEvent) : void
      {
         this.m_IsChecked = !this.m_IsChecked;
         this.UpdateState();
         this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_BUTTON_RELEASE);
      }
      
      public function addClickEventListener(param1:Function) : void
      {
         this._clipListener.addEventListener(MouseEvent.CLICK,param1);
      }
   }
}
