package com.popcap.flash.bejeweledblitz.game.ui.coins
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class CoinSprite extends Sprite
   {
       
      
      private var m_App:Blitz3App;
      
      public var isSpinning:Boolean = false;
      
      public var value:int = 0;
      
      private var mTimer:int = 0;
      
      private var mCoinAnimation:ImageInst;
      
      private var mCoinImage:ImageInst;
      
      private var mAnimationBitmap:Bitmap;
      
      private var mCoinBitmap:Bitmap;
      
      public function CoinSprite(app:Blitz3App, val:int)
      {
         super();
         this.m_App = app;
         this.value = val;
         this.mCoinAnimation = app.ImageManager.getImageInst(Blitz3GameImages.IMAGE_COIN_ANIMATION);
         this.mCoinImage = app.ImageManager.getImageInst(Blitz3GameImages.IMAGE_COIN);
         this.mAnimationBitmap = new Bitmap(this.mCoinAnimation.pixels);
         this.mCoinBitmap = new Bitmap(this.mCoinImage.pixels);
         this.mAnimationBitmap.x = -(this.mAnimationBitmap.width * 0.5);
         this.mAnimationBitmap.y = -(this.mAnimationBitmap.height * 0.5);
         this.mCoinBitmap.x = -(this.mCoinBitmap.width * 0.5);
         this.mCoinBitmap.y = -(this.mCoinBitmap.height * 0.5);
         addChild(this.mCoinBitmap);
      }
      
      public function Reset() : void
      {
         if(parent != null)
         {
            parent.removeChild(this);
         }
         this.isSpinning = false;
         if(this.mAnimationBitmap.parent != null)
         {
            this.mAnimationBitmap.parent.removeChild(this.mAnimationBitmap);
         }
         addChild(this.mCoinBitmap);
      }
      
      public function Update() : void
      {
         if(!this.isSpinning)
         {
            return;
         }
         if(this.mCoinBitmap.parent != null)
         {
            removeChild(this.mCoinBitmap);
            addChild(this.mAnimationBitmap);
         }
         var numFrames:int = this.mCoinAnimation.mSource.mNumFrames;
         var percent:Number = this.mTimer * 0.01;
         var frame:int = percent * 24 % numFrames;
         this.mCoinAnimation.mFrame = frame;
         this.mAnimationBitmap.bitmapData = this.mCoinAnimation.pixels;
         ++this.mTimer;
      }
   }
}
