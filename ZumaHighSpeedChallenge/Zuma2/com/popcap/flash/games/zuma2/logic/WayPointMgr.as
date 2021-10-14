package com.popcap.flash.games.zuma2.logic
{
   import flash.geom.Point;
   
   public class WayPointMgr
   {
       
      
      public var mDoorX:int;
      
      public var mWayPoints:Vector.<WayPoint>;
      
      public var v1:SexyVector3;
      
      public var mApp:Zuma2App;
      
      public var v3:SexyVector3;
      
      public var mDoorY:int;
      
      public function WayPointMgr(param1:Zuma2App)
      {
         this.mWayPoints = new Vector.<WayPoint>();
         this.v3 = new SexyVector3(0,0,0);
         this.v1 = new SexyVector3(1,0,0);
         super();
         this.mApp = param1;
      }
      
      public function SetWayPoint(param1:Ball, param2:Number, param3:Boolean) : void
      {
         var _loc5_:int = 0;
         var _loc11_:Number = NaN;
         if(this.mWayPoints.length == 0)
         {
            return;
         }
         var _loc4_:int;
         if((_loc4_ = int(param2)) < 0)
         {
            _loc4_ = 0;
            _loc5_ = 1;
         }
         else if(_loc4_ >= int(this.mWayPoints.length))
         {
            if(!param3)
            {
               _loc5_ = (_loc4_ = int(this.mWayPoints.length - 1)) + 1;
            }
            else
            {
               _loc4_ = int(param2) % int(this.mWayPoints.length);
               _loc5_ = int(param2 + 1) % int(this.mWayPoints.length);
            }
         }
         else
         {
            _loc5_ = _loc4_ + 1;
         }
         var _loc6_:WayPoint;
         var _loc7_:WayPoint = _loc6_ = this.mWayPoints[_loc4_];
         if(_loc5_ < int(this.mWayPoints.length))
         {
            _loc7_ = this.mWayPoints[_loc5_];
         }
         var _loc8_:Number = param1.GetX();
         var _loc9_:Number = param1.GetY();
         if(Math.abs(_loc7_.x - _loc6_.x) > 5 || Math.abs(_loc7_.y - _loc6_.y) > 5)
         {
            param1.SetPos(_loc6_.x,_loc6_.y);
         }
         else
         {
            _loc11_ = param2 - int(param2);
            param1.SetPos(_loc11_ * (_loc7_.x - _loc6_.x) + _loc6_.x,_loc11_ * (_loc7_.y - _loc6_.y) + _loc6_.y);
         }
         var _loc10_:* = Math.abs(param1.GetX() - _loc8_) + Math.abs(param1.GetY() - _loc9_) > 10;
         this.CalcAvgRotationForPoint(_loc4_);
         param1.SetRotation(_loc6_.mAvgRotation,_loc10_);
         param1.SetWayPoint(param2,_loc6_.mInTunnel);
         param1.SetPriority(_loc6_.mPriority);
      }
      
      public function LoadCurve(param1:String, param2:CurveDesc) : void
      {
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:WayPoint = null;
         this.mWayPoints = new Vector.<WayPoint>();
         var _loc3_:CurveData = new CurveData(this.mApp);
         _loc3_.Load(param1);
         param2.GetValuesFrom(_loc3_);
         var _loc4_:Vector.<PathPoint> = _loc3_.mPointList;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = _loc4_[0];
         var _loc7_:int = 15;
         var _loc8_:int = 0;
         while(_loc8_ < _loc4_.length)
         {
            _loc9_ = _loc4_[_loc8_].x;
            _loc10_ = _loc4_[_loc8_].x;
            if(!_loc5_ && _loc9_ >= 0 && _loc10_ >= 0 && _loc9_ <= 540 && _loc10_ <= 405)
            {
               this.mDoorX = _loc9_;
               this.mDoorY = _loc10_;
               _loc5_ = true;
            }
            (_loc11_ = new WayPoint(_loc4_[_loc8_].x,_loc4_[_loc8_].y)).mInTunnel = _loc4_[_loc8_].mInTunnel;
            _loc11_.mPriority = _loc4_[_loc8_].mPriority;
            this.mWayPoints.push(_loc11_);
            if(_loc6_ && _loc4_[_loc8_].mInTunnel)
            {
               _loc7_ = this.mWayPoints.length;
            }
            else
            {
               _loc6_ = false;
            }
            _loc8_++;
         }
         param2.mCutoffPoint = _loc7_ - 18;
      }
      
      public function GetEndPoint() : int
      {
         return int(this.mWayPoints.length - 1);
      }
      
      public function InTunnel2(param1:Ball, param2:Boolean) : Boolean
      {
         var _loc3_:int = param1.GetWayPoint();
         if(param2)
         {
            _loc3_ += param1.GetRadius();
         }
         else
         {
            _loc3_ -= param1.GetRadius();
         }
         if(this.InTunnel(_loc3_))
         {
            return true;
         }
         return false;
      }
      
      public function InTunnel(param1:int) : Boolean
      {
         if(param1 < 0)
         {
            return true;
         }
         if(param1 >= this.mWayPoints.length)
         {
            return false;
         }
         return this.mWayPoints[param1].mInTunnel;
      }
      
      public function CheckDiscontinuity(param1:int, param2:int) : Boolean
      {
         var _loc6_:WayPoint = null;
         var _loc7_:Number = NaN;
         var _loc3_:int = param1;
         var _loc4_:int = param1 + param2;
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         if(_loc3_ > this.mWayPoints.length)
         {
            _loc3_ = this.mWayPoints.length;
         }
         if(_loc4_ < 0)
         {
            _loc4_ = 0;
         }
         if(_loc4_ > this.mWayPoints.length)
         {
            _loc4_ = this.mWayPoints.length;
         }
         if(_loc3_ >= _loc4_)
         {
            return false;
         }
         var _loc5_:WayPoint = this.mWayPoints[_loc3_++];
         while(_loc3_ < _loc4_)
         {
            _loc6_ = this.mWayPoints[_loc3_];
            if((_loc7_ = Math.abs(_loc5_.x - _loc6_.x) + Math.abs(_loc5_.y - _loc6_.y)) > 10)
            {
               return true;
            }
            _loc5_ = _loc6_;
            _loc3_++;
         }
         return false;
      }
      
      public function GetPointPos(param1:Number) : Point
      {
         var _loc2_:int = int(param1);
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         else if(_loc2_ >= int(this.mWayPoints.length))
         {
            _loc2_ = int(this.mWayPoints.length) - 1;
         }
         var _loc3_:WayPoint = this.mWayPoints[_loc2_];
         return new Point(_loc3_.x,_loc3_.y);
      }
      
      public function GetCanonicalAngle(param1:Number) : Number
      {
         if(param1 > 0)
         {
            while(param1 > Zuma2App.MY_PI)
            {
               param1 -= 2 * Zuma2App.MY_PI;
            }
         }
         else if(param1 < 0)
         {
            while(param1 < -Zuma2App.MY_PI)
            {
               param1 += 2 * Zuma2App.MY_PI;
            }
         }
         return param1;
      }
      
      public function CalcPerpendicularForPoint(param1:int) : void
      {
         var _loc2_:WayPoint = this.mWayPoints[param1];
         if(_loc2_.mHavePerpendicular)
         {
            return;
         }
         var _loc3_:WayPoint = _loc2_;
         var _loc4_:Boolean = false;
         if(param1 + 1 < int(this.mWayPoints.length))
         {
            _loc3_ = this.mWayPoints[param1 + 1];
            if(Math.abs(_loc2_.x - _loc3_.x) > 5 || Math.abs(_loc2_.y - _loc3_.y) > 5 && param1 > 0)
            {
               _loc4_ = true;
               _loc3_ = this.mWayPoints[param1 - 1];
            }
         }
         else
         {
            _loc3_ = this.mWayPoints[param1 - 1];
            if((Math.abs(_loc2_.x - _loc3_.x) > 5 || Math.abs(_loc2_.y - _loc3_.y) > 5) && param1 + 1 < int(this.mWayPoints.length))
            {
               _loc3_ = this.mWayPoints[param1 + 1];
            }
            else
            {
               _loc4_ = true;
            }
         }
         if(_loc4_)
         {
            this.v3.x = _loc2_.y - _loc3_.y;
            this.v3.y = _loc3_.x - _loc2_.x;
            this.v3.z = 0;
            this.v3 = this.v3.Normalize();
            _loc2_.mPerpendicular = this.v3;
         }
         else
         {
            this.v3.x = _loc3_.y - _loc2_.y;
            this.v3.y = _loc2_.x - _loc3_.x;
            this.v3.z = 0;
            this.v3 = this.v3.Normalize();
            _loc2_.mPerpendicular = this.v3;
         }
         _loc2_.mRotation = Math.acos(_loc2_.mPerpendicular.Dot(this.v1));
         if(_loc2_.mPerpendicular.y > 0)
         {
            _loc2_.mRotation *= -1;
         }
         if(_loc2_.mRotation < 0)
         {
            _loc2_.mRotation += 2 * Zuma2App.MY_PI;
         }
         _loc2_.mHavePerpendicular = true;
      }
      
      public function CalcAvgRotationForPoint(param1:int) : void
      {
         var _loc5_:int = 0;
         var _loc7_:WayPoint = null;
         var _loc8_:WayPoint = null;
         var _loc9_:Number = NaN;
         var _loc2_:WayPoint = this.mWayPoints[param1];
         if(_loc2_.mHaveAvgRotation)
         {
            return;
         }
         this.CalcPerpendicularForPoint(param1);
         _loc2_.mHaveAvgRotation = true;
         _loc2_.mAvgRotation = _loc2_.mRotation;
         var _loc3_:int = param1 - 10;
         var _loc4_:int = param1 + 10;
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         if(_loc4_ >= int(this.mWayPoints.length))
         {
            _loc4_ = int(this.mWayPoints.length) - 1;
         }
         var _loc6_:Number = 0;
         this.CalcPerpendicularForPoint(_loc3_);
         _loc5_ = _loc3_ + 1;
         for(; _loc5_ < _loc4_; _loc5_++)
         {
            this.CalcPerpendicularForPoint(_loc5_);
            if((_loc6_ = this.GetCanonicalAngle(this.mWayPoints[_loc5_].mRotation - this.mWayPoints[_loc5_ - 1].mRotation)) > 0.1 || _loc6_ < -0.1)
            {
               _loc7_ = this.mWayPoints[_loc5_];
               _loc8_ = this.mWayPoints[_loc5_ - 1];
               if(!(Math.abs(_loc7_.x - _loc8_.x) > 5 || Math.abs(_loc7_.y - _loc8_.y) > 5))
               {
                  _loc9_ = 1 - Number(_loc5_ - _loc3_) / (_loc4_ - _loc3_);
                  _loc2_.mAvgRotation = this.mWayPoints[_loc3_].mRotation + _loc9_ * _loc6_;
               }
               continue;
               return;
            }
         }
      }
      
      public function FindFreeWayPoint(param1:Ball, param2:Ball, param3:Boolean, param4:Boolean = false, param5:int = 0) : void
      {
         var _loc9_:int = 0;
         var _loc6_:int = !!param3 ? 1 : -1;
         var _loc7_:int = int(param1.GetWayPoint());
         if(param3 && param2.GetWayPoint() > _loc7_)
         {
            _loc7_ = int(param2.GetWayPoint());
         }
         else if(!param3 && param2.GetWayPoint() < _loc7_)
         {
            _loc7_ = int(param2.GetWayPoint());
         }
         var _loc8_:WayPoint = null;
         while(_loc7_ >= 0 && (param4 || _loc7_ < int(this.mWayPoints.length)))
         {
            _loc8_ = this.mWayPoints[_loc7_ % int(this.mWayPoints.length)];
            param2.SetPos(_loc8_.x,_loc8_.y);
            if(!param1.CollidesWithPhysically(param2,param5))
            {
               break;
            }
            _loc9_ = _loc7_ % int(this.mWayPoints.length);
            _loc7_ += _loc6_;
            if(param4 && _loc9_ + _loc6_ < 0)
            {
               _loc7_ -= _loc6_;
               break;
            }
         }
         this.SetWayPointInt(param2,_loc7_,param4);
      }
      
      public function GetPriority(param1:int) : int
      {
         if(param1 < 0 || param1 >= int(this.mWayPoints.length))
         {
            return 0;
         }
         return this.mWayPoints[param1].mPriority;
      }
      
      public function SetWayPointInt(param1:Ball, param2:int, param3:Boolean) : void
      {
         if(this.mWayPoints.length == 0)
         {
            return;
         }
         var _loc4_:int;
         if((_loc4_ = param2) < 0)
         {
            _loc4_ = 0;
         }
         else if(_loc4_ >= int(this.mWayPoints.length))
         {
            if(param3)
            {
               _loc4_ = int(param2) % int(this.mWayPoints.length);
            }
            else
            {
               _loc4_ = int(this.mWayPoints.length) - 1;
            }
         }
         var _loc5_:WayPoint = this.mWayPoints[_loc4_];
         this.CalcAvgRotationForPoint(_loc4_);
         param1.SetPos(_loc5_.x,_loc5_.y);
         param1.SetWayPoint(param2,_loc5_.mInTunnel);
         param1.SetRotation(_loc5_.mAvgRotation,false);
      }
      
      public function GetNumPoints() : int
      {
         return this.mWayPoints.length;
      }
      
      public function CalcPerpendicular(param1:Number) : SexyVector3
      {
         var _loc2_:int = int(param1);
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         if(_loc2_ >= int(this.mWayPoints.length))
         {
            _loc2_ = int(this.mWayPoints.length - 1);
         }
         var _loc3_:WayPoint = this.mWayPoints[_loc2_];
         this.CalcPerpendicularForPoint(_loc2_);
         return _loc3_.mPerpendicular;
      }
      
      public function GetRotationForPoint(param1:int) : Number
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 >= this.mWayPoints.length - 1)
         {
            param1 = this.mWayPoints.length - 1;
         }
         var _loc2_:WayPoint = this.mWayPoints[param1];
         this.CalcPerpendicularForPoint(param1);
         return _loc2_.mRotation;
      }
   }
}
