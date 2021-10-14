package com.popcap.flash.games.zuma2.logic
{
   import com.popcap.flash.framework.resources.images.ImageInst;
   import flash.geom.Point;
   
   public class FrogBody
   {
       
      
      public var mType:int;
      
      public var mLegsImage:ImageInst;
      
      public var mTongueImage:ImageInst;
      
      public var mMouthOffset:Point;
      
      public var mNextBallX:int;
      
      public var mCel:int;
      
      public var mMouthImage:ImageInst;
      
      public var mBodyOffset:Point;
      
      public var mCY:int;
      
      public var mLegsOffset:Point;
      
      public var mTongueX:Number;
      
      public var mEyesOffset:Point;
      
      public var mLazerEyeLoopImage:ImageInst;
      
      public var mBodyImage:ImageInst;
      
      public var mShadowImage:ImageInst;
      
      public var mCX:int;
      
      public var mEyesImage:ImageInst;
      
      public var mAlpha:int;
      
      public var mNextBallY:int;
      
      public function FrogBody()
      {
         super();
         this.mCel = 0;
      }
   }
}
