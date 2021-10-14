package com.popcap.flash.bejeweledblitz.dailyspin2.UI
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardController;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardInfo;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardType;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class SpinBoardTileCursorView
   {
      
      private static const mAnimNone:String = "";
      
      private static const mAnimSelected:String = "selection";
      
      private static const mAnimCollecting:String = "collection1";
      
      private static const mAnimCollected:String = "collection2";
      
      private static const mAnimUpgradingRegular:String = "regularupgrade";
      
      private static const mAnimUpgradingPremium:String = "premiumupgrade";
       
      
      private var mUIController:SpinBoardUIController;
      
      private var mController:SpinBoardController;
      
      private var mTilesHandler:SpinBoardTilesHandler;
      
      private var sCursorCounter:uint;
      
      private var mFXWidget:MovieClip;
      
      private var mIsExecutingAnAction:Boolean;
      
      private var mCurrentlyExecutingAnimationName:String;
      
      private var mCurrentAction:SpinBoardTileCursorAction;
      
      private var mActionQueue:Vector.<SpinBoardTileCursorAction>;
      
      private var mCachedLastFramesOfAnimations:Dictionary;
      
      public function SpinBoardTileCursorView(param1:MovieClip)
      {
         super();
         this.mFXWidget = param1;
         this.mUIController = SpinBoardUIController.GetInstance();
         this.mController = SpinBoardController.GetInstance();
         this.mTilesHandler = this.mUIController.GetTilesHandler();
         this.sCursorCounter = 0;
         this.mActionQueue = new Vector.<SpinBoardTileCursorAction>();
         this.mCachedLastFramesOfAnimations = new Dictionary();
         this.mCachedLastFramesOfAnimations[mAnimNone] = -1;
         this.mCachedLastFramesOfAnimations[mAnimCollected] = Utils.GetAnimationLastFrame(this.mFXWidget,mAnimCollected);
         this.mCachedLastFramesOfAnimations[mAnimCollecting] = Utils.GetAnimationLastFrame(this.mFXWidget,mAnimCollecting);
         this.mCachedLastFramesOfAnimations[mAnimSelected] = Utils.GetAnimationLastFrame(this.mFXWidget,mAnimSelected);
         this.mCachedLastFramesOfAnimations[mAnimUpgradingRegular] = Utils.GetAnimationLastFrame(this.mFXWidget,mAnimUpgradingRegular);
         this.mCachedLastFramesOfAnimations[mAnimUpgradingPremium] = Utils.GetAnimationLastFrame(this.mFXWidget,mAnimUpgradingPremium);
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.mIsExecutingAnAction = false;
         this.mCurrentAction = null;
         this.mCurrentlyExecutingAnimationName = "";
      }
      
      public function GetAnimationNameForAction(param1:uint) : String
      {
         var _loc3_:SpinBoardInfo = null;
         var _loc4_:* = false;
         var _loc2_:String = "";
         switch(param1)
         {
            case SpinBoardTileCursorActionType.SpinBoardTileCursorActionSelected:
               _loc2_ = mAnimSelected;
               break;
            case SpinBoardTileCursorActionType.SpinBoardTileCursorActionCollecting:
               _loc2_ = mAnimCollecting;
               break;
            case SpinBoardTileCursorActionType.SpinBoardTileCursorActionCollected:
               _loc2_ = mAnimCollected;
               break;
            case SpinBoardTileCursorActionType.SpinBoardTileCursorActionUpgrading:
               _loc3_ = SpinBoardUIController.GetInstance().GetCurrentlyShowingSpinBoard();
               if(_loc3_ != null)
               {
                  if(_loc4_ = _loc3_.GetType() == SpinBoardType.PremiumBoard)
                  {
                     _loc2_ = "premiumupgrade";
                  }
                  else
                  {
                     _loc2_ = "regularupgrade";
                  }
               }
         }
         return _loc2_;
      }
      
      public function AddActionInQueue(param1:uint, param2:SpinBoardTileView, param3:uint, param4:Function, param5:Boolean, param6:Boolean, param7:Boolean) : Boolean
      {
         var _loc8_:Boolean = true;
         if(this.mIsExecutingAnAction)
         {
            if(param5 && this.mCurrentAction != null && this.mCurrentAction.mCanBePreempted)
            {
               this.AbortAllActions();
               this.ExecuteAction(new SpinBoardTileCursorAction(param1,param2,param3,param4,param7,this.mCachedLastFramesOfAnimations[this.GetAnimationNameForAction(param1)]));
            }
            else if(!param6)
            {
               this.mActionQueue.push(new SpinBoardTileCursorAction(param1,param2,param3,param4,param7,this.mCachedLastFramesOfAnimations[this.GetAnimationNameForAction(param1)]));
            }
            else
            {
               _loc8_ = false;
            }
         }
         else
         {
            this.ExecuteAction(new SpinBoardTileCursorAction(param1,param2,param3,param4,param7,this.mCachedLastFramesOfAnimations[this.GetAnimationNameForAction(param1)]));
         }
         return _loc8_;
      }
      
      private function AbortAllActions() : void
      {
         this.mFXWidget.visible = false;
         this.Reset();
         var _loc1_:int = this.mActionQueue.length;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            this.mActionQueue[_loc2_] = null;
            _loc2_++;
         }
         this.mActionQueue.splice(0,this.mActionQueue.length);
      }
      
      public function ExecuteAction(param1:SpinBoardTileCursorAction) : void
      {
         if(param1 != null && param1.mTileView != null)
         {
            if(this.mIsExecutingAnAction)
            {
               return;
            }
            this.mCurrentAction = param1;
            this.mIsExecutingAnAction = true;
            this.mFXWidget.addEventListener(Event.ENTER_FRAME,this.OnEnterFrame);
            this.mFXWidget.x = this.mCurrentAction.mTileView.GetTileClip().x;
            this.mFXWidget.y = this.mCurrentAction.mTileView.GetTileClip().y;
            this.mFXWidget.visible = false;
            switch(param1.mAction)
            {
               case SpinBoardTileCursorActionType.SpinBoardTileCursorActionSelected:
                  this.mCurrentlyExecutingAnimationName = mAnimSelected;
                  this.PlayCursorSound();
                  break;
               case SpinBoardTileCursorActionType.SpinBoardTileCursorActionUpgrading:
                  this.PlayUpgradeSequence();
                  Blitz3App.app.SoundManager.playSound(Blitz3GameSounds.SOUND_SPINBOARD_REWARD_TILE_UPGRADE);
                  break;
               case SpinBoardTileCursorActionType.SpinBoardTileCursorActionCollecting:
                  this.mCurrentlyExecutingAnimationName = mAnimCollecting;
                  break;
               case SpinBoardTileCursorActionType.SpinBoardTileCursorActionCollected:
                  this.mCurrentlyExecutingAnimationName = mAnimCollected;
                  break;
               default:
                  this.mCurrentlyExecutingAnimationName = "";
                  this.OnActionComplete();
            }
            if(this.mCurrentlyExecutingAnimationName != "")
            {
               this.mFXWidget.visible = true;
               this.mFXWidget.gotoAndPlay(this.mCurrentlyExecutingAnimationName);
            }
         }
         else
         {
            this.OnActionComplete();
         }
      }
      
      public function OnEnterFrame(param1:Event) : void
      {
         if(this.mFXWidget.currentFrame == this.mCurrentAction.mFrameIdToStopAt)
         {
            this.mFXWidget.removeEventListener(Event.ENTER_FRAME,this.OnEnterFrame);
            this.OnActionComplete();
         }
      }
      
      private function OnActionComplete() : void
      {
         var _loc1_:SpinBoardTileCursorAction = null;
         this.mFXWidget.visible = false;
         this.mIsExecutingAnAction = false;
         if(this.mCurrentAction.mActionCompleteCallback != null)
         {
            this.mCurrentAction.mActionCompleteCallback(this.mCurrentAction.mTileId);
         }
         if(this.mActionQueue.length != 0)
         {
            _loc1_ = this.mActionQueue[0];
            this.mActionQueue.splice(0,1);
            this.ExecuteAction(_loc1_);
         }
      }
      
      private function PlayUpgradeSequence() : void
      {
         var _loc2_:* = false;
         var _loc1_:SpinBoardInfo = SpinBoardUIController.GetInstance().GetCurrentlyShowingSpinBoard();
         if(_loc1_ != null)
         {
            _loc2_ = _loc1_.GetType() == SpinBoardType.PremiumBoard;
            if(_loc2_)
            {
               this.mCurrentlyExecutingAnimationName = mAnimUpgradingPremium;
            }
            else
            {
               this.mCurrentlyExecutingAnimationName = mAnimUpgradingRegular;
            }
         }
      }
      
      private function PlayCursorSound() : void
      {
         var _loc1_:uint = this.sCursorCounter % 6;
         Blitz3App.app.SoundManager.playSound("SOUND_BLITZ3GAME_SPINBOARD_CURSOR_" + _loc1_);
         ++this.sCursorCounter;
      }
   }
}
