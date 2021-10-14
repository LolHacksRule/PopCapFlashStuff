package com.popcap.flash.games.blitz3.game.states
{
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.games.blitz3.session.DataStore;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class GameHelpState extends Sprite implements IAppState
   {
       
      
      private var mApp:Blitz3Game;
      
      private var mIsForced:Boolean = false;
      
      private var mDontShow:Boolean = false;
      
      private var mIsShowing:Boolean = false;
      
      private var mHasAddedContinueHandler:Boolean = false;
      
      public function GameHelpState(app:Blitz3Game)
      {
         super();
         this.mApp = app;
         this.mDontShow = this.mApp.sessionData.dataStore.GetFlag(DataStore.FLAG_HIDE_TUTORIAL);
      }
      
      public function ForceHelp(forced:Boolean) : void
      {
         this.mIsForced = forced;
      }
      
      public function update() : void
      {
         if(this.mDontShow)
         {
            dispatchEvent(new Event(GameState.SIGNAL_GAME_RESET));
            return;
         }
         this.ShowHelp();
      }
      
      public function draw(elapsed:int) : void
      {
      }
      
      public function onEnter() : void
      {
         if(this.mDontShow)
         {
            return;
         }
         this.ShowHelp();
      }
      
      public function onExit() : void
      {
         this.HideHelp();
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
      
      private function ShowHelp() : void
      {
         if(this.mIsShowing)
         {
            return;
         }
         if(!this.mHasAddedContinueHandler)
         {
            this.mApp.ui.help.continueButton.addEventListener(MouseEvent.CLICK,this.HandleContinue);
            this.mHasAddedContinueHandler = true;
         }
         this.mApp.ui.help.visible = true;
         this.mApp.ui.help.continueButton.visible = true;
         this.mApp.ui.help.backButton.visible = false;
         this.mApp.ui.help.StartTutorial();
         this.mIsShowing = true;
      }
      
      private function HideHelp() : void
      {
         if(!this.mIsShowing)
         {
            return;
         }
         this.mApp.ui.help.visible = false;
         this.mIsShowing = false;
      }
      
      private function HandleContinue(e:Event) : void
      {
         if(!this.mIsShowing)
         {
            return;
         }
         this.mApp.sessionData.dataStore.SetFlag(DataStore.FLAG_HIDE_TUTORIAL,true);
         this.mDontShow = true;
         dispatchEvent(new Event(GameState.SIGNAL_GAME_RESET));
      }
      
      private function HandleMouseOver(e:Event) : void
      {
         this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_BUTTON_OVER);
      }
      
      private function HandleMouseDown(e:Event) : void
      {
         this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_BUTTON_PRESS);
      }
      
      private function HandleMouseUp(e:Event) : void
      {
         this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_BUTTON_release);
      }
   }
}
