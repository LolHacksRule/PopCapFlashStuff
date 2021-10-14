package com.popcap.flash.bejeweledblitz.replay.states
{
   import com.popcap.flash.bejeweledblitz.replay.ui.MainWidgetReplay;
   import com.popcap.flash.framework.IAppState;
   import flash.display.Sprite;
   
   public class GameOverState extends Sprite implements IAppState
   {
       
      
      protected var m_App:Blitz3Replay;
      
      public function GameOverState(app:Blitz3Replay)
      {
         super();
         this.m_App = app;
      }
      
      public function update() : void
      {
      }
      
      public function draw(elapsed:int) : void
      {
      }
      
      public function onEnter() : void
      {
         var replayWidget:MainWidgetReplay = this.m_App.ui as MainWidgetReplay;
         if(replayWidget == null)
         {
            return;
         }
         replayWidget.gameOver.visible = true;
      }
      
      public function onExit() : void
      {
         var replayWidget:MainWidgetReplay = this.m_App.ui as MainWidgetReplay;
         if(replayWidget == null)
         {
            return;
         }
         replayWidget.gameOver.visible = false;
      }
      
      public function onKeyUp(keyCode:int) : void
      {
      }
      
      public function onKeyDown(keyCode:int) : void
      {
      }
   }
}
