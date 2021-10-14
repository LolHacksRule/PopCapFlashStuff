package com.popcap.flash.games.blitz3.ui.widgets.anims
{
   import com.popcap.flash.games.blitz3.ui.sprites.CoinSprite;
   import flash.geom.Point;
   
   public class CoinTokenTravelAnim
   {
       
      
      private var mIsInited:Boolean = false;
      
      private var mIsDone:Boolean = false;
      
      private var mCoinSprite:CoinSprite;
      
      private var mStartPos:Point;
      
      private var mRangePos:Point;
      
      private var mTimer:int = 0;
      
      private var mDuration:int = 0;
      
      public function CoinTokenTravelAnim(coinSprite:CoinSprite, endX:int, endY:int, duration:int)
      {
         this.mStartPos = new Point();
         this.mRangePos = new Point();
         super();
         this.mRangePos.x = endX;
         this.mRangePos.y = endY;
         this.mCoinSprite = coinSprite;
         this.mDuration = duration;
      }
      
      public function Update() : void
      {
         if(this.mIsDone)
         {
            return;
         }
         if(this.mTimer >= this.mDuration)
         {
            this.mIsDone = true;
            return;
         }
         if(!this.mIsInited)
         {
            this.Init();
         }
         var percent:Number = this.mTimer / this.mDuration;
         this.mCoinSprite.x = this.mRangePos.x * percent + this.mStartPos.x;
         this.mCoinSprite.y = this.mRangePos.y * percent + this.mStartPos.y;
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
         this.mRangePos.x -= this.mStartPos.x;
         this.mRangePos.y -= this.mStartPos.y;
         this.mIsInited = true;
      }
   }
}
