package com.popcap.flash.bejeweledblitz.dailyspin2
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import org.osmf.logging.Log;
   
   public class SpinBoardPlayerDataHandler
   {
       
      
      private var mSpinBoardPlayerDataContainer:SpinBoardPlayerDataContainer;
      
      private var mListeners:Vector.<Function>;
      
      public function SpinBoardPlayerDataHandler()
      {
         super();
         this.mSpinBoardPlayerDataContainer = new SpinBoardPlayerDataContainer();
         this.mListeners = new Vector.<Function>();
      }
      
      public function Init() : void
      {
         var _loc1_:Object = Blitz3App.app.network.ExternalCall("getSpinBoardUserProgress");
         this.mSpinBoardPlayerDataContainer.SetInfoFromInitialConfig(_loc1_);
         this.mSpinBoardPlayerDataContainer.SetInfo(_loc1_,false);
      }
      
      public function GetBoardProgressById(param1:String) : SpinBoardPlayerProgress
      {
         var _loc2_:SpinBoardPlayerProgress = null;
         var _loc3_:SpinBoardPlayerProgress = this.mSpinBoardPlayerDataContainer.GetBoardProgress(SpinBoardType.PremiumBoard);
         var _loc4_:SpinBoardPlayerProgress = this.mSpinBoardPlayerDataContainer.GetBoardProgress(SpinBoardType.RegularBoard);
         if(_loc3_ != null && _loc3_.GetBoardId() == param1)
         {
            _loc2_ = _loc3_;
         }
         else if(_loc4_ != null && _loc4_.GetBoardId() == param1)
         {
            _loc2_ = _loc4_;
         }
         return _loc2_;
      }
      
      public function GetBoardProgressByType(param1:int) : SpinBoardPlayerProgress
      {
         return this.mSpinBoardPlayerDataContainer.GetBoardProgress(param1);
      }
      
      public function GetNextFreeSpinAvailableTime() : Number
      {
         return this.mSpinBoardPlayerDataContainer.GetNextFreeSpinAvailableTime();
      }
      
      public function AddListener(param1:Function) : void
      {
         if(this.mListeners != null)
         {
            this.mListeners.push(param1);
         }
      }
      
      public function RemoveListener(param1:Function) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this.mListeners != null)
         {
            _loc2_ = this.mListeners.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               if(param1 == this.mListeners[_loc3_])
               {
                  this.mListeners.splice(_loc3_,1);
               }
               _loc3_++;
            }
         }
      }
      
      public function SetAdRewardSpinAvailable(param1:Boolean) : void
      {
         this.mSpinBoardPlayerDataContainer.SetAdRewardSpinAvailable(param1);
      }
      
      public function SetHasFreeSpinAvailable(param1:Boolean) : void
      {
         this.mSpinBoardPlayerDataContainer.SetFreeSpinAvailable(param1);
      }
      
      public function GetPaidSpinBalance() : int
      {
         return this.mSpinBoardPlayerDataContainer.GetPaidSpinBalance();
      }
      
      public function HasFreeSpinAvailable() : Boolean
      {
         return this.mSpinBoardPlayerDataContainer.IsFreeSpinAvailable();
      }
      
      public function AdRewardSpinAvailable() : Boolean
      {
         return this.mSpinBoardPlayerDataContainer.AdRewardSpinAvailable();
      }
      
      public function SetPaidSpinBalance(param1:int) : void
      {
         var _loc2_:int = 0;
         this.mSpinBoardPlayerDataContainer.SetPaidSpinBalance(param1);
         if(this.mListeners != null)
         {
            _loc2_ = 0;
            while(_loc2_ < this.mListeners.length)
            {
               this.mListeners[_loc2_].call();
               _loc2_++;
            }
         }
      }
      
      public function HasPurchasedPremiumBoard(param1:String) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:SpinBoardPlayerProgress = this.mSpinBoardPlayerDataContainer.GetBoardProgress(SpinBoardType.PremiumBoard);
         if(_loc3_.GetBoardId() == param1)
         {
            if(!_loc3_.HasTimerExpired() && !_loc3_.HasBeenReset())
            {
               _loc2_ = true;
            }
         }
         return _loc2_;
      }
      
      public function GetSpinBoardPlayerDataContainer() : SpinBoardPlayerDataContainer
      {
         return this.mSpinBoardPlayerDataContainer;
      }
      
      public function ResetSpinBoardProgress(param1:int, param2:Boolean) : void
      {
         var _loc3_:SpinBoardPlayerProgress = this.mSpinBoardPlayerDataContainer.GetBoardProgress(param1);
         if(_loc3_ != null)
         {
            _loc3_.Reset(param2);
            SpinBoardController.GetInstance().GetStateHandler().SetState(SpinBoardState.BoardReset);
         }
         else
         {
            Log("[SpinBoardPlayerDataHandler] Null SpinBoardPlayerProgress");
         }
      }
      
      public function GetProgressOfExpiredSpinBoard() : SpinBoardPlayerProgress
      {
         var _loc3_:SpinBoardPlayerProgress = null;
         var _loc1_:SpinBoardPlayerProgress = null;
         var _loc2_:int = SpinBoardType.Count - 1;
         while(_loc2_ >= 0)
         {
            _loc3_ = this.GetBoardProgressByType(_loc2_);
            if(_loc3_ != null && _loc3_.GetBoardId() != "" && !_loc3_.HasBeenReset())
            {
               if(_loc3_.HasTimerExpired())
               {
                  _loc1_ = _loc3_;
                  break;
               }
            }
            _loc2_--;
         }
         return _loc1_;
      }
      
      public function IncreaseAnticipatedSpinCountThroughFTUE() : void
      {
         this.SetPaidSpinBalance(this.mSpinBoardPlayerDataContainer.GetPaidSpinBalance() + SpinBoardController.GetInstance().GetCatalogue().GetFTUESpinReward());
      }
   }
}
