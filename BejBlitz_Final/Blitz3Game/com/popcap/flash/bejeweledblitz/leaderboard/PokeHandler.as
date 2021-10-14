package com.popcap.flash.bejeweledblitz.leaderboard
{
   public class PokeHandler
   {
       
      
      private var _app:Blitz3Game;
      
      private var _leaderBoardWidget:LeaderboardWidget;
      
      private var _pokeConfirmationMessageBox:PokeWarningPopUp = null;
      
      public var playerEntry:LeaderboardListBox;
      
      public function PokeHandler(param1:Blitz3Game, param2:LeaderboardWidget)
      {
         super();
         this._app = param1;
         this._leaderBoardWidget = param2;
      }
      
      public function IsPokeInProgress(param1:LeaderboardListBox) : Boolean
      {
         return false;
      }
      
      private function GetMessageText(param1:Boolean, param2:String) : String
      {
         var _loc4_:* = null;
         var _loc3_:* = "";
         if(param1)
         {
            _loc3_ = "Are you sure you want to poke " + param2 + " ?";
         }
         else if(this.playerEntry.playerData.pokeCountFromCurrentUser >= this._leaderBoardWidget.pokeLimit)
         {
            _loc4_ = "";
            switch(this._app.mainmenuLeaderboard.pokeLimit)
            {
               case 0:
                  _loc4_ = "";
                  break;
               case 1:
                  _loc4_ = " A player can be poked once per day.";
                  break;
               default:
                  _loc4_ = " A player can be poked up to " + this._app.mainmenuLeaderboard.pokeLimit + " times a day.";
            }
            _loc3_ = "You have reached daily poke limit for " + param2 + "." + _loc4_;
         }
         else if(this.playerEntry.playerData.rank <= this._leaderBoardWidget.getCurrentPlayerData().rank)
         {
            _loc3_ = "You cannot poke people at higher rank than you in the leaderboard.";
         }
         else
         {
            _loc3_ = "You need to play the game at least once to be able to poke other players.";
         }
         return _loc3_;
      }
      
      private function ShowMessageBox(param1:Boolean, param2:LeaderboardListBox) : void
      {
         this.playerEntry = param2;
         var _loc3_:String = this.playerEntry.playerData.getPlayerName();
         if(this._pokeConfirmationMessageBox == null)
         {
            this._pokeConfirmationMessageBox = new PokeWarningPopUp(false,this._app);
            this._pokeConfirmationMessageBox.buttonClose.setPress(this.OnClickClose);
         }
         if(param1)
         {
            this._pokeConfirmationMessageBox.setUpConfirmationalDialogue(_loc3_);
         }
         else
         {
            this._pokeConfirmationMessageBox.setUpInformativeDialogue(_loc3_);
         }
         this._pokeConfirmationMessageBox.setText(this.GetMessageText(param1,_loc3_));
         this.RegisterMouseEventsForPokeMessageBox(this._pokeConfirmationMessageBox.isConfirmationalDialogue);
         this._pokeConfirmationMessageBox.show();
      }
      
      public function OnPressPoke(param1:LeaderboardListBox, param2:Boolean) : void
      {
         this.ShowMessageBox(param2,param1);
      }
      
      public function RegisterMouseEventsForPokeMessageBox(param1:Boolean) : void
      {
         if(this._pokeConfirmationMessageBox != null)
         {
            this._pokeConfirmationMessageBox.buttonYes.setPress(this.OnConfirmingPoke);
            this._pokeConfirmationMessageBox.buttonNo.setPress(this.OnDecliningPoke);
         }
      }
      
      public function DeregisterMouseEventsForPokeMessageBox() : void
      {
         if(this._pokeConfirmationMessageBox != null)
         {
            this._pokeConfirmationMessageBox.buttonYes.setPress(null);
            this._pokeConfirmationMessageBox.buttonNo.setPress(null);
         }
      }
      
      public function OnConfirmingPoke() : void
      {
         this.DeregisterMouseEventsForPokeMessageBox();
         if(this.playerEntry.isIngameList)
         {
            this._app.ingameLeaderboard.TryPoke(this.playerEntry);
         }
         else
         {
            this._app.mainmenuLeaderboard.TryPoke(this.playerEntry);
         }
      }
      
      public function OnDecliningPoke() : void
      {
         this.DeregisterMouseEventsForPokeMessageBox();
         this._leaderBoardWidget.SendTrackingEvent("Poke","Button Clicked",-1,this.playerEntry.playerData.pokeCountFromCurrentUser,this._leaderBoardWidget.GetCurrentRivalCount(),this.playerEntry.playerData);
         this.OnPokeProcessCompleted();
      }
      
      public function OnPokeProcessCompleted() : void
      {
         this._pokeConfirmationMessageBox.hide();
         this.playerEntry = null;
      }
      
      public function OnPokeResultUpdated(param1:uint) : void
      {
         this.playerEntry.playerData.pokeCountFromCurrentUser = param1;
         this.playerEntry.setAllowPoke(param1 < this._app.mainmenuLeaderboard.pokeLimit);
      }
      
      public function OnClickClose() : void
      {
         this._pokeConfirmationMessageBox.btnX.gotoAndStop("down");
         this._leaderBoardWidget.SendTrackingEvent("Poke","Button Clicked",-1,this.playerEntry.playerData.pokeCountFromCurrentUser,this._leaderBoardWidget.GetCurrentRivalCount(),this.playerEntry.playerData);
         this.OnPokeProcessCompleted();
      }
   }
}
