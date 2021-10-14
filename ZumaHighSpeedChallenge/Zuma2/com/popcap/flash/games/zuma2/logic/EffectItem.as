package com.popcap.flash.games.zuma2.logic
{
   import com.popcap.flash.framework.resources.images.ImageInst;
   import flash.display.Bitmap;
   import flash.display.BlendMode;
   import flash.display.PixelSnapping;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   
   public class EffectItem
   {
       
      
      public var mXOffset:Vector.<Component>;
      
      public var mAngle:Vector.<Component>;
      
      public var mBitmap:Bitmap;
      
      public var mImage:ImageInst;
      
      public var mSprite:Sprite;
      
      public var mCel:int;
      
      public var mColor:ColorTransform;
      
      public var mApp:Zuma2App;
      
      public var mScale:Vector.<Component>;
      
      public var mOpacity:Vector.<Component>;
      
      public var mYOffset:Vector.<Component>;
      
      public function EffectItem(param1:Zuma2App)
      {
         this.mScale = new Vector.<Component>();
         this.mOpacity = new Vector.<Component>();
         this.mAngle = new Vector.<Component>();
         this.mXOffset = new Vector.<Component>();
         this.mYOffset = new Vector.<Component>();
         super();
         this.mApp = param1;
      }
      
      public function Init(param1:Number, param2:Number) : void
      {
         this.mSprite = new Sprite();
         this.mImage.mFrame = this.mCel;
         this.mBitmap = new Bitmap(this.mImage.pixels,PixelSnapping.NEVER,true);
         this.mBitmap.x = -this.mBitmap.width / 2;
         this.mBitmap.y = -this.mBitmap.height / 2;
         this.mBitmap.transform.colorTransform = this.mColor;
         this.mBitmap.blendMode = BlendMode.ADD;
         this.mSprite.addChild(this.mBitmap);
         this.mSprite.x = param1 * Zuma2App.SHRINK_PERCENT;
         this.mSprite.y = param2 * Zuma2App.SHRINK_PERCENT;
         this.mApp.mLayers[2].mForeground.addChild(this.mSprite);
      }
      
      public function Delete() : void
      {
         if(this.mSprite != null)
         {
            if(this.mSprite.parent != null)
            {
               this.mSprite.parent.removeChild(this.mSprite);
            }
         }
      }
   }
}
