package com.popcap.flash.bejeweledblitz.dailyspin2.UI
{
   public class SpinBoardFrenzyBarStepsTracker
   {
       
      
      public var mTotalSteps:uint;
      
      public var mPreviousTotalSteps:uint;
      
      public var mCurrentSteps:uint;
      
      public var mPreviousSteps:uint;
      
      public var mOutroDone:Boolean;
      
      public var mBlockOutro:Boolean;
      
      public var mProgressExpected:Boolean;
      
      public function SpinBoardFrenzyBarStepsTracker()
      {
         super();
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.mTotalSteps = 0;
         this.mPreviousTotalSteps = 0;
         this.mCurrentSteps = 0;
         this.mPreviousSteps = 0;
         this.mOutroDone = true;
         this.mBlockOutro = false;
         this.mProgressExpected = false;
      }
   }
}
