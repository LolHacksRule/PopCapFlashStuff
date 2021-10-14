package com.popcap.flash.bejeweledblitz.party
{
   import com.caurina.transitions.Tweener;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.bejeweledblitz.leaderboard.PlayerData;
   import com.popcap.flash.games.blitz3.challenge.ChallengeViewSideGame;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class PartyStateSideGame extends ChallengeViewSideGame implements IPartyState
   {
      
      private static const _END_Y:Number = 70;
      
      private static const _START_Y:Number = 300;
      
      private static const _TOTAL_Y_DELTA:Number = _END_Y - _START_Y;
       
      
      private var _app:Blitz3Game;
      
      private var _playerBitmap:Bitmap;
      
      private var _opponentBitmap:Bitmap;
      
      private var _comboWidget:PartyComboWidget;
      
      private var _btnBack:GenericButtonClip;
      
      private var _isPlayedTier0:Boolean = false;
      
      private var _isPlayedTier1:Boolean = false;
      
      private var _isPlayedTier2:Boolean = false;
      
      private var _isPlayedTier3:Boolean = false;
      
      public function PartyStateSideGame(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._playerBitmap = new Bitmap();
         this._opponentBitmap = new Bitmap();
         this._comboWidget = new PartyComboWidget(this._app,this.mcCombo);
         this._btnBack = new GenericButtonClip(this._app,this.btnBack);
         this._btnBack.setPress(this.backPress);
         this.playersContainer.imageContainerLeft.container.addChild(this._playerBitmap);
         this.playersContainer.imageContainerRight.container.addChild(this._opponentBitmap);
         this.sideBarTTHitMC.addEventListener(MouseEvent.ROLL_OVER,this.showToolTip,false,0,true);
         this.sideBarTTHitMC.addEventListener(MouseEvent.ROLL_OUT,this.hideToolTip,false,0,true);
         this.sideBarTTHitMC.useHandCursor = false;
         this.ttMC.mouseEnabled = false;
         this.ttMC.visible = false;
         this.ttMC.mouseEnabled = false;
         this.ttMC.mouseChildren = false;
         this.goalTTMC_0.addEventListener(MouseEvent.ROLL_OVER,this.showGoalToolTip,false,0,true);
         this.goalTTMC_0.addEventListener(MouseEvent.ROLL_OUT,this.hideGoalToolTip,false,0,true);
         this.goalTTMC_0.useHandCursor = false;
         this.ttMC_0.visible = false;
         this.goalTTMC_1.addEventListener(MouseEvent.ROLL_OVER,this.showGoalToolTip,false,0,true);
         this.goalTTMC_1.addEventListener(MouseEvent.ROLL_OUT,this.hideGoalToolTip,false,0,true);
         this.goalTTMC_1.useHandCursor = false;
         this.ttMC_1.visible = false;
         this.goalTTMC_2.addEventListener(MouseEvent.ROLL_OVER,this.showGoalToolTip,false,0,true);
         this.goalTTMC_2.addEventListener(MouseEvent.ROLL_OUT,this.hideGoalToolTip,false,0,true);
         this.goalTTMC_2.useHandCursor = false;
         this.ttMC_2.visible = false;
      }
      
      private function backPress() : void
      {
         Utils.log(this,"backPress called.");
         this._app.party.showWelcomeState(false);
         this._app.metaUI.highlight.Hide(true);
         this._app.metaUI.tutorial.HideArrow();
         this._app.mainState.showParty();
      }
      
      public function showBackButton(param1:Boolean) : void
      {
         this.btnBack.visible = param1;
         this.txtBack.visible = param1;
         this.txtComboHelp.visible = !param1;
      }
      
      private function showToolTip(param1:MouseEvent) : void
      {
         this.ttMC.visible = true;
         this.ttMC.gotoAndPlay(2);
      }
      
      private function hideToolTip(param1:MouseEvent) : void
      {
         this.ttMC.visible = false;
         this.ttMC.gotoAndStop(1);
      }
      
      private function showGoalToolTip(param1:MouseEvent) : void
      {
         var _loc2_:int = int(param1.target.name.substr(-1));
         var _loc3_:String = this._comboWidget.getGoalGemType(_loc2_);
         if(_loc3_ != "")
         {
            this["ttMC_" + _loc2_].visible = true;
            this["ttMC_" + _loc2_].gotoAndPlay(2);
            this["ttMC_" + _loc2_].tooltipMC.txt.htmlText = this._app.TextManager.GetLocString("LOC_BLITZ3GAME_CHALLENGE_GOAL_TOOLTIP_" + _loc3_);
         }
      }
      
      private function hideGoalToolTip(param1:MouseEvent) : void
      {
         var _loc2_:int = int(param1.target.name.substr(-1));
         this["ttMC_" + _loc2_].visible = false;
         this["ttMC_" + _loc2_].gotoAndStop(1);
      }
      
      public function update() : void
      {
         this._comboWidget.update(true);
         Tweener.removeTweens(this.mcBar);
         Tweener.removeTweens(this.playersContainer);
         var _loc1_:Number = Math.max(0,this._app.party.getPartyData().getBothPlayersScorePercent());
         Tweener.addTween(this.mcBar,{
            "scaleY":Math.max(0.001,_loc1_),
            "time":0.5
         });
         Tweener.addTween(this.playersContainer,{
            "y":_START_Y + _TOTAL_Y_DELTA * _loc1_,
            "time":0.5,
            "onUpdate":this.updateDividers
         });
      }
      
      private function updateDividers() : void
      {
         var _loc1_:Number = this._app.party.getPartyData().getTotalScore();
         this.playersContainer.txtCurrentScore.htmlText = Utils.commafy(_loc1_);
         if(this._app.party.getPartyData().isEitherPlayerFake())
         {
            return;
         }
         var _loc2_:Number = Math.floor(this._app.party.getPartyData().getBothPlayersScorePercent() * 100);
         var _loc3_:Boolean = false;
         if(_loc2_ >= 25)
         {
            if(!this._isPlayedTier0)
            {
               this.mcDivider0.gotoAndPlay("on");
               this._isPlayedTier0 = true;
               _loc3_ = true;
            }
         }
         if(_loc2_ >= 50)
         {
            if(!this._isPlayedTier1)
            {
               this.mcDivider1.gotoAndPlay("on");
               this._isPlayedTier1 = true;
               _loc3_ = true;
            }
         }
         if(_loc2_ >= 75)
         {
            if(!this._isPlayedTier2)
            {
               this.mcDivider2.gotoAndPlay("on");
               this._isPlayedTier2 = true;
               _loc3_ = true;
            }
         }
         if(_loc2_ >= 100)
         {
            if(!this._isPlayedTier3)
            {
               this.playersContainer.gotoAndStop("on");
               this._isPlayedTier3 = true;
               _loc3_ = true;
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
         if(_loc3_)
         {
            this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_COIN_COLLECTED);
         }
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
         if(this._app.sessionData.configManager.GetInt(ConfigManager.INT_FINISHED_BLITZ_PARTY_TUTORIAL) == 0)
         {
            this.mcDivider0.coinMC.visible = false;
            this.mcDivider1.coinMC.visible = false;
            this.mcDivider2.coinMC.visible = false;
            this.mcDivider3.coinMC.visible = false;
            this.txtComboHelp.text = "SCORE POINTS TO FILL THE METER!";
         }
         else
         {
            this.mcDivider0.coinMC.visible = true;
            this.mcDivider1.coinMC.visible = true;
            this.mcDivider2.coinMC.visible = true;
            this.mcDivider3.coinMC.visible = true;
            this.txtComboHelp.text = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_STATE_SIDE_BOTTOM_MESSAGE);
         }
         Utils.log(this,"reset called. hiding rare gem icons.");
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
         if(this._app.sessionData.configManager.GetInt(ConfigManager.INT_FINISHED_BLITZ_PARTY_TUTORIAL) == 0)
         {
            this.mcDivider3.txtPayoutNum.htmlText = "100%";
            this.mcDivider3.txtPayoutNum.x = 171;
            this.mcDivider2.payoutClip.txtPayoutNum.htmlText = "75%";
            this.mcDivider1.payoutClip.txtPayoutNum.htmlText = "50%";
            this.mcDivider0.payoutClip.txtPayoutNum.htmlText = "25%";
         }
         else
         {
            this.mcDivider3.txtPayoutNum.htmlText = Utils.grandify(this._app.party.getPartyData().payoutCoins100);
            this.mcDivider3.txtPayoutNum.x = 197;
            this.mcDivider2.payoutClip.txtPayoutNum.htmlText = Utils.grandify(this._app.party.getPartyData().payoutCoins75);
            this.mcDivider1.payoutClip.txtPayoutNum.htmlText = Utils.grandify(this._app.party.getPartyData().payoutCoins50);
            this.mcDivider0.payoutClip.txtPayoutNum.htmlText = Utils.grandify(this._app.party.getPartyData().payoutCoins25);
         }
         this.txtBack.mouseEnabled = false;
         this.showBackButton(false);
         this._playerBitmap.bitmapData = new BitmapData(50,50,false,3435973632);
         this.getCurrentPlayerData().copyBitmapDataTo(this._playerBitmap);
         this._playerBitmap.width = 50;
         this._playerBitmap.height = 50;
         this._opponentBitmap.bitmapData = new BitmapData(50,50,false,3435973632);
         this.getOpponentPlayerData().copyBitmapDataTo(this._opponentBitmap);
         this._opponentBitmap.height = 50;
         this._opponentBitmap.width = 50;
         this.reset();
         this.update();
         this._comboWidget.reset();
         this._comboWidget.update(false);
         if(this._app.party.getPartyData().isHighStakes())
         {
            this.bgContainer.gotoAndStop("highStakes");
         }
         else
         {
            this.bgContainer.gotoAndStop("normalStakes");
         }
         this.updateRareGems();
      }
      
      public function updateRareGems() : void
      {
         Utils.log(this,"updateRareGems called. setting player rare gem to: " + this.getCurrentPartyPlayerData().getRareGemFrameName());
         this.playerRareGemIcon.gotoAndStop(this.getCurrentPartyPlayerData().getRareGemFrameName());
         this.partnerRareGemIcon.gotoAndStop(this.getOpponentPartyPlayerData().getRareGemFrameName());
      }
      
      public function updateBackground() : void
      {
      }
      
      public function exitState() : void
      {
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
