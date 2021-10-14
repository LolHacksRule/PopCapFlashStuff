package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.game.ftue.impl.FTUEEvents;
   import com.popcap.flash.bejeweledblitz.game.session.IBlitz3NetworkHandler;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.framework.IAppState;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class GamePlayActiveState extends Sprite implements IAppState, IBlitz3NetworkHandler
   {
      
      public static const IDLE_TIME:int = 175;
      
      public static const TIME_UP_TIME:int = 175;
       
      
      private var m_App:Blitz3Game;
      
      private var mTimer:int = 0;
      
      private var mTimerStarted:Boolean = false;
      
      private var mIsTimeUp:Boolean = false;
      
      private var mIsActive:Boolean = false;
      
      private var mGameWidget:MainWidgetGame = null;
      
      public function GamePlayActiveState(param1:Blitz3Game)
      {
         super();
         this.m_App = param1;
         param1.network.AddHandler(this);
         this.mGameWidget = this.m_App.ui as MainWidgetGame;
      }
      
      public function Reset() : void
      {
         this.mTimerStarted = false;
         this.mIsTimeUp = false;
      }
      
      public function IsActive() : Boolean
      {
         return this.mIsActive;
      }
      
      public function setInActive() : void
      {
         this.mIsActive = false;
      }
      
      public function update() : void
      {
         this.m_App.logic.isActive = true;
         this.m_App.logic.Update();
         this.m_App.tutorial.Update();
         if(this.m_App.logic.timerLogic.GetTimeRemaining() == 0 && this.mIsTimeUp == false)
         {
            if(!this.m_App.logic.ShouldDelayTimeUp())
            {
               this.mIsTimeUp = true;
               if(!this.m_App.sessionData.finisherSessionData.IsFinisherSurfaced())
               {
                  (this.m_App.ui as MainWidgetGame).game.board.compliments.showTimeUp();
               }
            }
         }
         if(this.m_App.logic.timerLogic.GetTimeRemaining() == 0)
         {
            if(this.mTimer > 0)
            {
               --this.mTimer;
            }
         }
         if(this.m_App.logic.IsGameOver() && this.mTimer == 0)
         {
            dispatchEvent(new Event(GamePlayState.SIGNAL_GAME_PLAY_STOP));
            this.mTimerStarted = false;
         }
         this.mGameWidget.game.Update();
         this.mGameWidget.game.board.frame.Update();
         this.mGameWidget.game.board.clock.Update();
      }
      
      public function draw(param1:int) : void
      {
         this.mGameWidget.game.board.frame.Draw();
      }
      
      public function onEnter() : void
      {
         this.mIsActive = true;
         if(!this.mTimerStarted)
         {
            this.mTimer = IDLE_TIME;
            this.mTimerStarted = true;
         }
         this.m_App.logic.Resume();
         this.mGameWidget.game.ActivateBoostConsole();
         this.m_App.bjbEventDispatcher.SendEvent(FTUEEvents.FTUE_ENTER_EQUIPPED_RG_GAME,null);
      }
      
      public function onExit() : void
      {
         this.mIsActive = false;
      }
      
      public function HandleNetworkSuccess(param1:XML) : void
      {
      }
      
      public function HandleCartClosed(param1:Boolean) : void
      {
      }
   }
}
