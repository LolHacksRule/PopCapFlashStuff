package com.popcap.flash.games.blitz3.ui.widgets.effects
{
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.display.Bitmap;
   
   public class HintEffect extends SpriteEffect
   {
      
      public static const MAX_TIME:int = 150;
       
      
      private var mApp:Blitz3App;
      
      private var mLocus:Gem;
      
      private var mX:Number = 0;
      
      private var mY:Number = 0;
      
      private var mArrowAnim:ImageInst;
      
      private var mBurstAnim:ImageInst;
      
      private var mBurstBitmap:Bitmap;
      
      private var mLeftArrowBitmap:Bitmap;
      
      private var mRightArrowBitmap:Bitmap;
      
      private var mUpArrowBitmap:Bitmap;
      
      private var mDownArrowBitmap:Bitmap;
      
      private var mTimer:int = 0;
      
      private var mBurstDone:Boolean = false;
      
      private var mIsDone:Boolean = false;
      
      public function HintEffect(app:Blitz3App, locus:Gem)
      {
         super();
         this.mApp = app;
         this.mLocus = locus;
         this.init();
      }
      
      private function init() : void
      {
         this.mArrowAnim = this.mApp.imageManager.getImageInst(Blitz3Images.IMAGE_GEM_HINT_ARROWS);
         this.mBurstAnim = this.mApp.imageManager.getImageInst(Blitz3Images.IMAGE_GEM_HINT_FLASH);
         this.mBurstBitmap = new Bitmap();
         addChild(this.mBurstBitmap);
         this.mUpArrowBitmap = new Bitmap(this.mArrowAnim.mSource.mFrames[0]);
         this.mLeftArrowBitmap = new Bitmap(this.mArrowAnim.mSource.mFrames[1]);
         this.mDownArrowBitmap = new Bitmap(this.mArrowAnim.mSource.mFrames[2]);
         this.mRightArrowBitmap = new Bitmap(this.mArrowAnim.mSource.mFrames[3]);
         addChild(this.mUpArrowBitmap);
         addChild(this.mLeftArrowBitmap);
         addChild(this.mDownArrowBitmap);
         addChild(this.mRightArrowBitmap);
      }
      
      override public function IsDone() : Boolean
      {
         return this.mIsDone;
      }
      
      override public function Update() : void
      {
         if(!this.mLocus.canMatch() && this.mLocus.type != Gem.TYPE_RAINBOW)
         {
            this.mIsDone = true;
         }
         if(this.mIsDone)
         {
            return;
         }
         x = this.mLocus.x * 40 + 20;
         y = this.mLocus.y * 40 + 20;
         this.mBurstAnim.mFrame = int(this.mTimer / 100 * 15);
         this.mBurstBitmap.x = -(this.mBurstAnim.width / 2);
         this.mBurstBitmap.y = -(this.mBurstAnim.height / 2);
         if(this.mBurstAnim.mFrame >= this.mBurstAnim.mSource.mNumFrames)
         {
            this.mBurstBitmap.visible = false;
         }
         else
         {
            this.mBurstBitmap.bitmapData = this.mBurstAnim.pixels;
         }
         if(this.mTimer == MAX_TIME)
         {
            this.mIsDone = true;
         }
         ++this.mTimer;
      }
      
      override public function Draw(postFX:Boolean) : void
      {
         if(postFX)
         {
            return;
         }
         if(this.mIsDone)
         {
            return;
         }
         var angle:Number = 4 * (this.mTimer / 100) * Math.PI;
         var bounce:Number = 4 * Math.sin(angle);
         var halfW:Number = this.mArrowAnim.width / 2;
         var halfH:Number = this.mArrowAnim.height / 2;
         this.mUpArrowBitmap.x = -halfW;
         this.mUpArrowBitmap.y = 20 - halfH + bounce;
         this.mLeftArrowBitmap.x = -20 - halfW - bounce;
         this.mLeftArrowBitmap.y = -halfH;
         this.mDownArrowBitmap.x = -halfW;
         this.mDownArrowBitmap.y = -20 - halfH - bounce;
         this.mRightArrowBitmap.x = 20 - halfW + bounce;
         this.mRightArrowBitmap.y = -halfH;
      }
   }
}
