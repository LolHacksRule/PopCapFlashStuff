package com.popcap.flash.games.zuma2.logic
{
   import com.popcap.flash.framework.Canvas;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.games.zuma2.widgets.GameBoardWidget;
   import de.polygonal.ds.DLinkedList;
   import de.polygonal.ds.DListIterator;
   import flash.display.Bitmap;
   import flash.display.BlendMode;
   import flash.display.PixelSnapping;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public class Ball
   {
      
      public static var mIdGen:int = 0;
       
      
      public var mComboScore:int;
      
      public var mExplodeAlpha:Number = 1.0;
      
      public var mExplodeFrame:int;
      
      public var mPowerupIconSprite:Sprite;
      
      public var mExplodingFromLightning:Boolean;
      
      public var mIsCannon:Boolean;
      
      public var mIconAppearScale:Number;
      
      public var mBallBitmap:Bitmap;
      
      public var mHilightSprite:Sprite;
      
      public var mComboCount:int;
      
      public var mPowerupIconImage:ImageInst;
      
      public var p:SexyVector3;
      
      public var mDead:Boolean;
      
      public var mApp:Zuma2App;
      
      public var mGapBonus:int;
      
      public var mId:int;
      
      public var mStartFrame:int;
      
      public var mCollidesWithNext:Boolean;
      
      public var mLastPowerType:int;
      
      public var mExplodingInTunnel:Boolean;
      
      public var mCurve:CurveMgr;
      
      public var mLastFrame:int;
      
      public var mNeedCheckCollision:Boolean;
      
      private var mMatrix:Matrix;
      
      public var mPowerupIconBitmap:Bitmap;
      
      public var mCel:int;
      
      public var mPowerupBallImage:ImageInst;
      
      public var mList:DLinkedList;
      
      public var mBallImage:ImageInst;
      
      public var mBallExplodeBitmap:Bitmap;
      
      public var mPulseState:int;
      
      public var mRotationInc:Number;
      
      public var mHilightBitmap:Bitmap;
      
      public var mHilightPulse:Boolean;
      
      public var mSuckCount:int;
      
      public var mRotation:Number;
      
      public var mBackwardsSpeed:Number;
      
      public var mShrinkClear:Boolean;
      
      public var mUpdateCount:int;
      
      public var mShouldRemove:Boolean;
      
      public var mBallExplodeImage:ImageInst;
      
      public var mPriority:int;
      
      public var mPowerFade:int;
      
      public var mSuckPending:Boolean;
      
      public var mDestRotation:Number;
      
      public var mColorType:int;
      
      public var mPowerCount:int;
      
      public var mRadius:Number;
      
      public var mSuckFromCompacting:Boolean;
      
      public var mIconScaleRate:Number;
      
      public var mWayPoint:Number;
      
      public var mExploding:Boolean;
      
      public var mPulseTimer:int;
      
      public var mInTunnel:Boolean;
      
      public var mX:Number;
      
      public var mY:Number;
      
      public var mPowerupBallBitmap:Bitmap;
      
      public var mFrog:Gun;
      
      public var mBackwardsCount:int;
      
      public var mBullet:Bullet;
      
      public var mNumGaps:int;
      
      public var mSuckBack:Boolean;
      
      public var mSpeedy:Boolean;
      
      public var mPowerGracePeriod:int;
      
      public var mIconCel:int;
      
      public var mDestPowerType:int;
      
      public var mBallSprite:Sprite;
      
      public var mPowerType:int;
      
      public var mListItr:DListIterator;
      
      public function Ball(param1:Zuma2App)
      {
         this.mMatrix = new Matrix();
         this.p = new SexyVector3(0,0,0);
         super();
         this.mApp = param1;
         this.mDead = false;
         this.mId = ++mIdGen;
         this.mBallSprite = new Sprite();
         this.mHilightSprite = new Sprite();
         this.mHilightBitmap = new Bitmap();
         this.mBallImage = this.mApp.imageManager.getImageInst(this.PickBallColor());
         this.mBallImage.mFrame = Math.random() * 60;
         this.mMatrix.translate(-13,-13);
         this.mBallSprite = new Sprite();
         this.mBallSprite.graphics.beginBitmapFill(this.mBallImage.pixels,this.mMatrix,false,true);
         this.mBallSprite.graphics.drawRect(-13,-13,26,26);
         this.mBallSprite.graphics.endFill();
         this.mBallSprite.x = -50;
         this.mBallSprite.y = -50;
         this.mApp.mLayers[0].mBalls.addChild(this.mBallSprite);
         this.mApp.mLayers[0].mBalls.addChild(this.mHilightSprite);
         this.mPriority = 0;
         this.mFrog = null;
         this.mInTunnel = false;
         this.mCurve = null;
         this.mUpdateCount = 0;
         this.mSuckFromCompacting = false;
         this.mX = 0;
         this.mY = 0;
         this.mSuckBack = true;
         this.mBullet = null;
         this.mCel = 0;
         this.mShouldRemove = false;
         this.mLastFrame = 0;
         this.mIsCannon = false;
         this.mSpeedy = false;
         this.mList = null;
         this.mCollidesWithNext = false;
         this.mSuckCount = 0;
         this.mBackwardsCount = 0;
         this.mBackwardsSpeed = 0;
         this.mComboCount = 0;
         this.mComboScore = 0;
         this.mRotation = 0;
         this.mRotationInc = 0;
         this.mNeedCheckCollision = false;
         this.mSuckPending = false;
         this.mShrinkClear = false;
         this.mIconCel = -1;
         this.mIconAppearScale = 1;
         this.mIconScaleRate = 0;
         this.mStartFrame = 0;
         this.mWayPoint = 0;
         this.mPowerType = PowerType.PowerType_None;
         this.mDestPowerType = PowerType.PowerType_None;
         this.mPowerCount = 0;
         this.mPowerFade = 0;
         this.mGapBonus = 0;
         this.mNumGaps = 0;
         this.mExplodeFrame = 0;
         this.mPowerGracePeriod = 0;
         this.mLastPowerType = PowerType.PowerType_None;
         this.mExplodingFromLightning = false;
         this.mExploding = this.mExplodingInTunnel = false;
         this.mRadius = 18;
      }
      
      public function SetComboCount(param1:int, param2:int) : void
      {
         this.mComboCount = param1;
         this.mComboScore = param2;
      }
      
      public function GetX() : Number
      {
         return this.mX;
      }
      
      public function SetPriority(param1:int) : void
      {
         if(param1 > this.mPriority)
         {
            this.mApp.mLayers[1].mBalls.addChild(this.mBallSprite);
            this.mApp.mLayers[1].mBalls.addChild(this.mHilightSprite);
            if(this.mPowerupIconSprite != null)
            {
               this.mApp.mLayers[1].mForeground.addChild(this.mPowerupIconSprite);
            }
         }
         if(param1 < this.mPriority)
         {
            this.mApp.mLayers[0].mBalls.addChild(this.mBallSprite);
            this.mApp.mLayers[0].mBalls.addChild(this.mHilightSprite);
            if(this.mPowerupIconSprite != null)
            {
               this.mApp.mLayers[0].mForeground.addChild(this.mPowerupIconSprite);
            }
         }
         this.mPriority = param1;
      }
      
      public function GetBackwardsSpeed() : int
      {
         return this.mBackwardsSpeed;
      }
      
      public function GetIsCannon() : Boolean
      {
         return this.mIsCannon;
      }
      
      public function SetBackwardsSpeed(param1:Number) : void
      {
         this.mBackwardsSpeed = param1;
      }
      
      public function GetExplosionColor() : String
      {
         var _loc1_:String = null;
         switch(this.mColorType)
         {
            case 0:
               _loc1_ = Zuma2Images.IMAGE_BALL_BLUE_EXPLOSION;
               break;
            case 1:
               _loc1_ = Zuma2Images.IMAGE_BALL_YELLOW_EXPLOSION;
               break;
            case 2:
               _loc1_ = Zuma2Images.IMAGE_BALL_RED_EXPLOSION;
               break;
            case 3:
               _loc1_ = Zuma2Images.IMAGE_BALL_GREEN_EXPLOSION;
               break;
            case 4:
               _loc1_ = Zuma2Images.IMAGE_BALL_PURPLE_EXPLOSION;
               break;
            case 5:
               break;
            default:
               _loc1_ = Zuma2Images.IMAGE_BALL_BLUE_EXPLOSION;
         }
         return _loc1_;
      }
      
      public function GetPrevBall(param1:Boolean = false) : Ball
      {
         if(this.mList == null)
         {
            return null;
         }
         var _loc2_:DListIterator = this.mListItr;
         if(_loc2_.node == this.mList.head)
         {
            return null;
         }
         if(!param1)
         {
            return _loc2_.node.prev.data;
         }
         var _loc3_:Ball = _loc2_.node.prev.data;
         if(_loc3_.GetCollidesWithNext())
         {
            return _loc3_;
         }
         return null;
      }
      
      public function RemoveFromList() : void
      {
         if(this.mList != null)
         {
            this.mList.remove(this.mListItr);
            this.mList = null;
            this.mListItr = null;
         }
      }
      
      public function UpdateExplosion() : void
      {
         if(!this.mExploding)
         {
            return;
         }
         if(!this.mExplodingFromLightning && this.mUpdateCount % 4 == 0)
         {
            ++this.mExplodeFrame;
            this.mExplodeAlpha -= 0.15;
         }
         if(this.mExplodeFrame >= 10)
         {
            this.mShouldRemove = true;
         }
      }
      
      public function GetIsExploding() : Boolean
      {
         return this.mExploding;
      }
      
      public function GetGapBonus() : int
      {
         return this.mGapBonus;
      }
      
      public function SetWayPoint(param1:Number, param2:Boolean) : void
      {
         this.mWayPoint = param1;
         this.mInTunnel = param2;
         if(param1 > 100)
         {
         }
      }
      
      public function Contains(param1:int, param2:int) : Boolean
      {
         param1 -= this.mX;
         param2 -= this.mY;
         var _loc3_:int = this.GetRadius() - 3;
         if(param1 * param1 + param2 * param2 < _loc3_ * _loc3_)
         {
            return true;
         }
         return false;
      }
      
      public function SetSuckPending(param1:Boolean, param2:Boolean = false) : void
      {
         this.mSuckPending = param1;
         this.mSuckFromCompacting = param2;
      }
      
      public function SetCollidesWithNext(param1:Boolean) : void
      {
         this.mCollidesWithNext = param1;
      }
      
      public function GetSuckCount() : int
      {
         return this.mSuckCount;
      }
      
      public function SetBallImage(param1:int) : void
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case 0:
               _loc2_ = Zuma2Images.IMAGE_BALL_BLUE;
               break;
            case 1:
               _loc2_ = Zuma2Images.IMAGE_BALL_YELLOW;
               break;
            case 2:
               _loc2_ = Zuma2Images.IMAGE_BALL_RED;
               break;
            case 3:
               _loc2_ = Zuma2Images.IMAGE_BALL_GREEN;
               break;
            case 4:
               _loc2_ = Zuma2Images.IMAGE_BALL_PURPLE;
               break;
            case 5:
               _loc2_ = Zuma2Images.IMAGE_BALL_WHITE;
               break;
            default:
               _loc2_ = Zuma2Images.IMAGE_BALL_BLUE;
         }
         this.mBallImage = this.mApp.imageManager.getImageInst(_loc2_);
         this.mBallImage.mFrame = Math.random() * 60;
         this.mBallSprite.graphics.clear();
         this.mBallSprite.graphics.beginBitmapFill(this.mBallImage.pixels,this.mMatrix,false,true);
         this.mBallSprite.graphics.drawRect(-13,-13,26,26);
         this.mBallSprite.graphics.endFill();
      }
      
      public function GetCollidesWithPrev() : Boolean
      {
         var _loc1_:Ball = this.GetPrevBall();
         if(_loc1_ != null)
         {
            return _loc1_.GetCollidesWithNext();
         }
         return false;
      }
      
      public function GetShouldRemove() : Boolean
      {
         return this.mShouldRemove;
      }
      
      public function CollidesWith(param1:Ball, param2:int = 0) : Boolean
      {
         return Math.abs(int(this.mWayPoint) - int(param1.mWayPoint)) < (this.mRadius + param2) * 2;
      }
      
      public function UpdateCollisionInfo(param1:int = 0) : void
      {
         var _loc2_:Ball = this.GetPrevBall();
         var _loc3_:Ball = this.GetNextBall();
         if(_loc2_ != null)
         {
            _loc2_.SetCollidesWithNext(_loc2_.CollidesWith(this,param1));
         }
         if(_loc3_ != null)
         {
            this.SetCollidesWithNext(_loc3_.CollidesWith(this,param1));
         }
         else
         {
            this.SetCollidesWithNext(false);
         }
      }
      
      public function GetColorType() : Number
      {
         return this.mColorType;
      }
      
      public function SetPos(param1:Number, param2:Number) : void
      {
         this.mX = param1;
         this.mY = param2;
      }
      
      public function Explode(param1:Boolean, param2:Boolean) : void
      {
         var _loc4_:PowerEffect = null;
         if(this.mExploding)
         {
            return;
         }
         this.mExplodeAlpha = 1;
         this.mBallSprite.graphics.clear();
         this.mHilightSprite.graphics.clear();
         if(this.mPowerupIconSprite != null)
         {
            this.mPowerupIconSprite.graphics.clear();
         }
         this.mExploding = true;
         this.mExplodingInTunnel = param1;
         if(!this.mExplodingInTunnel)
         {
            this.mExplodeFrame = 0;
            this.mBallExplodeImage = this.mApp.imageManager.getImageInst(this.GetExplosionColor());
            this.mBallExplodeImage.mFrame = this.mExplodeFrame;
            this.mBallExplodeBitmap = new Bitmap(this.mBallExplodeImage.pixels);
            this.mBallExplodeBitmap.x = -this.mBallExplodeBitmap.width / 2;
            this.mBallExplodeBitmap.y = -this.mBallExplodeBitmap.height / 2;
            this.mBallSprite.addChild(this.mBallExplodeBitmap);
         }
         var _loc3_:GameBoardWidget = this.mCurve.mBoard;
         if(this.GetPowerOrDestType() == PowerType.PowerType_ProximityBomb)
         {
            (_loc4_ = new PowerEffect(this.mApp,this.mX,this.mY)).AddDefaultEffectType(PowerEffect.PowerEffect_Bomb,this.mColorType,this.mRotation);
            _loc3_.AddPowerEffect(_loc4_);
            _loc3_.AddProxBombExplosion(this.GetX(),this.GetY());
         }
         else if(this.GetPowerOrDestType() != PowerType.PowerType_Accuracy)
         {
            if(this.GetPowerOrDestType() == PowerType.PowerType_MoveBackwards)
            {
               (_loc4_ = new ReversePowerEffect(this.mApp,this,this.mX,this.mY)).AddDefaultEffectType(PowerEffect.PowerEffect_Reverse,this.mColorType,this.mRotation);
               _loc3_.AddPowerEffect(_loc4_);
            }
            else if(this.GetPowerOrDestType() == PowerType.PowerType_SlowDown)
            {
               (_loc4_ = new PowerEffect(this.mApp,this.mX,this.mY)).AddDefaultEffectType(PowerEffect.PowerEffect_Stop,this.mColorType,this.mRotation);
               _loc3_.AddPowerEffect(_loc4_);
            }
            else if(this.GetPowerOrDestType() != PowerType.PowerType_Cannon)
            {
               if(this.GetPowerOrDestType() == PowerType.PowerType_Laser)
               {
               }
            }
         }
         if(this.GetPowerOrDestType() != PowerType.PowerType_None)
         {
         }
      }
      
      public function SetSuckCount(param1:int, param2:Boolean = true) : void
      {
         this.mSuckCount = param1;
         this.mSuckBack = param2;
      }
      
      public function GetPowerOrDestType(param1:Boolean = true) : int
      {
         if(this.mPowerType != PowerType.PowerType_None)
         {
            return this.mPowerType;
         }
         if(this.mPowerGracePeriod > 0 && this.mLastPowerType != PowerType.PowerType_None)
         {
            return this.mLastPowerType;
         }
         return this.mDestPowerType;
      }
      
      public function GetRotation() : Number
      {
         return this.mRotation;
      }
      
      public function GetBackwardsCount() : int
      {
         return this.mBackwardsCount;
      }
      
      public function GetSuckPending() : Boolean
      {
         return this.mSuckPending;
      }
      
      public function SetBackwardsCount(param1:int) : void
      {
         this.mBackwardsCount = param1;
      }
      
      public function GetNextBall(param1:Boolean = false) : Ball
      {
         if(this.mList == null)
         {
            return null;
         }
         var _loc2_:DListIterator = this.mListItr;
         if(_loc2_.node.next == null)
         {
            return null;
         }
         if(!param1 || this.GetCollidesWithNext())
         {
            return _loc2_.node.next.data;
         }
         return null;
      }
      
      public function Update(param1:Number = 1) : void
      {
         var _loc2_:String = null;
         ++this.mUpdateCount;
         if(this.mPowerFade > 0)
         {
            this.mIconAppearScale -= this.mIconScaleRate;
            if(this.mIconAppearScale < 1)
            {
               this.mIconAppearScale = 1;
            }
            --this.mPowerFade;
            if(this.mPowerFade == 0)
            {
               this.mPowerType = this.mDestPowerType;
               if(this.mPowerType == PowerType.PowerType_None)
               {
                  return;
               }
               this.mDestPowerType = PowerType.PowerType_None;
               if(this.mPowerType != PowerType.PowerType_None && this.mPowerCount <= 0)
               {
                  this.mPowerCount = 2000;
               }
               _loc2_ = this.GetPowerupImage();
               this.mPowerupBallImage = this.mApp.imageManager.getImageInst(_loc2_);
               this.mPowerupBallImage.mFrame = this.mIconCel;
               this.mPowerupIconSprite.graphics.beginBitmapFill(this.mPowerupBallImage.pixels,this.mMatrix,false,true);
               this.mPowerupIconSprite.graphics.drawRect(-13,-13,26,26);
               this.mPowerupIconSprite.graphics.endFill();
               this.mIconAppearScale = 1;
               if(this.mPowerType == PowerType.PowerType_MoveBackwards)
               {
                  this.mPowerupIconImage = this.mApp.imageManager.getImageInst(Zuma2Images.IMAGE_POWERUP_REVERSE_PULSE);
                  this.mPowerupIconImage.mFrame = 0;
                  this.mPowerupIconBitmap.bitmapData = this.mPowerupIconImage.pixels;
                  this.mPowerupIconBitmap.x = -this.mPowerupIconBitmap.width / 2;
                  this.mPowerupIconBitmap.y = -this.mPowerupIconBitmap.height / 2;
                  this.mPowerupIconBitmap.smoothing = true;
                  this.mPowerupIconSprite.addChild(this.mPowerupIconBitmap);
               }
               this.mBallSprite.visible = false;
               this.mIconCel = -1;
            }
         }
         if(this.mPowerCount > 0 && !this.mExploding)
         {
            if(--this.mPowerCount <= 0)
            {
               this.mPowerGracePeriod = 150;
               this.mLastPowerType = this.GetPowerOrDestType();
               this.SetPowerType(PowerType.PowerType_None);
            }
         }
         if(this.mPowerGracePeriod > 0 && --this.mPowerGracePeriod == 0)
         {
            this.mLastPowerType = PowerType.PowerType_None;
         }
         if(this.mPowerType != PowerType.PowerType_None)
         {
            if(!this.mExploding)
            {
               ++this.mPulseTimer;
               if(this.mPulseState == 0 && this.mPulseTimer >= 30)
               {
                  ++this.mPulseState;
                  this.mPulseTimer = 0;
               }
               else if(this.mPulseState == 1 && this.mPulseTimer >= 128)
               {
                  this.mPulseTimer = 0;
                  ++this.mPulseState;
               }
               else if(this.mPulseState == 2 && this.mPulseTimer >= 25)
               {
                  this.mPulseState = 0;
                  this.mPulseTimer = 0;
               }
            }
         }
         if(this.mPowerType == PowerType.PowerType_MoveBackwards && this.mUpdateCount % 4 == 0)
         {
            this.mCel = this.mCel == 0 ? 21 : int(this.mCel - 1);
         }
         this.UpdateRotation();
      }
      
      public function GetNumGaps() : int
      {
         return this.mNumGaps;
      }
      
      public function GetId() : int
      {
         return this.mId;
      }
      
      public function SetColorType(param1:int) : void
      {
         this.mColorType = param1;
         this.SetBallImage(this.mColorType);
      }
      
      public function SetNeedCheckCollision(param1:Boolean) : void
      {
         this.mNeedCheckCollision = param1;
      }
      
      public function GetListItr() : DListIterator
      {
         return this.mListItr;
      }
      
      public function GetWayPoint() : Number
      {
         return this.mWayPoint;
      }
      
      public function GetPowerupImage() : String
      {
         var _loc1_:String = null;
         switch(this.mColorType)
         {
            case 0:
               _loc1_ = Zuma2Images.IMAGE_POWERUP_BLUE;
               break;
            case 1:
               _loc1_ = Zuma2Images.IMAGE_POWERUP_YELLOW;
               break;
            case 2:
               _loc1_ = Zuma2Images.IMAGE_POWERUP_RED;
               break;
            case 3:
               _loc1_ = Zuma2Images.IMAGE_POWERUP_GREEN;
               break;
            case 4:
               _loc1_ = Zuma2Images.IMAGE_POWERUP_PURPLE;
               break;
            case 5:
               _loc1_ = Zuma2Images.IMAGE_POWERUP_WHITE;
               break;
            default:
               _loc1_ = Zuma2Images.IMAGE_POWERUP_BLUE;
         }
         return _loc1_;
      }
      
      public function DrawAboveBalls() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(this.mPowerupIconSprite != null && this.mPowerupIconSprite.parent != null)
         {
            _loc1_ = -Zuma2App.MY_PI / 2;
            this.mPowerupIconSprite.rotation = (_loc1_ + -this.mRotation) * Zuma2App.RAD_TO_DEG;
            this.mPowerupIconSprite.x = this.mX * Zuma2App.SHRINK_PERCENT;
            this.mPowerupIconSprite.y = this.mY * Zuma2App.SHRINK_PERCENT;
            this.mPowerupIconSprite.scaleX = this.mIconAppearScale;
            this.mPowerupIconSprite.scaleY = this.mIconAppearScale;
            if(this.mPowerType == PowerType.PowerType_MoveBackwards)
            {
            }
            if(this.mIconAppearScale == 1)
            {
               if(this.mPowerType == PowerType.PowerType_MoveBackwards)
               {
                  this.mPowerupIconImage.mFrame = this.mCel;
                  this.mPowerupIconBitmap.bitmapData = this.mPowerupIconImage.pixels;
               }
               else if(this.mPulseState < 2)
               {
                  _loc2_ = (255 - this.mPulseTimer * (this.mPulseState == 0 ? 4 : 2)) / 255;
                  this.mPowerupIconBitmap.alpha = _loc2_;
               }
            }
         }
         else if(this.mIconCel == -1 || this.mIconAppearScale <= 1)
         {
         }
      }
      
      public function GetCollidesWithNext() : Boolean
      {
         return this.mCollidesWithNext;
      }
      
      public function GetPowerType() : int
      {
         return this.mPowerType;
      }
      
      public function SetGapBonus(param1:int, param2:int) : void
      {
         this.mGapBonus = param1;
         this.mNumGaps = param2;
      }
      
      public function Intersects(param1:SexyVector3, param2:SexyVector3, param3:Point) : Boolean
      {
         this.p.x = param1.x - this.mX;
         this.p.y = param1.y - this.mY;
         this.p.z = 0;
         var _loc4_:Number = this.mRadius - 1;
         var _loc5_:Number = param2.Dot(param2);
         var _loc6_:Number = 2 * this.p.Dot(param2);
         var _loc7_:Number = this.p.Dot(this.p) - _loc4_ * 2 * (_loc4_ * 2);
         var _loc8_:Number;
         if((_loc8_ = _loc6_ * _loc6_ - 4 * _loc5_ * _loc7_) < 0)
         {
            return false;
         }
         _loc8_ = Math.sqrt(_loc8_);
         param3.x = (-_loc6_ - _loc8_) / (2 * _loc5_);
         return true;
      }
      
      public function PickBallColor() : String
      {
         var _loc2_:String = null;
         var _loc1_:int = Math.random() * 5;
         switch(_loc1_)
         {
            case 0:
               _loc2_ = Zuma2Images.IMAGE_BALL_BLUE;
               break;
            case 1:
               _loc2_ = Zuma2Images.IMAGE_BALL_YELLOW;
               break;
            case 2:
               _loc2_ = Zuma2Images.IMAGE_BALL_RED;
               break;
            case 3:
               _loc2_ = Zuma2Images.IMAGE_BALL_GREEN;
               break;
            case 4:
               _loc2_ = Zuma2Images.IMAGE_BALL_PURPLE;
               break;
            case 5:
               _loc2_ = Zuma2Images.IMAGE_BALL_WHITE;
               break;
            default:
               _loc2_ = Zuma2Images.IMAGE_BALL_BLUE;
         }
         this.mColorType = _loc1_;
         return _loc2_;
      }
      
      public function GetRadius() : Number
      {
         return this.mRadius;
      }
      
      public function Hide(param1:Boolean) : void
      {
         if(this.mBallSprite != null)
         {
            this.mBallSprite.visible = !param1;
         }
         if(this.mPowerupIconSprite != null)
         {
            this.mPowerupIconSprite.visible = !param1;
         }
      }
      
      public function Draw(param1:Canvas) : void
      {
         this.mBallSprite.x = (this.mX - this.mRadius) * Zuma2App.SHRINK_PERCENT + 13;
         this.mBallSprite.y = (this.mY - this.mRadius) * Zuma2App.SHRINK_PERCENT + 13;
         this.mBallSprite.rotation = -this.mRotation * Zuma2App.RAD_TO_DEG;
         if(!this.mExploding)
         {
            this.mBallImage.mFrame = this.GetFrame();
            this.mBallImage.mIsSmoothed = true;
            this.mBallSprite.graphics.clear();
            this.mBallSprite.graphics.beginBitmapFill(this.mBallImage.pixels,this.mMatrix,false,true);
            this.mBallSprite.graphics.drawRect(-13,-13,26,26);
            this.mBallSprite.graphics.endFill();
            this.mHilightSprite.graphics.clear();
            if(this.mHilightPulse && this.mPowerType == PowerType.PowerType_None)
            {
               this.mHilightSprite.x = (this.mX - this.mRadius) * Zuma2App.SHRINK_PERCENT + 13;
               this.mHilightSprite.y = (this.mY - this.mRadius) * Zuma2App.SHRINK_PERCENT + 13;
               this.mHilightSprite.rotation = -this.mRotation * Zuma2App.RAD_TO_DEG;
               this.mHilightSprite.blendMode = BlendMode.ADD;
               this.mHilightSprite.graphics.beginBitmapFill(this.mBallImage.pixels,this.mMatrix,false,true);
               this.mHilightSprite.graphics.drawRect(-13,-13,26,26);
               this.mHilightSprite.graphics.endFill();
            }
         }
         else if(this.mExploding && this.mBallExplodeImage != null)
         {
            this.mBallExplodeImage.mFrame = this.mExplodeFrame;
            this.mBallExplodeBitmap.bitmapData = this.mBallExplodeImage.pixels;
            this.mBallSprite.alpha = this.mExplodeAlpha;
         }
         this.DrawAboveBalls();
      }
      
      public function CollidesWithPhysically(param1:Ball, param2:int = 0) : Boolean
      {
         var _loc3_:Number = param1.GetX() - this.GetX();
         var _loc4_:Number = param1.GetY() - this.GetY();
         var _loc5_:Number = Number(param1.GetRadius() + param2 * 2 + this.GetRadius());
         return _loc3_ * _loc3_ + _loc4_ * _loc4_ < _loc5_ * _loc5_;
      }
      
      public function GetComboScore() : int
      {
         return this.mComboScore;
      }
      
      public function UpdateRotation() : void
      {
         if(this.mRotationInc != 0)
         {
            this.mRotation += this.mRotationInc;
            if(this.mRotationInc > 0 && this.mRotation > this.mDestRotation || this.mRotationInc < 0 && this.mRotation < this.mDestRotation)
            {
               this.mRotation = this.mDestRotation;
               this.mRotationInc = 0;
            }
         }
      }
      
      public function SetCollidesWithPrev(param1:Boolean) : void
      {
         var _loc2_:Ball = this.GetPrevBall();
         if(_loc2_ != null)
         {
            return _loc2_.SetCollidesWithNext(param1);
         }
      }
      
      public function InsertInList(param1:DLinkedList, param2:DListIterator, param3:CurveMgr) : DListIterator
      {
         this.mList = param1;
         if(param2.node == null)
         {
            this.mList.insertAfter(param2,this);
         }
         else
         {
            this.mList.insertBefore(param2,this);
         }
         this.mListItr = this.mList.nodeOf(this);
         if(this.mListItr.node == null)
         {
            trace("Iterator node is null");
         }
         this.mCurve = param3;
         return this.mListItr;
      }
      
      public function GetSuckBack() : Boolean
      {
         return this.mSuckBack;
      }
      
      public function SetPowerType(param1:int, param2:Boolean = true) : void
      {
         var _loc3_:ColorTransform = null;
         var _loc4_:int = 0;
         if(param1 == this.mPowerType)
         {
            return;
         }
         this.mPulseState = 0;
         this.mPulseTimer = 0;
         this.mIconCel = -1;
         if(param1 != PowerType.PowerType_None)
         {
            this.mPowerGracePeriod = 0;
            this.mLastPowerType = PowerType.PowerType_None;
         }
         if(param2)
         {
            this.mDestPowerType = param1;
            if(param1 == PowerType.PowerType_None && this.mPowerType == PowerType.PowerType_GauntletMultBall)
            {
               this.mPowerFade = 300;
            }
            else
            {
               this.mPowerFade = 100;
            }
            switch(param1)
            {
               case PowerType.PowerType_Accuracy:
                  this.mIconCel = 0;
                  break;
               case PowerType.PowerType_ColorNuke:
                  this.mIconCel = 1;
                  break;
               case PowerType.PowerType_SlowDown:
                  this.mIconCel = 2;
                  break;
               case PowerType.PowerType_ProximityBomb:
                  this.mIconCel = 3;
                  break;
               case PowerType.PowerType_MoveBackwards:
                  this.mIconCel = 4;
                  break;
               case PowerType.PowerType_Cannon:
                  this.mIconCel = 5;
                  break;
               case PowerType.PowerType_Laser:
                  this.mIconCel = 6;
            }
            if(param1 != PowerType.PowerType_None)
            {
               if(param1 != PowerType.PowerType_GauntletMultBall)
               {
                  this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_POWERUP_APPEARS2);
               }
            }
            else if(this.GetPowerOrDestType() != PowerType.PowerType_None)
            {
               if(this.GetPowerOrDestType() != PowerType.PowerType_GauntletMultBall)
               {
                  this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_POWERUP_DISAPPEARS);
               }
            }
            if(this.mIconCel != -1)
            {
               this.mPowerupIconImage = this.mApp.imageManager.getImageInst(Zuma2Images.IMAGE_POWERUP_POWERPULSES);
               this.mPowerupIconImage.mFrame = this.mIconCel;
               this.mPowerupIconBitmap = new Bitmap(this.mPowerupIconImage.pixels,PixelSnapping.NEVER,true);
               this.mPowerupIconBitmap.x = -this.mPowerupIconBitmap.width / 2;
               this.mPowerupIconBitmap.y = -this.mPowerupIconBitmap.height / 2;
               this.mPowerupIconBitmap.blendMode = BlendMode.ADD;
               _loc3_ = this.mPowerupIconBitmap.transform.colorTransform;
               _loc4_ = this.mApp.gBallColors[this.mColorType];
               _loc3_.redMultiplier = ((_loc4_ & 16711680) >> 16) / 255;
               _loc3_.greenMultiplier = ((_loc4_ & 65280) >> 8) / 255;
               _loc3_.blueMultiplier = ((_loc4_ & 255) >> 0) / 255;
               this.mPowerupIconBitmap.transform.colorTransform = _loc3_;
               if(this.mPowerupIconSprite == null)
               {
                  this.mPowerupIconSprite = new Sprite();
                  this.mPowerupIconSprite.addChild(this.mPowerupIconBitmap);
               }
               else
               {
                  this.mPowerupIconSprite.addChild(this.mPowerupIconBitmap);
               }
               this.mApp.mLayers[0].mForeground.addChild(this.mPowerupIconSprite);
               this.mIconAppearScale = 5;
               this.mIconScaleRate = (this.mIconAppearScale - 1) / Number(this.mPowerFade);
            }
            else if(this.mIconCel == -1 && this.mPowerupIconSprite.parent != null)
            {
               this.mPowerupIconSprite.parent.removeChild(this.mPowerupIconSprite);
               this.mPowerupIconSprite = null;
               this.mBallSprite.visible = true;
            }
         }
         else
         {
            this.mDestPowerType = PowerType.PowerType_None;
            this.mPowerType = param1;
         }
         if(param1 != PowerType.PowerType_None)
         {
         }
      }
      
      public function GetDestPowerType() : int
      {
         return this.mDestPowerType;
      }
      
      public function Delete() : void
      {
         if(this.mBallSprite.parent != null)
         {
            this.mBallSprite.parent.removeChild(this.mBallSprite);
         }
         if(this.mHilightSprite != null)
         {
            if(this.mHilightSprite.parent != null)
            {
               this.mHilightSprite.parent.removeChild(this.mHilightSprite);
            }
         }
         if(this.mPowerupIconSprite != null)
         {
            if(this.mPowerupIconSprite.parent != null)
            {
               this.mPowerupIconSprite.parent.removeChild(this.mPowerupIconSprite);
            }
         }
      }
      
      public function GetFrame() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 1;
         var _loc3_:int = 60;
         var _loc4_:int;
         _loc1_ = ((_loc4_ = this.mWayPoint) / _loc2_ + this.mStartFrame) % _loc3_;
         if(_loc1_ < 0)
         {
            _loc1_ = -_loc1_;
         }
         else if(_loc1_ >= _loc3_)
         {
            _loc1_ = _loc3_ - 1;
         }
         return _loc1_;
      }
      
      public function GetBullet() : Bullet
      {
         if(this.mBullet != null)
         {
         }
         return this.mBullet;
      }
      
      public function SetRotation(param1:Number, param2:Boolean = true) : void
      {
         if(param2)
         {
            this.mRotation = param1;
         }
         else
         {
            if(Math.abs(param1 - this.mRotation) <= 0.001)
            {
               return;
            }
            while(Math.abs(param1 - this.mRotation) > Zuma2App.MY_PI)
            {
               if(param1 > this.mRotation)
               {
                  param1 -= 2 * Zuma2App.MY_PI;
               }
               else
               {
                  param1 += 2 * Zuma2App.MY_PI;
               }
            }
            this.mDestRotation = param1;
            this.mRotationInc = Zuma2App.MY_PI / 30;
            if(param1 < this.mRotation)
            {
               this.mRotationInc = -this.mRotationInc;
            }
         }
      }
      
      public function GetY() : Number
      {
         return this.mY;
      }
      
      public function GetSpeedy() : Boolean
      {
         return this.mSpeedy;
      }
      
      public function GetSuckFromCompacting() : Boolean
      {
         return this.mSuckFromCompacting;
      }
      
      public function SetBullet(param1:Bullet) : void
      {
         this.mBullet = param1;
      }
      
      public function SetSpeedy(param1:Boolean) : void
      {
         this.mSpeedy = param1;
      }
      
      public function GetComboCount() : int
      {
         return this.mComboCount;
      }
   }
}
