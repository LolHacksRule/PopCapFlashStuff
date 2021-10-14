package com.popcap.flash.games.zuma2.logic
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class WarningLight
   {
       
      
      public var mSkullPathLitBitmap:Bitmap;
      
      public var mSkullPathBitmap:Bitmap;
      
      public var mSkullPathLitSprite:Sprite;
      
      public var mX:Number;
      
      public var mWaypoint:Number;
      
      public var mPulseAlpha:Number;
      
      public var mY:Number;
      
      public var mUpdateCount:int;
      
      public var mSkullPathSprite:Sprite;
      
      public var mAngle:Number;
      
      public var mState:int;
      
      public var mPulseRate:Number;
      
      public var mPriority:int;
      
      public var mApp:Zuma2App;
      
      public var mAlpha:Number;
      
      public function WarningLight(param1:Zuma2App, param2:Number, param3:Number)
      {
         super();
         this.mApp = param1;
         this.mX = param2;
         this.mY = param3;
         this.mAlpha = 0;
         this.mUpdateCount = 0;
         this.mAngle = 0;
         this.mState = 0;
         this.mWaypoint = -1;
         this.mPulseAlpha = 0;
         this.mPulseRate = 0;
         this.mPriority = 0;
         this.mSkullPathBitmap = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_SKULLPATH));
         this.mSkullPathBitmap.x = -this.mSkullPathBitmap.width / 2;
         this.mSkullPathBitmap.y = -this.mSkullPathBitmap.height / 2;
         this.mSkullPathLitBitmap = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_SKULLPATH_LIT));
         this.mSkullPathLitBitmap.x = -this.mSkullPathLitBitmap.width / 2;
         this.mSkullPathLitBitmap.y = -this.mSkullPathLitBitmap.height / 2;
         this.mSkullPathSprite = new Sprite();
         this.mSkullPathSprite.addChild(this.mSkullPathBitmap);
         this.mSkullPathSprite.x = this.mX * Zuma2App.SHRINK_PERCENT;
         this.mSkullPathSprite.y = this.mY * Zuma2App.SHRINK_PERCENT;
         this.mSkullPathLitSprite = new Sprite();
         this.mSkullPathLitSprite.addChild(this.mSkullPathLitBitmap);
         this.mSkullPathLitSprite.x = this.mX * Zuma2App.SHRINK_PERCENT;
         this.mSkullPathLitSprite.y = this.mY * Zuma2App.SHRINK_PERCENT;
         this.mApp.mLayers[0].mBackground.addChild(this.mSkullPathLitSprite);
         this.mApp.mLayers[0].mBackground.addChild(this.mSkullPathSprite);
      }
      
      public function SetAngle(param1:Number) : void
      {
         this.mAngle = param1;
         this.mSkullPathLitSprite.rotation = -this.mAngle * Zuma2App.RAD_TO_DEG + 90;
         this.mSkullPathSprite.rotation = -this.mAngle * Zuma2App.RAD_TO_DEG + 90;
      }
      
      public function Update() : Boolean
      {
         ++this.mUpdateCount;
         var _loc1_:Number = 5;
         if(this.mState == 1)
         {
            this.mAlpha = Math.min(255,this.mAlpha + _loc1_);
            if(this.mAlpha >= 255)
            {
               this.mState = 0;
            }
         }
         else if(this.mState == -1)
         {
            this.mAlpha = Math.max(0,this.mAlpha - _loc1_);
            if(this.mAlpha <= 0)
            {
               this.mState = 0;
            }
         }
         else if(this.mPulseRate != 0)
         {
            this.mPulseAlpha += this.mPulseRate > 0 ? this.mPulseRate * 2 : this.mPulseRate;
            if(this.mPulseRate < 0 && this.mPulseAlpha <= 0)
            {
               this.mPulseRate = 0;
               this.mPulseAlpha = 0;
            }
            else if(this.mPulseAlpha >= 255 && this.mPulseRate > 0)
            {
               this.mPulseRate *= -1;
               this.mPulseAlpha = 255;
               return true;
            }
         }
         return false;
      }
      
      public function Draw() : void
      {
         this.mSkullPathSprite.alpha = this.mAlpha / 255;
         this.mSkullPathLitSprite.alpha = this.mPulseAlpha / 255;
      }
   }
}
