package com.popcap.flash.games.zuma2.logic
{
   import flash.geom.Point;
   
   public class ReversePowerEffect extends PowerEffect
   {
       
      
      public var mCurve:CurveMgr;
      
      public var mStartWaypoint:Number;
      
      public var mRotation:Number;
      
      public var mWaypoint:Number;
      
      public var mScale:Number;
      
      public function ReversePowerEffect(param1:Zuma2App, param2:Ball, param3:Number = 0, param4:Number = 0)
      {
         super(param1,param3,param4);
         this.mCurve = param2.mCurve;
         this.mStartWaypoint = this.mWaypoint = param2.GetWayPoint();
         var _loc5_:Point = this.mCurve.mWayPointMgr.GetPointPos(this.mWaypoint);
         mX = _loc5_.x;
         mY = _loc5_.y;
         this.mRotation = this.mCurve.mWayPointMgr.GetRotationForPoint(this.mWaypoint);
      }
      
      override public function Draw() : void
      {
         var _loc4_:EffectItem = null;
         if(this.IsDone())
         {
            return;
         }
         var _loc1_:int = !!mDrawReverse ? int(mItems.length - 1) : 0;
         var _loc2_:int = !!mDrawReverse ? 0 : int(mItems.length);
         var _loc3_:int = _loc1_;
         while(!!mDrawReverse ? _loc3_ >= _loc2_ : _loc3_ < _loc2_)
         {
            (_loc4_ = mItems[_loc3_]).mSprite.alpha = GetComponentValue(_loc4_.mOpacity,255,mUpdateCount) / 255;
            if(_loc4_.mSprite.alpha != 0)
            {
               _loc4_.mSprite.scaleX = !!mDone ? Number(this.mScale) : Number(GetComponentValue(_loc4_.mScale,1,mUpdateCount));
               _loc4_.mSprite.scaleY = !!mDone ? Number(this.mScale) : Number(GetComponentValue(_loc4_.mScale,1,mUpdateCount));
               _loc4_.mSprite.rotation = -this.mRotation * Zuma2App.RAD_TO_DEG;
               _loc4_.mSprite.x = mX * Zuma2App.SHRINK_PERCENT;
               _loc4_.mSprite.y = mY * Zuma2App.SHRINK_PERCENT;
            }
            _loc3_ += !!mDrawReverse ? -1 : 1;
         }
      }
      
      override public function Update() : void
      {
         var _loc2_:Point = null;
         if(this.IsDone())
         {
            return;
         }
         super.Update();
         var _loc1_:Boolean = mDone;
         if(!_loc1_)
         {
            return;
         }
         this.mWaypoint -= 20;
         _loc2_ = this.mCurve.mWayPointMgr.GetPointPos(this.mWaypoint);
         mX = _loc2_.x;
         mY = _loc2_.y;
         this.mRotation = this.mCurve.mWayPointMgr.GetRotationForPoint(this.mWaypoint);
         this.mScale = this.mWaypoint / this.mStartWaypoint;
         if(this.mScale < 0)
         {
            mDone = true;
         }
      }
      
      override public function IsDone() : Boolean
      {
         return mDone && this.mWaypoint < 0;
      }
   }
}
