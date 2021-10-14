package com.popcap.flash.games.zuma2.logic
{
   import flash.net.URLLoader;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class CurveData
   {
      
      public static const SUBPIXEL_MULT:Number = 100;
      
      public static const INV_SUBPIXEL_MULT:Number = 1 / SUBPIXEL_MULT;
       
      
      public var aReader:ByteArray;
      
      public var mErrorString:String;
      
      public var mLoaded:Boolean;
      
      public var loader:URLLoader;
      
      public var mDrawCurve:Boolean;
      
      public var mPointList:Vector.<PathPoint>;
      
      public var mVersion:int;
      
      public var mEditType:int;
      
      public var mLinear:Boolean;
      
      public var mApp:Zuma2App;
      
      public var mVals:BasicCurveVals;
      
      public function CurveData(param1:Zuma2App)
      {
         this.loader = new URLLoader();
         super();
         this.mApp = param1;
         this.mLoaded = false;
      }
      
      public function Load(param1:String) : Boolean
      {
         var _loc3_:String = null;
         var _loc10_:int = 0;
         var _loc11_:ByteArray = null;
         var _loc12_:PathPoint = null;
         var _loc13_:int = 0;
         var _loc14_:* = false;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         this.Clear();
         this.mVals = new BasicCurveVals();
         this.mPointList = new Vector.<PathPoint>();
         var _loc2_:int = 0;
         this.aReader = this.mApp.mLevelData.mLevels[param1 + ".dat"];
         this.aReader.position = 0;
         this.aReader.endian = Endian.LITTLE_ENDIAN;
         _loc3_ = this.aReader.readUTFBytes(4);
         this.mVersion = this.aReader.readInt();
         this.mLinear = this.aReader.readBoolean();
         this.mVals.mStartDistance = this.aReader.readInt();
         this.mVals.mNumBalls = this.aReader.readInt();
         this.mVals.mBallRepeat = this.aReader.readInt();
         this.mVals.mMaxSingle = this.aReader.readInt();
         this.mVals.mNumColors = this.aReader.readInt();
         this.mVals.mSpeed = this.aReader.readFloat();
         this.mVals.mSlowDistance = this.aReader.readInt();
         this.mVals.mAccelerationRate = this.aReader.readFloat();
         this.mVals.mOrgAccelerationRate = this.mVals.mAccelerationRate;
         this.mVals.mMaxSpeed = this.aReader.readFloat();
         this.mVals.mOrgMaxSpeed = this.mVals.mMaxSpeed;
         this.mVals.mScoreTarget = this.aReader.readInt();
         this.mVals.mSkullRotation = this.aReader.readInt();
         this.mVals.mZumaBack = this.aReader.readInt();
         this.mVals.mZumaSlow = this.aReader.readInt();
         this.mVals.mSlowFactor = this.aReader.readFloat();
         this.mVals.mMaxClumpSize = this.aReader.readInt();
         var _loc4_:int = this.aReader.readInt();
         _loc2_ = 0;
         while(_loc2_ < PowerType.PowerType_Max)
         {
            this.mVals.mPowerUpFreq[_loc2_] = 0;
            this.mVals.mMaxNumPowerUps[_loc2_] = 100000000;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc4_ && _loc2_ < PowerType.PowerType_Max)
         {
            if(this.IsDeprecatedPowerUp(_loc2_))
            {
               this.aReader.readInt();
               if(this.mVersion >= 12)
               {
                  this.aReader.readInt();
               }
            }
            else
            {
               this.mVals.mPowerUpFreq[_loc2_] = this.aReader.readInt();
               if(this.mVersion >= 12)
               {
                  this.mVals.mMaxNumPowerUps[_loc2_] = this.aReader.readInt();
               }
            }
            _loc2_++;
         }
         this.mVals.mPowerUpChance = this.aReader.readInt();
         this.mDrawCurve = this.aReader.readBoolean();
         this.mVals.mDrawTunnels = this.aReader.readBoolean();
         this.mVals.mDestroyAll = this.aReader.readBoolean();
         this.mVals.mDrawPit = this.aReader.readBoolean();
         this.mVals.mDieAtEnd = this.aReader.readBoolean();
         var _loc5_:Boolean = this.aReader.readBoolean();
         var _loc6_:Boolean = this.aReader.readBoolean();
         if(!_loc5_)
         {
            this.mEditType = this.aReader.readInt();
            _loc10_ = this.aReader.readInt();
            _loc11_ = new ByteArray();
            this.aReader.readBytes(_loc11_,0,_loc10_);
         }
         else
         {
            this.mEditType = 0;
         }
         var _loc7_:int = this.aReader.readInt();
         var _loc8_:Number = 0;
         var _loc9_:Number = 0;
         _loc2_ = 0;
         while(_loc2_ < _loc7_)
         {
            _loc12_ = new PathPoint();
            _loc13_ = this.aReader.readByte();
            _loc12_.mInTunnel = (_loc13_ & 1) == 1;
            _loc14_ = (_loc13_ & 2) == 2;
            if(_loc6_ || this.mVersion >= 15)
            {
               _loc12_.mPriority = this.aReader.readByte();
            }
            if(_loc14_)
            {
               _loc12_.x = this.aReader.readFloat();
               _loc12_.y = this.aReader.readFloat();
            }
            else
            {
               _loc15_ = this.aReader.readByte();
               _loc16_ = this.aReader.readByte();
               _loc12_.x = _loc8_ + _loc15_ * INV_SUBPIXEL_MULT;
               _loc12_.y = _loc9_ + _loc16_ * INV_SUBPIXEL_MULT;
            }
            _loc8_ = _loc12_.x;
            _loc9_ = _loc12_.y;
            this.mPointList.push(_loc12_);
            _loc2_++;
         }
         this.mLoaded = true;
         return true;
      }
      
      public function IsDeprecatedPowerUp(param1:int) : Boolean
      {
         return param1 == PowerType.PowerType_Fireball || param1 == PowerType.PowerType_ShieldFrog || param1 == PowerType.PowerType_FreezeBoss || param1 == PowerType.PowerType_BallEater || param1 == PowerType.PowerType_BombBullet || param1 == PowerType.PowerType_Lob;
      }
      
      public function Clear() : void
      {
      }
   }
}
