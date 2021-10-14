package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.game.session.IBlitz3NetworkHandler;
   import com.popcap.flash.bejeweledblitz.game.session.IUserDataHandler;
   import com.popcap.flash.bejeweledblitz.game.session.raregem.RareGemOffer;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.framework.IAppState;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class PreGameMenuPreBoostCheckState extends Sprite implements IAppState, IBlitz3NetworkHandler, IUserDataHandler
   {
      
      public static const STATE_NORMAL:int = 0;
      
      public static const STATE_WAITING_FOR_SERVER:int = 2;
       
      
      protected var m_App:Blitz3Game;
      
      protected var _isActive:Boolean = false;
      
      protected var _curState:int;
      
      protected var m_HasBoughtCoins:Boolean = false;
      
      protected var m_PrevCoinBalance:int = 0;
      
      public function PreGameMenuPreBoostCheckState(param1:Blitz3Game)
      {
         super();
         this.m_App = param1;
         this._curState = STATE_NORMAL;
         this.m_App.network.AddHandler(this);
         this.m_App.sessionData.userData.currencyManager.AddHandler(this);
      }
      
      public function update() : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         (this.m_App.ui as MainWidgetGame).networkWait.Update();
         if(this.m_App.network.IsExternalCartOpen() || this._curState != STATE_NORMAL)
         {
            return;
         }
         var _loc1_:RareGemOffer = this.m_App.sessionData.rareGemManager.GetCurrentOffer();
         if(_loc1_.IsHarvested())
         {
            _loc2_ = "RareGem/";
            _loc3_ = "";
            _loc4_ = "";
            if((_loc5_ = this.m_App.sessionData.rareGemManager.GetStreakNum()) > 0)
            {
               _loc3_ = "Streak" + _loc5_;
            }
            else if(this.m_App.sessionData.rareGemManager.DailySpinAwardId)
            {
               _loc3_ = "Earned";
            }
            else if(_loc1_.IsViral())
            {
               _loc3_ = "Viral";
            }
            else
            {
               _loc3_ = "Random";
            }
            _loc2_ += _loc3_ + "/";
            _loc4_ = _loc1_.GetID();
            _loc2_ += _loc4_ + "/";
         }
         dispatchEvent(new Event(PreGameMenuState.SIGNAL_PREGAME_PREBOOST_CHECK_SUCCESS));
      }
      
      public function draw(param1:int) : void
      {
      }
      
      public function onEnter() : void
      {
         this._isActive = true;
         this.m_PrevCoinBalance = this.m_App.sessionData.userData.currencyManager.GetCurrencyByType(CurrencyManager.TYPE_COINS);
         this.m_HasBoughtCoins = false;
      }
      
      public function onExit() : void
      {
         this._isActive = false;
      }
      
      public function HandleNetworkSuccess(param1:XML) : void
      {
         if(!this._isActive)
         {
            return;
         }
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
            this.m_App.sessionData.rareGemManager.SellRareGem();
            dispatchEvent(new Event(PreGameMenuState.SIGNAL_PREGAME_PREBOOST_CHECK_FAILURE));
         }
      }
      
      public function HandleBalanceChangedByType(param1:Number, param2:String) : void
      {
         if(param2 == CurrencyManager.TYPE_COINS)
         {
            if(param1 != this.m_PrevCoinBalance)
            {
               this.m_HasBoughtCoins = true;
            }
            this.m_PrevCoinBalance = param1;
         }
      }
      
      public function HandleXPTotalChanged(param1:Number, param2:int) : void
      {
      }
   }
}
