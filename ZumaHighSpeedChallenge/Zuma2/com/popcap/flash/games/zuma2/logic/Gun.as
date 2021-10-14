package com.popcap.flash.games.zuma2.logic
{
   import com.popcap.flash.framework.Canvas;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.widgets.Widget;
   import com.popcap.flash.framework.widgets.WidgetContainer;
   import com.popcap.flash.games.zuma2.widgets.GameBoardWidget;
   import flash.display.Bitmap;
   import flash.display.PixelSnapping;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Gun extends WidgetContainer implements Widget
   {
      
      public static const GunState_Firing:int = 1;
      
      public static const FROG_HEIGHT:int = 134;
      
      public static const FrogType_Cannon:int = 1;
      
      public static const DEG_TO_RAD:Number = Zuma2App.MY_PI / 180;
      
      public static const FROG_WIDTH:int = 147;
      
      public static const RAD_TO_DEG:Number = 180 / Zuma2App.MY_PI;
      
      public static const FrogType_Normal:int = 0;
      
      public static const TONGUE_Y1:int = 5;
      
      public static const TONGUE_Y2:int = 3;
      
      public static const GunState_Normal:int = 0;
      
      public static const GunState_Reloading:int = 2;
      
      public static const TONGUE_YNOBALL:int = 7;
       
      
      public var mBallXOff:int;
      
      private var mIsInited:Boolean = false;
      
      public var mFirePoint:int;
      
      public var mCurrentBody:FrogBody;
      
      private var mEyesSprite:Sprite;
      
      public var mUpdateCount:int;
      
      private var mFrogBottomSprite:Sprite;
      
      private var mNextBullet:Bullet;
      
      public var mDestTime:int;
      
      private var mState:int;
      
      public var mCurX:Number = 0;
      
      public var mCurY:Number = 0;
      
      private var mEyesImage:ImageInst;
      
      private var mFrogTopBitmap:Bitmap;
      
      public var mRecoilAmt:int;
      
      private var mFireVel:int;
      
      private var mTongueBitmap:Bitmap;
      
      public var mBallYOff:int;
      
      public var mDestAngle:Number = 0;
      
      public var mCannonCount:int;
      
      public var mAngle:Number = 0;
      
      public var mBlinkCount:int;
      
      public var mBulletSprite:Sprite;
      
      private var mFrogCenter:Point;
      
      public var mCenterX:Number = 0;
      
      public var mCenterY:Number = 0;
      
      public var mBoard:GameBoardWidget;
      
      private var mApp:Zuma2App;
      
      public var mFarthestDistance:Number;
      
      private var mEyesBitmap:Bitmap;
      
      private var mStatePercent:Number = 0;
      
      public var mBX:Number = 0;
      
      public var mBY:Number = 0;
      
      private var mDotSprite:Sprite;
      
      public var mX:Number = 0;
      
      public var mY:Number = 0;
      
      private var mCenterPoint:Point;
      
      public var mBlinkTimer:int;
      
      private var mFrogBottomBitmap:Bitmap;
      
      public var mDestCount:int;
      
      public var mShowNextBall:Boolean;
      
      private var mFrogTopSprite:Sprite;
      
      public var mReloadPoint:int;
      
      private var mBullet:Bullet;
      
      public var mDestX1:Number = 0;
      
      public var mDestX2:Number = 0;
      
      public var mDoingHop:Boolean;
      
      public var mBallPoint:int;
      
      public var mCannonState:int;
      
      public var mDestY2:Number = 0;
      
      private var mDotBitmap:Bitmap;
      
      private var mTongueSprite:Sprite;
      
      public var mFrogBody:FrogBody;
      
      public var mDestY1:Number = 0;
      
      public function Gun(param1:Zuma2App, param2:GameBoardWidget)
      {
         this.mFrogCenter = new Point();
         this.mCenterPoint = new Point();
         super();
         this.mApp = param1;
         this.mBoard = param2;
         this.init();
      }
      
      public function SetDotColor() : void
      {
         var _loc1_:String = null;
         if(this.mNextBullet != null)
         {
            switch(this.mNextBullet.mColorType)
            {
               case 0:
                  _loc1_ = Zuma2Images.IMAGE_DOT_BLUE;
                  break;
               case 1:
                  _loc1_ = Zuma2Images.IMAGE_DOT_YELLOW;
                  break;
               case 2:
                  _loc1_ = Zuma2Images.IMAGE_DOT_RED;
                  break;
               case 3:
                  _loc1_ = Zuma2Images.IMAGE_DOT_GREEN;
                  break;
               case 4:
                  _loc1_ = Zuma2Images.IMAGE_DOT_PURPLE;
                  break;
               case 5:
                  _loc1_ = Zuma2Images.IMAGE_DOT_WHITE;
                  break;
               default:
                  _loc1_ = Zuma2Images.IMAGE_DOT_BLACK;
            }
         }
         else
         {
            _loc1_ = Zuma2Images.IMAGE_DOT_BLACK;
         }
         this.mDotBitmap.bitmapData = this.mApp.imageManager.getBitmapData(_loc1_);
         this.mDotBitmap.smoothing = true;
         this.mDotBitmap.x = -(this.mDotBitmap.width / 2);
         this.mDotBitmap.y = -25;
      }
      
      public function init() : void
      {
         this.mIsInited = true;
         this.mState = GunState_Normal;
         this.mStatePercent = 0;
         this.mFireVel = 8;
         this.mBlinkCount = -1;
         this.mBlinkTimer = 0;
         this.mCenterX = 420;
         this.mCenterY = 354;
         this.mCurrentBody = new FrogBody();
         this.SetFrogType(FrogType_Normal,true);
         this.mEyesImage = this.mApp.imageManager.getImageInst(Zuma2Images.IMAGE_FROG_EYES);
         this.mEyesImage.mFrame = 0;
         this.mEyesSprite = new Sprite();
         this.mEyesBitmap = new Bitmap(this.mEyesImage.pixels,PixelSnapping.NEVER,true);
         this.mEyesBitmap.x = -this.mEyesBitmap.width / 2;
         this.mEyesBitmap.y = -9;
         this.mEyesSprite.addChild(this.mEyesBitmap);
         this.mEyesSprite.visible = false;
         this.mBulletSprite = new Sprite();
         this.mDotSprite = new Sprite();
         this.mDotBitmap = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_DOT_BLACK),PixelSnapping.NEVER,true);
         this.mDotBitmap.x = -this.mDotBitmap.width / 2;
         this.mDotBitmap.y = -25;
         this.mDotSprite.addChild(this.mDotBitmap);
         this.mFrogTopSprite = new Sprite();
         this.mFrogTopBitmap = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_FROG_TOP));
         this.mFrogTopBitmap.smoothing = true;
         this.mFrogTopBitmap.x = -(this.mFrogTopBitmap.width / 2);
         this.mFrogTopBitmap.y = -(this.mFrogTopBitmap.height / 2);
         this.mFrogTopSprite.addChild(this.mFrogTopBitmap);
         this.mFrogTopSprite.x = this.mX;
         this.mFrogTopSprite.y = this.mY;
         this.mTongueSprite = new Sprite();
         this.mTongueBitmap = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_FROG_TONGUE));
         this.mTongueBitmap.smoothing = true;
         this.mTongueBitmap.x = -(this.mTongueBitmap.width / 2);
         this.mTongueBitmap.y = -5;
         this.mTongueSprite.addChild(this.mTongueBitmap);
         this.mTongueSprite.x = this.mX;
         this.mTongueSprite.y = this.mY;
         this.mFrogBottomSprite = new Sprite();
         this.mFrogBottomBitmap = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_FROG_BOTTOM));
         this.mFrogBottomBitmap.smoothing = true;
         this.mFrogBottomBitmap.x = -(this.mFrogBottomBitmap.width / 2);
         this.mFrogBottomBitmap.y = 13;
         this.mFrogBottomSprite.addChild(this.mFrogBottomBitmap);
         this.mFrogBottomSprite.x = this.mX;
         this.mFrogBottomSprite.y = this.mY;
         this.mApp.mLayers[0].mBalls.addChild(this.mFrogBottomSprite);
         this.mApp.mLayers[0].mBalls.addChild(this.mTongueSprite);
         this.mApp.mLayers[0].mForeground.addChild(this.mDotSprite);
         this.mApp.mLayers[0].mForeground.addChild(this.mFrogTopSprite);
         this.mApp.mLayers[0].mForeground.addChild(this.mEyesSprite);
      }
      
      public function SetDestAngle(param1:Number) : void
      {
         while(this.mAngle < 0)
         {
            this.mAngle += 2 * Zuma2App.MY_PI;
         }
         while(this.mAngle > 2 * Zuma2App.MY_PI)
         {
            this.mAngle -= 2 * Zuma2App.MY_PI;
         }
         var _loc2_:Number = Math.abs(param1 - this.mAngle);
         if(_loc2_ > Zuma2App.MY_PI)
         {
            if(param1 < this.mAngle)
            {
               param1 += 2 * Zuma2App.MY_PI;
            }
            else
            {
               param1 -= 2 * Zuma2App.MY_PI;
            }
         }
         this.mDestAngle = param1;
      }
      
      public function GetAngle() : Number
      {
         return this.mAngle;
      }
      
      public function SetBulletType(param1:int) : void
      {
         if(this.mBullet != null && param1 != -1)
         {
            this.mBullet.SetColorType(param1);
         }
      }
      
      override public function draw(param1:Canvas) : void
      {
         this.mFrogBottomSprite.x = this.mX * Zuma2App.SHRINK_PERCENT;
         this.mFrogBottomSprite.y = this.mY * Zuma2App.SHRINK_PERCENT;
         this.mFrogTopSprite.x = this.mX * Zuma2App.SHRINK_PERCENT;
         this.mFrogTopSprite.y = this.mY * Zuma2App.SHRINK_PERCENT;
         this.mFrogBottomSprite.rotation = this.mAngle * RAD_TO_DEG - 90;
         this.mFrogTopSprite.rotation = this.mAngle * RAD_TO_DEG - 90;
         this.mFrogBottomBitmap.y = 13 - this.mRecoilAmt;
         this.mFrogTopBitmap.y = -(this.mFrogTopBitmap.height / 2) - this.mRecoilAmt;
         this.mDotSprite.x = this.mX * Zuma2App.SHRINK_PERCENT;
         this.mDotSprite.y = this.mY * Zuma2App.SHRINK_PERCENT;
         this.mDotSprite.rotation = this.mAngle * RAD_TO_DEG - 90;
         this.mDotBitmap.y = -25 - this.mRecoilAmt;
         this.DrawTongue();
         this.mEyesSprite.x = this.mX * Zuma2App.SHRINK_PERCENT;
         this.mEyesSprite.y = this.mY * Zuma2App.SHRINK_PERCENT;
         this.mEyesSprite.rotation = this.mAngle * RAD_TO_DEG - 90;
         this.mEyesBitmap.y = -9 - this.mRecoilAmt;
         if(this.mState != GunState_Normal || this.mBlinkCount >= 0)
         {
            this.DrawEyes();
         }
         else
         {
            this.mEyesSprite.visible = false;
         }
         if(this.mBullet != null)
         {
            this.mBullet.Draw(param1);
         }
      }
      
      public function LevelReset() : void
      {
         this.SetFrogType(FrogType_Normal,true);
         this.mState = GunState_Normal;
         this.SetDotColor();
      }
      
      public function IsFiring() : Boolean
      {
         return this.mState == GunState_Firing;
      }
      
      public function CalcAngle() : void
      {
         if(this.mBullet == null)
         {
            return;
         }
         var _loc1_:Point = new Point();
         var _loc2_:Number = this.mCurY + this.mReloadPoint;
         var _loc3_:Number = this.mCurY + this.mFirePoint;
         var _loc4_:Number = this.mCurY + this.mBallPoint;
         _loc1_.x = this.mCurX - 2;
         if(this.mState == GunState_Normal)
         {
            _loc1_.y = _loc4_;
         }
         else if(this.mState == GunState_Reloading)
         {
            _loc1_.y = _loc2_ + (_loc4_ - _loc2_) * this.mStatePercent;
         }
         else
         {
            if(this.mStatePercent > 0.6)
            {
               return;
            }
            _loc1_.y = _loc4_ + (_loc3_ - _loc4_) * this.mStatePercent / 0.6;
         }
         this.RotateXY(_loc1_,this.mCurX,this.mCurY,-this.mAngle);
         if(this.mState == GunState_Reloading && this.mApp.gSuckMode)
         {
            if(this.mBX != 0 || this.mBY != 0)
            {
               _loc1_.x = x * this.mStatePercent + this.mBX * (1 - this.mStatePercent);
               _loc1_.y = y * this.mStatePercent + this.mBY * (1 - this.mStatePercent);
            }
         }
         this.mBullet.SetPos(_loc1_.x,_loc1_.y);
         this.mBullet.SetRotation(this.mAngle);
      }
      
      public function SetFrogType(param1:int, param2:Boolean) : void
      {
         var _loc3_:FrogBody = null;
         if(param2)
         {
            _loc3_ = this.mCurrentBody;
            _loc3_.mAlpha = 255;
         }
         _loc3_.mTongueX = 52;
         _loc3_.mCX = FROG_WIDTH / 2;
         _loc3_.mCY = FROG_HEIGHT / 2;
         this.mReloadPoint = -20;
         this.mFirePoint = 8;
         this.mBallPoint = 40;
         this.mBallXOff = this.mBallYOff = 0;
         _loc3_.mNextBallX = 62;
         _loc3_.mNextBallY = 25;
         _loc3_.mType = param1;
         if(this.mBullet != null && !this.mBullet.GetJustFired())
         {
         }
         if(this.mNextBullet != null && !this.mNextBullet.GetJustFired())
         {
         }
         if(param1 == FrogType_Normal)
         {
            _loc3_.mMouthOffset = new Point(26,param1 == FrogType_Normal ? Number(79) : Number(82));
            if(param1 == FrogType_Normal)
            {
               _loc3_.mLegsOffset = new Point(2,38);
               this.mBallYOff = 0;
            }
            else
            {
               _loc3_.mLegsOffset = new Point(1,41);
            }
            _loc3_.mBodyOffset = new Point(16,4);
            _loc3_.mEyesOffset = new Point(32,47);
            this.mCannonState = -1;
         }
      }
      
      public function GetFiredBullet() : Bullet
      {
         var _loc1_:Bullet = null;
         if(this.mState == GunState_Firing && this.mStatePercent >= 0.9)
         {
            _loc1_ = this.mBullet;
            this.mState = GunState_Normal;
            this.mBullet = null;
            return _loc1_;
         }
         return null;
      }
      
      public function PlayerDied() : void
      {
         this.mState = GunState_Normal;
         this.mRecoilAmt = 0;
         this.mStatePercent = 1;
         this.mBullet.Hide(true);
      }
      
      public function SwapBullets(param1:Boolean = true) : void
      {
         var _loc2_:Bullet = null;
         if(this.mState != GunState_Normal)
         {
            return;
         }
         if(this.mApp.gSuckMode)
         {
            if(param1)
            {
               this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_BALL_SWAP);
            }
            _loc2_ = this.mBullet;
            this.mBullet = this.mNextBullet;
            this.mNextBullet = _loc2_;
            this.mBullet.Hide(false);
            this.mNextBullet.Hide(true);
            this.SetDotColor();
            this.CalcAngle();
            return;
         }
         if(this.mBullet == null || this.mNextBullet == null)
         {
            return;
         }
         if(this.mBullet.GetColorType() == this.mNextBullet.GetColorType())
         {
            return;
         }
         if(param1)
         {
            this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_BALL_SWAP);
         }
         _loc2_ = this.mBullet;
         this.mBullet = this.mNextBullet;
         this.mNextBullet = _loc2_;
         this.mBullet.Hide(false);
         this.mNextBullet.Hide(true);
         this.SetDotColor();
         this.CalcAngle();
      }
      
      public function DrawTongue() : void
      {
         var _loc1_:int = 0;
         this.mTongueSprite.x = this.mX * Zuma2App.SHRINK_PERCENT;
         this.mTongueSprite.y = this.mY * Zuma2App.SHRINK_PERCENT;
         this.mTongueSprite.rotation = this.mAngle * RAD_TO_DEG - 90;
         switch(this.mState)
         {
            case GunState_Normal:
               _loc1_ = TONGUE_Y2;
               break;
            case GunState_Firing:
               _loc1_ = TONGUE_Y1 * this.mStatePercent + TONGUE_Y2 * (1 - this.mStatePercent);
               break;
            case GunState_Reloading:
               _loc1_ = TONGUE_Y2 * this.mStatePercent + TONGUE_Y1 * (1 - this.mStatePercent);
         }
         if(this.mBullet == null)
         {
            _loc1_ = TONGUE_YNOBALL;
         }
         this.mTongueBitmap.y = -5 + _loc1_ - this.mRecoilAmt;
      }
      
      public function SetNextBulletType(param1:int) : void
      {
         if(this.mNextBullet != null && param1 != -1)
         {
            this.mNextBullet.SetColorType(param1);
            this.SetDotColor();
         }
      }
      
      public function GetCenterY() : int
      {
         return this.mCenterY;
      }
      
      public function StartFire() : Boolean
      {
         if(this.mState != GunState_Normal)
         {
            return false;
         }
         if(this.mBullet == null)
         {
            return false;
         }
         this.mStatePercent = 0;
         this.mState = GunState_Firing;
         var _loc1_:Bullet = this.mBullet;
         _loc1_.SetJustFired(true);
         var _loc2_:Number = this.mAngle;
         var _loc3_:Number = Math.cos(_loc2_);
         var _loc4_:Number = Math.sin(_loc2_);
         var _loc5_:Number = this.mFireVel;
         this.mBullet.SetVelocity(_loc3_ * _loc5_,_loc4_ * _loc5_);
         this.CalcAngle();
         return true;
      }
      
      public function GetCenterX() : int
      {
         return this.mCenterX;
      }
      
      public function Reload3() : void
      {
         if(this.mBullet == null && this.mNextBullet != null)
         {
            this.mBX = 0;
            this.mBY = 0;
            this.mBullet = this.mNextBullet;
            this.mNextBullet = null;
            this.mStatePercent = 0;
            this.mState = GunState_Reloading;
            this.SetDotColor();
            this.CalcAngle();
         }
      }
      
      public function NeedsReload() : Boolean
      {
         return this.mNextBullet == null || this.mBullet == null;
      }
      
      public function SetAngleToDestAngle() : void
      {
         while(this.mDestAngle < 0)
         {
            this.mDestAngle += 2 * Zuma2App.MY_PI;
         }
         while(this.mDestAngle > 2 * Zuma2App.MY_PI)
         {
            this.mDestAngle -= 2 * Zuma2App.MY_PI;
         }
         this.mAngle = this.mDestAngle;
      }
      
      public function SetFireSpeed(param1:Number) : void
      {
         this.mFireVel = param1;
      }
      
      public function Reload2(param1:int, param2:Boolean, param3:int, param4:int, param5:int) : void
      {
         var _loc6_:Bullet;
         (_loc6_ = new Bullet(this.mApp)).mFrog = this;
         _loc6_.SetColorType(param1);
         _loc6_.SetPowerType(param3,false);
         this.mBX = param4;
         this.mBY = param5;
         this.mStatePercent = 0;
         this.mBullet.Delete();
         this.mBullet = _loc6_;
         this.mState = GunState_Reloading;
         if(!param2)
         {
            this.mStatePercent = 1;
            this.mState = GunState_Normal;
         }
         this.SetDotColor();
         this.CalcAngle();
      }
      
      public function GetNextBullet() : Bullet
      {
         return this.mNextBullet;
      }
      
      public function DeleteBullet() : void
      {
         if(this.mBullet != null)
         {
            this.mBullet.Delete();
            this.mBullet = this.mNextBullet;
            this.mNextBullet = null;
         }
      }
      
      public function SetDestPos(param1:int, param2:int, param3:int, param4:Boolean = false) : void
      {
         this.mDoingHop = param4;
         this.mDestX1 = this.mCenterX;
         this.mDestY1 = this.mCenterY;
         this.mDestX2 = param1;
         this.mDestY2 = param2;
         var _loc5_:Number = (this.mDestX2 - this.mDestX1) * (this.mDestX2 - this.mDestX1);
         var _loc6_:Number = (this.mDestY2 - this.mDestY1) * (this.mDestY2 - this.mDestY1);
         var _loc7_:Number = Math.sqrt(_loc5_ + _loc6_);
         this.mDestCount = _loc7_ / param3;
         if(this.mDestCount < 1)
         {
            this.mDestCount = 1;
         }
         this.mDestTime = this.mDestCount;
      }
      
      public function SetAngle(param1:Number) : void
      {
         this.mAngle = this.mDestAngle = param1;
         this.CalcAngle();
      }
      
      public function SetPos(param1:int, param2:int) : void
      {
         this.mCenterY = param1;
         this.mCenterY = param2;
         this.mDestCount = 0;
         this.mCurX = param1;
         this.mCurY = param2;
         this.CalcAngle();
         var _loc3_:int = this.GetCenterX() > 800 - this.GetCenterX() ? 0 : 800;
         var _loc4_:int = this.GetCenterY() > 600 - this.GetCenterY() ? 0 : 600;
         var _loc5_:Point = new Point(this.GetCenterX(),this.GetCenterY());
         var _loc6_:Point = new Point(_loc3_,_loc4_);
         this.mFarthestDistance = Point.distance(_loc5_,_loc6_);
      }
      
      public function Reload(param1:int, param2:Boolean, param3:int) : void
      {
         var _loc4_:Bullet;
         (_loc4_ = new Bullet(this.mApp)).mFrog = this;
         _loc4_.SetColorType(param1);
         _loc4_.SetPowerType(param3,false);
         this.mStatePercent = 0;
         if(this.mBullet != null)
         {
            this.mBullet.Delete();
         }
         this.mBullet = this.mNextBullet;
         if(this.mBullet != null)
         {
            this.mBullet.Hide(false);
         }
         if(this.mCannonCount > 0 && this.mBullet && !this.mBullet.GetIsCannon())
         {
         }
         this.mNextBullet = _loc4_;
         this.mState = GunState_Reloading;
         if(!param2)
         {
            this.mStatePercent = 1;
            this.mState = GunState_Normal;
         }
         this.SetDotColor();
         this.CalcAngle();
      }
      
      public function GetDestAngle() : Number
      {
         return this.mDestAngle;
      }
      
      public function RotateXY(param1:Point, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc5_:Number = param1.x - param2;
         var _loc6_:Number = param1.y - param3;
         param4 += Zuma2App.MY_PI / 2;
         param1.x = param2 + _loc5_ * Math.cos(param4) + _loc6_ * Math.sin(param4);
         param1.y = param3 + _loc6_ * Math.cos(param4) - _loc5_ * Math.sin(param4);
      }
      
      public function EmptyBullets(param1:Boolean = true) : void
      {
         if(param1)
         {
            this.SetFrogType(FrogType_Normal,true);
         }
         if(this.mNextBullet != null)
         {
            this.mNextBullet.Delete();
            this.mNextBullet = null;
         }
         if(this.mBullet != null)
         {
            this.mBullet.Delete();
            this.mBullet = null;
         }
      }
      
      override public function update() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(!this.mIsInited)
         {
            this.init();
         }
         ++this.mUpdateCount;
         this.mCurX = this.mCenterX;
         this.mCurY = this.mCenterY;
         if(this.mBullet != null)
         {
            this.mBullet.Update();
         }
         if(this.mNextBullet != null)
         {
            this.mNextBullet.Update();
         }
         if(this.mBlinkCount >= 0 && --this.mBlinkTimer == 0)
         {
            --this.mBlinkCount;
            this.mBlinkTimer = 15;
         }
         if(this.mAngle != this.mDestAngle)
         {
            _loc2_ = 100;
            _loc3_ = _loc2_;
            _loc4_ = this.mAngle;
            if(this.mAngle < this.mDestAngle)
            {
               this.mAngle += _loc3_;
               if(this.mAngle > this.mDestAngle)
               {
                  this.SetAngleToDestAngle();
               }
            }
            else
            {
               this.mAngle -= _loc3_;
               if(this.mAngle < this.mDestAngle)
               {
                  this.SetAngleToDestAngle();
               }
            }
         }
         if(this.mDestCount > 0)
         {
            --this.mDestCount;
            _loc5_ = Number(this.mDestCount) / this.mDestTime;
            this.mCenterX = _loc5_ * this.mDestX1 + (1 - _loc5_) * this.mDestX2;
            this.mCenterY = _loc5_ * this.mDestY1 + (1 - _loc5_) * this.mDestY2;
            if(this.mDestCount == 0)
            {
               this.mDoingHop = false;
            }
         }
         var _loc1_:Number = 1;
         if(this.mState == GunState_Firing)
         {
            this.mStatePercent += 0.15;
            if(this.mStatePercent > 0.6)
            {
               this.mBullet.Update();
               this.mRecoilAmt += 2.33;
            }
         }
         else
         {
            this.mStatePercent += 0.07 / _loc1_;
            if(this.mState == GunState_Reloading)
            {
               if((this.mRecoilAmt = this.mRecoilAmt - 0.7 / _loc1_) < 0)
               {
                  this.mRecoilAmt = 0;
               }
            }
         }
         if(this.mStatePercent > 1)
         {
            this.mStatePercent = 1;
            if(this.mState == GunState_Reloading)
            {
               this.mState = GunState_Normal;
               this.mRecoilAmt = 0;
            }
         }
         if(this.mState == GunState_Normal && this.mRecoilAmt > 0)
         {
            if((this.mRecoilAmt = this.mRecoilAmt - 0.7) / _loc1_ < 0)
            {
               this.mRecoilAmt = 0;
            }
         }
         this.CalcAngle();
      }
      
      public function GetX() : Number
      {
         return this.mX;
      }
      
      public function GetY() : Number
      {
         return this.mY;
      }
      
      public function DrawEyes() : void
      {
         var _loc1_:int = 0;
         if(this.mBlinkCount >= 0)
         {
            _loc1_ = this.mBlinkCount % 2 == 0 ? -1 : 1;
         }
         else if(this.mState != GunState_Firing)
         {
            _loc1_ = 1;
         }
         if(_loc1_ >= 0)
         {
            this.mEyesImage.mFrame = _loc1_;
            this.mEyesBitmap.bitmapData = this.mEyesImage.pixels;
            this.mEyesSprite.visible = true;
         }
      }
      
      public function GetBullet() : Bullet
      {
         return this.mBullet;
      }
      
      public function Move(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = param1 - this.mFrogTopSprite.x;
         var _loc4_:Number = param2 - this.mFrogTopSprite.y;
         var _loc5_:Number = Math.atan2(_loc4_,_loc3_);
         this.mFrogTopSprite.rotation = _loc5_ * RAD_TO_DEG - 90;
         this.mFrogBottomSprite.rotation = _loc5_ * RAD_TO_DEG - 90;
         this.mDotSprite.x = this.mX - 50 * Math.cos(_loc5_);
         this.mDotSprite.y = this.mY - 50 * Math.sin(_loc5_);
         this.mAngle = _loc5_;
      }
   }
}
