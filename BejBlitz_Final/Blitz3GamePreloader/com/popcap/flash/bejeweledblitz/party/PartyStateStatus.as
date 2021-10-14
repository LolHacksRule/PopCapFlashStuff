package com.popcap.flash.bejeweledblitz.party
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.games.blitz3.challenge.ChallengeViewStatus;
   import com.popcap.flash.games.blitz3.challenge.SimpleGemView;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class PartyStateStatus extends ChallengeViewStatus implements IPartyState
   {
      
      private static const _MAX_COUNTDOWN_TIME:Number = 60000;
       
      
      private var _app:Blitz3Game;
      
      private var _onDoneCallback:Function;
      
      private var _isCountingDown:Boolean = false;
      
      private var _startTime:Number = 0;
      
      private var _isSendWallPostChecked:Boolean = false;
      
      private var _specialGemArray:Vector.<SimpleGemView>;
      
      private var _btnRetry:GenericButtonClip;
      
      private var _btnSubmit:GenericButtonClip;
      
      private var _btnCheck:GenericButtonClip;
      
      public function PartyStateStatus(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._btnRetry = new GenericButtonClip(this._app,this.btnRetry);
         this._btnRetry.setPress(this.payRetryPress);
         this._btnSubmit = new GenericButtonClip(this._app,this.btnSubmit);
         this._btnSubmit.setPress(this.finalizePress);
         this._specialGemArray = new Vector.<SimpleGemView>();
         this._specialGemArray.push(this.gem0);
         this._specialGemArray.push(this.gem1);
         this._specialGemArray.push(this.gem2);
      }
      
      public function setDoneCallback(param1:Function = null) : void
      {
         this._onDoneCallback = param1;
      }
      
      public function getClip() : MovieClip
      {
         return this;
      }
      
      public function enterState() : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         (this._app.ui as MainWidgetGame).menu.leftPanel.showMainButton(true);
         (this._app.ui as MainWidgetGame).menu.leftPanel.showKeyStoneButton(true);
         this._app.quest.Show(true);
         this._app.party.togglePartyBGVisibility(true);
         var _loc1_:int = this._app.sessionData.configManager.GetInt(ConfigManager.INT_FINISHED_BLITZ_PARTY_TUTORIAL);
         this.txtHeader.htmlText = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_STATUS_HEADER);
         this.txtPointsScored.htmlText = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_STATUS_POINTS);
         if(_loc1_ == 0 || _loc1_ == 1)
         {
            if(_loc1_ == 1)
            {
               this.txtQuestion.htmlText = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_STATE_STATUS_QUESTION_LIMITED);
            }
            else
            {
               this.txtQuestion.htmlText = "";
            }
            this.btnSubmit.txtSubmit.htmlText = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_CONTINUE);
            this.txtTime.htmlText = "";
            this.youCanCollectT.htmlText = "";
            this._btnRetry.clipListener.visible = false;
            this.showGems(false);
            this._btnSubmit.clipListener.x = this.txtTime.x + this.txtTime.width / 2;
         }
         else
         {
            this._btnSubmit.clipListener.x = 374;
            _loc2_ = this._app.party.getPartyData().getTierIndex();
            _loc3_ = new String();
            if(_loc2_ == 0)
            {
               _loc3_ = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_STATE_STATUS_QUESTION_0_GOALS);
            }
            else if(_loc2_ == 4)
            {
               _loc3_ = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_STATE_STATUS_QUESTION_PERFECT);
            }
            else
            {
               _loc3_ = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_STATE_STATUS_QUESTION_N_GOALS).replace("%GOALS%",_loc2_);
            }
            this.txtQuestion.htmlText = _loc3_;
            if(this._app.party.getPartyData().isPlayerSender())
            {
               this.youCanCollectT.htmlText = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_STATE_STATUS_FOOTER);
            }
            else
            {
               this.youCanCollectT.htmlText = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_STATE_STATUS_FOOTER_P2);
            }
            this.btnRetry.txtTryAgain.htmlText = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_STATE_STATUS_TRY_AGAIN_BTN);
            this.btnSubmit.txtSubmit.htmlText = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_STATE_STATUS_SEND_BTN);
            this._btnRetry.activate();
            this._btnRetry.clipListener.alpha = 1;
            this._btnRetry.clipListener.visible = true;
            if(this._app.party.getPartyData().canReplay)
            {
               this._app.party.getPartyData().canReplay = false;
               this.startCountdown();
            }
            _loc4_ = PartyServerIO.getCloseStakeCostIndex(this._app.party.getPartyData().stakesNum);
            _loc5_ = String(PartyServerIO.stakesArray[_loc4_].retryCost);
            if(this.btnRetry.tokenCostT)
            {
               this.btnRetry.tokenCostT.text = _loc5_;
            }
            this.showGems(true);
            this.updateGems();
         }
         this._btnSubmit.setPress(this.finalizePress);
         this._btnSubmit.activate();
         this.txtPlayerScoreNum.htmlText = Utils.commafy(this._app.party.getPartyData().getCurrentPartyPlayerData().playerScore);
         if(this._app.party.getPartyData().isHighStakes())
         {
            this.mcRetryCoins.gotoAndStop("on");
         }
         else
         {
            this.mcRetryCoins.gotoAndStop("off");
         }
      }
      
      private function showGems(param1:Boolean) : void
      {
         this.gem0.visible = param1;
         this.gem1.visible = param1;
         this.gem2.visible = param1;
      }
      
      private function updateGems() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = this._app.party.getPartyData().targetCombo.hypercubeCount;
         if(_loc2_ > 0)
         {
            this._specialGemArray[_loc1_].mcGem.gotoAndStop("hyper");
            this._specialGemArray[_loc1_].txtProgress.htmlText = String(this._app.party.getPartyData().getCurrentPartyPlayerData().comboData.getTotalHypercubes());
            this._specialGemArray[_loc1_].txtGemName.htmlText = "Hypercubes";
            _loc1_++;
         }
         var _loc3_:uint = this._app.party.getPartyData().targetCombo.multiplierType;
         if(_loc3_ > 0)
         {
            this._specialGemArray[_loc1_].mcGem.gotoAndStop("multi");
            this._specialGemArray[_loc1_].txtProgress.htmlText = String(this._app.party.getPartyData().getCurrentPartyPlayerData().comboData.multiplierCount);
            this._specialGemArray[_loc1_].txtGemName.htmlText = "Multipliers";
            _loc1_++;
         }
         var _loc4_:String;
         if((_loc4_ = this._app.party.getPartyData().targetCombo.getFirstFlameColor()) != "")
         {
            this._specialGemArray[_loc1_].mcGem.gotoAndStop("flame" + Utils.getFirstUppercase(_loc4_));
            this._specialGemArray[_loc1_].txtProgress.htmlText = String(this._app.party.getPartyData().getTotalFlames(_loc4_));
            this._specialGemArray[_loc1_].txtGemName.htmlText = "Flame Gems";
            _loc1_++;
         }
         var _loc5_:String = this._app.party.getPartyData().targetCombo.getFirstStarColor();
         if(_loc1_ <= 2 && _loc5_ != "")
         {
            this._specialGemArray[_loc1_].mcGem.gotoAndStop("star" + Utils.getFirstUppercase(_loc5_));
            this._specialGemArray[_loc1_].txtProgress.htmlText = String(this._app.party.getPartyData().getTotalStars(_loc5_));
            this._specialGemArray[_loc1_].txtGemName.htmlText = "Star Gems";
            _loc1_++;
         }
      }
      
      public function exitState() : void
      {
         if(!this._isCountingDown)
         {
            this.sendFinalize();
         }
         this._app.party.togglePartyBGVisibility(false);
      }
      
      public function startCountdown() : void
      {
         if(!this._app.party.isDoneWithPartyTutorial())
         {
            return;
         }
         this._startTime = getTimer();
         if(!this._isCountingDown && this._btnRetry.isActive())
         {
            this._isCountingDown = true;
            this.addEventListener(Event.ENTER_FRAME,this.onCountdown);
         }
      }
      
      public function stopCountdown() : void
      {
         if(this._isCountingDown)
         {
            this.txtTime.htmlText = "";
            this._isCountingDown = false;
            this.removeEventListener(Event.ENTER_FRAME,this.onCountdown);
         }
      }
      
      private function onCountdown(param1:Event) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:String = null;
         var _loc2_:Number = getTimer() - this._startTime;
         if(_loc2_ >= _MAX_COUNTDOWN_TIME)
         {
            this.stopCountdown();
            this.txtTime.htmlText = ":00";
            this._btnRetry.deactivate();
            this._btnRetry.clipListener.alpha = 0.2;
            PartyServerIO.setFinalizeScoreCallback(this.onFinalize);
            this.sendFinalize();
            this.btnSubmit.txtSubmit.htmlText = "SEND SCORE";
            this._btnSubmit.setPress(this.nextPress);
         }
         else
         {
            _loc3_ = Math.floor((_MAX_COUNTDOWN_TIME - _loc2_) / 1000);
            _loc4_ = String(_loc3_);
            if(_loc3_ < 10)
            {
               _loc4_ = "0" + String(_loc3_);
            }
            this.txtTime.htmlText = ":" + _loc4_;
         }
      }
      
      private function checkPress() : void
      {
         this._isSendWallPostChecked = !this._isSendWallPostChecked;
      }
      
      private function nextPress() : void
      {
         visible = false;
         if(this._isSendWallPostChecked)
         {
            this.sendWallPostHalfway();
         }
         if(this._onDoneCallback != null)
         {
            this._onDoneCallback.call();
         }
      }
      
      private function payRetryPress() : void
      {
         Utils.log(this,"onPayRetryPress called.");
         var _loc1_:uint = PartyServerIO.getCloseStakeCostIndex(this._app.party.getPartyData().stakesNum);
         var _loc2_:uint = uint(PartyServerIO.stakesArray[_loc1_].retryCost);
         if(PartyServerIO.purchasedTokens >= _loc2_)
         {
            this._btnRetry.deactivate();
            this._btnSubmit.deactivate();
            this.stopCountdown();
            this._app.party.showRetry();
         }
         else
         {
            this.stopCountdown();
            this._app.party.showOutOfTokens();
         }
      }
      
      private function onStartCallback() : void
      {
         PartyServerIO.setStartPartyCallback();
         if(PartyServerIO.currentPartyData.isValid)
         {
            this._app.party.showGameState(PartyServerIO.currentPartyData);
         }
         else
         {
            Utils.log(this,"onStartCallback :: ERROR server prevented new game from being started.");
         }
      }
      
      private function sendFinalize() : void
      {
         this.stopCountdown();
         PartyServerIO.sendFinalaizeScore(this._app.party.getPartyData().partyID);
         this._btnRetry.deactivate();
         this._btnRetry.clipListener.alpha = 0.2;
         this.txtTime.htmlText = ":00";
      }
      
      private function finalizePress() : void
      {
         if(this._app.sessionData.configManager.GetInt(ConfigManager.INT_FINISHED_BLITZ_PARTY_TUTORIAL) >= 2)
         {
            PartyServerIO.reset();
            PartyServerIO.setFinalizeScoreCallback(this.onFinalize);
            this.sendFinalize();
            visible = false;
            this._app.metaUI.highlight.showLoadingWheel();
         }
         else
         {
            if(this._app.sessionData.configManager.GetInt(ConfigManager.INT_FINISHED_BLITZ_PARTY_TUTORIAL) == 0)
            {
               this._app.sessionData.configManager.SetInt(ConfigManager.INT_FINISHED_BLITZ_PARTY_TUTORIAL,1);
               this._app.sessionData.configManager.CommitChanges();
            }
            else if(this._app.sessionData.configManager.GetInt(ConfigManager.INT_FINISHED_BLITZ_PARTY_TUTORIAL) == 1)
            {
               this._app.sessionData.configManager.SetInt(ConfigManager.INT_FINISHED_BLITZ_PARTY_TUTORIAL,2);
               this._app.sessionData.configManager.CommitChanges();
            }
            this.stopCountdown();
            this._app.party.showWelcomeState();
         }
      }
      
      private function onFinalize() : void
      {
         this._app.metaUI.highlight.stopNetworkTimeoutDialog();
         this._app.metaUI.highlight.Hide(true);
         this._app.party.getPartyData().copyFrom(PartyServerIO.currentPartyData);
         if(this._app.party.getPartyData().isPlayerSender())
         {
            PartyServerIO.sendMultiplayerGameRequest();
         }
         this.nextPress();
      }
      
      private function sendWallPostHalfway() : void
      {
         var _loc1_:PartyData = this._app.party.getPartyData();
         PartyServerIO.sendWallPost(_loc1_.getOpponentPartyPlayerData().getPlayerData().playerName,_loc1_.getOpponentPartyPlayerData().getPlayerData().playerFuid,_loc1_.getCurrentPartyPlayerData().playerScore,_loc1_.getOpponentPartyPlayerData().playerScore,_loc1_.getTotalScore(),_loc1_.payoutCoinsTotal,true,_loc1_.isHighStakes(),_loc1_.getTierIndex());
      }
   }
}
