package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.game.session.FeatureManager;
   import com.popcap.flash.bejeweledblitz.game.session.IBlitz3NetworkHandler;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.framework.IAppState;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class PreGameMenuCheckState extends Sprite implements IAppState, IBlitz3NetworkHandler
   {
      
      public static const STATE_NORMAL:int = 0;
      
      public static const STATE_WAITING_FOR_CALLBACK:int = 1;
      
      public static const STATE_WAITING_FOR_SERVER:int = 2;
       
      
      protected var m_App:Blitz3Game;
      
      protected var m_IsActive:Boolean = false;
      
      protected var m_CurState:int;
      
      public function PreGameMenuCheckState(app:Blitz3Game)
      {
         super();
         this.m_App = app;
         this.m_CurState = STATE_NORMAL;
         this.m_App.network.AddHandler(this);
      }
      
      public function update() : void
      {
         if(this.m_App.network.isOffline)
         {
            dispatchEvent(new Event(PreGameMenuState.SIGNAL_PREGAME_CHECK_SUCCESS));
            return;
         }
         (this.m_App.ui as MainWidgetGame).networkWait.Update();
         if(this.m_App.network.IsExternalCartOpen() || this.m_CurState != STATE_NORMAL)
         {
            return;
         }
         if(this.m_App.sessionData.userData.GetCoins() < 0)
         {
            this.m_App.network.ShowCart();
            return;
         }
         dispatchEvent(new Event(PreGameMenuState.SIGNAL_PREGAME_CHECK_SUCCESS));
      }
      
      public function draw(elapsed:int) : void
      {
      }
      
      public function onEnter() : void
      {
         this.m_IsActive = true;
         if(!this.m_App.sessionData.featureManager.IsEnabled(FeatureManager.FEATURE_BOOST_SELECTION))
         {
            dispatchEvent(new Event(PreGameMenuState.SIGNAL_PREGAME_CHECK_SUCCESS));
         }
      }
      
      public function onExit() : void
      {
         this.m_IsActive = false;
      }
      
      public function onKeyUp(keyCode:int) : void
      {
      }
      
      public function onKeyDown(keyCode:int) : void
      {
      }
      
      public function HandleNetworkSuccess(response:XML) : void
      {
         if(!this.m_IsActive)
         {
            return;
         }
         if(this.m_CurState == STATE_WAITING_FOR_SERVER)
         {
            this.m_CurState = STATE_NORMAL;
            this.m_App.network.ReportEvent("BoostLock/OutOfCoins/Monitized");
            (this.m_App.ui as MainWidgetGame).networkWait.Hide(this);
         }
      }
      
      public function HandleNetworkError() : void
      {
      }
      
      public function HandleBuyCoinsCallback(success:Boolean) : void
      {
      }
      
      public function HandleExternalPause(isPaused:Boolean) : void
      {
      }
      
      public function HandleCartClosed(coinsPurchased:Boolean) : void
      {
         if(!this.m_IsActive)
         {
            return;
         }
         if(coinsPurchased)
         {
            (this.m_App.ui as MainWidgetGame).networkWait.Show(this);
            this.m_CurState = STATE_WAITING_FOR_SERVER;
         }
         else
         {
            dispatchEvent(new Event(PreGameMenuState.SIGNAL_PREGAME_CHECK_FAILURE));
         }
      }
      
      public function HandleNetworkGameStart() : void
      {
      }
   }
}
