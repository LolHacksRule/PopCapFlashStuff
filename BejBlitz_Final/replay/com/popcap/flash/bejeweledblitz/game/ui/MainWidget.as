package com.popcap.flash.bejeweledblitz.game.ui
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.game.BackgroundWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.game.GameWidget;
   import flash.display.Sprite;
   
   public class MainWidget extends Sprite
   {
       
      
      protected var m_App:Blitz3App;
      
      public var background:BackgroundWidget;
      
      public var game:GameWidget;
      
      public function MainWidget(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.background = this.m_App.uiFactory.GetBackgroundWidget();
         this.game = new GameWidget(app);
      }
      
      public function Init() : void
      {
         this.AddChildren();
         this.InitChildren();
      }
      
      public function PlayMode(playing:Boolean) : void
      {
      }
      
      public function MessageMode(messaging:Boolean, message:Sprite = null) : void
      {
      }
      
      protected function AddChildren() : void
      {
         addChild(this.background);
         addChild(this.game);
      }
      
      protected function InitChildren() : void
      {
         this.background.Init();
         this.game.Init();
      }
   }
}
