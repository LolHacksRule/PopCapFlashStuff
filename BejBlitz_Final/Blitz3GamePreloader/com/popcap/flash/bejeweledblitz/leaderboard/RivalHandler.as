package com.popcap.flash.bejeweledblitz.leaderboard
{
   public class RivalHandler
   {
       
      
      private var _app:Blitz3Game;
      
      private var _leaderBoardWidget:LeaderboardWidget;
      
      private var _flagConfirmationMessageBox:PokeWarningPopUp = null;
      
      public var playerEntry:LeaderboardListBox;
      
      public function RivalHandler(param1:Blitz3Game, param2:LeaderboardWidget)
      {
         super();
         this._app = param1;
         this._leaderBoardWidget = param2;
      }
      
      public function IsFlagInProgress(param1:LeaderboardListBox) : Boolean
      {
         return this.playerEntry != null && this.playerEntry != param1;
      }
      
      private function GetMessageText(param1:Boolean, param2:Boolean, param3:String) : String
      {
         var _loc4_:* = "";
         if(param1)
         {
            _loc4_ = param3 + " will be flagged as your rival, Confirm?";
         }
         else if(param2)
         {
            _loc4_ = param3 + " will no longer be your rival, Confirm?";
         }
         else if(this._leaderBoardWidget.flagLimit == 1)
         {
            _loc4_ = "You can only flag one person as your rival. Please unflag your current rival to flag a new one.";
         }
         else
         {
            _loc4_ = "You can only flag " + this._leaderBoardWidget.flagLimit + " people as your rivals. Please unflag an existing rival to flag a new one.";
         }
         return _loc4_;
      }
      
      private function ShowMessageBox(param1:LeaderboardListBox, param2:Boolean, param3:Boolean) : void
      {
         this.playerEntry = param1;
         var _loc4_:String = this.playerEntry.playerData.getPlayerName();
         if(this._flagConfirmationMessageBox == null)
         {
            this._flagConfirmationMessageBox = new PokeWarningPopUp(true,this._app);
            this._flagConfirmationMessageBox.buttonClose.setPress(this.OnClickClose);
         }
         if(param2 || param3)
         {
            this._flagConfirmationMessageBox.setUpConfirmationalDialogue(_loc4_);
         }
         else
         {
            this._flagConfirmationMessageBox.setUpInformativeDialogue(_loc4_);
         }
         this._flagConfirmationMessageBox.setText(this.GetMessageText(param2,param3,_loc4_));
         this.RegisterMouseEventsForFlagMessageBox();
         this._flagConfirmationMessageBox.show();
      }
      
      public function OnPressFlag(param1:LeaderboardListBox, param2:Boolean, param3:Boolean) : void
      {
         this.ShowMessageBox(param1,param2,param3);
      }
      
      public function RegisterMouseEventsForFlagMessageBox() : void
      {
         if(this._flagConfirmationMessageBox != null)
         {
            this._flagConfirmationMessageBox.buttonYes.setPress(this.OnConfirmingFlag);
            this._flagConfirmationMessageBox.buttonNo.setPress(this.OnDecliningFlag);
         }
      }
      
      public function DeregisterMouseEventsForFlagMessageBox() : void
      {
         if(this._flagConfirmationMessageBox != null)
         {
            this._flagConfirmationMessageBox.buttonYes.setPress(null);
            this._flagConfirmationMessageBox.buttonNo.setPress(null);
         }
      }
      
      public function OnConfirmingFlag() : void
      {
         this.DeregisterMouseEventsForFlagMessageBox();
         if(this.playerEntry.isIngameList)
         {
            this._app.ingameLeaderboard.TryFlag(this.playerEntry);
         }
         else
         {
            this._app.mainmenuLeaderboard.TryFlag(this.playerEntry);
         }
      }
      
      public function OnDecliningFlag() : void
      {
         this.DeregisterMouseEventsForFlagMessageBox();
         this._leaderBoardWidget.SendTrackingEvent("Flag","Button Clicked",-1,this.playerEntry.playerData.pokeCountFromCurrentUser,this._leaderBoardWidget.GetCurrentRivalCount(),this.playerEntry.playerData);
         this.OnFlagProcessCompleted();
      }
      
      public function OnFlagProcessCompleted() : void
      {
         this._flagConfirmationMessageBox.hide();
         this.playerEntry = null;
      }
      
      public function OnFlagStatusUpdated(param1:Boolean) : void
      {
         this.playerEntry.playerData.isFlaggedByCurrentUser = param1;
         this._app.DispatchValidatePokeAndFlagButtonsForPlayer(this.playerEntry.playerData);
      }
      
      public function OnClickClose() : void
      {
         this._flagConfirmationMessageBox.btnX.gotoAndStop("down");
         this._leaderBoardWidget.SendTrackingEvent("Flag","Button Clicked",-1,this.playerEntry.playerData.pokeCountFromCurrentUser,this._leaderBoardWidget.GetCurrentRivalCount(),this.playerEntry.playerData);
         this.OnFlagProcessCompleted();
      }
   }
}
