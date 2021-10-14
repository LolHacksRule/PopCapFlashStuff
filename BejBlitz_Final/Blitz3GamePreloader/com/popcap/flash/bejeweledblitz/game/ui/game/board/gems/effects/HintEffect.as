package com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   
   public class HintEffect extends SpriteEffect
   {
      
      public static const MAX_TIME:int = 150;
       
      
      private var m_App:Blitz3App;
      
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
      
      public function HintEffect(param1:Blitz3App, param2:Gem)
      {
         super();
         this.m_App = param1;
         this.mLocus = param2;
         this.init();
      }
      
      private function init() : void
      {
         this.mArrowAnim = this.m_App.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_HINT_ARROWS);
         this.mBurstAnim = this.m_App.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_HINT_FLASH);
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
         if(this.mIsDone)
         {
            return;
         }
         x = this.mLocus.x * 40 + 20;
         y = this.mLocus.y * 40 + 20;
         this.mBurstAnim.mFrame = int(this.mTimer * 0.01 * 15);
         this.mBurstBitmap.x = -(this.mBurstAnim.width * 0.5);
         this.mBurstBitmap.y = -(this.mBurstAnim.height * 0.5);
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
      
      override public function Draw() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(this.mIsDone)
         {
            return;
         }
         var _loc1_:Number = 4 * (this.mTimer * 0.01) * Math.PI;
         _loc2_ = 4 * Math.sin(_loc1_);
         _loc3_ = this.mArrowAnim.width * 0.5;
         _loc4_ = this.mArrowAnim.height * 0.5;
         this.mUpArrowBitmap.x = -_loc3_;
         this.mUpArrowBitmap.y = 20 - _loc4_ + _loc2_;
         this.mLeftArrowBitmap.x = -20 - _loc3_ - _loc2_;
         this.mLeftArrowBitmap.y = -_loc4_;
         this.mDownArrowBitmap.x = -_loc3_;
         this.mDownArrowBitmap.y = -20 - _loc4_ - _loc2_;
         this.mRightArrowBitmap.x = 20 - _loc3_ + _loc2_;
         this.mRightArrowBitmap.y = -_loc4_;
      }
   }
}
