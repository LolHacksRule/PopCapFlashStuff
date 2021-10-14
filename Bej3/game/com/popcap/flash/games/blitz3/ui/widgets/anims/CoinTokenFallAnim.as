package com.popcap.flash.games.blitz3.ui.widgets.anims
{
   import com.popcap.flash.games.blitz3.ui.sprites.CoinSprite;
   import flash.geom.Point;
   
   public class CoinTokenFallAnim
   {
       
      
      private var mIsDone:Boolean = false;
      
      private var mIsInited:Boolean = false;
      
      private var mCoinSprite:CoinSprite = null;
      
      private var mStartPos:Point;
      
      private var mRangePos:Point;
      
      private var mTimer:int = 0;
      
      private var mDuration:int = 0;
      
      public function CoinTokenFallAnim(coinSprite:CoinSprite, duration:int)
      {
         this.mStartPos = new Point();
         this.mRangePos = new Point();
         super();
         this.mCoinSprite = coinSprite;
         this.mDuration = duration;
      }
      
      public function Update() : void
      {
         if(this.mIsDone)
         {
            return;
         }
         if(!this.mIsInited)
         {
            this.Init();
         }
         if(this.mTimer == this.mDuration)
         {
            this.mCoinSprite.parent.removeChild(this.mCoinSprite);
            this.mIsDone = true;
            return;
         }
         var percent:Number = this.mTimer / this.mDuration;
         this.mCoinSprite.y = this.mRangePos.y * percent + this.mStartPos.y;
         this.mCoinSprite.alpha = 1 - percent;
         var scale:Number = 1 - percent * 0.8;
         this.mCoinSprite.scaleX = scale;
         this.mCoinSprite.scaleY = scale;
         ++this.mTimer;
      }
      
      public function IsDone() : Boolean
      {
         return this.mIsDone;
      }
      
      private function Init() : void
      {
         this.mStartPos.x = this.mCoinSprite.x;
         this.mStartPos.y = this.mCoinSprite.y;
         this.mRangePos.x = 0;
         this.mRangePos.y = 40;
         this.mIsInited = true;
      }
   }
}
