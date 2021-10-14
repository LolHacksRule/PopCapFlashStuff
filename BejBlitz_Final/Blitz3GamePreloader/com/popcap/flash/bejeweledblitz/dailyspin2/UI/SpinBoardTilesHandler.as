package com.popcap.flash.bejeweledblitz.dailyspin2.UI
{
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardController;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardElementInfo;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardInfo;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardPlayerProgress;
   import flash.display.MovieClip;
   import flash.trace.Trace;
   import org.osmf.logging.Log;
   
   public class SpinBoardTilesHandler
   {
       
      
      private const mRows:uint = 5;
      
      private const mColumns:uint = 5;
      
      private var mAreAllTilesValid:Boolean = false;
      
      private var mSpinBoardViewContainer:SpinBoardViewContainer;
      
      private var mSpinBoardClip:SpinBoardView;
      
      private var mSpinBoardInfo:SpinBoardInfo;
      
      private var mCurrentlyHighlightedTileIndex:int = -1;
      
      private var mTiles:Vector.<SpinBoardTileView>;
      
      private var mTileCursor:SpinBoardTileCursorView;
      
      private var mCurrentlyShowingBoard:SpinBoardInfo;
      
      private var mUserProgress:SpinBoardPlayerProgress;
      
      private var mTileActions:Vector.<uint>;
      
      private var mTileActionsCompleteCallback:Function;
      
      public function SpinBoardTilesHandler(param1:SpinBoardViewContainer)
      {
         super();
         this.mSpinBoardViewContainer = param1;
         this.mTiles = new Vector.<SpinBoardTileView>();
         this.mTileCursor = new SpinBoardTileCursorView(this.mSpinBoardViewContainer.GetOrCreateSpinBoardView().mSpinBoardTilesContainer.SpinBoardTileUIFX);
         this.mTileActions = new Vector.<uint>();
         if(this.mSpinBoardViewContainer != null)
         {
            this.mSpinBoardClip = this.mSpinBoardViewContainer.GetOrCreateSpinBoardView();
         }
         else
         {
            Trace("[SpinBoardTilesHandler] SpinView Null");
         }
      }
      
      public function StartListeningHighlighterUpdates() : void
      {
         SpinBoardController.GetInstance().GetHighlightController().RegisterHighlightTimerTickCallback(this.OnTileSelectionChanged);
      }
      
      public function StopListeningHighlighterUpdates() : void
      {
         SpinBoardController.GetInstance().GetHighlightController().DeregisterHighlightTimerTickCallback(this.OnTileSelectionChanged);
      }
      
      public function DoCollectionAnimationForSelectedTile() : void
      {
         this.mCurrentlyHighlightedTileIndex = SpinBoardController.GetInstance().GetHighlightController().GetCurrentHighlightIndex();
         if(this.mCurrentlyHighlightedTileIndex != -1 && this.mTiles[this.mCurrentlyHighlightedTileIndex] != null)
         {
            this.mTileCursor.AddActionInQueue(SpinBoardTileCursorActionType.SpinBoardTileCursorActionCollecting,this.mTiles[this.mCurrentlyHighlightedTileIndex],this.mCurrentlyHighlightedTileIndex,this.OnCollectingAnimComplete,true,false,false);
         }
         else
         {
            this.OnCollectingAnimComplete(this.mCurrentlyHighlightedTileIndex);
         }
      }
      
      public function OnCollectingAnimComplete(param1:uint) : void
      {
         SpinBoardUIController.GetInstance().SetAllowUserActions(true);
         SpinBoardUIController.GetInstance().GetSpinBoardRewardClaimPopupContainer().OpenSpinBoardRewardClaimPopup();
      }
      
      public function OnTileSelectionChanged() : void
      {
         var _loc1_:int = SpinBoardController.GetInstance().GetHighlightController().GetCurrentHighlightIndex();
         if(_loc1_ >= 0 && _loc1_ < this.mTiles.length)
         {
            this.mCurrentlyHighlightedTileIndex = _loc1_;
            this.mTileCursor.AddActionInQueue(SpinBoardTileCursorActionType.SpinBoardTileCursorActionSelected,this.mTiles[this.mCurrentlyHighlightedTileIndex],this.mCurrentlyHighlightedTileIndex,null,true,true,true);
         }
      }
      
      public function RefreshClaimedTiles(param1:Function, param2:Boolean) : void
      {
         this.SetupTilesForCurrentlyShowingBoard(true,false,param1,param2);
      }
      
      public function RefreshUpgradedTiles(param1:Function, param2:Boolean) : void
      {
         this.SetupTilesForCurrentlyShowingBoard(false,true,param1,param2);
      }
      
      public function RefreshTilesForCurrentlyShowingBoard(param1:Boolean, param2:Boolean, param3:Function, param4:Boolean) : void
      {
         this.SetupTilesForCurrentlyShowingBoard(param1,param1,param3,param4);
      }
      
      public function SetupTilesForCurrentlyShowingBoard(param1:Boolean, param2:Boolean, param3:Function, param4:Boolean) : void
      {
         var claimDiff:int = 0;
         var upgradeDiff:int = 0;
         var valueToShift:int = 0;
         var i:int = 0;
         var isEnabled:Boolean = false;
         var isUpgraded:Boolean = false;
         var actionType:uint = 0;
         var actionAdded:Boolean = false;
         var j:uint = 0;
         var shouldUpdateClaimedTiles:Boolean = param1;
         var shouldUpdateUpgradedTiles:Boolean = param2;
         var actionCallback:Function = param3;
         var invalidateTiles:Boolean = param4;
         this.mAreAllTilesValid = !invalidateTiles;
         if(!this.mAreAllTilesValid)
         {
            this.InitElements();
         }
         if(this.mAreAllTilesValid)
         {
            this.mCurrentlyShowingBoard = SpinBoardUIController.GetInstance().GetCurrentlyShowingSpinBoard();
            if(this.mCurrentlyShowingBoard != null)
            {
               this.mTileActions = new Vector.<uint>();
               this.mTileActionsCompleteCallback = actionCallback;
               this.mUserProgress = SpinBoardController.GetInstance().GetPlayerDataHandler().GetBoardProgressByType(this.mCurrentlyShowingBoard.GetType());
               if(this.mCurrentlyShowingBoard != null)
               {
                  if(!invalidateTiles)
                  {
                     claimDiff = this.mUserProgress.GetDifferenceBetweenClaimedBits();
                     upgradeDiff = this.mUserProgress.GetDifferenceBetweenUpgradeBits();
                     valueToShift = 1;
                     i = 0;
                     while(i < SpinBoardInfo.sNumberOfTiles)
                     {
                        if(claimDiff & valueToShift && shouldUpdateClaimedTiles || upgradeDiff & valueToShift && shouldUpdateUpgradedTiles)
                        {
                           isEnabled = !this.mUserProgress.GetClaimStatus(i);
                           isUpgraded = this.mUserProgress.GetUpgradeStatus(i);
                           actionType = SpinBoardTileCursorActionType.SpinBoardTileCursorActionNone;
                           if(!isEnabled)
                           {
                              actionType = SpinBoardTileCursorActionType.SpinBoardTileCursorActionCollected;
                           }
                           else if(isUpgraded)
                           {
                              actionType = SpinBoardTileCursorActionType.SpinBoardTileCursorActionUpgrading;
                           }
                           actionAdded = this.mTileCursor.AddActionInQueue(actionType,this.mTiles[i],i,function(param1:uint):void
                           {
                              if(mUserProgress.GetBoardId() == mCurrentlyShowingBoard.GetId())
                              {
                                 if(mTiles != null && [param1] != null)
                                 {
                                    mTiles[param1].SetEnabled(!mUserProgress.GetClaimStatus(param1));
                                    mTiles[param1].SetUpgradeStatus(mUserProgress.GetUpgradeStatus(param1));
                                    mTiles[param1].RefreshTileView();
                                 }
                              }
                              var _loc2_:* = mTileActions.indexOf(param1);
                              if(_loc2_ != -1)
                              {
                                 mTileActions.splice(_loc2_,1);
                                 if(mTileActions.length == 0 && mTileActionsCompleteCallback != null)
                                 {
                                    mTileActionsCompleteCallback(true);
                                 }
                              }
                           },true,false,false);
                           if(actionAdded)
                           {
                              this.mTileActions.push(i);
                           }
                        }
                        valueToShift <<= 1;
                        i++;
                     }
                     if(shouldUpdateClaimedTiles)
                     {
                        this.mUserProgress.SetDirtyStateForClaimedBits(false);
                     }
                     if(shouldUpdateUpgradedTiles)
                     {
                        this.mUserProgress.SetDirtyStateForUpgradedBits(false);
                     }
                     if(this.mTileActions.length == 0)
                     {
                        if(this.mTileActionsCompleteCallback != null)
                        {
                           this.mTileActionsCompleteCallback(true);
                        }
                        else
                        {
                           this.StartListeningHighlighterUpdates();
                        }
                     }
                  }
                  else
                  {
                     j = 0;
                     while(j < this.mTiles.length)
                     {
                        this.mTiles[j].SetEnabled(!this.mUserProgress.GetClaimStatus(j));
                        this.mTiles[j].SetUpgradeStatus(this.mUserProgress.GetUpgradeStatus(j));
                        this.mTiles[j].RefreshTileView();
                        j++;
                     }
                     if(this.mTileActionsCompleteCallback != null)
                     {
                        this.mTileActionsCompleteCallback(false);
                     }
                     else
                     {
                        this.StartListeningHighlighterUpdates();
                     }
                  }
               }
               else
               {
                  Log("[SpinBoardTilesHandler] activeBoardInfo null");
               }
            }
         }
         else
         {
            Log("[SpinBoardTilesHandler] Tried to set up board when tiles are not valid");
         }
      }
      
      public function Reset() : void
      {
         this.mTileCursor = null;
         this.mTiles.splice(0,this.mTiles.length);
         this.mTiles = null;
      }
      
      private function InitElements() : void
      {
         var _loc4_:SpinBoardTileUI = null;
         var _loc5_:SpinBoardTileView = null;
         this.mAreAllTilesValid = true;
         this.mTiles = new Vector.<SpinBoardTileView>();
         this.mCurrentlyShowingBoard = SpinBoardUIController.GetInstance().GetCurrentlyShowingSpinBoard();
         this.mUserProgress = SpinBoardController.GetInstance().GetPlayerDataHandler().GetBoardProgressByType(this.mCurrentlyShowingBoard.GetType());
         var _loc1_:MovieClip = this.mSpinBoardClip.mSpinBoardTilesContainer;
         var _loc2_:Vector.<SpinBoardElementInfo> = this.mCurrentlyShowingBoard.GetSpinBoardElements();
         var _loc3_:uint = 0;
         while(_loc3_ < 25)
         {
            if((_loc4_ = _loc1_.getChildByName("mSpinBoardElement_" + _loc3_.toString()) as SpinBoardTileUI) != null)
            {
               _loc5_ = new SpinBoardTileView(_loc4_,_loc2_[_loc3_],_loc3_);
               this.mTiles.push(_loc5_);
            }
            else
            {
               Log("[SpinBoardTilesHandler] Tile Null");
               this.mAreAllTilesValid = false;
            }
            _loc3_++;
         }
      }
   }
}
