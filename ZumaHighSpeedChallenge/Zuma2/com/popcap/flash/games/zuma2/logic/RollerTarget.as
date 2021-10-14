package com.popcap.flash.games.zuma2.logic
{
   public class RollerTarget
   {
       
      
      public var mRestingY:int;
      
      public var mX:Number;
      
      public var mVY:Number;
      
      public var mY:Number;
      
      public var mApp:Zuma2App;
      
      public var mNum:int;
      
      public var mBounceState:int;
      
      public var mDelay:int;
      
      public function RollerTarget(param1:Zuma2App)
      {
         super();
         this.mApp = param1;
         this.mNum = -1;
         this.mX = 0;
         this.mY = 0;
      }
   }
}
