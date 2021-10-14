package com.popcap.flash.bejeweledblitz.dailyspin2.UI
{
   import com.caurina.transitions.Tweener;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class SpinBoardFrenzyBarContainer
   {
       
      
      private var mIsPremiumFrenzyBar:Boolean;
      
      private var mFrenzyBarPanelView:FrenzyBarPanel;
      
      private var mInitialFrenzyPosition:Number;
      
      private var mInitialFrenzyHeight:Number;
      
      private var mUpdateCallback:Function;
      
      private var mBarFullCallback:Function;
      
      private var mFrenzyBarMarkers:Vector.<FrenzyBarMarker>;
      
      private var mRewardUpgradedPanel:MovieClip;
      
      private var mPremiumBoardStepsTracker:SpinBoardFrenzyBarStepsTracker;
      
      private var mRegularBoardStepsTracker:SpinBoardFrenzyBarStepsTracker;
      
      private var mCurrentStepsTracker:SpinBoardFrenzyBarStepsTracker;
      
      public function SpinBoardFrenzyBarContainer()
      {
         super();
         this.mFrenzyBarMarkers = new Vector.<FrenzyBarMarker>();
         this.mPremiumBoardStepsTracker = new SpinBoardFrenzyBarStepsTracker();
         this.mRegularBoardStepsTracker = new SpinBoardFrenzyBarStepsTracker();
      }
      
      public function Init(param1:FrenzyBarPanel) : void
      {
         this.mFrenzyBarPanelView = param1;
         this.mInitialFrenzyPosition = this.mFrenzyBarPanelView.y;
         this.mInitialFrenzyHeight = this.mFrenzyBarPanelView.height;
         this.mFrenzyBarPanelView.mFrenzyBarGlow.visible = false;
         this.mIsPremiumFrenzyBar = false;
      }
      
      public function SetInfo(param1:Boolean, param2:uint, param3:uint, param4:Boolean, param5:Boolean, param6:Function, param7:Function) : Boolean
      {
         this.mFrenzyBarPanelView.gotoAndStop(0);
         var _loc8_:Boolean = false;
         if(this.mFrenzyBarPanelView != null)
         {
            this.mUpdateCallback = param6;
            this.mBarFullCallback = param7;
            this.mIsPremiumFrenzyBar = param1;
            this.mCurrentStepsTracker = !!this.mIsPremiumFrenzyBar ? this.mPremiumBoardStepsTracker : this.mRegularBoardStepsTracker;
            this.mCurrentStepsTracker.mBlockOutro = !(param4 && param5);
            this.mCurrentStepsTracker.mProgressExpected = param5;
            if(this.mCurrentStepsTracker.mCurrentSteps != param3)
            {
               this.mCurrentStepsTracker.mPreviousSteps = this.mCurrentStepsTracker.mCurrentSteps;
               this.mCurrentStepsTracker.mCurrentSteps = param3;
            }
            if(this.mCurrentStepsTracker.mTotalSteps != param2)
            {
               this.mCurrentStepsTracker.mPreviousTotalSteps = this.mCurrentStepsTracker.mTotalSteps;
               this.mCurrentStepsTracker.mTotalSteps = param2;
               this.SetupFrenzyBarMarkers();
            }
            _loc8_ = this.ValidateState();
         }
         return _loc8_;
      }
      
      private function SetupFrenzyBarMarkers() : void
      {
         var _loc1_:FrenzyBarMarker = null;
         var _loc2_:uint = 0;
         while(this.mFrenzyBarMarkers.length != 0)
         {
            _loc1_ = this.mFrenzyBarMarkers.pop();
            this.mFrenzyBarPanelView.removeChild(_loc1_);
            _loc1_ = null;
         }
         this.mFrenzyBarMarkers.length = 0;
         if(this.mCurrentStepsTracker.mTotalSteps > 1)
         {
            _loc2_ = 1;
            while(_loc2_ < this.mCurrentStepsTracker.mTotalSteps)
            {
               _loc1_ = new FrenzyBarMarker();
               this.mFrenzyBarPanelView.addChildAt(_loc1_,0);
               _loc1_.visible = true;
               _loc1_.y = -(_loc2_ / this.mCurrentStepsTracker.mTotalSteps) * this.mInitialFrenzyHeight;
               this.mFrenzyBarMarkers.push(_loc1_);
               _loc2_++;
            }
         }
      }
      
      private function ValidateState() : Boolean
      {
         var _loc1_:Boolean = false;
         this.mFrenzyBarPanelView.mFrenzyProgressBarPremium.visible = this.mIsPremiumFrenzyBar;
         this.mFrenzyBarPanelView.mFrenzyProgressBarRegular.visible = !this.mIsPremiumFrenzyBar;
         var _loc2_:MovieClip = !!this.mIsPremiumFrenzyBar ? this.mFrenzyBarPanelView.mFrenzyProgressBarPremium : this.mFrenzyBarPanelView.mFrenzyProgressBarRegular;
         if(this.mCurrentStepsTracker.mCurrentSteps > this.mCurrentStepsTracker.mTotalSteps)
         {
            this.mCurrentStepsTracker.mCurrentSteps = this.mCurrentStepsTracker.mTotalSteps;
         }
         var _loc3_:Boolean = false;
         var _loc4_:Number = 0;
         if(this.mCurrentStepsTracker.mTotalSteps > 0)
         {
            _loc4_ = this.mCurrentStepsTracker.mCurrentSteps / this.mCurrentStepsTracker.mTotalSteps * this.mInitialFrenzyHeight;
         }
         if(this.mCurrentStepsTracker.mCurrentSteps == 0 && this.mCurrentStepsTracker.mPreviousSteps != 0 && this.mCurrentStepsTracker.mTotalSteps > 0 && this.mCurrentStepsTracker.mPreviousTotalSteps > 0)
         {
            _loc3_ = true;
            if(!this.mCurrentStepsTracker.mBlockOutro)
            {
               _loc4_ = this.mInitialFrenzyHeight;
            }
         }
         if(_loc3_ && !this.mCurrentStepsTracker.mOutroDone && !this.mCurrentStepsTracker.mBlockOutro)
         {
            Tweener.addTween(_loc2_,{
               "y":-_loc4_,
               "height":_loc4_,
               "time":1
            });
            Tweener.addTween(this.mFrenzyBarPanelView.mFrenzyParticle,{
               "y":-_loc4_,
               "time":1,
               "onComplete":this.OnFrenzyBarFull
            });
            _loc1_ = false;
            this.mCurrentStepsTracker.mOutroDone = true;
         }
         else
         {
            Tweener.addTween(_loc2_,{
               "y":-_loc4_,
               "height":_loc4_,
               "time":1
            });
            Tweener.addTween(this.mFrenzyBarPanelView.mFrenzyParticle,{
               "y":-_loc4_,
               "time":1,
               "onComplete":this.OnFrenzyUpdateComplete
            });
            _loc1_ = true;
            this.mCurrentStepsTracker.mOutroDone = false;
            this.mFrenzyBarPanelView.mFrenzyBarGlow.visible = this.mCurrentStepsTracker.mCurrentSteps != 0 && !Blitz3App.app.isLQMode;
         }
         return _loc1_;
      }
      
      private function OnRewardUpgradedAnimationUpdate(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:MovieClip = null;
         if(this.mRewardUpgradedPanel != null && this.mRewardUpgradedPanel.currentFrame == Utils.GetAnimationLastFrame(this.mRewardUpgradedPanel,"onRewardUpgraded"))
         {
            this.mRewardUpgradedPanel.removeEventListener(Event.ENTER_FRAME,this.OnRewardUpgradedAnimationUpdate);
            this.mRewardUpgradedPanel.visible = false;
            this.mRewardUpgradedPanel = null;
            if(this.mBarFullCallback != null)
            {
               this.mBarFullCallback(this.mCurrentStepsTracker.mProgressExpected);
            }
            this.mCurrentStepsTracker.mOutroDone = false;
            this.mFrenzyBarPanelView.gotoAndPlay("outro");
            if(this.mCurrentStepsTracker.mTotalSteps > 0)
            {
               _loc2_ = this.mCurrentStepsTracker.mCurrentSteps / this.mCurrentStepsTracker.mTotalSteps * this.mInitialFrenzyHeight;
               _loc3_ = !!this.mIsPremiumFrenzyBar ? this.mFrenzyBarPanelView.mFrenzyProgressBarPremium : this.mFrenzyBarPanelView.mFrenzyProgressBarRegular;
               Tweener.addTween(_loc3_,{
                  "y":-_loc2_,
                  "height":_loc2_,
                  "time":1
               });
               Tweener.addTween(this.mFrenzyBarPanelView.mFrenzyParticle,{
                  "y":-_loc2_,
                  "time":1,
                  "onComplete":this.OnFrenzyUpdateComplete
               });
            }
         }
      }
      
      private function OnFrenzyBarFull() : void
      {
         this.mRewardUpgradedPanel = SpinBoardUIController.GetInstance().GetSpinBoardContainer().GetOrCreateSpinBoardView().mRewardUpgradedPanel;
         if(this.mRewardUpgradedPanel != null)
         {
            this.mRewardUpgradedPanel.addEventListener(Event.ENTER_FRAME,this.OnRewardUpgradedAnimationUpdate);
            this.mRewardUpgradedPanel.gotoAndPlay("onRewardUpgraded");
            this.mRewardUpgradedPanel.visible = true;
         }
         this.mFrenzyBarPanelView.mFrenzyBarGlow.visible = false;
      }
      
      private function OnFrenzyUpdateComplete() : void
      {
         if(this.mUpdateCallback != null)
         {
            this.mUpdateCallback(this.mCurrentStepsTracker.mProgressExpected);
         }
         this.mFrenzyBarPanelView.gotoAndStop(0);
      }
      
      private function OnOutroComplete(param1:Event) : void
      {
         if(this.mIsPremiumFrenzyBar)
         {
            this.mFrenzyBarPanelView.gotoAndStop(0);
         }
         else
         {
            this.mFrenzyBarPanelView.gotoAndStop(0);
         }
         this.ValidateState();
         if(this.mUpdateCallback != null)
         {
            this.mUpdateCallback(this.mCurrentStepsTracker.mProgressExpected);
         }
      }
   }
}
