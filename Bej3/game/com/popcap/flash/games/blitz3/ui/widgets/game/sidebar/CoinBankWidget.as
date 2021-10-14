package com.popcap.flash.games.blitz3.ui.widgets.game.sidebar
{
   import com.popcap.flash.framework.events.EventBus;
   import com.popcap.flash.framework.events.EventContext;
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import com.popcap.flash.games.blitz3.ui.widgets.boosts.MediumCoinLabel;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class CoinBankWidget extends Sprite
   {
      
      public static const ANIM_TIME:int = 50;
      
      public static const APPEAR_TIME:int = 300;
       
      
      private var mApp:Blitz3App;
      
      private var mFormat:TextFormat;
      
      private var mBitmap:Bitmap;
      
      private var mBalance:MediumCoinLabel;
      
      private var mCollector:Sprite;
      
      private var mMover:Sprite;
      
      private var mCoinCap:int = -1;
      
      private var mCoinRoll:int = 0;
      
      private var mLastCoins:int = 0;
      
      private var mCoinRollTimer:int = 0;
      
      private var mAppearTimer:int = 0;
      
      private var mMoverTimer:int = 0;
      
      public function CoinBankWidget(app:Blitz3App)
      {
         super();
         this.mApp = app;
         this.mBalance = new MediumCoinLabel();
         this.mCollector = new Sprite();
         this.mMover = new Sprite();
         EventBus.GetGlobal().CaptureEvent("CoinTokenCollectAnimStartEvent",this.HandleCoinTokenCollectAnimStartEvent);
         EventBus.GetGlobal().CaptureEvent("CoinTokenCollectAnimCompleteEvent",this.HandleCoinTokenCollectAnimCompleteEvent);
      }
      
      public function Init() : void
      {
         cacheAsBitmap = true;
         this.mFormat = new TextFormat();
         this.mFormat.font = Blitz3Fonts.BLITZ_STANDARD;
         this.mFormat.size = 16;
         this.mFormat.align = TextFormatAlign.CENTER;
         addChild(this.mMover);
         this.mMover.addChild(this.mCollector);
      }
      
      public function Reset() : void
      {
         this.mCoinCap = this.mApp.sessionData.userData.GetCoins();
         this.mLastCoins = this.mCoinCap;
         this.mCoinRoll = this.mCoinCap;
         var coinString:String = StringUtils.InsertNumberCommas(this.mCoinRoll);
         this.mBalance.SetText(coinString);
         this.mAppearTimer = 0;
         this.mMoverTimer = 0;
      }
      
      public function Update() : void
      {
         var coinString:String = null;
         if(this.mApp.logic.timerLogic.IsPaused())
         {
            return;
         }
         var percent:Number = 0;
         if(this.mAppearTimer > 0)
         {
            --this.mAppearTimer;
            ++this.mMoverTimer;
            this.mMoverTimer = Math.min(this.mMoverTimer,ANIM_TIME);
            percent = this.Ease(this.mMoverTimer / ANIM_TIME);
         }
         else
         {
            --this.mMoverTimer;
            this.mMoverTimer = Math.max(this.mMoverTimer,0);
            percent = this.Ease(this.mMoverTimer / ANIM_TIME);
         }
         var redraw:Boolean = false;
         if(this.mCoinRoll < this.mCoinCap)
         {
            ++this.mCoinRollTimer;
            percent = this.mCoinRollTimer / ANIM_TIME;
            percent = percent > 1 ? Number(1) : Number(percent);
            this.mCoinRoll = (this.mCoinCap - this.mLastCoins) * percent + this.mLastCoins;
            redraw = true;
         }
         else if(this.mCoinRoll > this.mCoinCap)
         {
            this.mCoinRoll = this.mCoinCap;
            redraw = true;
         }
         if(redraw)
         {
            coinString = StringUtils.InsertNumberCommas(this.mCoinRoll);
            this.mBalance.SetText(coinString);
         }
      }
      
      private function Ease(input:Number) : Number
      {
         return Math.sin(input * Math.PI * 0.5);
      }
      
      private function HandleCoinTokenCollectAnimStartEvent(ctx:EventContext) : void
      {
         this.mAppearTimer = APPEAR_TIME;
      }
      
      private function HandleCoinTokenCollectAnimCompleteEvent(ctx:EventContext) : void
      {
         var newCap:int = this.mCoinCap + 100;
         if(this.mCoinCap != newCap)
         {
            this.mLastCoins = this.mCoinRoll;
            this.mCoinCap = newCap;
            this.mCoinRollTimer = 0;
         }
      }
   }
}
