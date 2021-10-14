package com.popcap.flash.games.zuma2.logic
{
   import com.popcap.flash.framework.resources.images.ImageInst;
   import flash.display.Bitmap;
   import flash.display.PixelSnapping;
   import flash.display.Sprite;
   
   public class RollerDigit
   {
       
      
      public var mX:Number;
      
      public var mY:Number;
      
      public var mRestingY:int;
      
      public var mNum:int;
      
      public var mDelay:int;
      
      public var mNumberMask:Sprite;
      
      public var mNumberImage:ImageInst;
      
      public var mVY:Number;
      
      public var mNextNumberImage:ImageInst;
      
      public var mApp:Zuma2App;
      
      public var mNumberSprite:Sprite;
      
      public var mBounceState:int;
      
      public var mNumberBitmap:Bitmap;
      
      public var mNextNumberBitmap:Bitmap;
      
      public function RollerDigit(param1:Zuma2App)
      {
         super();
         this.mApp = param1;
         this.mNum = -1;
         this.mX = 0;
         this.mY = 0;
         this.mNumberMask = new Sprite();
         this.mNumberMask.graphics.beginFill(16777215);
         this.mNumberMask.graphics.drawRect(0,-4,10,22 + 1 / 3);
         this.mNumberMask.graphics.endFill();
         this.mNumberImage = this.mApp.imageManager.getImageInst(Zuma2Images.IMAGE_UI_SCORENUMBERS);
         this.mNumberImage.mFrame = 0;
         this.mNumberBitmap = new Bitmap(this.mNumberImage.pixels,PixelSnapping.NEVER,true);
         this.mNextNumberBitmap = new Bitmap(this.mNumberImage.pixels,PixelSnapping.NEVER,true);
         this.mNextNumberBitmap.mask = this.mNumberMask;
         this.mNumberSprite = new Sprite();
         this.mNumberBitmap.mask = this.mNumberMask;
         this.mNumberSprite.mask = this.mNumberMask;
         this.mNumberSprite.addChild(this.mNumberMask);
         this.mNumberSprite.addChild(this.mNumberBitmap);
         this.mNumberSprite.addChild(this.mNextNumberBitmap);
         this.mApp.mLayers[0].mForeground.addChild(this.mNumberSprite);
      }
   }
}
