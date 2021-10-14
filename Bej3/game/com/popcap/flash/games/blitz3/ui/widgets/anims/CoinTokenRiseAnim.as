package com.popcap.flash.games.blitz3.ui.widgets.anims
{
   import com.popcap.flash.games.blitz3.ui.sprites.CoinSprite;
   
   public class CoinTokenRiseAnim
   {
       
      
      private var mIsDone:Boolean = false;
      
      private var mTimer:int = 0;
      
      private var mDuration:int = 0;
      
      private var mCoinSprite:CoinSprite = null;
      
      private var mStartY:int = 0;
      
      private var mEndY:int = 0;
      
      private var mRangeY:int = 0;
      
      public function CoinTokenRiseAnim(coinSprite:CoinSprite, duration:int)
      {
         super();
         this.mCoinSprite = coinSprite;
         this.mDuration = duration;
         this.mStartY = coinSprite.y;
         this.mEndY = this.mStartY - 40;
         this.mRangeY = this.mEndY - this.mStartY;
      }
      
      public function Update() : void
      {
         if(this.mIsDone)
         {
            return;
         }
         var percent:Number = this.mTimer / this.mDuration;
         this.mCoinSprite.y = this.mRangeY * percent + this.mStartY;
         this.mCoinSprite.scaleX = percent * 0.5 + 0.5;
         this.mCoinSprite.scaleY = percent * 0.5 + 0.5;
         ++this.mTimer;
         if(this.mTimer == this.mDuration)
         {
            this.mIsDone = true;
         }
      }
      
      public function IsDone() : Boolean
      {
         return this.mIsDone;
      }
   }
}
