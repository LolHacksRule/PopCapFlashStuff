package com.popcap.flash.games.zuma2.logic
{
   import com.popcap.flash.framework.Canvas;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   
   public class Bullet extends Ball
   {
       
      
      public var mHitDX:Number = 0;
      
      public var mHitBall:Ball;
      
      private var mDestX:Number = 0;
      
      private var mDestY:Number = 0;
      
      private var mMatrix:Matrix;
      
      public var mHaveSetPrevBall:Boolean;
      
      public var mHitX:Number = 0;
      
      public var mHitY:Number = 0;
      
      public var mMergeSpeed:Number = 0;
      
      private var mHitInFront:Boolean;
      
      public var mCurCurvePoint:Array;
      
      private var mVelX:Number = 0;
      
      private var mVelY:Number = 0;
      
      public var mJustFired:Boolean;
      
      public var mDoNewMerge:Boolean;
      
      public var mHitDY:Number = 0;
      
      public var mGapInfo:Vector.<GapInfo>;
      
      public var mHitPercent:Number = 0;
      
      public function Bullet(param1:Zuma2App)
      {
         this.mGapInfo = new Vector.<GapInfo>();
         this.mMatrix = new Matrix();
         this.mCurCurvePoint = new Array();
         super(param1);
         mApp = param1;
         this.mVelX = 0;
         this.mVelY = 0;
         mX = 0;
         mY = 0;
         mDead = false;
         this.mJustFired = false;
         this.mHitBall = null;
         this.mHitPercent = 0;
         this.mMergeSpeed = 0.025;
         this.mDoNewMerge = false;
         mUpdateCount = 0;
         this.mHitDX = 0;
         this.mHitDY = 0;
         this.mMatrix.translate(-13,-13);
         mBallSprite = new Sprite();
         mApp.mLayers[0].mBalls.addChild(mBallSprite);
         mPriority = 0;
      }
      
      public function GetCurGapBall(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this.mGapInfo.length)
         {
            if(this.mGapInfo[_loc3_].mCurve == param1)
            {
               _loc2_ = this.mGapInfo[_loc3_].mBallId;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function GetHitPercent() : Number
      {
         return this.mHitPercent;
      }
      
      public function CheckSetHitBallToPrevBall() : void
      {
         if(this.mHaveSetPrevBall || this.mHitBall == null)
         {
            return;
         }
         var _loc1_:Ball = this.mHitBall.GetPrevBall();
         if(_loc1_ == null)
         {
            return;
         }
         if(_loc1_.CollidesWithPhysically(this) && !_loc1_.GetIsExploding())
         {
            this.mHaveSetPrevBall = true;
            this.SetBallInfo(null);
            this.mHitBall = _loc1_;
            this.mHitInFront = true;
            this.mHitX = mX;
            this.mHitY = mY;
            this.mHitDX = mX - _loc1_.GetX();
            this.mHitDY = mY - _loc1_.GetY();
            this.mHitPercent = 0;
            this.SetBallInfo(this);
         }
      }
      
      public function GetPushBall() : Ball
      {
         if(this.mHitBall == null)
         {
            return null;
         }
         var _loc1_:Ball = null;
         _loc1_ = !!this.mHitInFront ? this.mHitBall.GetNextBall() : this.mHitBall;
         if(_loc1_ != null)
         {
            if(this.mDoNewMerge || _loc1_.CollidesWithPhysically(this))
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function SetHitBall(param1:Ball, param2:Boolean) : void
      {
         this.SetBallInfo(null);
         this.mHaveSetPrevBall = false;
         this.mHitBall = param1;
         this.mHitX = mX;
         this.mHitY = mY;
         this.mHitDX = mX - param1.GetX();
         this.mHitDY = mY - param1.GetY();
         this.mHitPercent = 0;
         this.mHitInFront = param2;
         this.SetBallInfo(this);
      }
      
      public function MergeFully() : void
      {
         this.mHitPercent = 1;
         this.Update();
      }
      
      public function GetHitBall() : Ball
      {
         return this.mHitBall;
      }
      
      public function UpdateHitPos() : void
      {
         this.mHitX = mX;
         this.mHitY = mY;
      }
      
      public function SetCurCurvePoint(param1:int, param2:int) : void
      {
         this.mCurCurvePoint[param1] = param2;
      }
      
      public function GetCurCurvePoint(param1:int) : int
      {
         return this.mCurCurvePoint[param1];
      }
      
      public function SetBallInfo(param1:Bullet) : void
      {
         if(this.mHitBall != null)
         {
            this.mHitBall.SetBullet(param1);
         }
      }
      
      public function SetDestPos(param1:Number, param2:Number) : void
      {
         this.mDestX = param1;
         this.mDestY = param2;
      }
      
      public function SetVelocity(param1:Number, param2:Number) : void
      {
         this.mVelX = param1;
         this.mVelY = param2;
      }
      
      public function GetMinGapDist() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.mGapInfo.length)
         {
            if(_loc1_ == 0 || this.mGapInfo[_loc2_].mDist < _loc1_)
            {
               _loc1_ = this.mGapInfo[_loc2_].mDist;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function GetHitInFront() : Boolean
      {
         return this.mHitInFront;
      }
      
      override public function Delete() : void
      {
         this.SetBallInfo(null);
         if(mBallSprite.parent != null)
         {
            mBallSprite.parent.removeChild(mBallSprite);
         }
      }
      
      public function GetJustFired() : Boolean
      {
         return this.mJustFired;
      }
      
      public function SetJustFired(param1:Boolean) : void
      {
         this.mJustFired = param1;
      }
      
      public function SetMergeSpeed(param1:Number) : void
      {
         this.mMergeSpeed = param1;
      }
      
      override public function GetX() : Number
      {
         return mX;
      }
      
      override public function GetY() : Number
      {
         return mY;
      }
      
      override public function Update(param1:Number = 1) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         ++mUpdateCount;
         if(this.mHitBall == null)
         {
            _loc2_ = this.mVelX * param1;
            _loc3_ = this.mVelY * param1;
            mX += _loc2_;
            mY += _loc3_;
         }
         else if(!mExploding)
         {
            this.mHitPercent += this.mMergeSpeed;
            if(this.mHitPercent > 1)
            {
               this.mHitPercent = 1;
            }
            if(!this.mDoNewMerge)
            {
               mX = this.mHitX + this.mHitPercent * (this.mDestX - this.mHitX);
               mY = this.mHitY + this.mHitPercent * (this.mDestY - this.mHitY);
            }
         }
         UpdateRotation();
      }
      
      override public function PickBallColor() : String
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
         mColorType = _loc1_;
         return _loc2_;
      }
      
      override public function Draw(param1:Canvas) : void
      {
         mBallSprite.x = mX * Zuma2App.SHRINK_PERCENT;
         mBallSprite.y = mY * Zuma2App.SHRINK_PERCENT;
         mBallSprite.rotation = mRotation * Zuma2App.RAD_TO_DEG - 90;
      }
      
      override public function GetNumGaps() : int
      {
         return this.mGapInfo.length;
      }
      
      public function RemoveGapInfoForBall(param1:int) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.mGapInfo.length)
         {
            if(this.mGapInfo[_loc2_].mBallId == param1)
            {
               this.mGapInfo.splice(_loc2_,1);
            }
            _loc2_++;
         }
      }
      
      public function AddGapInfo(param1:int, param2:int, param3:int) : Boolean
      {
         var _loc4_:int = 0;
         while(_loc4_ < this.mGapInfo.length)
         {
            if(this.mGapInfo[_loc4_].mBallId == param3)
            {
               return false;
            }
            _loc4_++;
         }
         this.mGapInfo.push(new GapInfo());
         var _loc5_:GapInfo;
         (_loc5_ = this.mGapInfo[this.mGapInfo.length - 1]).mBallId = param3;
         _loc5_.mDist = param2;
         _loc5_.mCurve = param1;
         return true;
      }
      
      override public function SetBallImage(param1:int) : void
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
         mBallImage = mApp.imageManager.getImageInst(_loc2_);
         mBallSprite.graphics.clear();
         mBallSprite.graphics.beginBitmapFill(mBallImage.pixels,this.mMatrix,false,true);
         mBallSprite.graphics.drawRect(-13,-13,26,26);
         mBallSprite.graphics.endFill();
      }
   }
}
