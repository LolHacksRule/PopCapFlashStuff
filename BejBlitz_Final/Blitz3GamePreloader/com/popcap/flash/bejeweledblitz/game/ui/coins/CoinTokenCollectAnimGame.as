package com.popcap.flash.bejeweledblitz.game.ui.coins
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.topHUD.HUDCurrencyContainer;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class CoinTokenCollectAnimGame extends CoinTokenCollectAnim
   {
      
      private static const TRAVEL_DURATION:int = 95;
       
      
      private var _coinBank:Sprite;
      
      private var mTimer:int = 0;
      
      private var mPhase:int = 0;
      
      private var mStartX:int;
      
      private var mStartY:int;
      
      private var mEndX:int;
      
      private var mEndY:int;
      
      public function CoinTokenCollectAnimGame(param1:Blitz3App, param2:CoinSprite)
      {
         super(param1,param2);
         this._coinBank = (m_App as Blitz3Game).topHUD.getCurrencyContainerByType(param2.currencyType);
         var _loc3_:Point = new Point(param2.x,param2.y);
         if(param2.parent != null)
         {
            _loc3_ = this._coinBank.globalToLocal(param2.parent.localToGlobal(_loc3_));
         }
         param2.x = _loc3_.x;
         param2.y = _loc3_.y;
         this._coinBank.addChild(param2);
         this.mStartX = param2.x;
         this.mStartY = param2.y;
         this.mEndX = -this.mStartX + param2.width * 0.5 + 6;
         this.mEndY = -this.mStartY + param2.height * 0.5;
         (this._coinBank as HUDCurrencyContainer).setEnabled(true);
         (this._coinBank as HUDCurrencyContainer).setPurchaseDisabled();
         (m_App as Blitz3Game).topHUD.highlightCurrencyLabel(param2.currencyType);
      }
      
      override public function Update() : void
      {
         var _loc1_:Number = NaN;
         if(isDone)
         {
            return;
         }
         if(m_App.mIsReplay)
         {
            isDone = true;
         }
         _loc1_ = this.mTimer / TRAVEL_DURATION;
         coinSprite.x = this.mStartX + this.mEndX * _loc1_;
         coinSprite.y = this.mStartY + this.mEndY * _loc1_;
         if(_loc1_ >= 1)
         {
            isDone = true;
            m_App.sessionData.userData.currencyManager.AddCurrencyByType(coinSprite.value,coinSprite.currencyType);
         }
         else
         {
            ++this.mTimer;
         }
      }
   }
}
