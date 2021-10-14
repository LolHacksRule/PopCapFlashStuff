package com.popcap.flash.games.zuma2.logic
{
   import com.popcap.flash.framework.resources.images.ImageInst;
   import flash.display.Bitmap;
   import flash.display.BlendMode;
   import flash.display.PixelSnapping;
   import flash.display.Sprite;
   
   public class FireRing
   {
       
      
      public var mFireSprite:Sprite;
      
      public var mAlpha:Number;
      
      public var mFireBitmap:Bitmap;
      
      public var mApp:Zuma2App;
      
      public var mFireImage:ImageInst;
      
      public var mCel:int;
      
      public function FireRing(param1:Zuma2App)
      {
         super();
         this.mAlpha = 0;
         this.mCel = 0;
         this.mApp = param1;
         this.mFireImage = this.mApp.imageManager.getImageInst(Zuma2Images.IMAGE_DEATHSKULL_FIRERING);
         this.mFireImage.mFrame = 0;
         this.mFireBitmap = new Bitmap(this.mFireImage.pixels,PixelSnapping.NEVER,true);
         this.mFireBitmap.x = -this.mFireBitmap.width / 2;
         this.mFireBitmap.y = -this.mFireBitmap.height / 2;
         this.mFireBitmap.blendMode = BlendMode.ADD;
         this.mFireSprite = new Sprite();
         this.mFireSprite.alpha = 0;
         this.mFireSprite.addChild(this.mFireBitmap);
      }
   }
}
