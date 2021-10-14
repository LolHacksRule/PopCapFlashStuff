package com.popcap.flash.bejeweledblitz.replay.states
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.IAppState;
   import flash.display.Sprite;
   
   public class GamePlayPausedState extends Sprite implements IAppState
   {
      
      public static const FADE_TIME:int = 25;
       
      
      private var m_App:Blitz3App;
      
      private var mTimer:int = 0;
      
      private var m_Handlers:Vector.<IGamePlayPausedStateHandler>;
      
      public function GamePlayPausedState(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_Handlers = new Vector.<IGamePlayPausedStateHandler>();
      }
      
      public function AddHandler(handler:IGamePlayPausedStateHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function update() : void
      {
         if(this.mTimer < FADE_TIME)
         {
            ++this.mTimer;
         }
      }
      
      public function draw(elapsed:int) : void
      {
         var percent:Number = this.mTimer / FADE_TIME;
      }
      
      public function onEnter() : void
      {
         var handler:IGamePlayPausedStateHandler = null;
         this.m_App.logic.Pause();
         this.mTimer = 0;
         for each(handler in this.m_Handlers)
         {
            handler.HandleBeginPause();
         }
      }
      
      public function onExit() : void
      {
         var handler:IGamePlayPausedStateHandler = null;
         if(parent != null)
         {
            parent.removeChild(this);
         }
         this.m_App.ui.game.board.gemLayer.alpha = 1;
         this.m_App.logic.Resume();
         this.m_App.ui.stage.focus = this.m_App.ui.stage;
         for each(handler in this.m_Handlers)
         {
            handler.HandleEndPause();
         }
      }
      
      public function onKeyUp(keyCode:int) : void
      {
      }
      
      public function onKeyDown(keyCode:int) : void
      {
      }
   }
}
