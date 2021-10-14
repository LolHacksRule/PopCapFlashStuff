package com.popcap.flash.bejeweledblitz.dailyspin2
{
   import com.popcap.flash.bejeweledblitz.dailyspin2.UI.SpinBoardUIController;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   
   public class SpinsShareHandler
   {
       
      
      private var mController:SpinBoardController;
      
      private var mAmountToShare:Number;
      
      private var mNormalTiles:uint;
      
      private var mSpecialTiles:uint;
      
      private var mBoardId:String;
      
      private var mBoardType:String;
      
      private var mHasExpired:Boolean;
      
      public function SpinsShareHandler(param1:SpinBoardController)
      {
         super();
         this.mController = param1;
         this.mAmountToShare = 0;
         this.mBoardId = "";
         this.mBoardType = "";
         this.mHasExpired = false;
         Blitz3App.app.network.AddExternalCallback("OnShareSequenceComplete",this.OnShareSequenceSuccess);
         Blitz3App.app.network.AddExternalCallback("OnShareSequenceCanceled",this.OnShareSequenceCanceled);
      }
      
      public function InitiateSpinsShareSequence() : void
      {
         this.ValidateAmountToShare();
         if(this.mAmountToShare > 0)
         {
            SpinBoardUIController.GetInstance().ShowSharePopup();
         }
         else
         {
            this.OnShareSequenceCanceled();
         }
      }
      
      public function ValidateAmountToShare() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc4_:SpinBoardInfo = null;
         var _loc5_:SpinBoardInfo = null;
         var _loc3_:SpinBoardPlayerProgress = this.mController.GetPlayerDataHandler().GetProgressOfExpiredSpinBoard();
         if(_loc3_ != null)
         {
            this.mHasExpired = _loc3_.HasTimerExpired();
            this.mBoardId = _loc3_.GetBoardId();
            if((_loc4_ = this.mController.GetCatalogue().GetSpinBoardInfo(_loc3_.GetBoardId())) != null)
            {
               this.mBoardType = _loc4_.GetTypeString();
            }
            this.mSpecialTiles = _loc3_.GetSpecialTilesClaimed();
            this.mNormalTiles = _loc3_.GetProgressiveSpinCount() - this.mSpecialTiles;
            _loc1_ = this.mSpecialTiles * this.mController.GetCatalogue().GetSpecialTileShareAmount();
            _loc2_ = this.mNormalTiles * this.mController.GetCatalogue().GetNormalTileShareAmount();
            this.mAmountToShare = _loc2_ + _loc1_;
         }
         else if((_loc5_ = this.mController.GetActiveSpinBoardInfo()) != null)
         {
            _loc3_ = this.mController.GetPlayerDataHandler().GetBoardProgressByType(_loc5_.GetType());
            if(_loc3_.AreAllTilesClaimed())
            {
               this.mBoardId = _loc3_.GetBoardId();
               this.mSpecialTiles = _loc3_.GetSpecialTilesClaimed();
               this.mNormalTiles = _loc3_.GetProgressiveSpinCount() - this.mSpecialTiles;
               this.mBoardType = _loc5_.GetTypeString();
               _loc1_ = this.mSpecialTiles * this.mController.GetCatalogue().GetSpecialTileShareAmount();
               _loc2_ = this.mNormalTiles * this.mController.GetCatalogue().GetNormalTileShareAmount();
               this.mAmountToShare = _loc2_ + _loc1_;
            }
         }
         if(_loc3_ == null)
         {
            this.mAmountToShare = 0;
            this.mBoardId = "";
            this.mSpecialTiles = 0;
            this.mNormalTiles = 0;
            this.mHasExpired = false;
         }
      }
      
      public function GetTotalAmountToShare() : uint
      {
         return this.mAmountToShare;
      }
      
      public function GetNormalTilesClaimed() : uint
      {
         return this.mNormalTiles;
      }
      
      public function GetSpecialTilesClaimed() : uint
      {
         return this.mSpecialTiles;
      }
      
      public function OnShareSequenceSuccess(param1:int) : void
      {
         var _loc2_:String = !!this.mHasExpired ? "BoardExpiry" : "BoardClear";
         var _loc3_:uint = this.mSpecialTiles * this.mController.GetCatalogue().GetSpecialTileShareAmount();
         var _loc4_:uint = this.mNormalTiles * this.mController.GetCatalogue().GetNormalTileShareAmount();
         var _loc5_:Object = {
            "RegularTilesClaimed":this.mNormalTiles,
            "RegularTileCoinReward":_loc4_,
            "SpecialTilesClaimed":this.mSpecialTiles,
            "SpecialTilesCoinReward":_loc3_,
            "NumFriendsShared":param1,
            "BoardID":this.mBoardId,
            "BoardType":this.mBoardType,
            "ShareReason":_loc2_
         };
         SpinBoardController.GetInstance().GetTelemetryTracker().TrackEvent(SpinBoardTelemetryEventType.Share,_loc5_);
         this.OnShareSequenceComplete();
      }
      
      public function OnShareSequenceCanceled() : void
      {
         Blitz3App.app.network.ExternalCall("Spin.cancelShareSpin",this.mBoardId);
         this.OnShareSequenceComplete();
      }
      
      public function OnShareSequenceComplete() : void
      {
         var _loc1_:SpinBoardPlayerProgress = this.mController.GetPlayerDataHandler().GetBoardProgressById(this.mBoardId);
         if(_loc1_ != null && _loc1_.GetBoardId() == this.mBoardId)
         {
            _loc1_.Reset(this.mHasExpired);
         }
         this.mAmountToShare = 0;
         this.mBoardId = "";
         this.mSpecialTiles = 0;
         this.mNormalTiles = 0;
         this.mBoardType = "";
         this.mHasExpired = false;
         this.mController.GetStateHandler().SetState(SpinBoardState.RewardShareSequenceComplete);
      }
      
      public function OnShareCancelButtonClicked() : void
      {
         this.OnShareSequenceCanceled();
      }
      
      public function OnShareButtonClicked() : void
      {
         Blitz3App.app.network.ExternalCall("Spin.shareSpin",this.mAmountToShare,this.mBoardId);
      }
   }
}
