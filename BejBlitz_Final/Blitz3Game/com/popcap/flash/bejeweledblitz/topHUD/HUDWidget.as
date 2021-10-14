package com.popcap.flash.bejeweledblitz.topHUD
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.game.session.IUserDataHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import com.popcap.flash.bejeweledblitz.logic.tokens.CoinToken;
   import com.popcap.flash.bejeweledblitz.logic.tokens.ICoinTokenLogicHandler;
   import com.popcap.flash.bejeweledblitz.party.PartyServerIO;
   import flash.geom.Point;
   
   public class HUDWidget extends HudViewWidget implements IUserDataHandler, IBlitzLogicHandler, ICoinTokenLogicHandler
   {
       
      
      private var _currencyContainers:Vector.<HUDCurrencyContainer>;
      
      private var _app:Blitz3Game;
      
      private var _targetCoins:Number = -1;
      
      private var _coinRoll:Number = 0;
      
      private var _targetShards:Number = -1;
      
      private var _shardRoll:Number = 0;
      
      private var _targetDiamonds:Number = -1;
      
      private var _diamondRoll:Number = 0;
      
      private var _targetGoldBars:Number = -1;
      
      private var _goldbarRoll:Number = 0;
      
      private var _currentTokens:Number = 0;
      
      public function HUDWidget(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._app.sessionData.userData.currencyManager.AddHandler(this);
         this._app.logic.AddHandler(this);
         this._app.logic.coinTokenLogic.AddHandler(this);
      }
      
      public function Init() : void
      {
         var _loc2_:HUDCurrencyContainer = null;
         var _loc1_:CurrencyManager = this._app.sessionData.userData.currencyManager;
         this._currencyContainers = new Vector.<HUDCurrencyContainer>();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc1_.currencyTypes.length)
         {
            _loc2_ = new HUDCurrencyContainer(this._app,_loc1_.currencyTypes[_loc3_]);
            _loc2_.setEnabled(true);
            this._currencyContainers.push(_loc2_);
            _loc3_++;
         }
         this.currency_placeholder1.addChild(this._currencyContainers[0]);
         this.currency_placeholder2.addChild(this._currencyContainers[1]);
         this.currency_placeholder3.addChild(this._currencyContainers[2]);
         this.currency_placeholder4.addChild(this._currencyContainers[3]);
         this.currency_placeholder5.addChild(this._currencyContainers[4]);
      }
      
      public function HandleBalanceChangedByType(param1:Number, param2:String) : void
      {
         if(param2 == CurrencyManager.TYPE_COINS)
         {
            if(this._targetCoins != param1)
            {
               this._targetCoins = param1;
            }
            this.Update();
         }
         else if(param2 == CurrencyManager.TYPE_SHARDS)
         {
            if(this._targetShards != param1)
            {
               this._targetShards = param1;
            }
            this.Update();
         }
         else if(param2 == CurrencyManager.TYPE_DIAMONDS)
         {
            if(this._targetDiamonds != param1)
            {
               this._targetDiamonds = param1;
            }
            this.Update();
         }
         else if(param2 == CurrencyManager.TYPE_GOLDBARS)
         {
            if(this._targetGoldBars != param1)
            {
               this._targetGoldBars = param1;
            }
            this.Update();
         }
         else if(param2 == CurrencyManager.TYPE_TOKENS)
         {
            if(PartyServerIO.purchasedTokens != param1)
            {
               PartyServerIO.purchasedTokens = param1;
            }
            this.Update();
         }
      }
      
      public function HandleXPTotalChanged(param1:Number, param2:int) : void
      {
      }
      
      public function Update() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(this._coinRoll != this._targetCoins)
         {
            _loc1_ = Math.round((this._targetCoins - this._coinRoll) / 10);
            if(_loc1_ <= 2)
            {
               this._coinRoll = this._targetCoins;
            }
            else
            {
               this._coinRoll += _loc1_;
            }
            this.getCurrencyContainerByType(CurrencyManager.TYPE_COINS).updateValue(this._coinRoll);
         }
         if(this._shardRoll != this._targetShards)
         {
            _loc1_ = Math.round((this._targetShards - this._shardRoll) / 10);
            if(_loc1_ <= 2)
            {
               this._shardRoll = this._targetShards;
            }
            else
            {
               this._shardRoll += _loc1_;
            }
            this.getCurrencyContainerByType(CurrencyManager.TYPE_SHARDS).updateValue(this._shardRoll);
         }
         if(this._diamondRoll != this._targetDiamonds)
         {
            _loc1_ = Math.round((this._targetDiamonds - this._diamondRoll) / 10);
            if(_loc1_ <= 2)
            {
               this._diamondRoll = this._targetDiamonds;
            }
            else
            {
               this._diamondRoll += _loc1_;
            }
            this.getCurrencyContainerByType(CurrencyManager.TYPE_DIAMONDS).updateValue(this._diamondRoll);
         }
         if(this._goldbarRoll != this._targetGoldBars)
         {
            _loc1_ = Math.round((this._targetGoldBars - this._goldbarRoll) / 10);
            if(_loc1_ <= 2)
            {
               this._goldbarRoll = this._targetGoldBars;
            }
            else
            {
               this._goldbarRoll += _loc1_;
            }
            this.getCurrencyContainerByType(CurrencyManager.TYPE_GOLDBARS).updateValue(this._goldbarRoll);
         }
         if(this._currentTokens != PartyServerIO.purchasedTokens)
         {
            _loc2_ = Math.round((PartyServerIO.purchasedTokens - this._currentTokens) / 5);
            if(_loc2_ <= 2)
            {
               this._currentTokens = PartyServerIO.purchasedTokens;
            }
            else
            {
               this._currentTokens += _loc2_;
            }
            this.getCurrencyContainerByType(CurrencyManager.TYPE_TOKENS).updateValue(this._currentTokens);
         }
      }
      
      public function getCurrencyContainerByType(param1:String) : HUDCurrencyContainer
      {
         var _loc2_:int = this._currencyContainers.length;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            if(this._currencyContainers[_loc3_].currencyType == param1)
            {
               return this._currencyContainers[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      public function enableCurrencyPurchaseButtons(param1:Boolean) : void
      {
         var _loc2_:int = this._currencyContainers.length;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            this._currencyContainers[_loc3_].setEnabled(param1);
            _loc3_++;
         }
      }
      
      public function highlightCurrencyLabel(param1:String) : void
      {
         var _loc2_:HUDCurrencyContainer = this.getCurrencyContainerByType(param1);
         var _loc3_:Point = new Point(0,0);
         if(param1 == CurrencyManager.TYPE_COINS)
         {
            _loc3_ = this._app.topLayer.globalToLocal(currency_placeholder1.parent.localToGlobal(new Point(currency_placeholder1.x,currency_placeholder1.y)));
         }
         else if(param1 == CurrencyManager.TYPE_SHARDS)
         {
            _loc3_ = this._app.topLayer.globalToLocal(currency_placeholder2.parent.localToGlobal(new Point(currency_placeholder2.x,currency_placeholder2.y)));
         }
         _loc2_.x = _loc3_.x;
         _loc2_.y = _loc3_.y;
         this._app.topLayer.addChild(_loc2_);
      }
      
      public function reclaimCurrencyLabel(param1:String = "") : void
      {
         var _loc2_:HUDCurrencyContainer = null;
         var _loc3_:Point = new Point(0,0);
         if(param1 == CurrencyManager.TYPE_COINS || param1 == "")
         {
            _loc2_ = this.getCurrencyContainerByType(CurrencyManager.TYPE_COINS);
            if(_loc2_.parent != null && _loc2_.parent == this._app.topLayer)
            {
               Utils.removeAllChildrenFrom(this.currency_placeholder1);
               _loc3_ = this.currency_placeholder1.globalToLocal(_loc2_.parent.localToGlobal(new Point(_loc2_.x,_loc2_.y)));
               _loc2_.x = _loc3_.x;
               _loc2_.y = _loc3_.y;
               this.currency_placeholder1.addChild(_loc2_);
            }
         }
         if(param1 == CurrencyManager.TYPE_SHARDS || param1 == "")
         {
            _loc2_ = this.getCurrencyContainerByType(CurrencyManager.TYPE_SHARDS);
            if(_loc2_.parent != null && _loc2_.parent == this._app.topLayer)
            {
               Utils.removeAllChildrenFrom(this.currency_placeholder2);
               _loc3_ = this.currency_placeholder2.globalToLocal(_loc2_.parent.localToGlobal(new Point(_loc2_.x,_loc2_.y)));
               _loc2_.x = _loc3_.x;
               _loc2_.y = _loc3_.y;
               this.currency_placeholder2.addChild(_loc2_);
            }
         }
      }
      
      public function HandleGameLoad() : void
      {
      }
      
      public function HandleGameBegin() : void
      {
      }
      
      public function HandleGameAbort() : void
      {
      }
      
      public function HandleGamePaused() : void
      {
      }
      
      public function HandleGameResumed() : void
      {
      }
      
      public function HandleScore(param1:ScoreValue) : void
      {
      }
      
      public function HandleGameEnd() : void
      {
         this.reclaimCurrencyLabel();
      }
      
      public function HandleBlockingEvent() : void
      {
      }
      
      public function HandleCoinCreated(param1:CoinToken) : void
      {
      }
      
      public function HandleCoinCollected(param1:CoinToken) : void
      {
         if(param1.container == null)
         {
            this.reclaimCurrencyLabel(CurrencyManager.TYPE_COINS);
         }
         else
         {
            param1.container = null;
         }
      }
      
      public function HandleMultiCoinCollectionSkipped(param1:int) : void
      {
      }
      
      public function HandleGameTimeDelayed() : void
      {
      }
   }
}
