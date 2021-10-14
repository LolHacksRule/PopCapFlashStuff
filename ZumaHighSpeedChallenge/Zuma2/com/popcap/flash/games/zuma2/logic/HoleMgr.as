package com.popcap.flash.games.zuma2.logic
{
   import com.popcap.flash.framework.Canvas;
   
   public class HoleMgr
   {
      
      public static const HOLE_SIZE:int = 0;
       
      
      public var mApp:Zuma2App;
      
      public var mHoles:Array;
      
      public var mNumHoles:int;
      
      public var v1:SexyVector3;
      
      public function HoleMgr(param1:Zuma2App)
      {
         this.mHoles = new Array();
         this.v1 = new SexyVector3(0,0,0);
         super();
         this.mApp = param1;
         this.mNumHoles = 0;
      }
      
      public function Draw(param1:Canvas) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.mNumHoles)
         {
            if(this.mHoles[_loc2_].mVisible)
            {
               this.mHoles[_loc2_].Draw(param1);
            }
            _loc2_++;
         }
      }
      
      public function PlaceHole(param1:int, param2:int, param3:int, param4:Number, param5:Boolean = true) : int
      {
         var _loc6_:SexyVector3 = new SexyVector3(param2,param3,param4);
         this.SetupHole(_loc6_);
         var _loc7_:Hole;
         (_loc7_ = new Hole(this.mApp)).mX = _loc6_.x;
         _loc7_.mY = _loc6_.y;
         _loc7_.mFrame = 0;
         _loc7_.mRotation = _loc6_.z;
         _loc7_.mPercentOpen = 0;
         _loc7_.mVisible = param5;
         _loc7_.mCurve = null;
         _loc7_.mCurveNum = param1;
         _loc7_.SetPos();
         this.mHoles[this.mNumHoles] = _loc7_;
         ++this.mNumHoles;
         return this.mNumHoles - 1;
      }
      
      public function Update() : void
      {
         var _loc2_:Hole = null;
         var _loc3_:int = 0;
         var _loc4_:Hole = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.mNumHoles)
         {
            _loc2_ = this.mHoles[_loc1_];
            _loc3_ = 0;
            while(_loc3_ < _loc2_.mShared.length)
            {
               _loc4_ = this.mHoles[_loc2_.mShared[_loc3_]];
               if(_loc2_.GetPctOpen() > _loc4_.GetPctOpen())
               {
                  _loc4_.SetPctOpen(_loc2_.GetPctOpen());
               }
               _loc3_++;
            }
            _loc2_.Update();
            _loc1_++;
         }
      }
      
      public function SetPctOpen(param1:int, param2:Number) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Hole = null;
         this.mHoles[param1].SetPctOpen(param2);
         var _loc3_:Hole = this.mHoles[param1];
         if(!_loc3_.mVisible)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_.mShared.length)
            {
               _loc5_ = this.mHoles[_loc3_.mShared[_loc4_]];
               if(_loc3_.GetPctOpen() > _loc5_.GetPctOpen())
               {
                  _loc5_.SetPctOpen(_loc3_.GetPctOpen());
               }
               _loc4_++;
            }
         }
      }
      
      public function UpdateHoleInfo(param1:int, param2:int, param3:int, param4:Number, param5:Boolean = true) : void
      {
         var _loc6_:Hole = this.mHoles[param1];
         this.v1.x = 0;
         this.v1.y = 0;
         this.v1.z = 0;
         this.SetupHole(this.v1);
         _loc6_.mX = this.v1.x;
         _loc6_.mY = this.v1.y;
         _loc6_.mRotation = this.v1.z;
         _loc6_.mVisible = param5;
      }
      
      public function SetupHole(param1:SexyVector3) : void
      {
         param1.x -= HOLE_SIZE / 2;
         param1.y -= HOLE_SIZE / 2;
         while(param1.z < 0)
         {
            param1.z += 2 * Zuma2App.MY_PI;
         }
         while(param1.z > 2 * Zuma2App.MY_PI)
         {
            param1.z -= 2 * Zuma2App.MY_PI;
         }
         if(Math.abs(param1.z) < 0.2)
         {
            param1.z = 0;
         }
         else if(Math.abs(param1.z - Zuma2App.MY_PI / 2) < 0.2)
         {
            param1.z = Zuma2App.MY_PI / 2;
         }
         else if(Math.abs(param1.z - Zuma2App.MY_PI) < 0.2)
         {
            param1.z = Zuma2App.MY_PI;
         }
         else if(Math.abs(param1.z - 3 * Zuma2App.MY_PI / 2) < 0.2)
         {
            param1.z = 3 * Zuma2App.MY_PI / 2;
         }
         else if(Math.abs(param1.z - 2 * Zuma2App.MY_PI) < 0.2)
         {
            param1.z = 0;
         }
      }
      
      public function DrawRings(param1:Canvas) : void
      {
      }
   }
}
