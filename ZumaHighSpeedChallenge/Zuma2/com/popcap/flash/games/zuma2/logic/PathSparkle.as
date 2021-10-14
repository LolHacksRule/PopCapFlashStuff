package com.popcap.flash.games.zuma2.logic
{
   import com.popcap.flash.framework.resources.images.ImageInst;
   import flash.display.Bitmap;
   import flash.display.BlendMode;
   import flash.display.PixelSnapping;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   
   public class PathSparkle
   {
       
      
      public var mSparkleImage:ImageInst;
      
      public var mX:Number;
      
      public var mY:Number;
      
      public var mSparkleSprite:Sprite;
      
      public var mApp:Zuma2App;
      
      public var mUpdateCount:int;
      
      public var mPri:int;
      
      public var mCel:int;
      
      public var mSparkleBitmap:Bitmap;
      
      public function PathSparkle(param1:Zuma2App)
      {
         super();
         this.mApp = param1;
         this.mCel = 0;
         this.mUpdateCount = 0;
         this.mPri = 0;
         this.mSparkleSprite = new Sprite();
         this.mSparkleImage = this.mApp.imageManager.getImageInst(Zuma2Images.IMAGE_PATH_SPARKLES);
         this.mSparkleImage.mFrame = this.mCel;
         this.mSparkleBitmap = new Bitmap(this.mSparkleImage.pixels,PixelSnapping.NEVER,true);
         this.mSparkleBitmap.x = -this.mSparkleBitmap.width / 2;
         this.mSparkleBitmap.y = -this.mSparkleBitmap.height / 2;
         this.mSparkleBitmap.blendMode = BlendMode.ADD;
         var _loc2_:ColorTransform = this.mSparkleBitmap.transform.colorTransform;
         _loc2_.redMultiplier = 1;
         _loc2_.blueMultiplier = 0;
         _loc2_.greenMultiplier = 1;
         this.mSparkleBitmap.transform.colorTransform = _loc2_;
         this.mSparkleSprite.addChild(this.mSparkleBitmap);
         this.mApp.mLayers[2].mForeground.addChild(this.mSparkleSprite);
      }
      
      public function Delete() : void
      {
         if(this.mSparkleSprite.parent != null)
         {
            this.mSparkleSprite.parent.removeChild(this.mSparkleSprite);
         }
      }
      
      public function Update() : void
      {
         this.mSparkleImage.mFrame = this.mCel;
         this.mSparkleBitmap.bitmapData = this.mSparkleImage.pixels;
         this.mSparkleSprite.x = this.mX * Zuma2App.SHRINK_PERCENT;
         this.mSparkleSprite.y = this.mY * Zuma2App.SHRINK_PERCENT;
      }
   }
}
