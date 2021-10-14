package com.popcap.flash.bejeweledblitz.dailyspin2
{
   import com.adobe.crypto.MD5;
   import com.popcap.flash.bejeweledblitz.Globals;
   import com.popcap.flash.bejeweledblitz.UrlParameters;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   
   public class SpinBoardRewardClaimHandler
   {
       
      
      public const SPINBOARD_CLAIM_REWARD_URL:String = "/facebook/bj2/claimSpin.php";
      
      private var mCurrentState:uint;
      
      private var mPreviousState:uint;
      
      private var mTileIdForCurrentClaimRequest:int;
      
      private var mTileInfoForCurrentClaimRequest:SpinBoardTileInfo;
      
      private var mSpinBoardInfoForCurrentClaimRequest:SpinBoardInfo;
      
      private var mLastTileIdForClaimRequest:int;
      
      private var mLastTileInfoForClaimRequest:SpinBoardTileInfo;
      
      private var mLastSpinBoardInfoForClaimRequest:SpinBoardInfo;
      
      private var mLastClaimState:uint;
      
      private const ClientVerValidator:uint = 2;
      
      private var mSpinClaimTypeForCurrentClaimRequest:String;
      
      private var mStateChangedCallback:Function;
      
      public function SpinBoardRewardClaimHandler()
      {
         super();
         this.mCurrentState = SpinBoardRewardClaimState.ClaimStateNotInitiated;
         this.mPreviousState = SpinBoardRewardClaimState.ClaimStateNotInitiated;
      }
      
      public function GetLastClaimState() : uint
      {
         return this.mLastClaimState;
      }
      
      public function GetCurrentState() : uint
      {
         return this.mCurrentState;
      }
      
      public function SetCurrentState(param1:uint) : void
      {
         if(this.mCurrentState != param1)
         {
            this.mPreviousState = this.mCurrentState;
            this.mCurrentState = param1;
            if(this.mStateChangedCallback != null)
            {
               this.mStateChangedCallback();
            }
         }
      }
      
      public function GetLastTileId() : int
      {
         return this.mLastTileIdForClaimRequest;
      }
      
      public function GetCurrentTileId() : int
      {
         return this.mTileIdForCurrentClaimRequest;
      }
      
      public function GetLastSpinBoard() : SpinBoardInfo
      {
         return this.mLastSpinBoardInfoForClaimRequest;
      }
      
      public function GetSpinBoard() : SpinBoardInfo
      {
         return this.mSpinBoardInfoForCurrentClaimRequest;
      }
      
      public function GetLastTileInfo() : SpinBoardTileInfo
      {
         return this.mLastTileInfoForClaimRequest;
      }
      
      public function GetCurrentTileInfo() : SpinBoardTileInfo
      {
         return this.mTileInfoForCurrentClaimRequest;
      }
      
      public function SetStateChangedCallback(param1:Function) : void
      {
         this.mStateChangedCallback = param1;
      }
      
      public function OnRewardClaimRequested() : Boolean
      {
         var _loc1_:SpinBoardController = SpinBoardController.GetInstance();
         var _loc2_:int = _loc1_.GetHighlightController().GetCurrentHighlightIndex();
         Utils.logWithStackTrace(this,"[OnRewardClaimRequested] : " + _loc2_);
         var _loc3_:SpinBoardInfo = _loc1_.GetActiveSpinBoardInfo();
         return this.InitiateClaim(_loc3_,_loc2_);
      }
      
      public function ProcessClaim(param1:SpinBoardInfo, param2:uint, param3:SpinBoardTileInfo, param4:String) : Boolean
      {
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc5_:Boolean = true;
         if(param1 != null && param3 != null)
         {
            _loc6_ = this.mSpinBoardInfoForCurrentClaimRequest != null && this.mTileInfoForCurrentClaimRequest != null;
            _loc7_ = this.mSpinBoardInfoForCurrentClaimRequest == null || this.mTileInfoForCurrentClaimRequest == null || this.mSpinBoardInfoForCurrentClaimRequest.GetId() == param1.GetId() && this.mTileIdForCurrentClaimRequest == param2 && param4 == this.mSpinClaimTypeForCurrentClaimRequest;
            if(!_loc6_ || _loc7_)
            {
               this.mTileIdForCurrentClaimRequest = param2;
               this.mSpinBoardInfoForCurrentClaimRequest = param1;
               this.mTileInfoForCurrentClaimRequest = param3;
               this.mSpinClaimTypeForCurrentClaimRequest = param4;
               this.MakeClaimRequest();
            }
            else
            {
               Utils.log(this,"ProcessClaim : Claim Process already in progress.");
               _loc5_ = false;
            }
         }
         else
         {
            Utils.log(this,"ProcessClaim : board null.");
            _loc5_ = false;
         }
         return _loc5_;
      }
      
      private function MakeClaimRequest() : void
      {
         this.SetCurrentState(SpinBoardRewardClaimState.ClaimStateInitiated);
         var _loc1_:URLRequest = new URLRequest(Globals.labsPath + this.SPINBOARD_CLAIM_REWARD_URL);
         _loc1_.method = URLRequestMethod.POST;
         var _loc2_:URLVariables = Blitz3App.app.network.GetSecureVariables();
         var _loc3_:String = this.mSpinBoardInfoForCurrentClaimRequest.GetId();
         _loc2_["boardId"] = _loc3_;
         var _loc4_:SpinBoardPlayerProgress = SpinBoardController.GetInstance().GetPlayerDataHandler().GetBoardProgressById(_loc3_);
         var _loc5_:int = 1;
         if(_loc4_ != null)
         {
            _loc5_ = _loc4_.GetBoardClaimIterator();
         }
         var _loc6_:String = this.mTileIdForCurrentClaimRequest + "," + _loc5_.toString();
         _loc2_["cellId"] = _loc6_;
         _loc2_["type"] = this.mSpinClaimTypeForCurrentClaimRequest;
         _loc2_["csm"] = MD5.hash(_loc3_ + _loc6_ + this.mSpinClaimTypeForCurrentClaimRequest + Blitz3App.app.network.GetSalt());
         _loc2_["validator"] = this.ClientVerValidator;
         UrlParameters.Get().InjectParams(_loc2_);
         _loc1_.data = _loc2_;
         var _loc7_:URLLoader;
         (_loc7_ = new URLLoader()).addEventListener(Event.COMPLETE,this.OnClaimRequestSucceeded);
         _loc7_.addEventListener(IOErrorEvent.IO_ERROR,this.OnClaimRequestFailed);
         _loc7_.load(_loc1_);
      }
      
      private function GetLocalClaimResponse() : String
      {
         return "{\r\n\t\"result\": \"success\",\r\n\t\"dailyspin\": {\r\n\t\t\"paidBalance\": 2,\r\n\t\t\"coinBalance\": 7700,\r\n        \"progress\": { \r\n            \"regular\": {\r\n                \"boardId\": \"Spin-RegTest1-0\",\r\n                \"claimBits\": 512,\r\n                \"upgradeBits\": 0,\r\n                \"boardResetTime\": 1537391520\r\n            }\r\n        }\r\n\t},\r\n\t\"reason\": \"CLAIMED_SUCCESSFULLY\",\r\n\t\"wallet\": {\r\n\t\t\"coins\": 7700,\r\n\t\t\"xp\": 0,\r\n\t\t\"spins\": 2,\r\n\t\t\"currency1\": 0,\r\n\t\t\"currency2\": 0,\r\n\t\t\"currency3\": 0\r\n\t},\r\n\t\"inventory\": {\r\n\t\t\"uberGemGrants\": [],\r\n\t\t\"uberGemShares\": [],\r\n\t\t\"uberGemGifts\": {\r\n\t\t\t\"Aquamarine\": 10\r\n\t\t}\r\n\t}\r\n}";
      }
      
      public function SendTileClaimedTelemetry() : void
      {
         var _loc3_:SpinBoardPlayerProgress = null;
         var _loc4_:Object = null;
         var _loc1_:SpinBoardController = SpinBoardController.GetInstance();
         var _loc2_:SpinBoardInfo = SpinBoardController.GetInstance().GetActiveSpinBoardInfo();
         if(_loc2_ != null)
         {
            _loc3_ = _loc1_.GetPlayerDataHandler().GetBoardProgressByType(_loc2_.GetType());
            if(_loc3_ != null)
            {
               _loc4_ = {
                  "BoardId":this.mSpinBoardInfoForCurrentClaimRequest.GetId(),
                  "BoardType":this.mSpinBoardInfoForCurrentClaimRequest.GetType(),
                  "SlotType":(!!_loc3_.GetUpgradeStatus(this.mTileIdForCurrentClaimRequest) ? "Upgraded" : "Normal"),
                  "ItemClaimed":this.mTileInfoForCurrentClaimRequest.GetRewards()[0].GetDisplayName(),
                  "Quantity":this.mTileInfoForCurrentClaimRequest.GetRewards()[0].GetAmount(),
                  "nth_spin":_loc3_.GetProgressiveSpinCount(),
                  "ItemWeight":this.mTileInfoForCurrentClaimRequest.GetHighlightWeight(),
                  "SpinTypeUsed":this.mSpinClaimTypeForCurrentClaimRequest,
                  "FreeSpinBalance":(!!_loc1_.GetPlayerDataHandler().HasFreeSpinAvailable() ? 1 : 0),
                  "PurchasedSpinBalance":_loc1_.GetPlayerDataHandler().GetPaidSpinBalance(),
                  "ResetTime":_loc3_.GetBoardResetTime()
               };
               _loc1_.GetTelemetryTracker().TrackEvent(SpinBoardTelemetryEventType.Claim,_loc4_);
            }
         }
      }
      
      public function OnClaimSucceeded(param1:Object) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc2_:Boolean = false;
         if(param1 != null)
         {
            _loc3_ = SpinBoardController.GetInstance().GetPlayerDataHandler().GetSpinBoardPlayerDataContainer().SetInfo(param1.dailySpin,true);
            if((_loc4_ = Utils.getIntFromObjectKey(param1,"spin_balance",-1)) == -1)
            {
               _loc4_ = Utils.getIntFromObjectKey(param1.wallet,"spin_balance",-1);
            }
            if(_loc4_ != -1)
            {
               SpinBoardController.GetInstance().GetPlayerDataHandler().SetPaidSpinBalance(_loc4_);
            }
            Blitz3App.app.sessionData.userData.currencyManager.ParseCurrencyData(param1.wallet);
            if(_loc3_)
            {
               this.SendTileClaimedTelemetry();
               this.SetCurrentState(SpinBoardRewardClaimState.ClaimStateSuccess);
               if(this.mTileInfoForCurrentClaimRequest != null && this.mTileInfoForCurrentClaimRequest.GetRewards()[0].GetRewardType() == SpinBoardRewardType.RewardTypeGems)
               {
                  (Blitz3App.app.ui as MainWidgetGame).menu.leftPanel.showInventoryBlingButton();
               }
               this.OnClaimFinished();
               _loc2_ = true;
            }
         }
         return _loc2_;
      }
      
      public function OnClaimRequestSucceeded(param1:Event) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc2_:URLLoader = param1.currentTarget as URLLoader;
         _loc2_.removeEventListener(Event.COMPLETE,this.OnClaimRequestSucceeded,false);
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.OnClaimRequestFailed,false);
         if(_loc2_ && _loc2_.data)
         {
            _loc3_ = true;
            _loc4_ = JSON.parse(_loc2_.data);
            if((_loc5_ = Utils.getStringFromObjectKey(_loc4_,"status","")) == "CLAIMED_SUCCESSFULLY")
            {
               this.OnClaimSucceeded(_loc4_);
            }
            else
            {
               this.OnClaimFailed(_loc4_);
            }
         }
      }
      
      public function OnClaimRequestFailed(param1:Event) : void
      {
         this.OnClaimFailed(null);
      }
      
      public function OnClaimFailed(param1:Object) : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc2_:Object = {
            "ErrorType":"UNKNOWN_ERROR",
            "ErrorLocation":"SpinBoard_Claim"
         };
         if(param1 != null)
         {
            _loc3_ = Utils.getStringFromObjectKey(param1,"status","");
            _loc2_.ErrorType = _loc3_;
            if(_loc3_ == "FREE_SPIN_ALREADY_REDEEMED")
            {
               this.SetCurrentState(SpinBoardRewardClaimState.ClaimStateFreeSpinAlreadyRedeemed);
            }
            else if(_loc3_ == "PAID_SPIN_INSUFFICIENT_BALANCE")
            {
               this.SetCurrentState(SpinBoardRewardClaimState.ClaimStateOutOfSpins);
            }
            else if(_loc3_ == "IN_ACTIVE_BOARD")
            {
               this.SetCurrentState(SpinBoardRewardClaimState.ClaimSpinBoardNotActive);
            }
            else if(_loc3_ == "INVALID_BOARD")
            {
               this.SetCurrentState(SpinBoardRewardClaimState.ClaimStateSpinBoardExpired);
            }
            else if(_loc3_ == "CLAIM_ALREADY_USED")
            {
               this.SetCurrentState(SpinBoardRewardClaimState.ClaimAlreadyProcessed);
            }
            else if(_loc3_ == "INVALID_CLAIM_TIMESTAMP")
            {
               this.SetCurrentState(SpinBoardRewardClaimState.ClaimSpinBoardInvalidClaimTimeStamp);
            }
            else if(_loc3_ == "INVALID_CLAIM_REQUEST")
            {
               this.SetCurrentState(SpinBoardRewardClaimState.ClaimSpinBoardInvalidRequest);
            }
            else
            {
               this.SetCurrentState(SpinBoardRewardClaimState.ClaimStateFailed);
            }
            SpinBoardController.GetInstance().GetPlayerDataHandler().GetSpinBoardPlayerDataContainer().SetInfo(param1.dailySpin,true);
            _loc4_ = SpinBoardController.GetInstance().GetPlayerDataHandler().GetPaidSpinBalance();
            _loc5_ = Utils.getNumberFromObjectKey(param1,"spin_balance",_loc4_);
            SpinBoardController.GetInstance().GetPlayerDataHandler().SetPaidSpinBalance(_loc5_);
            Blitz3App.app.sessionData.userData.currencyManager.ParseCurrencyData(param1.wallet);
         }
         else
         {
            this.SetCurrentState(SpinBoardRewardClaimState.ClaimStateFailed);
         }
         SpinBoardController.GetInstance().GetTelemetryTracker().TrackEvent(SpinBoardTelemetryEventType.Error,_loc2_);
      }
      
      public function OnClaimRetryCanceled() : void
      {
         this.OnClaimFinished();
      }
      
      public function OnClaimFinished() : void
      {
         this.mLastClaimState = this.mCurrentState;
         this.SetCurrentState(SpinBoardRewardClaimState.ClaimStateNotInitiated);
         this.mLastSpinBoardInfoForClaimRequest = this.mSpinBoardInfoForCurrentClaimRequest;
         this.mLastTileIdForClaimRequest = this.mTileIdForCurrentClaimRequest;
         this.mLastTileInfoForClaimRequest = this.mTileInfoForCurrentClaimRequest;
         this.mTileIdForCurrentClaimRequest = -1;
         this.mSpinBoardInfoForCurrentClaimRequest = null;
         this.mTileInfoForCurrentClaimRequest = null;
         this.mSpinClaimTypeForCurrentClaimRequest = "";
      }
      
      public function ReInitiateClaim() : void
      {
         if(this.mSpinBoardInfoForCurrentClaimRequest != null && this.mTileInfoForCurrentClaimRequest != null)
         {
            this.InitiateClaim(this.mSpinBoardInfoForCurrentClaimRequest,this.mTileIdForCurrentClaimRequest,this.mSpinClaimTypeForCurrentClaimRequest);
         }
         else
         {
            this.SetCurrentState(SpinBoardRewardClaimState.ClaimStateInitiated);
            this.OnClaimFailed(null);
         }
      }
      
      public function InitiateClaim(param1:SpinBoardInfo, param2:int, param3:String = "") : Boolean
      {
         var _loc5_:SpinBoardElementInfo = null;
         var _loc6_:SpinBoardPlayerDataHandler = null;
         var _loc7_:SpinBoardPlayerProgress = null;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:Boolean = false;
         var _loc11_:SpinBoardTileInfo = null;
         var _loc4_:Boolean = false;
         if(param1 != null && param2 != -1)
         {
            _loc5_ = param1.GetSpinBoardElements()[param2];
            _loc8_ = (_loc7_ = (_loc6_ = SpinBoardController.GetInstance().GetPlayerDataHandler()).GetBoardProgressByType(param1.GetType())).GetUpgradeStatus(param2);
            _loc9_ = _loc6_.HasFreeSpinAvailable();
            _loc10_ = _loc6_.AdRewardSpinAvailable();
            if(param3 == "")
            {
               param3 = !!_loc9_ ? SpinClaimType.FREE : (!!_loc10_ ? SpinClaimType.AD : SpinClaimType.PAID);
            }
            _loc11_ = _loc5_.GetTileInfo(_loc8_);
            this.ProcessClaim(param1,param2,_loc11_,param3);
            SpinBoardController.GetInstance().GetStateHandler().SetState(SpinBoardState.RewardClaim);
            _loc4_ = true;
         }
         return _loc4_;
      }
      
      public function OnRemainingClaimActionAcknowledged() : void
      {
         this.mLastSpinBoardInfoForClaimRequest = null;
         this.mLastTileInfoForClaimRequest = null;
         this.mLastTileIdForClaimRequest = 0;
         this.mLastClaimState = SpinBoardRewardClaimState.ClaimStateNotInitiated;
      }
   }
}
