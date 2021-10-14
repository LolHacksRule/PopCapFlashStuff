package com.popcap.flash.games.blitz3.game.states
{
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.games.bej3.blitz.IBlitz3NetworkHandler;
   import com.popcap.flash.games.blitz3.session.IUserDataHandler;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class PreGameMenuPreBoostCheckState extends Sprite implements IAppState, IBlitz3NetworkHandler, IUserDataHandler
   {
      
      public static const STATE_NORMAL:int = 0;
      
      public static const STATE_WAITING_FOR_CALLBACK:int = 1;
      
      public static const STATE_WAITING_FOR_SERVER:int = 2;
       
      
      protected var m_App:Blitz3Game;
      
      protected var m_IsActive:Boolean = false;
      
      protected var m_CurState:int;
      
      protected var m_HasBoughtCoins:Boolean = false;
      
      protected var m_PrevCoinBalance:int = 0;
      
      public function PreGameMenuPreBoostCheckState(app:Blitz3Game)
      {
         super();
         this.m_App = app;
         this.m_CurState = STATE_NORMAL;
         this.m_App.network.AddHandler(this);
         this.m_App.sessionData.userData.AddHandler(this);
      }
      
      public function update() : void
      {
         if(this.m_App.network.isOffline)
         {
            dispatchEvent(new Event(PreGameMenuState.SIGNAL_PREGAME_PREBOOST_CHECK_SUCCESS));
            return;
         }
         this.m_App.ui.networkWait.Update();
         if(this.m_App.creditsScreen.visible || this.m_App.network.IsExternalCartOpen() || this.m_CurState != STATE_NORMAL)
         {
            return;
         }
         if(this.m_App.sessionData.userData.GetCoins() < 0)
         {
            this.m_App.network.ShowCart();
            return;
         }
         if(this.m_App.sessionData.rareGemManager.HasCurRareGem())
         {
            this.m_App.network.ReportEvent("RareGemBought");
            if(this.m_HasBoughtCoins)
            {
               this.m_App.network.ReportEvent("RareGemMonitized");
            }
         }
         dispatchEvent(new Event(PreGameMenuState.SIGNAL_PREGAME_PREBOOST_CHECK_SUCCESS));
      }
      
      public function draw(elapsed:int) : void
      {
      }
      
      public function onEnter() : void
      {
         this.m_IsActive = true;
         this.m_PrevCoinBalance = this.m_App.sessionData.userData.GetCoins();
         this.m_HasBoughtCoins = false;
      }
      
      public function onExit() : void
      {
         this.m_IsActive = false;
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
      
      public function HandleNetworkError() : void
      {
      }
      
      public function HandleNetworkSuccess() : void
      {
         if(!this.m_IsActive)
         {
            return;
         }
         if(this.m_CurState == STATE_WAITING_FOR_SERVER)
         {
            this.m_CurState = STATE_NORMAL;
            this.m_App.ui.networkWait.Hide(this);
            this.m_App.creditsScreen.Hide();
         }
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
            this.m_App.ui.networkWait.Show(this);
            this.m_CurState = STATE_WAITING_FOR_SERVER;
         }
         else
         {
            dispatchEvent(new Event(PreGameMenuState.SIGNAL_PREGAME_PREBOOST_CHECK_FAILURE));
         }
      }
      
      public function HandleNetworkGameStart() : void
      {
      }
      
      public function HandleCoinBalanceChanged(balance:int) : void
      {
         if(balance != this.m_PrevCoinBalance)
         {
            this.m_HasBoughtCoins = true;
         }
         this.m_PrevCoinBalance = balance;
      }
      
      public function HandleXPTotalChanged(xp:Number, level:int) : void
      {
      }
   }
}
