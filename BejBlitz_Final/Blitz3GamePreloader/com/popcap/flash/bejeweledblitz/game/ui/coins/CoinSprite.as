package com.popcap.flash.bejeweledblitz.game.ui.coins
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
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
      
      private var mCoinMC:MovieClip;
      
      public var currencyType:String;
      
      public function CoinSprite(param1:Blitz3App, param2:int, param3:String = "coins")
      {
         super();
         this.m_App = param1;
         this.value = param2;
         this.currencyType = param3;
         this.mCoinAnimation = param1.ImageManager.getImageInst(Blitz3GameImages.IMAGE_COIN_ANIMATION);
         this.mCoinImage = param1.ImageManager.getImageInst(Blitz3GameImages.IMAGE_COIN);
         this.mCoinMC = new MovieClip();
         this.mAnimationBitmap = new Bitmap(this.mCoinAnimation.pixels);
         if(param3 == CurrencyManager.TYPE_COINS)
         {
            this.mCoinBitmap = new Bitmap(this.mCoinImage.pixels);
            this.mCoinMC.addChild(this.mCoinBitmap);
         }
         else
         {
            this.mCoinMC.addChild(CurrencyManager.getImageByType(param3,false));
         }
         this.mAnimationBitmap.x = -(this.mAnimationBitmap.width * 0.5);
         this.mAnimationBitmap.y = -(this.mAnimationBitmap.height * 0.5);
         this.mCoinMC.x = -(this.mCoinMC.width * 0.5);
         this.mCoinMC.y = -(this.mCoinMC.height * 0.5);
         addChild(this.mCoinMC);
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
         addChild(this.mCoinMC);
      }
      
      public function Update() : void
      {
         if(!this.isSpinning)
         {
            return;
         }
         if(this.mCoinMC != null && this.mCoinMC.parent != null)
         {
            Utils.removeAllChildrenFrom(this.mCoinMC);
            removeChild(this.mCoinMC);
            addChild(this.mAnimationBitmap);
         }
         var _loc1_:int = this.mCoinAnimation.mSource.mNumFrames;
         var _loc3_:Number = this.mTimer * 0.01;
         var _loc4_:int = _loc3_ * 24 % _loc1_;
         this.mCoinAnimation.mFrame = _loc4_;
         this.mAnimationBitmap.bitmapData = this.mCoinAnimation.pixels;
         ++this.mTimer;
      }
   }
}
