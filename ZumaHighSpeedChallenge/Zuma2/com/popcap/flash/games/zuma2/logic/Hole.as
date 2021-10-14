package com.popcap.flash.games.zuma2.logic
{
   import com.popcap.flash.framework.Canvas;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   
   public class Hole
   {
       
      
      public var mFrame:int;
      
      public var mPercentOpen:Number;
      
      public var mSkullBaseSprite:Sprite;
      
      public var mSkullHeadBitmapData:BitmapData;
      
      public var mX:int;
      
      public var mY:int;
      
      public var mCurve:CurveMgr;
      
      public var mDeathAlpha:Number;
      
      public var mUpdateCount:int;
      
      public var mRotation:Number;
      
      public var mSkullHoleBitmap:Bitmap;
      
      public var mCurveNum:int;
      
      public var mDoDeathFade:Boolean;
      
      public var mSkullHoleSprite:Sprite;
      
      public var mShared:Vector.<Hole>;
      
      public var mRing:Array;
      
      public var mVisible:Boolean;
      
      public var mPercentTarget:Number;
      
      public var mSkullHeadMatrix:Matrix;
      
      public var mSkullHeadSprite:Sprite;
      
      public var mSkullSprite:Sprite;
      
      public var mSkullJawBitmap:Bitmap;
      
      public var mSkullBaseBitmap:Bitmap;
      
      public var mApp:Zuma2App;
      
      public var mSkullJawSprite:Sprite;
      
      public var mSkullMask:Sprite;
      
      public function Hole(param1:Zuma2App)
      {
         this.mRing = new Array();
         this.mSkullHeadMatrix = new Matrix();
         super();
         this.mApp = param1;
         this.mFrame = 0;
         this.mVisible = true;
         this.mPercentOpen = 0;
         this.mPercentTarget = -1;
         this.mUpdateCount = 0;
         this.mCurveNum = -1;
         this.mDoDeathFade = false;
         this.mDeathAlpha = 0;
         this.mShared = new Vector.<Hole>();
         this.mRing[0] = new FireRing(this.mApp);
         this.mRing[1] = new FireRing(this.mApp);
         this.mRing[1].mCel = -1;
         this.mRing[2] = new FireRing(this.mApp);
         this.mRing[2].mCel = -1;
         this.mSkullSprite = new Sprite();
         this.mSkullHeadSprite = new Sprite();
         this.mSkullBaseSprite = new Sprite();
         this.mSkullHoleSprite = new Sprite();
         this.mSkullJawSprite = new Sprite();
         this.mSkullHoleBitmap = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_DEATHSKULL_HOLE));
         this.mSkullJawBitmap = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_DEATHSKULL_JAW));
         this.mSkullHeadBitmapData = this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_DEATHSKULL_HEAD);
         this.mSkullBaseBitmap = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_DEATHSKULL_BASE));
         this.mSkullHoleBitmap.smoothing = true;
         this.mSkullJawBitmap.smoothing = true;
         this.mSkullBaseBitmap.smoothing = true;
         this.mSkullJawBitmap.x = -(this.mSkullJawBitmap.width / 2);
         this.mSkullJawBitmap.y = -(this.mSkullJawBitmap.height / 2) + 10;
         this.mSkullHeadMatrix.translate(-this.mSkullHeadBitmapData.width / 2,-this.mSkullHeadBitmapData.height / 2 - 3);
         this.mSkullBaseBitmap.x = -(this.mSkullBaseBitmap.width / 2);
         this.mSkullBaseBitmap.y = -(this.mSkullBaseBitmap.height / 2);
         this.mSkullHoleBitmap.x = -(this.mSkullHoleBitmap.width / 2);
         this.mSkullHoleBitmap.y = -(this.mSkullHoleBitmap.height / 2);
         this.mSkullMask = new Sprite();
         this.mSkullMask.graphics.beginFill(0);
         this.mSkullMask.graphics.drawCircle(-8,-8,32.5);
         this.mSkullMask.graphics.endFill();
         this.mSkullHeadSprite.graphics.beginBitmapFill(this.mSkullHeadBitmapData,this.mSkullHeadMatrix,false,true);
         this.mSkullHeadSprite.graphics.drawRect(-this.mSkullHeadBitmapData.width / 2,-this.mSkullHeadBitmapData.height / 2 - 5,this.mSkullHeadBitmapData.width,this.mSkullHeadBitmapData.height);
         this.mSkullHeadSprite.graphics.endFill();
         this.mSkullHeadSprite.mask = this.mSkullMask;
         this.mSkullHoleSprite.addChild(this.mSkullHoleBitmap);
         this.mSkullJawSprite.addChild(this.mSkullJawBitmap);
         this.mSkullBaseSprite.addChild(this.mSkullBaseBitmap);
         this.mApp.mLayers[0].mBackground.addChild(this.mSkullHoleSprite);
         this.mApp.mLayers[0].mBackground.addChild(this.mSkullJawSprite);
         this.mApp.mLayers[0].mBackground.addChild(this.mSkullHeadSprite);
         this.mApp.mLayers[0].mBackground.addChild(this.mSkullBaseSprite);
         this.mApp.mLayers[0].mBackground.addChild(this.mSkullMask);
         this.mApp.mLayers[0].mBackground.addChild(this.mRing[0].mFireSprite);
         this.mApp.mLayers[0].mBackground.addChild(this.mRing[1].mFireSprite);
         this.mApp.mLayers[0].mBackground.addChild(this.mRing[2].mFireSprite);
      }
      
      public function SetPctOpen(param1:Number) : void
      {
         if(param1 < this.mPercentOpen && this.mVisible)
         {
            this.mPercentTarget = param1;
         }
         else
         {
            this.mPercentOpen = param1;
            this.mPercentTarget = -1;
         }
      }
      
      public function GetPctOpen() : Number
      {
         return this.mPercentOpen;
      }
      
      public function DrawRings() : void
      {
         var _loc2_:FireRing = null;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         if(this.mDeathAlpha >= 255 || !this.mDoDeathFade && this.mDeathAlpha != 0)
         {
            _loc1_ = 0;
            while(_loc1_ < 3)
            {
               _loc1_++;
            }
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            this.mRing[1].mFireSprite.visible = true;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc2_ = this.mRing[_loc1_];
            if(!(_loc2_.mCel == -1 || _loc2_.mAlpha == 0))
            {
               _loc3_ = _loc2_.mAlpha;
               if(this.mDoDeathFade)
               {
                  _loc3_ = Math.min(_loc3_,255 - this.mDeathAlpha);
               }
               _loc2_.mFireImage.mFrame = _loc2_.mCel;
               _loc2_.mFireBitmap.bitmapData = _loc2_.mFireImage.pixels;
               _loc2_.mFireSprite.alpha = _loc3_ / 255;
            }
            _loc1_++;
         }
      }
      
      public function SetPos() : void
      {
         this.mSkullBaseSprite.x = this.mX * Zuma2App.SHRINK_PERCENT;
         this.mSkullBaseSprite.y = this.mY * Zuma2App.SHRINK_PERCENT;
         this.mSkullJawSprite.x = this.mX * Zuma2App.SHRINK_PERCENT;
         this.mSkullJawSprite.y = this.mY * Zuma2App.SHRINK_PERCENT;
         this.mSkullHoleSprite.x = this.mX * Zuma2App.SHRINK_PERCENT;
         this.mSkullHoleSprite.y = this.mY * Zuma2App.SHRINK_PERCENT;
         this.mSkullHeadSprite.x = this.mX * Zuma2App.SHRINK_PERCENT;
         this.mSkullHeadSprite.y = this.mY * Zuma2App.SHRINK_PERCENT;
         this.mSkullMask.x = this.mSkullHeadSprite.x;
         this.mSkullMask.y = this.mSkullHeadSprite.y;
         this.mSkullBaseSprite.rotation = this.mRotation * Zuma2App.RAD_TO_DEG + 90;
         this.mSkullHeadSprite.rotation = this.mRotation * Zuma2App.RAD_TO_DEG + 90;
         this.mSkullJawSprite.rotation = this.mRotation * Zuma2App.RAD_TO_DEG + 90;
         this.mSkullHoleSprite.rotation = this.mRotation * Zuma2App.RAD_TO_DEG + 90;
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            this.mRing[_loc1_].mFireSprite.x = this.mX * Zuma2App.SHRINK_PERCENT;
            this.mRing[_loc1_].mFireSprite.y = this.mY * Zuma2App.SHRINK_PERCENT;
            this.mRing[_loc1_].mFireSprite.rotation = this.mRotation * Zuma2App.RAD_TO_DEG + 90;
            _loc1_++;
         }
      }
      
      public function DrawMain(param1:Canvas, param2:Boolean = false) : void
      {
      }
      
      public function Update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         if(this.mDoDeathFade)
         {
            this.mDeathAlpha += 2;
            if(this.mDeathAlpha > 255)
            {
               this.mDeathAlpha = 255;
            }
         }
         else if(this.mDeathAlpha > 0)
         {
            this.mDeathAlpha = this.mDeathAlpha - 1;
            if(this.mDeathAlpha < 0)
            {
               this.mDeathAlpha = 0;
            }
         }
         ++this.mUpdateCount;
         if(this.mPercentOpen > this.mPercentTarget && this.mPercentTarget >= 0)
         {
            this.mPercentOpen -= 0.01;
            if(this.mPercentOpen < this.mPercentTarget)
            {
               this.mPercentOpen = this.mPercentTarget;
               this.mPercentTarget = -1;
            }
         }
         if(this.mPercentOpen > 0 && this.mVisible)
         {
            _loc2_ = 36;
            _loc1_ = 7 - this.mPercentOpen * 4;
            if(_loc1_ < 3)
            {
               _loc1_ = 3;
            }
            else if(_loc1_ > 7)
            {
               _loc1_ = 7;
            }
            _loc3_ = 255 / (6 * Number(_loc2_));
            if(this.mRing[0].mCel != -1)
            {
               this.mRing[0].mAlpha += _loc3_;
               if(this.mRing[0].mAlpha >= 255)
               {
                  this.mRing[0].mAlpha = 255;
               }
               if(this.mUpdateCount % _loc1_ == 0)
               {
                  if(++this.mRing[0].mCel >= _loc2_)
                  {
                     this.mRing[0].mCel = -1;
                  }
               }
            }
            _loc4_ = 128 / (Number(_loc1_) * 10);
            if(this.mRing[1].mAlpha == 0 && this.mRing[0].mCel == 21)
            {
               this.mRing[1].mCel = 0;
               this.mRing[1].mAlpha = 128;
            }
            else if(this.mRing[1].mCel != -1)
            {
               this.mRing[1].mAlpha += _loc4_;
               if(this.mRing[1].mAlpha >= 255)
               {
                  this.mRing[1].mAlpha = 255;
               }
               if(this.mUpdateCount % _loc1_ == 0)
               {
                  if(++this.mRing[1].mCel >= _loc2_)
                  {
                     this.mRing[1].mCel = 0;
                     this.mRing[1].mAlpha = 128;
                  }
               }
            }
            if(this.mRing[2].mAlpha == 0 && this.mRing[1].mCel == _loc2_ / 2)
            {
               this.mRing[2].mCel = 0;
               this.mRing[2].mAlpha = 128;
            }
            else if(this.mRing[2].mCel != -1)
            {
               this.mRing[2].mAlpha += _loc4_;
               if(this.mRing[2].mAlpha >= 255)
               {
                  this.mRing[2].mAlpha = 255;
               }
               if(this.mUpdateCount % _loc1_ == 0)
               {
                  if(++this.mRing[2].mCel >= _loc2_)
                  {
                     this.mRing[2].mCel = 0;
                     this.mRing[2].mAlpha = 128;
                  }
               }
            }
         }
         else if(this.mVisible)
         {
            _loc5_ = true;
            _loc1_ = 7 - this.mPercentOpen * 4;
            if(_loc1_ < 3)
            {
               _loc1_ = 3;
            }
            else if(_loc1_ > 7)
            {
               _loc1_ = 7;
            }
            _loc6_ = 0;
            _loc6_ = 0;
            while(_loc6_ < 3)
            {
               if(this.mRing[_loc6_].mAlpha > 0)
               {
                  if(this.mUpdateCount % _loc1_ == 0)
                  {
                     if(++this.mRing[_loc6_].mCel >= 36)
                     {
                     }
                  }
                  this.mRing[_loc6_].mCel = 0;
                  this.mRing[_loc6_].mAlpha -= 2;
                  if(this.mRing[_loc6_].mAlpha <= 0)
                  {
                     this.mRing[_loc6_].mAlpha = 0;
                  }
                  else
                  {
                     _loc5_ = false;
                  }
               }
               _loc6_++;
            }
            if(_loc5_)
            {
               _loc6_ = 0;
               while(_loc6_ < 3)
               {
                  this.mRing[_loc6_].mCel = _loc6_ == 0 ? 0 : -1;
                  this.mRing[_loc6_].mAlpha = 0;
                  _loc6_++;
               }
            }
         }
      }
      
      public function Draw(param1:Canvas, param2:Number = 0) : void
      {
         this.mSkullHeadSprite.x = this.mX * Zuma2App.SHRINK_PERCENT + -this.mSkullHeadBitmapData.width / 2 + 21 + 20 * this.mPercentOpen;
         this.mSkullHeadSprite.y = this.mY * Zuma2App.SHRINK_PERCENT + -this.mSkullHeadBitmapData.height / 2 + 17 + 20 * this.mPercentOpen;
         this.DrawMain(param1,false);
         if(this.mDeathAlpha > 0)
         {
            this.DrawMain(param1,true);
         }
         if(this.mVisible)
         {
            this.DrawRings();
         }
      }
   }
}
