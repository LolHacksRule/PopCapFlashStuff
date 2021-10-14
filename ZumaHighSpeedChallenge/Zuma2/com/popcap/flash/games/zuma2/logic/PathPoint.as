package com.popcap.flash.games.zuma2.logic
{
   public class PathPoint
   {
       
      
      public var mSplinePoint:Boolean;
      
      public var mEndPoint:Boolean;
      
      public var mSelected:Boolean;
      
      public var mPriority:int;
      
      public var mDist:Number;
      
      public var t:Number;
      
      public var x:Number;
      
      public var y:Number;
      
      public var mInTunnel:Boolean;
      
      public function PathPoint(param1:Number = 0, param2:Number = 0, param3:Number = 0)
      {
         super();
         this.x = param1;
         this.y = param2;
         this.mDist = param3;
         this.mInTunnel = false;
         this.mSelected = false;
         this.mPriority = 0;
         this.mEndPoint = false;
         this.t = 0;
         this.mSplinePoint = false;
      }
   }
}
