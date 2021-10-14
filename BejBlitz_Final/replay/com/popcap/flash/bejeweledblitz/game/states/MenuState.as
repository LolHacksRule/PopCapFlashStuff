package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.menu.MenuWidget;
   import com.popcap.flash.framework.IAppState;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   
   public class MenuState extends EventDispatcher implements IAppState
   {
      
      public static const TRANSITION_TIME:int = 50;
       
      
      private var m_App:Blitz3Game;
      
      private var mTimer:int = 0;
      
      private var mIsFading:Boolean = false;
      
      private var mFadeIn:Boolean = false;
      
      public function MenuState(app:Blitz3Game)
      {
         super();
         this.m_App = app;
         (this.m_App.ui as MainWidgetGame).menu.playButton.addEventListener(MouseEvent.CLICK,this.HandleMouseClick);
         this.m_App.metaUI.tutorialWelcome.AddPlayButtonHandler(this.HandlePlayTutorialClick);
      }
      
      public function update() : void
      {
         var menu:MenuWidget = null;
         menu = (this.m_App.ui as MainWidgetGame).menu;
         menu.Update();
         this.m_App.metaUI.Update();
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
               menu.playButton.mouseEnabled = true;
               menu.playButton.useHandCursor = true;
            }
            else
            {
               menu.visible = false;
               dispatchEvent(new Event(MainState.SIGNAL_PLAY));
            }
         }
      }
      
      public function draw(elapsed:int) : void
      {
      }
      
      public function onEnter() : void
      {
         var mainWidget:MainWidgetGame = this.m_App.ui as MainWidgetGame;
         this.m_App.ui.game.sidebar.buttons.menuButton.buttonMode = false;
         this.m_App.ui.game.sidebar.buttons.hintButton.buttonMode = false;
         mainWidget.optionsButton.visible = false;
         this.mFadeIn = true;
         this.mTimer = 0;
      }
      
      public function onExit() : void
      {
         var mainWidget:MainWidgetGame = null;
         mainWidget = this.m_App.ui as MainWidgetGame;
         mainWidget.menu.visible = false;
         mainWidget.optionsButton.visible = true;
      }
      
      public function onKeyUp(keyCode:int) : void
      {
      }
      
      public function onKeyDown(keyCode:int) : void
      {
      }
      
      private function doFade(percent:Number) : void
      {
         (this.m_App.ui as MainWidgetGame).menu.alpha = 1 - percent;
      }
      
      private function StartGame() : void
      {
      }
      
      private function HandleMouseClick(e:MouseEvent) : void
      {
         this.m_App.ui.game.sidebar.buttons.menuButton.buttonMode = true;
         this.m_App.ui.game.sidebar.buttons.hintButton.buttonMode = true;
         dispatchEvent(new Event(MainState.SIGNAL_LEAVE_MAIN_MENU));
      }
      
      private function HandlePlayTutorialClick(e:MouseEvent) : void
      {
         dispatchEvent(new Event(MainState.SIGNAL_PLAY_TUTORIAL));
      }
   }
}
