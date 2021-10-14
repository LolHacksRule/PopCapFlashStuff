package com.popcap.flash.games.zuma2.logic
{
   import com.popcap.flash.framework.Canvas;
   import com.popcap.flash.framework.resources.sounds.SoundResource;
   import com.popcap.flash.games.zuma2.widgets.GameBoardWidget;
   import de.polygonal.ds.DLinkedList;
   import de.polygonal.ds.DListIterator;
   import flash.geom.Point;
   
   public class CurveMgr
   {
      
      public static const MAX_GAP_SIZE:int = 300;
      
      public static const PROXIMITY_BOMB_RADIUS:int = 56;
       
      
      public var mNumPowerUpsThisLevel:Array;
      
      public var mPendingBalls:DLinkedList;
      
      public var mBulletList:DLinkedList;
      
      public var mLevel:Level;
      
      public var mNumPowerupsActivated:Array;
      
      public var mInitialPathHilite:Boolean;
      
      public var mPath:String;
      
      public var mCurveDesc:CurveDesc;
      
      public var mInDanger:Boolean;
      
      public var mSkullHilite:Number = 0;
      
      public var mBallObj:Object;
      
      public var mLastClearedBallPoint:int;
      
      public var mPlayedSparkleSound:Boolean;
      
      public var mIsLoaded:Boolean;
      
      public var mHaveSets:Boolean;
      
      public var mProxBombCounter:int;
      
      public var mWarningLights:Vector.<WarningLight>;
      
      public var mOverrideSpeed:Number;
      
      public var mHasReachedCruisingSpeed:Boolean;
      
      public var mNumBallsCreated:int;
      
      public var mPathLightEndFrame:int;
      
      public var mBoard:GameBoardWidget;
      
      public var mApp:Zuma2App;
      
      public var mStopTime:int;
      
      public var mBallColorHasPowerup:Array;
      
      public var mBackwardCount:int;
      
      public var mDangerPoint:int;
      
      public var mSpeedScale:Number;
      
      public var mCanCheckForSpeedup:Boolean;
      
      public var mSlowCount:int;
      
      public var mStopAddingBalls:Boolean;
      
      public var mCurveNum:int;
      
      public var mSparkles:Vector.<PathSparkle>;
      
      public var mHasReachedRolloutPoint:Boolean;
      
      public var mPostZumaFlashTimer:int;
      
      public var mLastPowerupTime:int;
      
      public var mFirstChainEnd:int;
      
      public var mLastPathShowTick:int;
      
      public var mTotalBalls:int;
      
      public var mDoingClearCurveRollout:Boolean;
      
      public var mLastSpawnedPowerUpFrame:Array;
      
      public var mLastPathHilitePitch:int;
      
      public var mBallList:DLinkedList;
      
      public var mSkullHiliteDir:Number = 0;
      
      public var mLastPathHiliteWP:int;
      
      public var mWayPointMgr:WayPointMgr;
      
      public var mNeedsSpeedup:Boolean;
      
      public var mLastCompletedPowerUpFrame:Array;
      
      public var mHadPowerUp:Boolean;
      
      public var mAdvanceSpeed:Number;
      
      public var mFirstBallMovedBackwards:Boolean;
      
      public function CurveMgr(param1:Zuma2App)
      {
         this.mBallList = new DLinkedList();
         this.mBulletList = new DLinkedList();
         this.mPendingBalls = new DLinkedList();
         this.mSparkles = new Vector.<PathSparkle>();
         this.mBallObj = new Object();
         this.mWarningLights = new Vector.<WarningLight>();
         this.mBallColorHasPowerup = new Array();
         this.mLastSpawnedPowerUpFrame = new Array();
         this.mLastCompletedPowerUpFrame = new Array();
         this.mNumPowerUpsThisLevel = new Array();
         this.mNumPowerupsActivated = new Array();
         super();
         this.mApp = param1;
         this.mWayPointMgr = new WayPointMgr(param1);
         this.mCurveDesc = new CurveDesc(param1);
         this.Reset();
      }
      
      public function GetBoardTickCount() : int
      {
         return this.GetBoardStateCount() * 10;
      }
      
      public function AdvanceBullets() : void
      {
         var _loc1_:DListIterator = this.mBulletList.getListIterator();
         while(_loc1_.valid())
         {
            this.AdvanceMergingBullet(_loc1_);
         }
      }
      
      public function GetPoint(param1:int, param2:PathSparkle) : void
      {
         var _loc3_:Vector.<WayPoint> = this.mWayPointMgr.mWayPoints;
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 >= _loc3_.length)
         {
            param1 = _loc3_.length - 1;
         }
         var _loc4_:WayPoint = _loc3_[param1];
         param2.mX = _loc4_.x;
         param2.mY = _loc4_.y;
         param2.mPri = _loc4_.mPriority;
      }
      
      public function UpdatePlaying() : Boolean
      {
         var _loc1_:int = 0;
         var _loc5_:PathSparkle = null;
         if(this.mStopAddingBalls && this.mPostZumaFlashTimer > 0)
         {
            --this.mPostZumaFlashTimer;
         }
         var _loc2_:Boolean = false;
         var _loc3_:int = !!this.mBallList.isEmpty() ? 0 : int(this.mBallList.tail.data.GetWayPoint());
         var _loc4_:Boolean = this.mBallList.isEmpty() || _loc3_ < this.mCurveDesc.mCutoffPoint;
         if(this.mStopTime > 0)
         {
            --this.mStopTime;
            if(_loc4_)
            {
               this.mStopTime = 0;
            }
            if(this.mStopTime == 0)
            {
               this.mAdvanceSpeed = 0;
            }
         }
         if(this.mInitialPathHilite && !this.mBoard.mPreventBallAdvancement && this.mLastPathHiliteWP < this.mWayPointMgr.GetNumPoints() && this.mSkullHiliteDir == 0)
         {
            this.mSparkles.push(new PathSparkle(this.mApp));
            _loc5_ = this.mSparkles[this.mSparkles.length - 1];
            this.GetPoint(this.mLastPathHiliteWP,_loc5_);
            this.mLastPathHiliteWP += 10;
            if(this.mLastPathHiliteWP >= this.mWayPointMgr.GetNumPoints())
            {
               _loc2_ = true;
               this.mSkullHiliteDir = 12;
            }
            if(this.mBoard.mUpdateCnt % 25 == 0)
            {
               if(this.mCurveNum != 1 && this.mLastPathHilitePitch > -20)
               {
                  --this.mLastPathHilitePitch;
               }
               else if(this.mCurveNum == 1 && this.mLastPathHilitePitch < 0)
               {
                  ++this.mLastPathHilitePitch;
               }
            }
            if(!this.mPlayedSparkleSound)
            {
               this.mPlayedSparkleSound = true;
               this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_SPARKLE_START);
            }
         }
         _loc1_ = 0;
         while(_loc1_ < this.mSparkles.length)
         {
            ++(_loc5_ = this.mSparkles[_loc1_]).mUpdateCount;
            if(_loc5_.mUpdateCount % 3 == 0)
            {
               if(++_loc5_.mCel >= 14)
               {
                  this.mSparkles.splice(_loc1_,1);
                  _loc1_--;
                  _loc5_.Delete();
               }
            }
            _loc1_++;
         }
         this.mSkullHilite += this.mSkullHiliteDir;
         if(this.mSkullHiliteDir > 0 && this.mSkullHilite >= 255)
         {
            this.mSkullHilite = 255;
            this.mSkullHiliteDir *= -1;
         }
         else if(this.mSkullHiliteDir < 0 && this.mSkullHilite <= 0)
         {
            this.mSkullHilite = this.mSkullHiliteDir = 0;
         }
         var _loc6_:Boolean = false;
         _loc1_ = 0;
         while(_loc1_ < this.mWarningLights.length)
         {
            if(_loc6_)
            {
               this.mWarningLights[_loc1_].mPulseRate = -this.mWarningLights[_loc1_ - 1].mPulseRate;
            }
            _loc6_ = this.mWarningLights[_loc1_].Update();
            if(this.mInitialPathHilite)
            {
               this.mWarningLights[_loc1_].mPulseAlpha -= 5;
               if(this.mWarningLights[_loc1_].mPulseAlpha < 0)
               {
                  this.mWarningLights[_loc1_].mPulseAlpha = 0;
               }
            }
            _loc1_++;
         }
         if(this.mInitialPathHilite)
         {
            return _loc2_;
         }
         if(this.mSlowCount > 0)
         {
            --this.mSlowCount;
            if(_loc4_ && !this.mStopAddingBalls)
            {
               this.mSlowCount = 0;
            }
         }
         if(this.mBackwardCount > 0)
         {
            --this.mBackwardCount;
            if(_loc4_ && !this.mStopAddingBalls)
            {
               this.mBackwardCount = 0;
            }
         }
         if(this.mApp.gAddBalls)
         {
            this.AddBall();
         }
         this.UpdateBalls();
         this.AdvanceBullets();
         this.UpdateSuckingBalls();
         this.AdvanceBalls();
         this.AdvanceBackwardBalls();
         this.RemoveBallsAtFront();
         this.RemoveBallsAtEnd();
         this.UpdateSets();
         this.UpdatePowerUps();
         if(!this.mBallList.isEmpty())
         {
            this.SetFarthestBall(this.mBallList.tail.data.GetWayPoint());
         }
         else
         {
            this.SetFarthestBall(0);
         }
         if(!this.mHasReachedCruisingSpeed)
         {
            if(this.mAdvanceSpeed - this.mCurveDesc.mVals.mSpeed * this.mSpeedScale < 0.1)
            {
               this.mHasReachedCruisingSpeed = true;
            }
         }
         return _loc2_;
      }
      
      public function GetNumInARow(param1:Ball, param2:int, param3:Object) : int
      {
         var _loc8_:Ball = null;
         var _loc9_:Ball = null;
         var _loc10_:Ball = null;
         if(param1.GetColorType() != param2)
         {
            return 0;
         }
         var _loc4_:Ball;
         var _loc5_:Ball = _loc4_ = param1;
         var _loc6_:int = param2;
         var _loc7_:int = 1;
         while((_loc9_ = _loc5_.GetNextBall(true)) != null)
         {
            if(_loc9_.GetColorType() != _loc6_)
            {
               break;
            }
            _loc5_ = _loc9_;
            _loc7_++;
         }
         _loc8_ = _loc4_;
         while((_loc10_ = _loc8_.GetPrevBall(true)) != null)
         {
            if(_loc10_.GetColorType() != _loc6_)
            {
               break;
            }
            _loc8_ = _loc10_;
            _loc7_++;
         }
         param3.aNextEnd = _loc5_;
         param3.aPrevEnd = _loc8_;
         return _loc7_;
      }
      
      public function HideBalls(param1:Boolean) : void
      {
         var _loc3_:Ball = null;
         var _loc2_:DListIterator = this.mBallList.getListIterator();
         _loc2_.start();
         while(_loc2_.valid())
         {
            _loc3_ = _loc2_.data;
            _loc3_.Hide(param1);
            _loc2_.forth();
         }
      }
      
      public function AdvanceMergingBullet(param1:DListIterator) : void
      {
         var _loc3_:Ball = null;
         var _loc4_:DListIterator = null;
         var _loc5_:Boolean = false;
         var _loc6_:Ball = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Ball = null;
         var _loc10_:Ball = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc2_:Bullet = param1.data;
         this.DoMerge(_loc2_);
         if(_loc2_.GetHitPercent() >= 1)
         {
            _loc3_ = _loc2_.GetHitBall();
            _loc4_ = new DListIterator(this.mBallList,_loc3_.mListItr.node);
            if(_loc5_ = _loc2_.GetHitInFront())
            {
               _loc4_.forth();
            }
            (_loc6_ = new Ball(this.mApp)).SetRotation(_loc2_.GetRotation());
            _loc6_.SetColorType(_loc2_.GetColorType());
            _loc6_.SetPowerType(_loc2_.GetPowerType());
            this.mWayPointMgr.SetWayPoint(_loc6_,_loc2_.GetWayPoint(),this.mLevel.mLoopAtEnd);
            _loc6_.InsertInList(this.mBallList,_loc4_,this);
            _loc7_ = _loc2_.GetMinGapDist();
            _loc8_ = _loc2_.GetNumGaps();
            _loc2_.Delete();
            this.mBulletList.remove(param1);
            ++this.mTotalBalls;
            _loc9_ = _loc6_.GetPrevBall();
            _loc10_ = _loc6_.GetNextBall();
            _loc6_.UpdateCollisionInfo(5);
            _loc6_.SetNeedCheckCollision(true);
            if(_loc9_ != null && _loc6_.GetCollidesWithPrev())
            {
               _loc9_.SetNeedCheckCollision(true);
            }
            if(_loc7_ > 0)
            {
               if((_loc7_ -= 64) < 0)
               {
                  _loc7_ = 0;
               }
               if((_loc12_ = (_loc12_ = (_loc11_ = 500) * (MAX_GAP_SIZE - _loc7_) / MAX_GAP_SIZE) / 10 * 10) < 10)
               {
                  _loc12_ = 10;
               }
               if(_loc12_ > 0)
               {
                  if(_loc8_ > 1)
                  {
                     _loc12_ *= _loc8_;
                  }
                  _loc6_.SetGapBonus(_loc12_,_loc8_);
               }
            }
            if(!this.CheckSet(_loc6_))
            {
               if(_loc9_ != null && !_loc9_.GetCollidesWithNext() && _loc9_.GetColorType() == _loc6_.GetColorType() && _loc9_.GetBullet() == null && !_loc9_.GetIsExploding())
               {
                  _loc6_.SetSuckPending(true);
                  _loc6_.SetSuckCount(1);
               }
               else if(_loc10_ != null && !_loc6_.GetCollidesWithNext() && _loc10_.GetColorType() == _loc6_.GetColorType() && _loc10_.GetBullet() == null && !_loc10_.GetIsExploding())
               {
                  _loc6_.SetSuckPending(true);
                  if(_loc10_.GetSuckCount() <= 0)
                  {
                     _loc10_.SetSuckCount(1);
                  }
               }
               else
               {
                  this.mBoard.ResetInARowBonus();
                  _loc6_.SetGapBonus(0,0);
               }
            }
            else
            {
               this.mBoard.IncNumClearsInARow(1);
            }
         }
         else
         {
            ++this.mBoard.mBallColorMap[_loc2_.GetColorType()];
            param1.forth();
         }
      }
      
      public function IsInDanger() : Boolean
      {
         return this.mInDanger;
      }
      
      public function GetDangerDistance() : int
      {
         return this.mWayPointMgr.GetNumPoints() - this.mDangerPoint;
      }
      
      public function DrawSkullPath() : void
      {
         var _loc2_:WarningLight = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.mWarningLights.length)
         {
            _loc2_ = this.mWarningLights[_loc1_];
            _loc2_.Draw();
            _loc1_++;
         }
      }
      
      public function AdvanceBalls() : void
      {
         var _loc3_:Number = NaN;
         var _loc12_:int = 0;
         var _loc18_:Number = NaN;
         var _loc19_:DListIterator = null;
         var _loc20_:Ball = null;
         var _loc21_:Ball = null;
         var _loc22_:Number = NaN;
         var _loc23_:Ball = null;
         var _loc24_:Number = NaN;
         var _loc25_:Boolean = false;
         var _loc26_:Ball = null;
         var _loc27_:int = 0;
         var _loc28_:Number = NaN;
         var _loc29_:int = 0;
         var _loc30_:int = 0;
         var _loc31_:int = 0;
         var _loc32_:int = 0;
         var _loc33_:int = 0;
         var _loc34_:WarningLight = null;
         var _loc35_:Number = NaN;
         if(this.mBallList.isEmpty())
         {
            return;
         }
         var _loc1_:Boolean = this.mLevel.CanAdvanceBalls();
         var _loc2_:int = this.mDangerPoint;
         var _loc4_:Number = this.mCurveDesc.mVals.mSpeed * this.mSpeedScale;
         if(this.mCurveDesc.mVals.mAccelerationRate != 0)
         {
            this.mCurveDesc.mCurAcceleration += this.mCurveDesc.mVals.mAccelerationRate;
            if((_loc4_ += this.mCurveDesc.mCurAcceleration) > this.mCurveDesc.mVals.mMaxSpeed)
            {
               _loc4_ = this.mCurveDesc.mVals.mMaxSpeed;
            }
         }
         if(this.mSlowCount > 0)
         {
            _loc4_ /= 4;
         }
         var _loc5_:Number = this.mCurveDesc.mVals.mSlowFactor;
         var _loc6_:Number = this.mLevel.mPostZumaTimeSpeedInc * _loc4_ + _loc4_;
         var _loc7_:Number;
         if((_loc7_ = _loc5_ - this.mLevel.mPostZumaTimeSlowInc * this.mCurveDesc.mVals.mSlowFactor) < 1)
         {
            _loc7_ = 1;
         }
         if(this.mApp.mLevelMgr.mPostZumaTime == 0 || !this.mBoard.HasAchievedZuma())
         {
            _loc6_ = _loc4_;
            _loc7_ = _loc5_;
         }
         if(this.mApp.gDieAtEnd)
         {
            if(this.mFirstChainEnd < this.mDangerPoint - this.mCurveDesc.mVals.mSlowDistance || !this.mHasReachedCruisingSpeed)
            {
               _loc4_ = _loc6_;
            }
            else if(this.mFirstChainEnd < this.mDangerPoint)
            {
               _loc18_ = Number(this.mFirstChainEnd - (this.mDangerPoint - this.mCurveDesc.mVals.mSlowDistance)) / this.mCurveDesc.mVals.mSlowDistance;
               _loc4_ = (1 - _loc18_) * _loc6_ + _loc18_ * _loc6_ / _loc7_;
            }
            else
            {
               _loc4_ /= _loc7_;
               this.mBoard.SetRollingInDangerZone();
            }
         }
         var _loc8_:Boolean = false;
         if(this.mDoingClearCurveRollout)
         {
            (_loc19_ = this.mBallList.getListIterator()).end();
            while(_loc19_.valid())
            {
               if(!(_loc20_ = _loc19_.data).GetIsExploding())
               {
                  if(_loc20_.GetWayPoint() / Number(this.mWayPointMgr.GetEndPoint()) >= this.mApp.mLevelMgr.mClearCurveRolloutPct)
                  {
                     _loc8_ = true;
                  }
                  break;
               }
               _loc19_.back();
            }
         }
         if(this.mAdvanceSpeed > _loc4_ && !this.mBoard.mPreventBallAdvancement && (!this.mDoingClearCurveRollout || _loc8_))
         {
            this.mDoingClearCurveRollout = false;
            this.mAdvanceSpeed -= 0.1;
         }
         else if(this.mAdvanceSpeed <= _loc4_ && _loc8_)
         {
            this.mDoingClearCurveRollout = false;
         }
         if(this.mAdvanceSpeed < _loc4_)
         {
            this.mAdvanceSpeed += 0.005;
            if(this.mAdvanceSpeed >= _loc4_)
            {
               this.mAdvanceSpeed = _loc4_;
            }
         }
         _loc3_ = !!_loc1_ ? Number(this.mAdvanceSpeed) : Number(0);
         if(this.mOverrideSpeed >= 0)
         {
            _loc3_ += this.mOverrideSpeed;
         }
         if(this.mBoard.mPreventBallAdvancement)
         {
            _loc3_ = 0;
         }
         var _loc9_:Ball;
         var _loc10_:Number = (_loc9_ = this.mBallList.head.data).GetWayPoint();
         var _loc11_:Number = 0;
         if(!this.mFirstBallMovedBackwards && !this.mStopTime)
         {
            _loc11_ = _loc3_;
            this.mWayPointMgr.SetWayPoint(_loc9_,_loc10_ + _loc3_,this.mLevel.mLoopAtEnd);
         }
         if(this.mApp.gSuckMode && this.mStopAddingBalls && !this.mBallList.isEmpty())
         {
            _loc9_ = this.mBallList.head.data;
            this.mAdvanceSpeed = _loc4_;
            if(_loc9_.GetSpeedy())
            {
               if((_loc21_ = _loc9_.GetNextBall()) != null)
               {
                  if(_loc21_.GetSpeedy())
                  {
                     this.mAdvanceSpeed = 20;
                  }
                  else
                  {
                     _loc22_ = _loc21_.GetWayPoint() - _loc9_.GetWayPoint();
                     this.mAdvanceSpeed = _loc22_ / 10;
                  }
                  if(this.mAdvanceSpeed > 20)
                  {
                     this.mAdvanceSpeed = 20;
                  }
                  else if(this.mAdvanceSpeed < _loc4_)
                  {
                     this.mAdvanceSpeed = _loc4_;
                  }
               }
            }
         }
         var _loc13_:Boolean = false;
         var _loc14_:DListIterator;
         (_loc14_ = this.mBallList.getListIterator()).start();
         var _loc15_:Ball = null;
         while(_loc14_.valid())
         {
            _loc9_ = _loc14_.data;
            _loc23_ = null;
            _loc14_.forth();
            if(!_loc14_.hasNext())
            {
               break;
            }
            _loc24_ = (_loc23_ = _loc14_.data).GetWayPoint();
            _loc10_ = _loc9_.GetWayPoint();
            _loc25_ = false;
            if(_loc10_ > _loc24_ - _loc9_.GetRadius() - _loc23_.GetRadius())
            {
               this.mWayPointMgr.SetWayPoint(_loc23_,_loc10_ + _loc9_.GetRadius() + _loc23_.GetRadius(),this.mLevel.mLoopAtEnd);
               _loc25_ = true;
            }
            if(_loc25_)
            {
               if(!_loc9_.GetCollidesWithNext())
               {
                  if(_loc9_.GetSpeedy() && !_loc23_.GetSpeedy())
                  {
                     _loc26_ = _loc9_;
                     while(_loc26_ != null)
                     {
                        _loc26_.SetSpeedy(false);
                        _loc26_ = _loc26_.GetPrevBall(true);
                     }
                  }
                  _loc9_.SetCollidesWithNext(true);
                  this.mBoard.PlayBallClick(Zuma2Sounds.SOUND_BALL_CLICK1);
               }
               _loc11_ = _loc23_.GetWayPoint() - _loc24_;
               _loc9_.SetNeedCheckCollision(false);
            }
            else
            {
               _loc11_ = 0;
            }
            if(_loc15_ == null && !_loc9_.GetCollidesWithNext())
            {
               _loc15_ = _loc9_;
               _loc12_ = this.mCurveDesc.mVals.mStartDistance;
               if(_loc15_.GetWayPoint() < _loc12_ / 100 * this.GetCurveLength())
               {
                  _loc13_ = true;
               }
            }
         }
         if(!_loc13_ && this.mLevel.mTempSpeedupTimer <= 0)
         {
            this.mCanCheckForSpeedup = true;
            this.mOverrideSpeed = -1;
         }
         _loc12_ = this.mCurveDesc.mVals.mStartDistance;
         if(!this.mHasReachedRolloutPoint && this.mBackwardCount <= 0 && this.mBallList.tail.data.GetWayPoint() >= _loc12_ / 100 * this.GetCurveLength())
         {
            this.mHasReachedRolloutPoint = true;
         }
         if(_loc15_ == null)
         {
            _loc15_ = this.mBallList.tail.data;
            this.mCanCheckForSpeedup = true;
            if(this.HasReachedCruisingSpeed())
            {
               _loc13_ = true;
            }
         }
         this.mFirstChainEnd = _loc15_.GetWayPoint();
         if(_loc13_ && this.mCanCheckForSpeedup && this.mLevel.mHurryToRolloutAmt > 0)
         {
            _loc12_ = this.mCurveDesc.mVals.mStartDistance;
            if(this.mFirstChainEnd < _loc12_ / 100 * this.GetCurveLength())
            {
               this.mCanCheckForSpeedup = false;
               this.mOverrideSpeed = this.mLevel.mHurryToRolloutAmt;
            }
            else
            {
               this.mCanCheckForSpeedup = true;
               this.mOverrideSpeed = -1;
            }
         }
         var _loc16_:*;
         if((_loc16_ = this.mFirstChainEnd >= _loc2_) && this.mApp.gDieAtEnd)
         {
            _loc27_ = this.GetBoardTickCount();
            _loc28_ = Number(this.GetCurveLength() - this.mFirstChainEnd) / Number(this.GetCurveLength() - this.mDangerPoint);
            _loc29_ = 100 + 4000 * _loc28_;
            if((_loc30_ = this.mBoard.GetStateCount()) >= this.mPathLightEndFrame && _loc27_ - this.mLastPathShowTick >= _loc29_)
            {
               if((_loc31_ = this.mLevel.GetFarthestBallPercent(_loc31_,false)) == this.mCurveNum)
               {
                  this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_WARNING1);
               }
               this.mLastPathShowTick = _loc27_;
               this.mPathLightEndFrame = _loc30_;
               if(this.mWarningLights.length > 0)
               {
                  _loc32_ = this.mWarningLights.length;
                  _loc33_ = 0;
                  while(_loc33_ < this.mWarningLights.length)
                  {
                     if((_loc34_ = this.mWarningLights[_loc33_]).mWaypoint + 18 > this.mFirstChainEnd)
                     {
                        _loc32_ = _loc33_;
                        break;
                     }
                     _loc33_++;
                  }
                  if(_loc32_ < this.mWarningLights.length)
                  {
                     this.mWarningLights[_loc32_].mPulseRate = 30 * (1 - _loc28_);
                     _loc35_ = 10;
                     if(this.mWarningLights[_loc32_].mPulseRate < _loc35_)
                     {
                        this.mWarningLights[_loc32_].mPulseRate = _loc35_;
                     }
                  }
               }
            }
         }
         var _loc17_:Boolean = this.mInDanger;
         this.mInDanger = this.mBallList.tail.data.GetWayPoint() >= this.mDangerPoint && this.mApp.gDieAtEnd;
         if(_loc17_ != this.mInDanger && this.mWarningLights.length > 0)
         {
            _loc33_ = 0;
            while(_loc33_ < this.mWarningLights.length)
            {
               this.mWarningLights[_loc33_].mState = !!this.mInDanger ? 1 : -1;
               _loc33_++;
            }
         }
      }
      
      public function GetNumPendingSingles(param1:int) : int
      {
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = -1;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:DListIterator;
         (_loc7_ = this.mPendingBalls.getListIterator()).end();
         while(_loc7_.valid() && _loc2_ <= param1)
         {
            if((_loc6_ = _loc7_.data.GetColorType()) != _loc3_)
            {
               if(_loc5_ == 1)
               {
                  _loc4_++;
               }
               _loc5_ = 1;
               _loc2_++;
               _loc3_ = _loc6_;
            }
            else
            {
               _loc5_++;
            }
            _loc7_.back();
         }
         var _loc8_:DListIterator;
         (_loc8_ = this.mBallList.getListIterator()).start();
         while(_loc8_.valid() && _loc2_ <= param1)
         {
            if((_loc6_ = _loc8_.data.GetColorType()) != _loc3_)
            {
               if(_loc5_ == 1)
               {
                  _loc4_++;
               }
               _loc5_ = 1;
               _loc2_++;
               _loc3_ = _loc6_;
            }
            else
            {
               _loc5_++;
            }
            _loc8_.forth();
         }
         return _loc4_;
      }
      
      public function AddBall() : void
      {
         var _loc4_:Number = NaN;
         if(!this.mApp.gAddBalls || this.mLevel.mNum == int.MAX_VALUE && this.mBoard.mPreventBallAdvancement)
         {
            return;
         }
         if(this.mPendingBalls.isEmpty())
         {
            if(this.mStopAddingBalls)
            {
               return;
            }
            this.AddPendingBall();
         }
         var _loc1_:Ball = this.mPendingBalls.head.data;
         this.mWayPointMgr.SetWayPoint(_loc1_,1,this.mLevel.mLoopAtEnd);
         var _loc2_:Ball = null;
         if(!this.mBallList.isEmpty())
         {
            _loc2_ = this.mBallList.head.data;
            if(this.mAdvanceSpeed > _loc2_.GetRadius() && _loc2_.GetWayPoint() >= 0)
            {
               if(_loc2_.GetWayPoint() - this.mAdvanceSpeed < 5)
               {
                  _loc4_ = _loc2_.GetWayPoint() - _loc2_.GetRadius() - _loc1_.GetRadius() - 0.001;
                  _loc1_.SetWayPoint(_loc4_,this.mWayPointMgr.InTunnel(_loc4_));
               }
            }
            else if(_loc1_.GetWayPoint() > _loc2_.GetWayPoint() || _loc1_.CollidesWith(_loc2_))
            {
               return;
            }
         }
         var _loc3_:DListIterator = this.mBallList.getListIterator();
         _loc3_.start();
         _loc1_.InsertInList(this.mBallList,_loc3_,this);
         _loc1_.UpdateCollisionInfo(5 + this.mAdvanceSpeed);
         _loc1_.SetNeedCheckCollision(true);
         _loc1_.SetRotation(this.mWayPointMgr.GetRotationForPoint(_loc1_.GetWayPoint()));
         _loc1_.SetBackwardsCount(0);
         _loc1_.SetSuckCount(0);
         _loc1_.SetGapBonus(0,0);
         _loc1_.SetComboCount(0,0);
         this.mPendingBalls.removeHead();
         if(_loc1_.GetWayPoint() > 1)
         {
            this.AddBall();
         }
      }
      
      public function CheckCollision(param1:Bullet, param2:Boolean = true) : Boolean
      {
         var _loc9_:Ball = null;
         var _loc10_:Ball = null;
         var _loc11_:SexyVector3 = null;
         var _loc12_:SexyVector3 = null;
         var _loc13_:SexyVector3 = null;
         var _loc14_:SexyVector3 = null;
         var _loc15_:Number = NaN;
         var _loc16_:int = 0;
         var _loc3_:Bullet = param1;
         var _loc4_:Ball = null;
         var _loc5_:* = false;
         var _loc6_:DListIterator = this.mBallList.getListIterator();
         var _loc7_:DListIterator;
         (_loc7_ = this.mBulletList.getListIterator()).start();
         while(_loc7_.valid())
         {
            _loc3_ = _loc7_.data;
            if(param1.CollidesWithPhysically(_loc3_))
            {
               _loc3_.Update();
               this.AdvanceMergingBullet(_loc7_);
               break;
            }
            _loc7_.forth();
         }
         var _loc8_:Boolean = false;
         _loc6_.start();
         while(_loc6_.valid())
         {
            if((_loc4_ = _loc6_.data).CollidesWithPhysically(_loc3_,0) && _loc4_.GetBullet() == null && !_loc4_.GetIsExploding())
            {
               if((_loc9_ = _loc4_.GetPrevBall(true)) == null || _loc9_.GetBullet() == null)
               {
                  if((_loc10_ = _loc4_.GetNextBall(true)) == null || _loc10_.GetBullet() == null)
                  {
                     _loc11_ = new SexyVector3(_loc4_.GetX(),_loc4_.GetY(),0);
                     _loc12_ = new SexyVector3(_loc3_.GetX(),_loc3_.GetY(),0);
                     _loc13_ = this.mWayPointMgr.CalcPerpendicular(_loc4_.GetWayPoint());
                     _loc5_ = (_loc14_ = _loc12_.Sub(_loc11_).Cross(_loc13_)).z < 0;
                     if(!this.mWayPointMgr.InTunnel2(_loc4_,_loc5_))
                     {
                        if(!param1.GetIsCannon())
                        {
                           break;
                        }
                     }
                  }
               }
            }
            if(_loc8_)
            {
               return true;
            }
            _loc6_.forth();
         }
         if(_loc6_.node != null)
         {
            if(param1.GetIsCannon())
            {
               return true;
            }
            _loc3_.SetHitBall(_loc4_,_loc5_);
            _loc3_.SetMergeSpeed(this.mCurveDesc.mMergeSpeed);
            _loc10_ = _loc4_.GetNextBall();
            if(!_loc5_)
            {
               _loc3_.RemoveGapInfoForBall(_loc4_.GetId());
            }
            else if(_loc10_ != null)
            {
               _loc3_.RemoveGapInfoForBall(_loc10_.GetId());
            }
            if(this.mApp.gStopSuckbackImmediately)
            {
               if(_loc5_ && _loc10_ != null && _loc10_.GetSuckBack() && _loc10_.GetSuckCount() > 0 && _loc10_.GetColorType() != _loc3_.GetColorType())
               {
                  _loc10_.SetSuckCount(0);
               }
               else if(!_loc5_ && _loc4_ != null && _loc4_.GetSuckBack() && _loc4_.GetSuckCount() > 0 && _loc4_.GetColorType() != _loc3_.GetColorType())
               {
                  _loc4_.SetSuckCount(0);
               }
            }
            this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_BALL_CLICK2);
            _loc15_ = _loc4_.GetWayPoint();
            _loc16_ = 80;
            if(this.mWayPointMgr.CheckDiscontinuity(_loc15_ - _loc16_,2 * _loc16_))
            {
               _loc3_.mDoNewMerge = true;
            }
            this.mBulletList.append(_loc3_);
            return true;
         }
         return false;
      }
      
      public function GetNumPendingMatches() : int
      {
         var _loc1_:int = 0;
         var _loc2_:Ball = null;
         if(this.mPendingBalls.size == 0 && this.mBallList.size == 0)
         {
            return 0;
         }
         _loc1_ = this.mPendingBalls.size > 0 ? int(this.mPendingBalls.tail.data.GetColorType()) : int(this.mBallList.head.data.GetColorType());
         var _loc3_:int = 0;
         var _loc4_:DListIterator;
         (_loc4_ = this.mPendingBalls.getListIterator()).end();
         while(_loc4_.valid())
         {
            _loc2_ = _loc4_.data;
            if(_loc2_.GetColorType() != _loc1_)
            {
               break;
            }
            _loc3_++;
            _loc4_.back();
         }
         if(this.mPendingBalls.size > 0)
         {
            return _loc3_;
         }
         var _loc5_:DListIterator;
         (_loc5_ = this.mBallList.getListIterator()).start();
         while(_loc5_.valid())
         {
            _loc2_ = _loc5_.data;
            if(_loc2_.GetColorType() != _loc1_)
            {
               break;
            }
            _loc3_++;
            _loc5_.forth();
         }
         return _loc3_;
      }
      
      public function Reset() : void
      {
         var _loc1_:int = 0;
         this.mPlayedSparkleSound = false;
         this.mHasReachedCruisingSpeed = false;
         this.mNumBallsCreated = 0;
         this.mNeedsSpeedup = false;
         this.mOverrideSpeed = -1;
         this.mProxBombCounter = -1;
         this.mHasReachedRolloutPoint = false;
         this.mCanCheckForSpeedup = false;
         this.mLastPowerupTime = 0;
         this.mLastPathHiliteWP = 0;
         this.mLastPathHilitePitch = this.mCurveNum == 1 ? -20 : 0;
         this.mInitialPathHilite = false;
         this.mSkullHilite = 0;
         this.mDoingClearCurveRollout = false;
         this.mSkullHiliteDir = 0;
         _loc1_ = 0;
         while(_loc1_ < PowerType.PowerType_Max)
         {
            this.mNumPowerUpsThisLevel[_loc1_] = 0;
            this.mNumPowerupsActivated[_loc1_] = 0;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            this.mBallColorHasPowerup[_loc1_] = 0;
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.mWarningLights.length)
         {
            this.mWarningLights[_loc2_].mState = -1;
            if(this.mWarningLights[_loc2_].mPulseRate > 0)
            {
               this.mWarningLights[_loc2_].mPulseRate *= -1;
            }
            _loc2_++;
         }
      }
      
      public function CheckBallIntersection(param1:SexyVector3, param2:SexyVector3, param3:Point, param4:Boolean = false) : Ball
      {
         var _loc8_:Ball = null;
         var _loc9_:Number = NaN;
         var _loc10_:Point = null;
         var _loc5_:Ball = null;
         var _loc6_:int = 0;
         var _loc7_:DListIterator;
         (_loc7_ = this.mBallList.getListIterator()).start();
         while(_loc7_.valid())
         {
            _loc8_ = _loc7_.data;
            if(!this.mWayPointMgr.InTunnel(_loc8_.GetWayPoint()))
            {
               _loc10_ = new Point();
               if((!_loc8_.GetIsExploding() || !param4) && _loc8_.Intersects(param1,param2,_loc10_))
               {
                  if((_loc9_ = _loc10_.x) < param3.x && _loc9_ > 0)
                  {
                     _loc5_ = _loc8_;
                     param3.x = _loc9_;
                  }
               }
            }
            _loc7_.forth();
            _loc6_++;
         }
         return _loc5_;
      }
      
      public function StartExploding(param1:Ball, param2:Boolean = false, param3:Boolean = true) : void
      {
         if(param1.GetIsExploding())
         {
            return;
         }
         if(param3)
         {
            ++this.mBoard.mLevelStats.mNumBallsCleared;
            this.mBoard.IncNumCleared(1);
         }
         this.mLastClearedBallPoint = param1.GetWayPoint();
         if(param1.GetSuckPending())
         {
            param1.SetSuckPending(false);
         }
         param1.Explode(this.mWayPointMgr.InTunnel(param1.GetWayPoint()),param2);
         if(param1.GetPowerOrDestType() != PowerType.PowerType_None)
         {
            ++this.mNumPowerupsActivated[param1.GetPowerOrDestType()];
            this.mBoard.ActivatePowerBall(param1);
            this.mLastCompletedPowerUpFrame[param1.GetPowerOrDestType()] = this.mBoard.GetStateCount();
            this.mHadPowerUp = true;
         }
      }
      
      public function CanRestart() : Boolean
      {
         return this.mBallList.isEmpty();
      }
      
      public function DeleteBalls() : void
      {
         var _loc1_:DListIterator = this.mBallList.getListIterator();
         var _loc2_:DListIterator = this.mBulletList.getListIterator();
         var _loc3_:DListIterator = this.mPendingBalls.getListIterator();
         _loc2_.start();
         while(_loc2_.valid())
         {
            _loc2_.data.Delete();
            _loc2_.forth();
         }
         _loc1_.start();
         while(_loc1_.valid())
         {
            _loc1_.data.Delete();
            _loc1_.forth();
         }
         _loc3_.start();
         while(_loc3_.valid())
         {
            _loc3_.data.Delete();
            _loc3_.forth();
         }
         this.mBallList.clear();
         this.mPendingBalls.clear();
         this.mBulletList.clear();
      }
      
      public function DoMerge(param1:Bullet) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Ball = null;
         var _loc12_:Boolean = false;
         var _loc2_:Bullet = param1;
         _loc2_.CheckSetHitBallToPrevBall();
         var _loc3_:Ball = _loc2_.GetHitBall();
         var _loc4_:Number = _loc2_.GetRotation();
         this.mWayPointMgr.SetWayPoint(_loc2_,_loc3_.GetWayPoint(),this.mLevel.mLoopAtEnd);
         this.mWayPointMgr.FindFreeWayPoint(_loc3_,_loc2_,_loc2_.GetHitInFront(),this.mLevel.mLoopAtEnd);
         _loc2_.SetDestPos(_loc2_.GetX(),_loc2_.GetY());
         _loc2_.SetRotation(_loc4_,true);
         _loc2_.SetRotation(this.mWayPointMgr.GetRotationForPoint(_loc2_.GetWayPoint()),false);
         _loc2_.Update();
         var _loc5_:Ball;
         if((_loc5_ = _loc2_.GetPushBall()) != null)
         {
            _loc6_ = 1 - _loc2_.GetHitPercent();
            _loc7_ = int(-_loc2_.GetRadius() * _loc6_ / 2);
            _loc8_ = _loc5_.GetWayPoint();
            _loc9_ = _loc2_.GetHitPercent() * _loc2_.GetHitPercent() * (_loc5_.GetRadius() + _loc2_.GetRadius());
            this.mWayPointMgr.FindFreeWayPoint(_loc2_,_loc2_.GetPushBall(),true,this.mLevel.mLoopAtEnd,_loc7_);
            if(_loc5_.GetWayPoint() - _loc2_.GetWayPoint() > _loc9_)
            {
               if((_loc10_ = _loc2_.GetWayPoint() + _loc9_) > _loc8_)
               {
                  this.mWayPointMgr.SetWayPoint(_loc5_,_loc10_,this.mLevel.mLoopAtEnd);
               }
               else
               {
                  this.mWayPointMgr.SetWayPoint(_loc5_,_loc8_,this.mLevel.mLoopAtEnd);
               }
            }
            _loc5_.SetNeedCheckCollision(true);
            if(!this.mApp.gStopSuckbackImmediately)
            {
               _loc11_ = _loc3_.GetNextBall();
               if((_loc12_ = _loc2_.GetHitInFront()) && _loc11_ != null && _loc11_.GetSuckBack() && _loc11_.GetSuckCount() > 0 && _loc11_.GetColorType() != _loc2_.GetColorType())
               {
                  _loc11_.SetSuckCount(0);
               }
               else if(!_loc12_ && _loc3_ != null && _loc3_.GetSuckBack() && _loc3_.GetSuckCount() > 0 && _loc3_.GetColorType() != _loc2_.GetColorType())
               {
                  _loc3_.SetSuckCount(0);
               }
            }
         }
      }
      
      public function DrawBalls(param1:Canvas) : void
      {
         var _loc4_:Ball = null;
         var _loc5_:Bullet = null;
         var _loc2_:DListIterator = this.mBallList.getListIterator();
         _loc2_.start();
         while(_loc2_.valid())
         {
            (_loc4_ = _loc2_.data).Draw(param1);
            _loc2_.forth();
         }
         var _loc3_:DListIterator = this.mBulletList.getListIterator();
         _loc3_.start();
         while(_loc3_.valid())
         {
            (_loc5_ = _loc3_.data).Draw(param1);
            _loc3_.forth();
         }
      }
      
      public function CanSpawnPowerUp(param1:int) : Boolean
      {
         var _loc2_:int = this.mCurveDesc.mVals.mMaxNumPowerUps[param1];
         if(param1 == PowerType.PowerType_Accuracy || param1 == PowerType.PowerType_ColorNuke || param1 == PowerType.PowerType_Laser || param1 == PowerType.PowerType_Cannon)
         {
            return false;
         }
         return true;
      }
      
      public function CheckSet(param1:Ball) : Boolean
      {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Ball = null;
         var _loc8_:Ball = null;
         var _loc9_:DListIterator = null;
         var _loc10_:SoundResource = null;
         var _loc11_:String = null;
         var _loc12_:SoundResource = null;
         var _loc13_:Number = NaN;
         this.mHadPowerUp = false;
         this.mBallObj.aNextEnd = null;
         this.mBallObj.aPrevEnd = null;
         var _loc3_:int = param1.GetComboCount();
         var _loc4_:int;
         if((_loc4_ = this.GetNumInARow(param1,param1.GetColorType(),this.mBallObj)) >= 3)
         {
            this.mBoard.SetNumCleared(0);
            this.mBoard.SetCurComboCount(_loc3_);
            this.mBoard.SetCurComboScore(param1.GetComboScore());
            this.mBoard.mNeedComboCount.clear();
            _loc2_ = 0;
            while(_loc2_ < PowerType.PowerType_Max)
            {
               this.mApp.gGotPowerUp[_loc2_] = false;
               _loc2_++;
            }
            _loc5_ = 0;
            _loc6_ = 0;
            _loc7_ = this.mBallObj.aNextEnd.GetNextBall();
            _loc8_ = this.mBallObj.aPrevEnd;
            while(_loc8_ != _loc7_)
            {
               if(_loc8_.GetSuckPending())
               {
                  _loc8_.SetSuckPending(false);
                  this.mBoard.IncNumClearsInARow(1);
               }
               this.StartExploding(_loc8_);
               _loc5_ += _loc8_.GetGapBonus();
               if(_loc8_.GetNumGaps() > _loc6_)
               {
                  _loc6_ = _loc8_.GetNumGaps();
               }
               _loc8_.SetGapBonus(0,0);
               _loc8_ = _loc8_.GetNextBall();
            }
            this.DoScoring(param1,this.mBoard.GetNumCleared(),_loc3_,_loc5_,_loc6_);
            if(this.mBoard.GetCurComboCount() > this.mBoard.mLevelStats.mMaxCombo || this.mBoard.GetCurComboCount() == this.mBoard.mLevelStats.mMaxCombo && this.mBoard.GetCurComboScore() >= this.mBoard.mLevelStats.mMaxComboScore)
            {
               this.mBoard.mLevelStats.mMaxCombo = this.mBoard.GetCurComboCount();
               this.mBoard.mLevelStats.mMaxComboScore = this.mBoard.GetCurComboScore();
            }
            _loc8_ = this.mBallObj.aPrevEnd;
            while(_loc8_ != _loc7_)
            {
               _loc8_.SetComboCount(_loc3_,this.mBoard.GetCurComboScore());
               _loc8_ = _loc8_.GetNextBall();
            }
            (_loc9_ = this.mBoard.mNeedComboCount.getListIterator()).start();
            while(_loc9_.valid())
            {
               _loc9_.data.SetComboCount(_loc3_,this.mBoard.GetCurComboScore());
               _loc9_.forth();
            }
            this.mBoard.mNeedComboCount.clear();
            if(!this.mHadPowerUp)
            {
               switch(_loc3_)
               {
                  case 0:
                     _loc10_ = this.mApp.soundManager.getSoundResource(Zuma2Sounds.SOUND_BALLS_DESTROYED1);
                     break;
                  case 1:
                     _loc10_ = this.mApp.soundManager.getSoundResource(Zuma2Sounds.SOUND_BALLS_DESTROYED2);
                     break;
                  case 2:
                     _loc10_ = this.mApp.soundManager.getSoundResource(Zuma2Sounds.SOUND_BALLS_DESTROYED3);
                     break;
                  case 3:
                     _loc10_ = this.mApp.soundManager.getSoundResource(Zuma2Sounds.SOUND_BALLS_DESTROYED4);
                     break;
                  default:
                     _loc10_ = this.mApp.soundManager.getSoundResource(Zuma2Sounds.SOUND_BALLS_DESTROYED5);
               }
               _loc10_.setVolume(0.5);
               _loc10_.play(1);
               _loc11_ = "SOUND_BALL_COMBO" + (_loc3_ + 1);
               if((_loc12_ = this.mApp.soundManager.getSoundResource(_loc11_)) != null)
               {
                  if((_loc13_ = 0.4 + 0.2 * _loc3_) > 1)
                  {
                     _loc13_ = 1;
                  }
                  _loc12_.play(1);
               }
            }
            this.mBoard.SetCurComboCount(0);
            this.mBoard.SetCurComboScore(0);
            return true;
         }
         return false;
      }
      
      public function RollBallsIn() : void
      {
         this.mHasReachedCruisingSpeed = false;
         var _loc1_:Number = this.mCurveDesc.mVals.mSpeed;
         var _loc2_:int = this.mCurveDesc.mVals.mStartDistance;
         var _loc3_:Number = this.GetCurveLength() * _loc2_ / 100;
         if(this.mFirstChainEnd > 0)
         {
            _loc3_ -= Number(this.mFirstChainEnd / this.GetCurveLength());
            if(_loc3_ <= 0)
            {
               this.mAdvanceSpeed = this.mCurveDesc.mVals.mSpeed * this.mSpeedScale;
               return;
            }
         }
         var _loc4_:Number = 20 * _loc1_ + 1;
         var _loc5_:Number = -20 * _loc3_;
         var _loc6_:int = (-_loc4_ + Math.sqrt(_loc4_ * _loc4_ - 4 * _loc5_)) / 2;
         this.mAdvanceSpeed = _loc1_ + _loc6_ * 0.1;
         if(!this.mApp.gAddBalls)
         {
            this.mHasReachedCruisingSpeed = true;
            this.mAdvanceSpeed = this.mCurveDesc.mVals.mSpeed * this.mSpeedScale;
         }
      }
      
      public function UpdateSuckingBalls() : void
      {
         var _loc2_:Ball = null;
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Ball = null;
         var _loc6_:Ball = null;
         var _loc7_:Ball = null;
         var _loc8_:Boolean = false;
         var _loc9_:Bullet = null;
         var _loc10_:Ball = null;
         var _loc11_:Boolean = false;
         var _loc12_:Number = NaN;
         var _loc13_:int = 0;
         var _loc14_:Boolean = false;
         var _loc15_:Number = NaN;
         var _loc1_:DListIterator = this.mBallList.getListIterator();
         _loc1_.start();
         while(_loc1_.valid())
         {
            _loc2_ = _loc1_.data;
            if(!_loc2_.GetSuckBack() && _loc2_.GetSuckCount() > 0)
            {
               this.UpdateForwardSuckingBalls();
               return;
            }
            _loc3_ = _loc2_.GetSuckCount();
            _loc4_ = (_loc3_ >> 3) * this.mSpeedScale;
            if(_loc2_.GetSuckCount() > 0)
            {
               _loc5_ = null;
               while(_loc1_.valid())
               {
                  _loc5_ = _loc1_.data;
                  _loc1_.forth();
                  _loc5_.SetSuckCount(0);
                  this.mWayPointMgr.SetWayPoint(_loc5_,_loc5_.GetWayPoint() - _loc4_,this.mLevel.mLoopAtEnd);
                  if((_loc9_ = _loc5_.GetBullet()) != null && !_loc9_.mDoNewMerge)
                  {
                     if((_loc10_ = _loc9_.GetPushBall()) != null)
                     {
                        this.mWayPointMgr.FindFreeWayPoint(_loc10_,_loc9_,false,this.mLevel.mLoopAtEnd);
                     }
                     _loc9_.UpdateHitPos();
                  }
                  if(!_loc5_.GetCollidesWithNext())
                  {
                     break;
                  }
               }
               _loc6_ = _loc5_;
               _loc2_.SetSuckCount(_loc3_ + 1);
               if((_loc7_ = _loc2_.GetPrevBall()) != null && _loc7_.GetColorType() == _loc2_.GetColorType() && _loc7_.GetIsExploding())
               {
                  while(_loc7_ != null)
                  {
                     if((_loc7_ = _loc7_.GetPrevBall()) != null && !_loc7_.GetIsExploding())
                     {
                        break;
                     }
                  }
               }
               if(_loc8_ = _loc7_ != null && _loc7_.GetColorType() == _loc2_.GetColorType())
               {
                  _loc11_ = false;
                  _loc12_ = _loc2_.GetWayPoint() - _loc2_.GetRadius() - _loc7_.GetRadius();
                  if(_loc7_.GetWayPoint() > _loc12_)
                  {
                     this.mWayPointMgr.SetWayPoint(_loc7_,_loc12_,this.mLevel.mLoopAtEnd);
                     _loc11_ = true;
                  }
                  if(_loc11_)
                  {
                     this.mBoard.PlayBallClick(Zuma2Sounds.SOUND_BALL_CLICK1);
                     _loc7_.SetCollidesWithNext(true);
                     _loc2_.SetSuckCount(0);
                     _loc13_ = 5 + 5 * _loc2_.GetComboCount();
                     _loc14_ = true;
                     if(!this.CheckSet(_loc2_) || _loc2_.GetSuckFromCompacting())
                     {
                        _loc2_.SetComboCount(0,0);
                     }
                     if(_loc13_ > 40)
                     {
                        _loc13_ = 40;
                     }
                     _loc13_ *= 3;
                     if(_loc14_)
                     {
                        if(_loc6_.GetBackwardsCount() == 0)
                        {
                           _loc6_.SetBackwardsCount(30);
                           if((_loc15_ = _loc2_.GetComboCount() * 1.5) <= 1)
                           {
                              _loc15_ = 1;
                           }
                           _loc6_.SetBackwardsSpeed(_loc15_);
                        }
                     }
                     this.ClearPendingSucks(_loc6_);
                  }
               }
               else
               {
                  _loc2_.SetSuckCount(0);
               }
            }
            else
            {
               _loc1_.forth();
            }
         }
      }
      
      public function DeleteBall(param1:Ball) : void
      {
         var _loc3_:DListIterator = null;
         var _loc2_:Bullet = param1.GetBullet();
         if(_loc2_ != null)
         {
            _loc2_.MergeFully();
            _loc3_ = this.mBulletList.nodeOf(_loc2_);
            if(_loc3_.valid())
            {
               this.AdvanceMergingBullet(_loc3_.data);
            }
         }
         this.DeleteBullet(param1.GetBullet());
         param1.SetCollidesWithPrev(false);
         param1.Delete();
      }
      
      public function DrawMisc() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.mSparkles.length)
         {
            this.mSparkles[_loc1_].Update();
            _loc1_++;
         }
      }
      
      public function RemoveBallsAtEnd() : void
      {
         var _loc4_:Ball = null;
         if(this.mApp.gDieAtEnd || this.mLevel.mLoopAtEnd)
         {
            return;
         }
         if(this.mBallList.isEmpty())
         {
            return;
         }
         var _loc1_:int = this.mWayPointMgr.GetEndPoint();
         var _loc2_:DListIterator = this.mBallList.getListIterator();
         _loc2_.end();
         var _loc3_:Boolean = false;
         while(!_loc3_)
         {
            if((_loc4_ = _loc2_.data).GetWayPoint() < _loc1_)
            {
               break;
            }
            if(!this.mLevel.mLoopAtEnd || _loc4_.GetIsExploding())
            {
               if(_loc2_.node != this.mBallList.head)
               {
                  _loc2_.back();
               }
               else
               {
                  _loc3_ = true;
               }
               this.DeleteBullet(_loc4_.GetBullet());
               _loc4_.RemoveFromList();
               _loc4_.mDead = true;
               this.DeleteBall(_loc4_);
            }
         }
      }
      
      public function GetFarthestBallPercent(param1:Boolean = true) : int
      {
         var _loc3_:DListIterator = null;
         var _loc4_:Ball = null;
         if(this.mBallList.isEmpty())
         {
            return 0;
         }
         var _loc2_:int = this.mBallList.tail.data.GetWayPoint();
         if(!param1)
         {
            _loc3_ = this.mBallList.getListIterator();
            _loc3_.start();
            while(_loc3_.valid())
            {
               if(!(_loc4_ = _loc3_.data).GetCollidesWithNext())
               {
                  _loc2_ = _loc4_.GetWayPoint();
                  break;
               }
               _loc3_.forth();
            }
         }
         return int(_loc2_ * 100 / this.mWayPointMgr.GetNumPoints());
      }
      
      public function SetLosing() : void
      {
         var _loc3_:Ball = null;
         var _loc1_:DListIterator = this.mBulletList.getListIterator();
         _loc1_.start();
         while(_loc1_.valid())
         {
            _loc1_.data.Delete();
            _loc1_.forth();
         }
         this.mBulletList = new DLinkedList();
         var _loc2_:DListIterator = this.mBallList.getListIterator();
         _loc2_.start();
         while(_loc2_.valid())
         {
            _loc3_ = _loc2_.data;
            _loc3_.SetSuckCount(this.mAdvanceSpeed * 4);
            _loc2_.forth();
         }
      }
      
      public function DoBackwards() : void
      {
         if(!this.mBallList.isEmpty())
         {
            this.mBackwardCount = 300;
         }
      }
      
      public function ActivateProximityBomb(param1:Ball) : void
      {
         var _loc4_:Ball = null;
         var _loc2_:int = PROXIMITY_BOMB_RADIUS;
         var _loc3_:DListIterator = this.mBallList.getListIterator();
         _loc3_.start();
         while(_loc3_.valid())
         {
            if(!(_loc4_ = _loc3_.data).GetIsExploding() && _loc4_.CollidesWithPhysically(param1,_loc2_))
            {
               _loc4_.SetComboCount(this.mBoard.GetCurComboCount(),this.mBoard.GetCurComboScore());
               this.mBoard.mNeedComboCount.append(_loc4_);
               this.StartExploding(_loc4_);
            }
            _loc3_.forth();
         }
      }
      
      public function SetPath(param1:String) : void
      {
         this.mPath = param1;
      }
      
      public function LoadCurve() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc7_:WayPoint = null;
         var _loc8_:Point = null;
         var _loc9_:SexyVector3 = null;
         var _loc10_:SexyVector3 = null;
         var _loc11_:SexyVector3 = null;
         this.mSpeedScale = 1;
         this.mWayPointMgr.LoadCurve(this.mPath,this.mCurveDesc);
         var _loc3_:Number = this.mCurveDesc.mVals.mSkullRotation;
         if(_loc3_ >= 0)
         {
            _loc3_ = Zuma2App.DEG_TO_RAD * _loc3_;
         }
         var _loc4_:int;
         if((_loc4_ = this.mWayPointMgr.mWayPoints.length) > 0)
         {
            this.mWayPointMgr.CalcPerpendicularForPoint(int(_loc4_ - 1));
            _loc1_ = (_loc7_ = this.mWayPointMgr.mWayPoints[_loc4_ - 1]).x;
            _loc2_ = _loc7_.y;
            if(_loc3_ < 0)
            {
               _loc3_ = _loc7_.mRotation;
            }
         }
         this.mLevel.mHoleMgr.PlaceHole(this.mCurveNum,_loc1_,_loc2_,_loc3_,this.mCurveDesc.mVals.mDrawPit);
         this.mDangerPoint = this.mWayPointMgr.mWayPoints.length - this.mCurveDesc.mDangerDistance;
         if(this.mDangerPoint >= this.mWayPointMgr.mWayPoints.length)
         {
            this.mDangerPoint = this.mWayPointMgr.mWayPoints.length - 1;
         }
         var _loc5_:int = 0;
         var _loc6_:int = this.mDangerPoint * this.mLevel.mPotPct;
         while(_loc6_ <= this.mWayPointMgr.GetEndPoint() - 50)
         {
            _loc8_ = this.mWayPointMgr.GetPointPos(_loc6_);
            _loc9_ = new SexyVector3(_loc8_.x,_loc8_.y,0);
            _loc10_ = this.mWayPointMgr.CalcPerpendicular(_loc6_).Mult(_loc5_);
            _loc11_ = _loc9_.Add(_loc10_);
            this.mWarningLights.push(new WarningLight(this.mApp,_loc11_.x,_loc11_.y));
            this.mWarningLights[this.mWarningLights.length - 1].SetAngle(this.mWayPointMgr.GetRotationForPoint(_loc6_));
            this.mWarningLights[this.mWarningLights.length - 1].mWaypoint = _loc6_;
            this.mWarningLights[this.mWarningLights.length - 1].mPriority = this.mWayPointMgr.GetPriority(_loc6_);
            _loc6_ += 50;
         }
         this.mIsLoaded = true;
      }
      
      public function HasReachedCruisingSpeed() : Boolean
      {
         return this.mHasReachedCruisingSpeed;
      }
      
      public function RemoveBallsAtFront() : void
      {
         var _loc2_:Ball = null;
         if(!this.mHasReachedCruisingSpeed)
         {
            return;
         }
         var _loc1_:DListIterator = this.mBallList.getListIterator();
         _loc1_.start();
         while(_loc1_.valid())
         {
            _loc2_ = _loc1_.data;
            if(!(_loc2_.GetWayPoint() < this.mCurveDesc.mCutoffPoint && this.mStopAddingBalls || _loc2_.GetWayPoint() < 1))
            {
               break;
            }
            _loc1_.forth();
            this.DeleteBullet(_loc2_.GetBullet());
            _loc2_.RemoveFromList();
            if(!_loc2_.GetIsExploding() && !this.mStopAddingBalls)
            {
               this.mPendingBalls.append(_loc2_);
            }
            else
            {
               if(!this.mStopAddingBalls)
               {
               }
               _loc2_.mDead = true;
               this.DeleteBall(_loc2_);
               if(this.mBallList.size == 0 && this.mStopAddingBalls)
               {
                  this.mLastClearedBallPoint = 0;
               }
            }
         }
      }
      
      public function StartLevel() : void
      {
         var _loc1_:int = 0;
         this.mPathLightEndFrame = 0;
         this.mLastPathShowTick = Math.min(0,this.GetBoardTickCount() - 1000000);
         this.mLastClearedBallPoint = 0;
         _loc1_ = 0;
         while(_loc1_ < PowerType.PowerType_Max)
         {
            this.mLastSpawnedPowerUpFrame[_loc1_] = this.mBoard.GetStateCount() - 1000;
            this.mLastCompletedPowerUpFrame[_loc1_] = this.mBoard.GetStateCount() - 1000;
            _loc1_++;
         }
         this.DeleteBalls();
         var _loc2_:int = this.mCurveDesc.mVals.mNumBalls > 0 && this.mCurveDesc.mVals.mNumBalls < 10 ? int(this.mCurveDesc.mVals.mNumBalls) : 10;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.AddPendingBall();
            _loc1_++;
         }
         this.mStopTime = 0;
         this.mSlowCount = 0;
         this.mBackwardCount = 0;
         this.mTotalBalls = _loc2_;
         this.mNumBallsCreated = this.mPendingBalls.size;
         this.mStopAddingBalls = false;
         this.mInDanger = false;
         this.mFirstChainEnd = 0;
         this.mFirstBallMovedBackwards = false;
         this.mApp.gDieAtEnd = !!this.mLevel.mLoopAtEnd ? false : Boolean(this.mCurveDesc.mVals.mDieAtEnd);
         this.RollBallsIn();
      }
      
      public function CheckGapShot(param1:Bullet) : Boolean
      {
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:WayPoint = null;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:DListIterator = null;
         var _loc17_:Ball = null;
         var _loc18_:Ball = null;
         var _loc19_:DListIterator = null;
         var _loc20_:Boolean = false;
         var _loc21_:Ball = null;
         var _loc2_:int = param1.GetRadius() * 2;
         var _loc3_:Number = param1.GetRadius();
         var _loc4_:Number = _loc3_ * _loc3_;
         var _loc5_:Number = param1.GetX();
         var _loc6_:Number = param1.GetY();
         var _loc10_:Vector.<WayPoint>;
         var _loc11_:int = (_loc10_ = this.mWayPointMgr.mWayPoints).length;
         var _loc12_:int;
         if((_loc12_ = param1.GetCurCurvePoint(this.mCurveNum)) > 0 && _loc12_ < _loc11_)
         {
            _loc7_ = (_loc9_ = _loc10_[_loc12_]).x - _loc5_;
            _loc8_ = _loc9_.y - _loc6_;
            if(_loc7_ * _loc7_ + _loc8_ * _loc8_ < _loc4_)
            {
               return false;
            }
            param1.SetCurCurvePoint(this.mCurveNum,0);
         }
         var _loc13_:int = 1;
         while(_loc13_ < _loc11_)
         {
            if(!(_loc9_ = _loc10_[_loc13_]).mInTunnel)
            {
               _loc7_ = _loc9_.x - _loc5_;
               _loc8_ = _loc9_.y - _loc6_;
               if(_loc7_ * _loc7_ + _loc8_ * _loc8_ < _loc4_)
               {
                  param1.SetCurCurvePoint(this.mCurveNum,_loc13_);
                  _loc14_ = 0;
                  _loc15_ = 0;
                  (_loc16_ = this.mBallList.getListIterator()).start();
                  while(_loc16_.valid())
                  {
                     if((_loc17_ = _loc16_.data).GetWayPoint() > _loc13_)
                     {
                        if((_loc18_ = _loc17_.GetPrevBall()) != null)
                        {
                           if(_loc17_.GetIsExploding())
                           {
                              (_loc19_ = new DListIterator(this.mBallList,_loc16_.node)).forth();
                              _loc20_ = false;
                              while(_loc19_.valid())
                              {
                                 if(!(_loc21_ = _loc19_.data).GetIsExploding())
                                 {
                                    _loc20_ = true;
                                    break;
                                 }
                                 _loc19_.forth();
                              }
                              if(!_loc20_)
                              {
                                 break;
                              }
                           }
                           _loc14_ = _loc17_.GetWayPoint() - _loc18_.GetWayPoint();
                           _loc15_ = _loc17_.GetId();
                        }
                        break;
                     }
                     _loc16_.forth();
                  }
                  if(_loc14_ > 0)
                  {
                     return param1.AddGapInfo(this.mCurveNum,_loc14_,_loc15_);
                  }
                  return false;
               }
            }
            _loc13_ += _loc2_;
         }
         return false;
      }
      
      public function UpdateForwardSuckingBalls() : void
      {
         var _loc2_:Ball = null;
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Ball = null;
         var _loc6_:Ball = null;
         var _loc7_:Ball = null;
         var _loc8_:Bullet = null;
         var _loc9_:Ball = null;
         var _loc10_:Boolean = false;
         var _loc11_:Number = NaN;
         var _loc1_:DListIterator = this.mBallList.getListIterator();
         _loc1_.end();
         while(true)
         {
            _loc2_ = _loc1_.data;
            _loc3_ = _loc2_.GetSuckCount();
            _loc4_ = (_loc3_ >> 3) * this.mSpeedScale;
            if(_loc2_.GetSuckCount() > 0)
            {
               while(true)
               {
                  (_loc5_ = _loc1_.data).SetSuckCount(0,false);
                  this.mWayPointMgr.SetWayPoint(_loc5_,_loc5_.GetWayPoint() + _loc4_,this.mLevel.mLoopAtEnd);
                  if((_loc8_ = _loc5_.GetBullet()) != null && !_loc8_.mDoNewMerge)
                  {
                     if((_loc9_ = _loc8_.GetPushBall()) != null)
                     {
                        this.mWayPointMgr.FindFreeWayPoint(_loc9_,_loc8_,false,this.mLevel.mLoopAtEnd);
                     }
                     _loc8_.UpdateHitPos();
                  }
                  if(!_loc5_.GetCollidesWithPrev())
                  {
                     break;
                  }
                  if(_loc1_.node == this.mBallList.head)
                  {
                     break;
                  }
                  _loc1_.back();
               }
               _loc6_ = _loc5_;
               _loc2_.SetSuckCount(_loc3_ + 1,false);
               if((_loc7_ = _loc2_.GetNextBall()) != null)
               {
                  _loc10_ = false;
                  _loc11_ = _loc2_.GetWayPoint() + _loc2_.GetRadius() + _loc7_.GetRadius();
                  if(_loc7_.GetWayPoint() < _loc11_)
                  {
                     this.mWayPointMgr.SetWayPoint(_loc7_,_loc11_,this.mLevel.mLoopAtEnd);
                     _loc10_ = true;
                  }
                  if(_loc10_)
                  {
                     this.mBoard.PlayBallClick(Zuma2Sounds.SOUND_BALL_CLICK1);
                     _loc7_.SetCollidesWithPrev(true);
                     _loc2_.SetSuckCount(0,true);
                     if(!this.CheckSet(_loc2_))
                     {
                        _loc2_.SetComboCount(0,0);
                     }
                     this.ClearPendingSucks(_loc6_);
                  }
               }
               else
               {
                  _loc2_.SetSuckCount(0,true);
               }
            }
            else
            {
               if(_loc1_.node == this.mBallList.head)
               {
                  break;
               }
               _loc1_.back();
            }
         }
      }
      
      public function GetCurveLength() : int
      {
         return this.mWayPointMgr.mWayPoints.length;
      }
      
      public function GetBoardStateCount() : int
      {
         return !!this.mBoard ? int(this.mBoard.GetStateCount()) : 0;
      }
      
      public function IsLosing() : Boolean
      {
         if(this.mHaveSets || this.mBallList.isEmpty() || this.mLevel.mLoopAtEnd || this.mBallList.tail.data.GetWayPoint() < this.mWayPointMgr.GetEndPoint() || !this.mBulletList.isEmpty() || this.mBackwardCount > 0)
         {
            return false;
         }
         var _loc1_:Ball = this.mBallList.tail.data;
         while(_loc1_ != null)
         {
            if(_loc1_.GetSuckCount() > 0)
            {
               return false;
            }
            _loc1_ = _loc1_.GetPrevBall(true);
         }
         return true;
      }
      
      public function DeleteBullet(param1:Bullet) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:DListIterator = this.mBulletList.nodeOf(param1);
         if(_loc2_.valid())
         {
            this.mBulletList.remove(_loc2_);
         }
         param1.Delete();
      }
      
      public function ActivatePower(param1:Ball) : void
      {
         var _loc2_:int = param1.GetPowerOrDestType();
         this.mApp.gGotPowerUp[_loc2_] = true;
         if(_loc2_ == PowerType.PowerType_ProximityBomb)
         {
            this.ActivateProximityBomb(param1);
         }
         else if(_loc2_ == PowerType.PowerType_MoveBackwards)
         {
            this.DoBackwards();
         }
         else if(_loc2_ == PowerType.PowerType_SlowDown)
         {
            this.DoSlowdown();
         }
      }
      
      public function AtRest() : Boolean
      {
         var _loc2_:Ball = null;
         if(this.mBallList.size == 0)
         {
            return true;
         }
         var _loc1_:DListIterator = this.mBallList.getListIterator();
         _loc1_.start();
         while(_loc1_.valid())
         {
            _loc2_ = _loc1_.data;
            if(_loc2_.GetIsExploding() || _loc2_.GetSuckCount() > 0 || _loc2_.GetBullet() != null)
            {
               return false;
            }
            _loc1_.forth();
         }
         return true;
      }
      
      public function AddPowerUp(param1:int) : Ball
      {
         var _loc2_:Vector.<Ball> = null;
         var _loc3_:Vector.<int> = null;
         var _loc4_:int = 0;
         var _loc5_:Ball = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:DListIterator = null;
         var _loc9_:Ball = null;
         if(!this.mApp.mLevelMgr.mUniquePowerupColor && param1 != PowerType.PowerType_GauntletMultBall)
         {
            return null;
         }
         _loc2_ = new Vector.<Ball>();
         _loc3_ = new Vector.<int>();
         _loc4_ = 0;
         while(_loc4_ < this.mCurveDesc.mVals.mNumColors)
         {
            if(this.mBallColorHasPowerup[_loc4_] == 0 || param1 == PowerType.PowerType_GauntletMultBall)
            {
               _loc3_.push(_loc4_);
            }
            _loc4_++;
         }
         _loc5_ = null;
         while(_loc3_.length > 0 && _loc5_ == null)
         {
            _loc6_ = Math.random() * _loc3_.length;
            _loc7_ = _loc3_[_loc6_];
            (_loc8_ = this.mBallList.getListIterator()).start();
            while(_loc8_.valid())
            {
               if((_loc9_ = _loc8_.data).GetPowerType() == PowerType.PowerType_None && _loc9_.GetDestPowerType() == PowerType.PowerType_None && _loc9_.GetColorType() == _loc7_ && !_loc9_.GetIsExploding())
               {
                  if(param1 != PowerType.PowerType_GauntletMultBall || param1 == PowerType.PowerType_GauntletMultBall && !this.mWayPointMgr.InTunnel2(_loc9_,true) && !this.mWayPointMgr.InTunnel2(_loc9_,false) && _loc9_.GetWayPoint() / this.mWayPointMgr.GetEndPoint() >= this.mApp.mLevelMgr.mMinMultBallDistance)
                  {
                     _loc2_.push(_loc9_);
                  }
                  else if(param1 == PowerType.PowerType_GauntletMultBall)
                  {
                  }
               }
               _loc8_.forth();
            }
            if(_loc2_.length == 0)
            {
               _loc3_.splice(_loc6_,1);
            }
            else if(_loc5_ == null)
            {
               _loc5_ = _loc2_[int(Math.random() * _loc2_.length)];
            }
         }
         if(_loc5_ != null)
         {
            _loc5_.SetPowerType(param1);
         }
         return _loc5_;
      }
      
      public function UpdateLosing() : void
      {
         var _loc3_:Ball = null;
         var _loc4_:int = 0;
         var _loc1_:DListIterator = this.mBallList.getListIterator();
         _loc1_.start();
         var _loc2_:int = this.mWayPointMgr.GetEndPoint();
         while(_loc1_.valid())
         {
            _loc3_ = _loc1_.data;
            if(_loc3_.GetWayPoint() >= _loc2_)
            {
               if((_loc4_ = _loc3_.GetSuckCount()) >= 0)
               {
                  _loc3_.Delete();
                  this.mBallList.remove(_loc1_);
                  _loc1_.forth();
                  continue;
               }
               _loc3_.SetSuckCount(_loc4_ + 1);
            }
            else
            {
               this.mWayPointMgr.SetWayPoint(_loc3_,_loc3_.GetWayPoint() + (_loc3_.GetSuckCount() >> 2),this.mLevel.mLoopAtEnd);
               _loc3_.SetSuckCount(_loc3_.GetSuckCount() + 1);
               if(_loc3_.GetWayPoint() >= _loc2_)
               {
                  _loc3_.SetSuckCount(0);
               }
            }
            _loc1_.forth();
         }
         if(!this.mBallList.isEmpty())
         {
            this.SetFarthestBall(this.mBallList.tail.data.GetWayPoint());
         }
      }
      
      public function DoScoring(param1:Ball, param2:int, param3:int, param4:int, param5:int) : void
      {
         var _loc13_:int = 0;
         var _loc14_:String = null;
         if(param2 == 0)
         {
            return;
         }
         var _loc6_:Number = 1.5;
         var _loc7_:Number = 1;
         var _loc8_:int = param2 * 10 + param4 + param3 * 100;
         var _loc9_:Boolean = false;
         var _loc10_:int = !!this.mApp.gSuckMode ? 10 : 4;
         var _loc11_:int = 0;
         if(this.mBoard.GetNumClearsInARow() > _loc10_ && param3 == 0)
         {
            _loc9_ = true;
            _loc11_ = (!!this.mApp.gSuckMode ? 10 : 100) + 10 * (this.mBoard.GetNumClearsInARow() - (_loc10_ + 1));
            _loc8_ += _loc11_;
            if(this.mLevel.AllowPointsFromBalls())
            {
               this.mBoard.IncCurInARowBonus(_loc11_);
            }
         }
         if(this.mLevel.AllowPointsFromBalls())
         {
            this.mBoard.IncCurComboScore(_loc8_);
            this.mBoard.IncScore(_loc8_,true);
            if(param3 > 0)
            {
               ++this.mBoard.mLevelStats.mNumCombos;
            }
            if(param4 > 0)
            {
               ++this.mBoard.mLevelStats.mNumGaps;
            }
         }
         var _loc12_:* = "";
         if(this.mLevel.AllowPointsFromBalls())
         {
            _loc12_ = "+" + _loc8_;
         }
         if(param3 > 0)
         {
            if(this.mLevel.AllowPointsFromBalls())
            {
               _loc6_ = 1.5;
               if((_loc7_ = 1 + (_loc6_ - 1) / 10 * (param3 + 1)) < 1)
               {
                  _loc7_ = 1;
               }
               _loc12_ += "\rCOMBO x" + (param3 + 1);
            }
         }
         if(param4 > 0)
         {
            if(this.mLevel.AllowPointsFromBalls())
            {
               if(param5 > 1)
               {
                  if(param5 > 3)
                  {
                     _loc12_ += "\rQUAD GAP BONUS!!!!";
                  }
                  else if(param5 > 2)
                  {
                     _loc12_ += "\rTRIPLE GAP BONUS!!!";
                  }
                  else
                  {
                     _loc12_ += "\rDOUBLE GAP BONUS!!";
                  }
               }
               else
               {
                  _loc12_ += "\rGAP BONUS!";
               }
            }
            this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_GAPBONUS1);
         }
         if(_loc9_ && this.mLevel.AllowPointsFromBalls())
         {
            _loc6_ = 1.5;
            if((_loc7_ = 1 + (_loc6_ - 1) / 10 * (this.mBoard.GetNumClearsInARow() + 1 - _loc10_)) < 1)
            {
               _loc7_ = 1;
            }
            if(_loc7_ > 1.5)
            {
               _loc7_ = 1.5;
            }
            _loc12_ += "\rCHAIN BONUS x" + (this.mBoard.GetNumClearsInARow() + 1);
            if((_loc13_ = this.mBoard.GetNumClearsInARow() - 5) > 10)
            {
               _loc13_ = 10;
            }
            _loc14_ = "SOUND_CHAIN" + _loc13_;
            this.mApp.soundManager.playSound(_loc14_);
         }
         this.mBoard.AddText(_loc12_,param1.GetX(),param1.GetY(),param1.GetColorType(),_loc7_);
      }
      
      public function ClearPendingSucks(param1:Ball) : void
      {
         var _loc2_:Ball = param1;
         var _loc3_:Boolean = true;
         while(_loc2_ != null)
         {
            if(_loc2_.GetSuckPending())
            {
               _loc2_.SetSuckPending(false);
               _loc2_.SetGapBonus(0,0);
            }
            _loc2_ = _loc2_.GetPrevBall();
            if(_loc2_ == null)
            {
               break;
            }
            if(!_loc2_.GetCollidesWithNext())
            {
               _loc3_ = false;
            }
            if(!_loc3_ && _loc2_.GetSuckCount())
            {
               break;
            }
         }
      }
      
      public function UpdateSets() : void
      {
         var _loc2_:Ball = null;
         var _loc3_:Boolean = false;
         var _loc4_:Ball = null;
         var _loc5_:Ball = null;
         this.mHaveSets = false;
         var _loc1_:DListIterator = this.mBallList.getListIterator();
         _loc1_.start();
         while(_loc1_.valid())
         {
            _loc2_ = _loc1_.data;
            _loc3_ = _loc2_.GetIsExploding();
            if(_loc3_)
            {
               this.mHaveSets = true;
            }
            if(_loc2_.GetShouldRemove())
            {
               _loc4_ = _loc2_.GetNextBall();
               _loc5_ = _loc2_.GetPrevBall();
               if(_loc4_ != null && !_loc4_.GetIsExploding())
               {
                  if(_loc5_ != null && !_loc5_.GetShouldRemove() && _loc4_.GetColorType() == _loc5_.GetColorType())
                  {
                     _loc4_.SetSuckCount(10);
                     _loc4_.SetComboCount(_loc2_.GetComboCount() + 1,_loc2_.GetComboScore());
                  }
               }
               if(_loc1_.node == this.mBallList.head)
               {
                  this.mAdvanceSpeed = 0;
                  if(this.mStopTime < 40)
                  {
                     this.mStopTime = 40;
                  }
               }
               this.DeleteBall(_loc2_);
               this.mBallList.remove(_loc1_);
            }
            else
            {
               if(_loc3_)
               {
                  _loc2_.UpdateExplosion();
               }
               else
               {
                  ++this.mBoard.mBallColorMap[_loc2_.GetColorType()];
               }
               _loc1_.forth();
            }
         }
      }
      
      public function SetFarthestBall(param1:int) : void
      {
         if(this.mBoard.GetGameState() == GameBoardWidget.GameState_Losing)
         {
            return;
         }
         var _loc2_:int = this.mDangerPoint;
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         var _loc3_:Number = 0;
         if(param1 >= _loc2_)
         {
            _loc3_ = Number(param1 - _loc2_) / (this.mWayPointMgr.GetNumPoints() - _loc2_);
         }
         this.mLevel.mHoleMgr.SetPctOpen(this.mCurveNum,_loc3_);
      }
      
      public function IsWinning() : Boolean
      {
         var _loc1_:Boolean = this.mBallList.isEmpty() && this.mPendingBalls.isEmpty();
         if(_loc1_)
         {
            return true;
         }
         return false;
      }
      
      public function UpdateBalls() : void
      {
         var _loc3_:Ball = null;
         var _loc1_:DListIterator = this.mBallList.getListIterator();
         var _loc2_:int = 0;
         _loc1_.start();
         while(_loc1_.valid())
         {
            _loc2_++;
            _loc3_ = _loc1_.data;
            _loc3_.Update();
            _loc1_.forth();
         }
         _loc1_ = this.mBulletList.getListIterator();
         _loc1_.start();
         while(_loc1_.valid())
         {
            _loc1_.data.Update();
            _loc1_.forth();
         }
      }
      
      public function DoSlowdown() : void
      {
         if(this.mSlowCount < 1000)
         {
            this.mSlowCount = 800;
         }
      }
      
      public function AddPendingBall() : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:Ball = new Ball(this.mApp);
         var _loc3_:int = this.mCurveDesc.mVals.mNumColors;
         if(!this.mPendingBalls.isEmpty())
         {
            _loc4_ = this.mPendingBalls.tail.data.GetColorType();
         }
         else if(!this.mBallList.isEmpty())
         {
            _loc4_ = this.mBallList.head.data.GetColorType();
         }
         else
         {
            _loc4_ = this.mLevel.GetRandomPendingBallColor(_loc3_);
         }
         if(_loc4_ >= _loc3_)
         {
            _loc4_ = this.mLevel.GetRandomPendingBallColor(_loc3_);
         }
         var _loc5_:int = this.GetNumPendingMatches();
         var _loc6_:int = 33;
         var _loc7_:int = 4;
         var _loc8_:int = this.mCurveDesc.mVals.mMaxSingle;
         if(Math.round(Math.random()) * 100 <= this.mCurveDesc.mVals.mBallRepeat && _loc5_ < this.mCurveDesc.mVals.mMaxClumpSize)
         {
            _loc2_ = _loc4_;
         }
         else if(_loc8_ < 10 && this.GetNumPendingSingles(1) == 1 && (_loc8_ == 0 || this.GetNumPendingSingles(10) > _loc8_))
         {
            _loc2_ = _loc4_;
         }
         else
         {
            do
            {
               _loc2_ = this.mLevel.GetRandomPendingBallColor(_loc3_);
            }
            while(_loc2_ == _loc4_);
            
         }
         _loc1_.SetColorType(_loc2_);
         _loc2_ = _loc1_.GetColorType();
         this.mPendingBalls.append(_loc1_);
         ++this.mNumBallsCreated;
         if(this.mCurveDesc.mVals.mNumBalls > 0 && this.mNumBallsCreated >= this.mCurveDesc.mVals.mNumBalls)
         {
            this.mStopAddingBalls = true;
         }
      }
      
      public function AdvanceBackwardBalls() : void
      {
         var _loc4_:Ball = null;
         var _loc5_:int = 0;
         var _loc6_:Ball = null;
         var _loc7_:Number = NaN;
         this.mFirstBallMovedBackwards = false;
         if(this.mBallList.isEmpty())
         {
            return;
         }
         var _loc1_:DListIterator = this.mBallList.getListIterator();
         _loc1_.end();
         var _loc2_:Boolean = false;
         var _loc3_:Number = 0;
         if(this.mBackwardCount)
         {
            this.mBallList.tail.data.SetBackwardsSpeed(1 * this.mSpeedScale);
            this.mBallList.tail.data.SetBackwardsCount(1);
         }
         while(true)
         {
            if((_loc5_ = (_loc4_ = _loc1_.data).GetBackwardsCount()) > 0)
            {
               _loc3_ = _loc4_.GetBackwardsSpeed();
               this.mWayPointMgr.SetWayPoint(_loc4_,_loc4_.GetWayPoint() - _loc3_,this.mLevel.mLoopAtEnd);
               _loc4_.SetBackwardsCount(_loc5_ - 1);
               _loc2_ = true;
            }
            if(_loc1_.node == this.mBallList.head)
            {
               break;
            }
            _loc1_.back();
            _loc6_ = _loc1_.data;
            if(_loc2_)
            {
               if(_loc6_.GetCollidesWithNext())
               {
                  this.mWayPointMgr.SetWayPoint(_loc6_,_loc6_.GetWayPoint() - _loc3_,this.mLevel.mLoopAtEnd);
               }
               else
               {
                  _loc7_ = _loc4_.GetWayPoint() - _loc4_.GetRadius() - _loc6_.GetRadius();
                  if(_loc6_.GetWayPoint() > _loc7_)
                  {
                     _loc2_ = true;
                     if(!_loc6_.GetCollidesWithNext())
                     {
                        _loc6_.SetCollidesWithNext(true);
                        this.mBoard.PlayBallClick(Zuma2Sounds.SOUND_BALL_CLICK1);
                     }
                     _loc3_ = _loc6_.GetWayPoint() - _loc7_;
                     _loc6_.SetWayPoint(_loc7_,this.mWayPointMgr.InTunnel(_loc7_));
                  }
                  else
                  {
                     _loc2_ = false;
                  }
               }
            }
         }
         if(_loc2_)
         {
            this.mFirstBallMovedBackwards = true;
            if(this.mStopTime < 20)
            {
               this.mStopTime = 20;
            }
         }
      }
      
      public function HasReachedRolloutPoint() : Boolean
      {
         return this.mHasReachedRolloutPoint;
      }
      
      public function UpdatePowerUps() : void
      {
         var _loc1_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:Boolean = false;
         var _loc12_:int = 0;
         if(this.mBallList.isEmpty() || this.mBoard.mPreventBallAdvancement)
         {
            return;
         }
         var _loc2_:int = this.mBoard.GetStateCount();
         if(_loc2_ < this.mApp.mLevelMgr.mPowerDelay)
         {
            return;
         }
         var _loc3_:int = this.mApp.mLevelMgr.mPowerupSpawnDelay;
         if(_loc3_ > 0 && _loc2_ - this.mLastPowerupTime < _loc3_)
         {
            return;
         }
         var _loc4_:int;
         if((_loc4_ = this.mCurveDesc.mVals.mPowerUpChance) == 0)
         {
            return;
         }
         if((_loc4_ -= _loc4_ * this.mLevel.GetPowerIncPct()) <= 0)
         {
            _loc4_ = 1;
         }
         if(this.mApp.mLevelMgr.mUniquePowerupColor)
         {
            _loc5_ = 0;
            _loc1_ = 0;
            while(_loc1_ < this.mCurveDesc.mVals.mNumColors)
            {
               if(this.mBallColorHasPowerup[_loc1_] > 0)
               {
                  _loc5_++;
               }
               _loc1_++;
            }
            if(_loc5_ == this.mCurveDesc.mVals.mNumColors)
            {
               return;
            }
         }
         if(int(Math.random() * _loc4_) == 0)
         {
            _loc6_ = 0;
            _loc1_ = 0;
            while(_loc1_ < PowerType.PowerType_Max)
            {
               if(this.CanSpawnPowerUp(_loc1_))
               {
                  _loc6_ += this.mCurveDesc.mVals.mPowerUpFreq[_loc1_];
               }
               _loc1_++;
            }
            if(_loc6_ == 0)
            {
               return;
            }
            _loc7_ = Math.random() * _loc6_;
            _loc8_ = 0;
            _loc1_ = 0;
            while(_loc1_ < PowerType.PowerType_Max)
            {
               if(this.CanSpawnPowerUp(_loc1_))
               {
                  _loc9_ = this.mCurveDesc.mVals.mPowerUpFreq[_loc1_];
                  if(_loc7_ < _loc8_ + _loc9_)
                  {
                     _loc10_ = this.mLastSpawnedPowerUpFrame[_loc1_];
                     _loc11_ = false;
                     _loc12_ = this.mApp.mLevelMgr.mPowerCooldown;
                     if(_loc2_ - _loc10_ < _loc12_)
                     {
                        return;
                     }
                     if(_loc2_ - this.mLastCompletedPowerUpFrame[_loc1_] < _loc12_ && this.mLastCompletedPowerUpFrame[_loc1_] > 0)
                     {
                        return;
                     }
                     this.AddPowerUp(_loc1_);
                     this.mLastPowerupTime = _loc2_;
                     this.mLastSpawnedPowerUpFrame[_loc1_] = _loc2_;
                     ++this.mNumPowerUpsThisLevel[_loc1_];
                     break;
                  }
                  _loc8_ += _loc9_;
               }
               _loc1_++;
            }
         }
      }
      
      public function GetDistanceToDeath() : int
      {
         if(!this.mInDanger || this.mBallList.isEmpty())
         {
            return -1;
         }
         var _loc1_:int = this.mWayPointMgr.GetNumPoints() - this.mBallList.tail.data.GetWayPoint();
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         return _loc1_;
      }
   }
}
