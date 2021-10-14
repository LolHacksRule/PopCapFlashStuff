package com.popcap.flash.games.blitz3.ui.sprites
{
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CheckBox extends Sprite
   {
       
      
      protected var m_App:Blitz3App;
      
      protected var m_Box:Bitmap;
      
      protected var m_Mark:Bitmap;
      
      protected var m_IsChecked:Boolean = false;
      
      public function CheckBox(app:Blitz3App)
      {
         super();
         this.m_App = app;
         useHandCursor = true;
         buttonMode = true;
         this.UpdateState();
         addEventListener(MouseEvent.CLICK,this.HandleClick);
      }
      
      public function IsChecked() : Boolean
      {
         return this.m_IsChecked;
      }
      
      public function SetChecked(checked:Boolean) : void
      {
         this.m_IsChecked = checked;
         this.UpdateState();
      }
      
      protected function UpdateState() : void
      {
      }
      
      protected function HandleClick(event:MouseEvent) : void
      {
         this.m_IsChecked = !this.m_IsChecked;
         this.UpdateState();
         this.m_App.soundManager.playSound(Blitz3Sounds.SOUND_BUTTON_release);
      }
   }
}
