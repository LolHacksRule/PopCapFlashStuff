package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.game.session.IBlitz3NetworkHandler;
   import com.popcap.flash.bejeweledblitz.game.session.ThrottleManager;
   import com.popcap.flash.bejeweledblitz.game.session.feature.FeatureManager;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.framework.IAppState;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class PreGameMenuCheckState extends Sprite implements IAppState, IBlitz3NetworkHandler
   {
      
      public static const STATE_NORMAL:int = 0;
      
      public static const STATE_WAITING_FOR_SERVER:int = 2;
       
      
      protected var m_App:Blitz3Game;
      
      protected var _isActive:Boolean = false;
      
      protected var _curState:int;
      
      public function PreGameMenuCheckState(param1:Blitz3Game)
      {
         super();
         this.m_App = param1;
         this._curState = STATE_NORMAL;
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
         if(this.m_App.network.IsExternalCartOpen() || this._curState != STATE_NORMAL)
         {
            return;
         }
         var _loc1_:Number = this.m_App.sessionData.userData.currencyManager.GetCurrencyByType(CurrencyManager.TYPE_COINS);
         if(_loc1_ < 0)
         {
            if(this.m_App.sessionData.throttleManager.IsEnabled(ThrottleManager.THROTTLE_DIRECT_TO_CART))
            {
               this.m_App.network.ShowMiniCart("boost",_loc1_);
            }
            else
            {
               this.m_App.network.ShowCart();
            }
            return;
         }
         dispatchEvent(new Event(PreGameMenuState.SIGNAL_PREGAME_CHECK_SUCCESS));
      }
      
      public function draw(param1:int) : void
      {
      }
      
      public function onEnter() : void
      {
         this._isActive = true;
         if(!this.m_App.sessionData.featureManager.isFeatureEnabled(FeatureManager.FEATURE_BOOSTS))
         {
            dispatchEvent(new Event(PreGameMenuState.SIGNAL_PREGAME_CHECK_SUCCESS));
         }
      }
      
      public function onExit() : void
      {
         this._isActive = false;
      }
      
      public function HandleNetworkSuccess(param1:XML) : void
      {
         if(this._curState == STATE_WAITING_FOR_SERVER)
         {
            this._curState = STATE_NORMAL;
            (this.m_App.ui as MainWidgetGame).networkWait.Hide(this);
         }
      }
      
      public function HandleCartClosed(param1:Boolean) : void
      {
         if(!this._isActive)
         {
            return;
         }
         if(param1)
         {
            (this.m_App.ui as MainWidgetGame).networkWait.Show(this);
            this._curState = STATE_WAITING_FOR_SERVER;
         }
         else
         {
            dispatchEvent(new Event(PreGameMenuState.SIGNAL_PREGAME_CHECK_FAILURE));
         }
      }
   }
}
