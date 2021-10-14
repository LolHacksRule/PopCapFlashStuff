package com.popcap.flash.bejeweledblitz.game.ui
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.game.BackgroundWidget;
   import flash.display.Sprite;
   
   public class MainWidget extends Sprite
   {
       
      
      public var background:BackgroundWidget;
      
      protected var m_App:Blitz3App;
      
      public function MainWidget(param1:Blitz3App)
      {
         super();
         this.m_App = param1;
      }
      
      public function Init() : void
      {
         this.AddChildren();
         this.InitChildren();
      }
      
      public function PlayMode(param1:Boolean) : void
      {
      }
      
      public function MessageMode(param1:Boolean, param2:Sprite) : void
      {
      }
      
      public function ClearMessages() : void
      {
      }
      
      protected function AddChildren() : void
      {
      }
      
      protected function InitChildren() : void
      {
      }
   }
}
