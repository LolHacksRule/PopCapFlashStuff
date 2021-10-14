package com.popcap.flash.games.zuma2.logic
{
   import com.popcap.flash.framework.Canvas;
   import com.popcap.flash.games.zuma2.widgets.GameBoardWidget;
   import de.polygonal.ds.DListIterator;
   
   public class Level
   {
       
      
      public var mPostZumaTimeSpeedInc:Number;
      
      public var mHasReachedCruisingSpeed:Boolean;
      
      public var mHoleMgr:HoleMgr;
      
      public var mCurFrogPoint:int;
      
      public var mDrawCurves:Boolean;
      
      public var mUpdateCount:int;
      
      public var mPostZumaTimeSlowInc:Number;
      
      public var mNumCurves:int;
      
      public var mPotPct:Number;
      
      public var mHaveReachedTarget:Boolean;
      
      public var mFurthestBallDistance:int;
      
      public var mFrog:Gun;
      
      public var mCurveMgr:Array;
      
      public var mMoveType:String;
      
      public var mTreasurePoints:Vector.<TreasurePoint>;
      
      public var mDisplayName:String;
      
      public var mTempSpeedupTimer:int;
      
      public var mFrogX:Array;
      
      public var mFrogY:Array;
      
      public var mAllCurvesAtRolloutPoint:Boolean;
      
      public var mFireSpeed:int;
      
      public var mTimeToComplete:int;
      
      public var mTreasureFreq:int;
      
      public var mTimer:int;
      
      public var mNum:int;
      
      public var mParTime:int;
      
      public var mId:String;
      
      public var mHurryToRolloutAmt:Number;
      
      public var mApp:Zuma2App;
      
      public var mLoopAtEnd:Boolean;
      
      public var mBoard:GameBoardWidget;
      
      public var mIsEndless:Boolean;
      
      public var mTunnelData:Array;
      
      public function Level(param1:Zuma2App)
      {
         this.mFrogX = new Array();
         this.mFrogY = new Array();
         this.mTreasurePoints = new Vector.<TreasurePoint>();
         this.mTunnelData = new Array();
         super();
         this.mApp = param1;
         this.mCurveMgr = new Array();
         this.mTimer = this.mTimeToComplete = -1;
         this.mPotPct = 1;
         this.mCurFrogPoint = 0;
         this.Reset();
      }
      
      public function ReInit() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.mNumCurves)
         {
            this.mCurveMgr[_loc1_].SetFarthestBall(0);
            _loc1_++;
         }
         this.mPotPct = 1;
         this.mFurthestBallDistance = 0;
         this.Reset();
         _loc1_ = 0;
         while(_loc1_ < this.mNumCurves)
         {
            this.mCurveMgr[_loc1_].Reset();
            _loc1_++;
         }
      }
      
      public function StartLevel() : void
      {
         this.mHoleMgr = new HoleMgr(this.mApp);
         var _loc1_:int = 0;
         while(_loc1_ < this.mNumCurves)
         {
            this.mCurveMgr[_loc1_].mBoard = this.mBoard;
            this.mCurveMgr[_loc1_].LoadCurve();
            this.mCurveMgr[_loc1_].StartLevel();
            if(_loc1_ == 0)
            {
               this.mCurveMgr[_loc1_].mInitialPathHilite = true;
            }
            _loc1_++;
         }
         this.mApp.gAddBalls = false;
      }
      
      public function SetFrog(param1:Gun) : void
      {
         this.mFrog = param1;
      }
      
      public function GetPowerIncPct() : int
      {
         return 0;
      }
      
      public function UpdatePlaying() : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:Boolean = this.mHasReachedCruisingSpeed;
         var _loc2_:Boolean = this.mAllCurvesAtRolloutPoint;
         this.mHasReachedCruisingSpeed = true;
         this.mAllCurvesAtRolloutPoint = true;
         var _loc3_:Boolean = false;
         _loc4_ = 0;
         while(_loc4_ < this.mNumCurves)
         {
            if(this.mCurveMgr[_loc4_].UpdatePlaying() && _loc4_ + 1 < this.mNumCurves)
            {
               this.mCurveMgr[_loc4_ + 1].mInitialPathHilite = true;
            }
            if(this.mCurveMgr[_loc4_].mSparkles.length > 0)
            {
               _loc3_ = true;
            }
            if(!this.mCurveMgr[_loc4_].HasReachedCruisingSpeed())
            {
               this.mHasReachedCruisingSpeed = false;
            }
            if(!this.mCurveMgr[_loc4_].HasReachedRolloutPoint())
            {
               this.mAllCurvesAtRolloutPoint = false;
            }
            if(this.mTempSpeedupTimer == 1)
            {
               this.mCurveMgr[_loc4_].mOverrideSpeed = -1;
            }
            if((_loc5_ = this.mCurveMgr[_loc4_].GetFarthestBallPercent()) > this.mFurthestBallDistance)
            {
               this.mFurthestBallDistance = _loc5_;
            }
            _loc4_++;
         }
         if(!this.mApp.gAddBalls && !_loc3_ && !this.mBoard.mPreventBallAdvancement)
         {
            this.mApp.gAddBalls = true;
            _loc4_ = 0;
            while(_loc4_ < this.mNumCurves)
            {
               this.mCurveMgr[_loc4_].mInitialPathHilite = false;
               _loc4_++;
            }
         }
      }
      
      public function GetRandomPendingBallColor(param1:int) : int
      {
         return int(Math.random() * param1);
      }
      
      public function GetBallAtXY(param1:int, param2:int) : Ball
      {
         var _loc4_:DListIterator = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.mNumCurves)
         {
            (_loc4_ = this.mCurveMgr[_loc3_].mBallList.getListIterator()).start();
            while(_loc4_.valid())
            {
               if(_loc4_.data.Contains(param1,param2))
               {
                  return _loc4_.data;
               }
               _loc4_.forth();
            }
            _loc3_++;
         }
         return null;
      }
      
      public function BulletHit(param1:Bullet) : void
      {
      }
      
      public function DoingInitialPathHilite() : Boolean
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.mNumCurves)
         {
            if(this.mCurveMgr[_loc1_].mInitialPathHilite)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function Reset() : void
      {
         this.mAllCurvesAtRolloutPoint = false;
         this.mHasReachedCruisingSpeed = false;
         this.mFurthestBallDistance = 0;
         var _loc1_:int = 0;
         while(_loc1_ < this.mNumCurves)
         {
            this.mCurveMgr[_loc1_].Reset();
            _loc1_++;
         }
      }
      
      public function AllowPointsFromBalls() : Boolean
      {
         return true;
      }
      
      public function CanAdvanceBalls() : Boolean
      {
         return true;
      }
      
      public function CheckFruitActivation(param1:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:TreasurePoint = null;
         if(this.mBoard.mPreventBallAdvancement)
         {
            return false;
         }
         var _loc2_:int = this.mTreasureFreq;
         if(!this.mApp.gForceFruit)
         {
            if(this.mBoard.mCurTreasure != null || int(Math.random() * _loc2_) != 0)
            {
               return false;
            }
         }
         var _loc3_:Vector.<int> = new Vector.<int>();
         if(param1 == -1)
         {
            _loc4_ = 0;
            _loc5_ = this.mNumCurves;
         }
         else
         {
            _loc4_ = _loc5_ = param1;
         }
         var _loc6_:int = _loc4_;
         while(_loc6_ < _loc5_)
         {
            _loc8_ = this.mCurveMgr[_loc6_].GetFarthestBallPercent();
            _loc9_ = 0;
            while(_loc9_ < this.mTreasurePoints.length)
            {
               if((_loc10_ = this.mTreasurePoints[_loc9_]).mCurveDist[_loc6_] > 0 && _loc8_ >= _loc10_.mCurveDist[_loc6_])
               {
                  _loc3_.push(_loc9_);
               }
               _loc9_++;
            }
            _loc6_++;
         }
         if(_loc3_.length == 0)
         {
            return false;
         }
         var _loc7_:int = Math.random() * _loc3_.length;
         this.mBoard.mCurTreasureNum = _loc3_[_loc7_];
         this.mBoard.mCurTreasure = this.mTreasurePoints[_loc3_[_loc7_]];
         this.mBoard.mCurTreasure.x = this.mTreasurePoints[_loc3_[_loc7_]].x;
         this.mBoard.mCurTreasure.y = this.mTreasurePoints[_loc3_[_loc7_]].y;
         this.mBoard.mMinTreasureY = this.mBoard.mMaxTreasureY = Number.MAX_VALUE;
         return true;
      }
      
      public function CurvesAtRest() : Boolean
      {
         if(this.mBoard.HasFiredBullets() || this.mBoard.GetGun().IsFiring())
         {
            return false;
         }
         var _loc1_:int = 0;
         while(_loc1_ < this.mNumCurves)
         {
            if(!this.mCurveMgr[_loc1_].AtRest())
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      public function GetFarthestBallPercent(param1:int = 0, param2:Boolean = false) : int
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < this.mNumCurves)
         {
            if((_loc5_ = this.mCurveMgr[_loc4_].GetFarthestBallPercent(param2)) > _loc3_)
            {
               if(param1 != 0)
               {
                  param1 = _loc4_;
               }
               _loc3_ = _loc5_;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function Draw(param1:Canvas) : void
      {
         this.mHoleMgr.Draw(param1);
      }
      
      public function GetRandomFrogBulletColor(param1:int, param2:int) : Number
      {
         return 1 / Number(param1);
      }
      
      public function Update(param1:Number) : void
      {
         ++this.mUpdateCount;
         if(this.mTimer > 0)
         {
            --this.mTimer;
         }
         this.mHoleMgr.Update();
      }
   }
}
