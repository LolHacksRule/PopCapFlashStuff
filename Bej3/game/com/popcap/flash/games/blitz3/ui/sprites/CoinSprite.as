package com.popcap.flash.games.blitz3.ui.sprites
{
   import com.popcap.flash.framework.resources.images.ImageInst;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class CoinSprite extends Sprite
   {
       
      
      public var isSpinning:Boolean = false;
      
      private var mTimer:int = 0;
      
      private var mImage:ImageInst;
      
      private var mSmallImage:ImageInst;
      
      private var mBitmap:Bitmap;
      
      private var mSmallBitmap:Bitmap;
      
      public function CoinSprite()
      {
         super();
      }
      
      public function Reset() : void
      {
         if(parent != null)
         {
            parent.removeChild(this);
         }
         this.isSpinning = false;
         if(this.mBitmap.parent != null)
         {
            this.mBitmap.parent.removeChild(this.mBitmap);
         }
         addChild(this.mSmallBitmap);
      }
      
      public function Update() : void
      {
         if(!this.isSpinning)
         {
            return;
         }
         if(this.mSmallBitmap.parent != null)
         {
            removeChild(this.mSmallBitmap);
            addChild(this.mBitmap);
         }
         var numFrames:int = this.mImage.mSource.mNumFrames;
         var fps:int = 24;
         var percent:Number = this.mTimer * 0.01;
         var frame:int = percent * fps % numFrames;
         this.mImage.mFrame = frame;
         this.mBitmap.bitmapData = this.mImage.pixels;
         ++this.mTimer;
      }
      
      private function GetImageStrip() : ImageInst
      {
         return new ImageInst();
      }
      
      private function GetSmallImageStrip() : ImageInst
      {
         return new ImageInst();
      }
   }
}
