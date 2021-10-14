package com.popcap.flash.games.blitz3.game.states
{
   import com.popcap.flash.framework.IAppState;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   
   public class MenuState extends EventDispatcher implements IAppState
   {
      
      public static const TRANSITION_TIME:int = 50;
       
      
      private var mApp:Blitz3Game;
      
      private var mTimer:int = 0;
      
      private var mIsFading:Boolean = false;
      
      private var mFadeIn:Boolean = false;
      
      public function MenuState(app:Blitz3Game)
      {
         super();
         this.mApp = app;
         this.mApp.ui.menu.playButton.addEventListener(MouseEvent.CLICK,this.HandleMouseClick);
      }
      
      public function update() : void
      {
         this.mApp.ui.menu.Update();
         if(!this.mIsFading)
         {
            return;
         }
         ++this.mTimer;
         var percent:Number = this.mTimer / TRANSITION_TIME;
         if(this.mFadeIn)
         {
            percent = 1 - percent;
         }
         this.doFade(percent);
         if(this.mTimer == TRANSITION_TIME)
         {
            if(this.mFadeIn)
            {
               this.mFadeIn = false;
               this.mIsFading = false;
               this.mApp.ui.menu.playButton.mouseEnabled = true;
               this.mApp.ui.menu.playButton.useHandCursor = true;
            }
            else
            {
               this.mApp.ui.menu.visible = false;
               dispatchEvent(new Event(MainState.SIGNAL_PLAY));
            }
         }
      }
      
      public function draw(elapsed:int) : void
      {
      }
      
      public function onEnter() : void
      {
         this.mApp.ui.game.sidebar.buttons.menuButton.buttonMode = false;
         this.mApp.ui.game.sidebar.buttons.hintButton.buttonMode = false;
         this.mApp.ui.optionsButton.visible = false;
         this.mApp.creditsScreen.screenID = 0;
         this.mFadeIn = true;
         this.mTimer = 0;
         this.mApp.ui.menu.Reset();
      }
      
      public function onExit() : void
      {
         this.mApp.ui.menu.visible = false;
         this.mApp.ui.optionsButton.visible = true;
      }
      
      public function onPush() : void
      {
      }
      
      public function onPop() : void
      {
      }
      
      public function onMouseUp(x:Number, y:Number) : void
      {
      }
      
      public function onMouseDown(x:Number, y:Number) : void
      {
      }
      
      public function onMouseMove(x:Number, y:Number) : void
      {
      }
      
      public function onKeyUp(keyCode:int) : void
      {
      }
      
      public function onKeyDown(keyCode:int) : void
      {
      }
      
      private function doFade(percent:Number) : void
      {
         this.mApp.ui.menu.alpha = 1 - percent;
      }
      
      private function StartGame() : void
      {
      }
      
      private function HandleMouseClick(e:MouseEvent) : void
      {
         this.mApp.ui.game.sidebar.buttons.menuButton.buttonMode = true;
         this.mApp.ui.game.sidebar.buttons.hintButton.buttonMode = true;
         dispatchEvent(new Event(MainState.SIGNAL_LEAVE_MAIN_MENU));
      }
   }
}
