package com.popcap.flash.bejeweledblitz.party
{
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.bejeweledblitz.leaderboard.PlayerData;
   import com.popcap.flash.games.blitz3.challenge.ChallengeViewListBox;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   
   public class PartyListBox extends ChallengeViewListBox
   {
       
      
      protected const _RIGHT_BORDER_X:Number = 225;
      
      protected const _RIGHT_PADDING:Number = 15;
      
      protected const _BTN_SPACER_X:Number = 5;
      
      protected var _app:Blitz3Game;
      
      protected var _partyListContainer:PartyListContainer;
      
      protected var _centerY:Number;
      
      protected var _isDestroyed:Boolean = false;
      
      protected var _isInteractive:Boolean = false;
      
      public var partyData:PartyData;
      
      private var _opponentBitmap:Bitmap;
      
      protected var _btnCover:GenericButtonClip;
      
      private var _btnPlay:GenericButtonClip;
      
      private var _btnDecline:GenericButtonClip;
      
      private var _isConfirming:Boolean = false;
      
      public function PartyListBox(param1:Blitz3Game, param2:PartyListContainer, param3:PartyData)
      {
         super();
         this._app = param1;
         this._partyListContainer = param2;
         this.partyData = new PartyData(this._app.sessionData.userData.GetFUID());
         this.partyData.copyFrom(param3);
         this._centerY = PartyListContainer.BOX_HEIGHT / 2;
         this._btnCover = new GenericButtonClip(this._app,this,false,true);
         this._btnCover.setShowGraphics(false);
         this._btnCover.setRollOver(this.btnRollOverCover);
         this._btnCover.setRollOut(this.btnRollOutCover);
         this._btnCover.setPress(this.btnPressCover);
         this._btnCover.setRelease(this.btnReleaseCover);
         this._btnCover.setStopPropagation(false);
         this._btnPlay = new GenericButtonClip(this._app,this.hitBoxPlay);
         this._btnPlay.setShowGraphics(false);
         this._btnPlay.setRollOver(this.btnRollOverPlay);
         this._btnPlay.setRollOut(this.btnRollOutPlay);
         this._btnPlay.setPress(this.btnPressPlay);
         this._btnPlay.setRelease(this.btnReleasePlay);
         this._btnDecline = new GenericButtonClip(this._app,this.hitBoxDecline);
         this._btnDecline.setShowGraphics(false);
         this._btnDecline.setRollOver(this.btnRollOverDecline);
         this._btnDecline.setRollOut(this.btnRollOutDecline);
         this._btnDecline.setPress(this.btnPressDecline);
         this._btnDecline.setRelease(this.btnReleaseDecline);
         this.txtName.htmlText = "";
         this.typeStakesClip.txtTime.htmlText = "";
         this.addEventListener(Event.ENTER_FRAME,this.onAdded);
      }
      
      private function btnRollOverCover() : void
      {
         if(this.partyData.isPartyTypeTeam())
         {
            if(this._isInteractive && this._app.party.isDoneWithPartyTutorial())
            {
               this._btnCover.clipListener.useHandCursor = false;
               this._btnPlay.activate();
               this._btnDecline.activate();
               this.gotoAndStop("overPartnerInteractive");
            }
            else
            {
               this.gotoAndStop("overPartner");
            }
         }
         else
         {
            this.gotoAndStop("overDuel");
         }
      }
      
      private function btnRollOutCover() : void
      {
         this._isConfirming = false;
         if(this.partyData.isPartyTypeTeam())
         {
            this.gotoAndStop("upPartner");
         }
         else
         {
            this.gotoAndStop("upDuel");
         }
         this._btnPlay.deactivate();
         this._btnDecline.deactivate();
      }
      
      private function btnPressCover() : void
      {
         if(!this._isInteractive)
         {
            this.btnRollOutCover();
         }
      }
      
      private function btnReleaseCover() : void
      {
         if(!this._app.party.isDoneWithPartyTutorial())
         {
            this.onPlayPress();
         }
         else if(!this._isInteractive)
         {
            this.btnRollOverCover();
         }
      }
      
      private function btnRollOverPlay() : void
      {
         if(this.btnPlay != null)
         {
            this.btnPlay.gotoAndStop("over");
         }
      }
      
      private function btnRollOutPlay() : void
      {
         if(this.btnPlay != null)
         {
            this.btnPlay.gotoAndStop("up");
         }
      }
      
      private function btnPressPlay() : void
      {
         this.btnRollOutPlay();
      }
      
      private function btnReleasePlay() : void
      {
         this.btnRollOverPlay();
         if(this._isConfirming)
         {
            this._isConfirming = false;
            PartyServerIO.sendDeclineParty(this.partyData.partyID);
            this._app.party.removeListBox(this.partyData.partyID);
         }
         else
         {
            this.onPlayPress();
         }
      }
      
      private function btnRollOverDecline() : void
      {
         if(this.btnDecline != null)
         {
            this.btnDecline.gotoAndStop("over");
         }
      }
      
      private function btnRollOutDecline() : void
      {
         if(this.btnDecline != null)
         {
            this.btnDecline.gotoAndStop("up");
         }
      }
      
      private function btnPressDecline() : void
      {
         this.btnRollOutDecline();
      }
      
      private function btnReleaseDecline() : void
      {
         this.btnRollOverDecline();
         if(this._isConfirming)
         {
            this._isConfirming = false;
            this.gotoAndStop("overPartnerInteractive");
         }
         else
         {
            this._isConfirming = true;
            this.gotoAndStop("overPartnerConfirm");
         }
      }
      
      private function onAdded(param1:Event) : void
      {
         if(this.txtName == null || this.typeStakesClip == null || this.typeStakesClip.mcContainer == null || this.typeStakesClip.txtGameType == null)
         {
            return;
         }
         this.removeEventListener(Event.ENTER_FRAME,this.onAdded);
         this._opponentBitmap = new Bitmap();
         this._opponentBitmap.bitmapData = new BitmapData(50,50,false);
         this.typeStakesClip.mcContainer.addChild(this._opponentBitmap);
         this.getOpponentPlayerData().copyBitmapDataTo(this._opponentBitmap,this.txtName);
         this._opponentBitmap.smoothing = true;
         this._opponentBitmap.width = 50;
         this._opponentBitmap.height = 50;
         if(this.partyData.isPartyTypeTeam())
         {
            if(this.partyData.isHighStakes())
            {
               this.typeStakesClip.gotoAndStop("partnerHigh");
            }
            else
            {
               this.typeStakesClip.gotoAndStop("partnerNormal");
            }
         }
         else if(this.partyData.isHighStakes())
         {
            this.typeStakesClip.gotoAndStop("duelHigh");
         }
         else
         {
            this.typeStakesClip.gotoAndStop("duelNormal");
         }
         if(this.partyData.isPartyTypeTeam())
         {
            this.typeStakesClip.txtGameType.htmlText = "PARTNER";
         }
         else
         {
            this.typeStakesClip.txtGameType.htmlText = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_DUEL_LABEL);
         }
         if(this.partyData.isEitherPlayerFake())
         {
            this.typeStakesClip.txtTime.visible = false;
         }
      }
      
      public function destroy() : void
      {
         if(!this._isDestroyed)
         {
            this._isDestroyed = true;
            this._app = null;
            this._partyListContainer = null;
            this.partyData.destroy();
            this.partyData = null;
            this._opponentBitmap = null;
         }
      }
      
      protected function onStatusPress() : void
      {
         this._app.party.showSideListStatus(this.partyData);
      }
      
      protected function onCollectPress() : void
      {
         this._app.party.showResultsState(this.partyData);
      }
      
      protected function onPlayPress() : void
      {
         this._app.party.showGameState(this.partyData);
         this._app.party.removeListBox(this.partyData.partyID);
      }
      
      protected function getCurrentPlayerData() : PlayerData
      {
         return this.getCurrentPartyPlayerData().getPlayerData();
      }
      
      protected function getCurrentPartyPlayerData() : PartyPlayerData
      {
         return this.partyData.getCurrentPartyPlayerData();
      }
      
      protected function getOpponentPlayerData() : PlayerData
      {
         return this.getOpponentPartyPlayerData().getPlayerData();
      }
      
      protected function getOpponentPartyPlayerData() : PartyPlayerData
      {
         return this.partyData.getOpponentPartyPlayerData();
      }
   }
}
