package com.popcap.flash.bejeweledblitz.party
{
   import com.caurina.transitions.Tweener;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.bejeweledblitz.leaderboard.PlayerData;
   import com.popcap.flash.games.blitz3.challenge.ChallengeViewSideListStatus;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   
   public class PartyStateSideListStatus extends ChallengeViewSideListStatus implements IPartyState
   {
      
      private static const _END_Y:Number = 70;
      
      private static const _START_Y:Number = 300;
      
      private static const _TOTAL_Y_DELTA:Number = _END_Y - _START_Y;
      
      private static const _MAX_NAME_LENGTH:Number = 14;
       
      
      private var _app:Blitz3Game;
      
      private var _playerBitmap:Bitmap;
      
      private var _opponentBitmap:Bitmap;
      
      private var _comboWidget:PartyComboWidget;
      
      private var _btnDone:GenericButtonClip;
      
      private var _btnRemind:GenericButtonClip;
      
      private var _isPlayedTier0:Boolean = false;
      
      private var _isPlayedTier1:Boolean = false;
      
      private var _isPlayedTier2:Boolean = false;
      
      private var _isPlayedTier3:Boolean = false;
      
      public function PartyStateSideListStatus(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._playerBitmap = new Bitmap();
         this._opponentBitmap = new Bitmap();
         this.txtBtnDone.mouseEnabled = false;
         this.txtBtnRemind.mouseEnabled = false;
         this._btnDone = new GenericButtonClip(this._app,this.btnDone);
         this._btnDone.setPress(this.donePress);
         this._btnRemind = new GenericButtonClip(this._app,this.btnRemind);
         this._btnRemind.setRelease(this.remindPress);
         this._comboWidget = new PartyComboWidget(this._app,this.mcCombo);
         this.txtBtnDone.htmlText = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_STATE_SIDE_LIST_STATUS_BACK);
         this.txtBtnRemind.htmlText = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_STATE_SIDE_LIST_STATUS_REMIND);
         this.playersContainer.imageContainerLeft.container.addChild(this._playerBitmap);
         this.playersContainer.imageContainerRight.container.addChild(this._opponentBitmap);
      }
      
      public function reset() : void
      {
         this._isPlayedTier0 = false;
         this._isPlayedTier1 = false;
         this._isPlayedTier2 = false;
         this._isPlayedTier3 = false;
         this.mcDivider0.gotoAndStop("off");
         this.mcDivider1.gotoAndStop("off");
         this.mcDivider2.gotoAndStop("off");
         this.mcDivider3.gotoAndStop("off");
         this.playersContainer.gotoAndStop("off");
         this.playersContainer.y = _START_Y;
         this.mcBar.scaleY = 0.01;
         this.playerRareGemIcon.gotoAndStop("off");
         this.partnerRareGemIcon.gotoAndStop("off");
      }
      
      public function getClip() : MovieClip
      {
         return this;
      }
      
      public function enterState() : void
      {
         Utils.log(this,"enterState called.");
         var _loc1_:Number = this._app.party.getPartyData().targetScore;
         this.mcDivider3.txtTargetScore.htmlText = Utils.grandify(_loc1_);
         this.mcDivider2.txtTargetScore.htmlText = Utils.grandify(_loc1_ * 0.75);
         this.mcDivider1.txtTargetScore.htmlText = Utils.grandify(_loc1_ * 0.5);
         this.mcDivider0.txtTargetScore.htmlText = Utils.grandify(_loc1_ * 0.25);
         this.mcDivider3.txtPayoutNum.htmlText = Utils.grandify(this._app.party.getPartyData().payoutCoins100);
         this.mcDivider2.payoutClip.txtPayoutNum.htmlText = Utils.grandify(this._app.party.getPartyData().payoutCoins75);
         this.mcDivider1.payoutClip.txtPayoutNum.htmlText = Utils.grandify(this._app.party.getPartyData().payoutCoins50);
         this.mcDivider0.payoutClip.txtPayoutNum.htmlText = Utils.grandify(this._app.party.getPartyData().payoutCoins25);
         this.getCurrentPlayerData().copyBitmapDataTo(this._playerBitmap);
         this.getOpponentPlayerData().copyBitmapDataTo(this._opponentBitmap);
         this.reset();
         Tweener.removeTweens(this.mcBar);
         Tweener.removeTweens(this.playersContainer);
         var _loc2_:Number = Math.max(0,this._app.party.getPartyData().getBothPlayersScorePercent());
         Tweener.addTween(this.mcBar,{
            "scaleY":Math.max(0.001,_loc2_),
            "time":0.5
         });
         Tweener.addTween(this.playersContainer,{
            "y":_START_Y + _TOTAL_Y_DELTA * _loc2_,
            "time":0.5,
            "onUpdate":this.updateDividers
         });
         this._comboWidget.reset();
         this._comboWidget.update(true);
         if(this._app.party.getPartyData().isHighStakes())
         {
            this.bgContainer.gotoAndStop("highStakes");
         }
         else
         {
            this.bgContainer.gotoAndStop("normalStakes");
         }
         this.playerRareGemIcon.gotoAndStop(this.getCurrentPartyPlayerData().getRareGemFrameName());
         this.partnerRareGemIcon.gotoAndStop(this.getOpponentPartyPlayerData().getRareGemFrameName());
      }
      
      private function updateDividers() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Number = Math.floor(this._app.party.getPartyData().getBothPlayersScorePercent() * 100);
         if(_loc2_ >= 25)
         {
            if(!this._isPlayedTier0)
            {
               this.mcDivider0.gotoAndPlay("on");
               this._isPlayedTier0 = true;
               _loc1_ = true;
            }
         }
         if(_loc2_ >= 50)
         {
            if(!this._isPlayedTier1)
            {
               this.mcDivider1.gotoAndPlay("on");
               this._isPlayedTier1 = true;
               _loc1_ = true;
            }
         }
         if(_loc2_ >= 75)
         {
            if(!this._isPlayedTier2)
            {
               this.mcDivider2.gotoAndPlay("on");
               this._isPlayedTier2 = true;
               _loc1_ = true;
            }
         }
         if(_loc2_ >= 100)
         {
            if(!this._isPlayedTier3)
            {
               this.playersContainer.gotoAndStop("on");
               this._isPlayedTier3 = true;
               _loc1_ = true;
            }
            if(this._app.party.getPartyData().areComboRequirementsMet())
            {
               this.mcDivider3.gotoAndStop("perfect");
            }
            else
            {
               this.mcDivider3.gotoAndStop("on");
            }
         }
         if(_loc1_)
         {
            this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_COIN_COLLECTED);
         }
         var _loc3_:Number = this._app.party.getPartyData().getTotalScore();
         this.playersContainer.txtCurrentScore.htmlText = Utils.commafy(_loc3_);
      }
      
      public function exitState() : void
      {
      }
      
      private function donePress() : void
      {
         this._app.party.showSideList();
      }
      
      private function remindPress() : void
      {
         Utils.log(this,"remindPress called.");
         var _loc1_:PartyData = this._app.party.getPartyData();
         PartyServerIO.sendWallPost(_loc1_.getOpponentPartyPlayerData().getPlayerData().playerName,_loc1_.getOpponentPartyPlayerData().getPlayerData().playerFuid,_loc1_.getCurrentPartyPlayerData().playerScore,_loc1_.getOpponentPartyPlayerData().playerScore,_loc1_.getTotalScore(),_loc1_.payoutCoinsTotal,true,_loc1_.isHighStakes(),_loc1_.getTierIndex());
      }
      
      protected function getCurrentPlayerData() : PlayerData
      {
         return this.getCurrentPartyPlayerData().getPlayerData();
      }
      
      protected function getCurrentPartyPlayerData() : PartyPlayerData
      {
         return this._app.party.getPartyData().getCurrentPartyPlayerData();
      }
      
      protected function getOpponentPlayerData() : PlayerData
      {
         return this.getOpponentPartyPlayerData().getPlayerData();
      }
      
      protected function getOpponentPartyPlayerData() : PartyPlayerData
      {
         return this._app.party.getPartyData().getOpponentPartyPlayerData();
      }
   }
}
