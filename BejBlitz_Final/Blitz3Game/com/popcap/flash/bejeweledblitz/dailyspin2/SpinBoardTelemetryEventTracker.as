package com.popcap.flash.bejeweledblitz.dailyspin2
{
   import com.popcap.flash.bejeweledblitz.Version;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   
   public class SpinBoardTelemetryEventTracker
   {
      
      public static const SEND_SPINBOARD_CLAIM_OR_PURCHASE_BOARD_METRICS:String = "sendSpinBoardClaimOrPurchaseTrackingData";
      
      public static const SEND_SPINBOARD_SHARE_METRICS:String = "sendSpinBoardCoinsSharedTrackingData";
      
      public static const SEND_SPINBOARD_ERROR_METRICS:String = "sendSpinBoardErrorTrackingData";
       
      
      public function SpinBoardTelemetryEventTracker()
      {
         super();
      }
      
      public function TrackEvent(param1:int, param2:Object) : void
      {
         switch(param1)
         {
            case SpinBoardTelemetryEventType.Claim:
            case SpinBoardTelemetryEventType.BoardPurchase:
               this.SendClaimOrBoardPurchaseTrackingEvent(param2);
               break;
            case SpinBoardTelemetryEventType.Share:
               this.SendCoinsSharedTrackingEvent(param2);
               break;
            case SpinBoardTelemetryEventType.Error:
               this.SendErrorTrackingEvent(param2);
               break;
            case SpinBoardTelemetryEventType.UI:
         }
      }
      
      public function SendErrorTrackingEvent(param1:Object) : void
      {
         Blitz3App.app.network.ExternalCall(SEND_SPINBOARD_ERROR_METRICS,{
            "ClientVersion":Version.version,
            "SNSUserID":Blitz3App.app.sessionData.userData.GetFUID(),
            "SessionID":Blitz3App.app.network.getSessionID(),
            "ErrorType":param1.ErrorType,
            "ErrorLocation":param1.ErrorLocation
         });
      }
      
      public function SendCoinsSharedTrackingEvent(param1:Object) : void
      {
         Blitz3App.app.network.ExternalCall(SEND_SPINBOARD_SHARE_METRICS,{
            "ClientVersion":Version.version,
            "SNSUserID":Blitz3App.app.sessionData.userData.GetFUID(),
            "SessionID":Blitz3App.app.network.getSessionID(),
            "BoardID":param1.BoardID,
            "BoardType":param1.BoardType,
            "RegularTilesClaimed":param1.RegularTilesClaimed,
            "RegularTileCoinReward":param1.RegularTileCoinReward,
            "SpecialTilesClaimed":param1.SpecialTilesClaimed,
            "SpecialTilesCoinReward":param1.SpecialTilesCoinReward,
            "NumFriendsShared":param1.NumFriendsShared,
            "ShareReason":param1.ShareReason
         });
      }
      
      public function SendClaimOrBoardPurchaseTrackingEvent(param1:Object) : void
      {
         Blitz3App.app.network.ExternalCall(SEND_SPINBOARD_CLAIM_OR_PURCHASE_BOARD_METRICS,{
            "ClientVersion":Version.version,
            "SNSUserID":Blitz3App.app.sessionData.userData.GetFUID(),
            "SessionID":Blitz3App.app.network.getSessionID(),
            "PurchaseType":param1.PurchaseType,
            "AmountSpent":param1.AmountSpent,
            "BoardId":param1.BoardId,
            "BoardType":(param1.BoardType == SpinBoardType.PremiumBoard ? "PremiumBoard" : "RegularBoard"),
            "SlotType":param1.SlotType,
            "ItemClaimed":param1.ItemClaimed,
            "Quantity":param1.Quantity,
            "nth_spin":param1.nth_spin,
            "ItemWeight":param1.ItemWeight,
            "SpinTypeUsed":param1.SpinTypeUsed,
            "FreeSpinBalance":param1.FreeSpinBalance,
            "PurchasedSpinBalance":param1.PurchasedSpinBalance,
            "ResetTime":param1.ResetTime
         });
      }
   }
}
