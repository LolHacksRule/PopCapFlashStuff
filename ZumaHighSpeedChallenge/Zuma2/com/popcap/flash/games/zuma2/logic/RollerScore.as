package com.popcap.flash.games.zuma2.logic
{
   import flash.display.Bitmap;
   import flash.display.PixelSnapping;
   import flash.display.Sprite;
   
   public class RollerScore
   {
       
      
      public var mRollerBitmap:Bitmap;
      
      public var mCurrNum:int;
      
      public var mTargetNum:int;
      
      public var mRollerSprite:Sprite;
      
      public var mTarget:Array;
      
      public var mGauntletMode:Boolean;
      
      public var mAtTarget:Boolean;
      
      public var mDigits:Array;
      
      public var mApp:Zuma2App;
      
      public var mNumbersImage:Bitmap;
      
      public function RollerScore(param1:Zuma2App, param2:Boolean = false)
      {
         this.mDigits = new Array();
         this.mTarget = new Array();
         super();
         this.mApp = param1;
         this.Reset(param2);
      }
      
      public function ForceScore(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1 > 999999)
         {
            param1 = 999999;
         }
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            this.mDigits[_loc2_].mNum = -1;
            this.mDigits[_loc2_].mVY = this.mDigits[_loc2_].mY = 0;
            this.mDigits[_loc2_].mDelay = this.mDigits[_loc2_].mBounceState = 0;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc3_ = int(Math.pow(10,_loc2_));
            _loc4_ = int(Math.pow(10,_loc2_ + 1));
            this.mDigits[_loc2_].mNum = param1 % _loc4_ / _loc3_;
            if(param1 / _loc4_ == 0)
            {
               break;
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            this.mTarget[_loc2_] = this.mDigits[_loc2_];
            _loc2_++;
         }
         this.mTargetNum = this.mCurrNum = param1;
         this.mAtTarget = true;
      }
      
      public function SetTargetScore(param1:int) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Number = NaN;
         if(param1 > 999999)
         {
            param1 = 999999;
         }
         if(param1 == this.mCurrNum)
         {
            return;
         }
         var _loc2_:int = param1 - this.mCurrNum;
         var _loc3_:int = 1;
         while(_loc2_ > 0)
         {
            _loc2_ /= 10;
            if(_loc2_ > 0)
            {
               _loc3_++;
            }
         }
         this.mTargetNum = param1;
         var _loc4_:int = 0;
         while(true)
         {
            _loc6_ = int(Math.pow(10,_loc4_));
            _loc7_ = int(Math.pow(10,_loc4_ + 1));
            _loc8_ = param1 % _loc7_ / _loc6_;
            this.mTarget[_loc4_].mNum = _loc8_;
            if(this.mDigits[_loc4_].mNum != _loc8_)
            {
               this.mDigits[_loc4_].mDelay = Math.random() * 15;
               if(this.mGauntletMode)
               {
                  this.mDigits[_loc4_].mVY = 1 * _loc3_ + Math.random() * 2;
                  _loc9_ = 3;
                  if(this.mDigits[_loc4_].mVY > _loc9_)
                  {
                     this.mDigits[_loc4_].mVY = _loc9_;
                  }
               }
               else
               {
                  this.mDigits[_loc4_].mVY = 1 + Math.random() * 0;
               }
               this.mDigits[_loc4_].mBounceState = 0;
            }
            if(int(param1 / _loc7_) == 0)
            {
               break;
            }
            _loc4_++;
         }
         _loc5_ = _loc4_ + 1;
         while(_loc5_ < 6)
         {
            this.mTarget[_loc5_].mNum = -1;
            _loc5_++;
         }
         this.mAtTarget = false;
      }
      
      public function Draw() : void
      {
         var _loc5_:RollerDigit = null;
         var _loc1_:int = this.mNumbersImage.height;
         var _loc2_:int = 11 * Zuma2App.SHRINK_PERCENT;
         var _loc3_:int = 8 * Zuma2App.SHRINK_PERCENT;
         var _loc4_:int = 0;
         while(_loc4_ < 6)
         {
            (_loc5_ = this.mDigits[_loc4_]).mNumberImage.mFrame = this.GetCel(_loc5_.mNum);
            _loc5_.mNumberBitmap.bitmapData = _loc5_.mNumberImage.pixels;
            _loc5_.mNumberBitmap.y = _loc5_.mY + _loc3_;
            if(_loc5_.mY != 0)
            {
               _loc5_.mNumberImage.mFrame = _loc5_.mNum == -1 ? int(this.GetCel(0)) : int(this.GetCel(_loc5_.mNum + 1));
               _loc5_.mNextNumberBitmap.bitmapData = _loc5_.mNumberImage.pixels;
               _loc5_.mNextNumberBitmap.y = _loc5_.mY + _loc3_ - _loc1_;
            }
            _loc4_++;
         }
      }
      
      public function Update() : void
      {
         var _loc4_:RollerDigit = null;
         var _loc5_:RollerTarget = null;
         if(this.mAtTarget)
         {
            return;
         }
         var _loc1_:int = this.mNumbersImage.height;
         var _loc2_:Boolean = true;
         var _loc3_:int = 5;
         while(_loc3_ >= 0)
         {
            _loc4_ = this.mDigits[_loc3_];
            _loc5_ = this.mTarget[_loc3_];
            if(--_loc4_.mDelay > 0)
            {
               _loc2_ = false;
            }
            else
            {
               _loc4_.mDelay = 0;
               if(_loc4_.mVY == 0)
               {
                  if(_loc4_.mNum != _loc5_.mNum)
                  {
                     _loc2_ = false;
                  }
               }
               else if(_loc4_.mVY != 0)
               {
                  _loc4_.mY += _loc4_.mVY;
                  if(_loc4_.mY >= _loc1_ && _loc4_.mBounceState == 0)
                  {
                     _loc4_.mNum = _loc4_.mNum == -1 ? 1 : int((_loc4_.mNum + 1) % 10);
                     if(_loc4_.mNum == _loc5_.mNum)
                     {
                        if(0)
                        {
                           _loc4_.mVY = 1 + Math.random() * 2;
                        }
                        _loc4_.mY = 0;
                        _loc4_.mBounceState = 1;
                        _loc2_ = false;
                     }
                     else
                     {
                        _loc2_ = false;
                        _loc4_.mY = _loc1_ - _loc4_.mY;
                     }
                  }
                  else if(_loc4_.mBounceState == 1 && _loc4_.mY >= 4)
                  {
                     _loc2_ = false;
                     ++_loc4_.mBounceState;
                     _loc4_.mVY *= -1;
                  }
                  else if(_loc4_.mBounceState == 2 && _loc4_.mY <= -8)
                  {
                     _loc2_ = false;
                     ++_loc4_.mBounceState;
                     _loc4_.mVY *= -1;
                     _loc4_.mRestingY = -8 + Math.random() * 0;
                  }
                  else if(_loc4_.mBounceState == 3 && _loc4_.mY >= _loc4_.mRestingY)
                  {
                     _loc4_.mVY = 0;
                     _loc4_.mBounceState = 0;
                  }
                  else
                  {
                     _loc2_ = false;
                  }
               }
            }
            _loc3_--;
         }
         this.mAtTarget = _loc2_;
      }
      
      public function GetTargetScore() : int
      {
         return this.mTargetNum;
      }
      
      public function Reset(param1:Boolean) : void
      {
         var _loc6_:RollerDigit = null;
         this.mGauntletMode = param1;
         this.mNumbersImage = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_UI_SCORENUMBERS));
         this.mRollerBitmap = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_UI_SCOREBAR),PixelSnapping.NEVER,true);
         this.mRollerSprite = new Sprite();
         this.mRollerSprite.addChild(this.mRollerBitmap);
         this.mApp.mLayers[0].mForeground.addChild(this.mRollerSprite);
         this.mRollerSprite.x = 8 * Zuma2App.SHRINK_PERCENT;
         this.mRollerSprite.y = 11 * Zuma2App.SHRINK_PERCENT;
         var _loc2_:Number = 8;
         var _loc3_:Number = 2;
         var _loc4_:int = 10;
         var _loc5_:int = 5;
         while(_loc5_ >= 0)
         {
            _loc6_ = new RollerDigit(this.mApp);
            this.mDigits[_loc5_] = _loc6_;
            this.mDigits[_loc5_].mX = _loc4_ + (this.mNumbersImage.width + _loc2_) * (5 - _loc5_);
            this.mDigits[_loc5_].mNumberSprite.x = this.mDigits[_loc5_].mX;
            this.mDigits[_loc5_].mVY = 0;
            this.mDigits[_loc5_].mNum = -1;
            this.mDigits[_loc5_].mY = 12;
            this.mDigits[_loc5_].mNumberSprite.y = this.mDigits[_loc5_].mY;
            this.mDigits[_loc5_].mDelay = 0;
            this.mDigits[_loc5_].mBounceState = 0;
            this.mTarget[_loc5_] = new RollerTarget(this.mApp);
            _loc5_--;
         }
         this.mDigits[0].mNum = this.mTarget[0].mNum = -1;
         this.mTargetNum = this.mCurrNum = 0;
         this.mAtTarget = true;
      }
      
      public function GetCurrentScore() : int
      {
         var _loc2_:RollerDigit = null;
         if(this.mCurrNum == this.mTargetNum)
         {
            return this.mCurrNum;
         }
         this.mCurrNum = 0;
         var _loc1_:int = 0;
         while(_loc1_ < 6)
         {
            _loc2_ = this.mDigits[_loc1_];
            if(_loc2_.mNum == -1)
            {
               break;
            }
            this.mCurrNum += Math.pow(10,_loc1_) * this.mDigits[_loc1_].mNum;
            _loc1_++;
         }
         return this.mCurrNum;
      }
      
      public function GetCel(param1:int) : int
      {
         if(param1 < 0)
         {
            return 0;
         }
         if(param1 % 10 > 0)
         {
            return param1;
         }
         return 10;
      }
   }
}
