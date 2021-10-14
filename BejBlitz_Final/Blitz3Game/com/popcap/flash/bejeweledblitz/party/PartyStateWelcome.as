package com.popcap.flash.bejeweledblitz.party
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.dailyspin2.UI.SpinBoardUIController;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.SingleButtonDialog;
   import com.popcap.flash.bejeweledblitz.game.ui.options.OptionMenuWidget;
   import com.popcap.flash.games.blitz3.challenge.ChallengeViewWelcome;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class PartyStateWelcome extends ChallengeViewWelcome implements IPartyState
   {
      
      private static const _MAX_STAKE_CHOICES:uint = 4;
      
      private static const _DEFAULT_STAKE_INDEX:uint = 2;
       
      
      private var _app:Blitz3Game;
      
      private var _isCountingDown:Boolean = false;
      
      private var _btnAddFriends:GenericButtonClip;
      
      private var _btnHelp:GenericButtonClip;
      
      private var _btnStakeArray:Vector.<GenericButtonClip>;
      
      private var _options:OptionMenuWidget;
      
      private var _errorPopup:SingleButtonDialog;
      
      private var _seriousErrorPopup:SingleButtonDialog;
      
      private var _featureNotUnlocked:ThrottledOffButInOverlay;
      
      private var _currentStakeIndex:int = -1;
      
      public function PartyStateWelcome(param1:Blitz3Game)
      {
         var _loc4_:GenericButtonClip = null;
         super();
         this._app = param1;
         this._btnAddFriends = new GenericButtonClip(this._app,this.btnAdd);
         this._btnAddFriends.setPress(this.onInvitePress);
         this._btnHelp = new GenericButtonClip(this._app,this.btnHelp);
         this._btnStakeArray = new Vector.<GenericButtonClip>();
         var _loc2_:uint = 0;
         while(_loc2_ < _MAX_STAKE_CHOICES)
         {
            (_loc4_ = new GenericButtonClip(this._app,this.getChildByName("btnStake" + _loc2_) as MovieClip)).setShowGraphics(false);
            _loc4_.setPress(this.stakePress,_loc2_);
            _loc4_.setRollOver(this.stakeRollOver,_loc2_);
            _loc4_.setRollOut(this.stakeRollOut,_loc2_);
            _loc4_.setDragOut(this.stakeRollOut,_loc2_);
            this._btnStakeArray.push(_loc4_);
            _loc2_++;
         }
         this._errorPopup = new SingleButtonDialog(this._app,16);
         this._errorPopup.Init();
         this._errorPopup.SetDimensions(420,200);
         this._errorPopup.SetContent("COMING SOON","We\'re currently working on this feature.<br/>Please try again later!","CONTINUE");
         this._errorPopup.AddContinueButtonHandler(this.errorPress);
         this._errorPopup.x = Dimensions.GAME_WIDTH / 2 - this._errorPopup.width / 2;
         this._errorPopup.y = Dimensions.PARTY_HEIGHT / 2 - this._errorPopup.height / 2 + 12;
         this._seriousErrorPopup = new SingleButtonDialog(this._app,16);
         this._seriousErrorPopup.Init();
         this._seriousErrorPopup.SetDimensions(420,200);
         this._seriousErrorPopup.AddContinueButtonHandler(this.featureErrorPress);
         this._seriousErrorPopup.x = Dimensions.GAME_WIDTH / 2 - this._errorPopup.width / 2;
         this._seriousErrorPopup.y = Dimensions.PARTY_HEIGHT / 2 - this._errorPopup.height / 2 + 12;
         var _loc3_:Shape = new Shape();
         _loc3_.graphics.beginFill(0,0.6);
         _loc3_.graphics.drawRect(0,0,Dimensions.GAME_WIDTH * 2,Dimensions.PARTY_HEIGHT * 2);
         _loc3_.x = this._errorPopup.x + this._errorPopup.width / 2 - _loc3_.width / 2;
         _loc3_.y = this._errorPopup.y + this._errorPopup.height / 2 - _loc3_.height / 2;
      }
      
      private function stakeRollOver(param1:int) : void
      {
         (this.getChildByName("btnBg" + param1) as MovieClip).gotoAndStop("over");
         this.showDealBurst(param1);
      }
      
      private function hideHighlights() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < _MAX_STAKE_CHOICES)
         {
            (this.getChildByName("btnBg" + _loc1_) as MovieClip).gotoAndStop("up");
            _loc1_++;
         }
      }
      
      private function showExclusiveHighlight(param1:int) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < _MAX_STAKE_CHOICES)
         {
            if(_loc2_ == param1)
            {
               (this.getChildByName("btnBg" + _loc2_) as MovieClip).gotoAndStop("down");
            }
            else
            {
               (this.getChildByName("btnBg" + _loc2_) as MovieClip).gotoAndStop("up");
            }
            _loc2_++;
         }
      }
      
      private function showDealBurst(param1:int = 3.0) : void
      {
         if(param1 == _MAX_STAKE_CHOICES - 1)
         {
            this.mcDeal.gotoAndPlay(1);
         }
      }
      
      private function stakeRollOut(param1:int) : void
      {
         if(param1 != this._currentStakeIndex)
         {
            (this.getChildByName("btnBg" + param1) as MovieClip).gotoAndStop("up");
         }
      }
      
      private function errorPress(param1:MouseEvent) : void
      {
         this._app.metaUI.highlight.hidePopUp();
         this._app.party.startStatusCountdown();
      }
      
      private function featureErrorPress(param1:MouseEvent) : void
      {
         this._app.network.Refresh();
      }
      
      public function getClip() : MovieClip
      {
         return this;
      }
      
      public function enterState() : void
      {
         this._app.quest.Show(true);
         this._app.party.togglePartyBGVisibility(false);
         this._app.party.reAlignSideGame();
         var _loc1_:MainWidgetGame = this._app.ui as MainWidgetGame;
         SpinBoardUIController.GetInstance().CloseSpinBoard();
         (this._app.ui as MainWidgetGame).menu.leftPanel.onPartyScreen();
         this.visible = true;
         this._app.party.showOutOfTokens(false);
         PartyServerIO.sendPartyOpen();
         var _loc2_:int = this._app.sessionData.configManager.GetInt(ConfigManager.INT_FINISHED_BLITZ_PARTY_TUTORIAL);
         if(_loc2_ == 0)
         {
            this._app.party.showTutorial(1);
         }
         else if(_loc2_ == 1)
         {
            this._app.party.showTutorial(5);
         }
         else if(_loc2_ == 2)
         {
            this._app.party.showTutorial();
         }
         else if(_loc2_ == 3)
         {
            this._app.party.showTutorial(8);
         }
         this._currentStakeIndex = -1;
         this.hideHighlights();
         this.handleStatsDisplay();
         this.showDealBurst();
      }
      
      public function exitState() : void
      {
         this.stopCountdown();
      }
      
      private function backPress() : void
      {
         if(this._featureNotUnlocked)
         {
            removeChild(this._featureNotUnlocked);
            this._featureNotUnlocked = null;
         }
         this.stopCountdown();
         this._app.mainState.GotoMainMenu();
      }
      
      private function startCountdown() : void
      {
         this.txtCountdown.htmlText = "";
         if(!this._isCountingDown)
         {
            this._isCountingDown = true;
            this.addEventListener(Event.ENTER_FRAME,this.updateCountdown);
         }
      }
      
      private function stopCountdown() : void
      {
         this.txtCountdown.htmlText = "";
         if(this._isCountingDown)
         {
            this.removeEventListener(Event.ENTER_FRAME,this.updateCountdown);
            this._isCountingDown = false;
         }
      }
      
      private function updateCountdown(param1:Event = null) : void
      {
         if(PartyServerIO.freeTokens > 0)
         {
            this.handleStatsDisplay();
         }
         else if(PartyServerIO.getFreeTokensSecondsRemaining() > 0)
         {
            this.txtCountdown.htmlText = "FREE Game in:<br/>" + Utils.getHourStringFromSeconds(PartyServerIO.getFreeTokensSecondsRemaining());
         }
         else
         {
            this.txtCountdown.htmlText = "";
            this.stopCountdown();
            PartyServerIO.setUpdateStatsCallback(this.onStatsCallback);
            PartyServerIO.sendUpdateStats();
         }
      }
      
      private function onStatsCallback() : void
      {
         if(PartyServerIO.getFreeTokensSecondsRemaining() > 0)
         {
            this.handleStatsDisplay();
         }
      }
      
      private function handleStatsDisplay() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:uint = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:Number = NaN;
         if(!(PartyServerIO.stakesArray.length < _MAX_STAKE_CHOICES || PartyServerIO.stakesArray[0].stakeCost == null || PartyServerIO.stakesArray[0].stakeCost <= 0 || PartyServerIO.stakesArray[0].coinsMax == null || PartyServerIO.stakesArray[0].coinsMax <= 0))
         {
            _loc2_ = this.mcCoin0.width;
            _loc3_ = 0;
            while(_loc3_ < _MAX_STAKE_CHOICES)
            {
               (this.getChildByName("txtWinNum" + _loc3_) as TextField).htmlText = Utils.commafy(PartyServerIO.stakesArray[_loc3_].coinsMax);
               (this.getChildByName("txtCostNum" + _loc3_) as TextField).htmlText = Utils.commafy(this.getStakeCost(_loc3_));
               _loc5_ = (_loc4_ = this.getChildByName("btnStake" + _loc3_) as MovieClip).x + _loc4_.width / 2;
               (this.getChildByName("mcCoin" + _loc3_) as MovieClip).x = _loc5_ - _loc4_.width / 3 - 4;
               (this.getChildByName("txtWinNum" + _loc3_) as TextField).x = (this.getChildByName("mcCoin" + _loc3_) as MovieClip).x + _loc2_ / 2 + 2;
               _loc3_++;
            }
         }
         var _loc1_:int = PartyServerIO.freeTokens;
         if(_loc1_ > 0)
         {
            this.stopCountdown();
            this.txtCostNum0.htmlText = "";
            this.mcFreeToggle.gotoAndStop("on");
            if(_loc1_ == 1)
            {
               this.txtCountdown.htmlText = String(_loc1_) + " FREE GAME<br/>REMAINING";
            }
            else
            {
               this.txtCountdown.htmlText = String(_loc1_) + " FREE GAMES<br/>REMAINING";
            }
         }
         else
         {
            this.startCountdown();
            this.mcFreeToggle.gotoAndStop("off");
         }
      }
      
      public function showErrorThrottle() : void
      {
         this._errorPopup.SetContent("COMING SOON","We\'re currently working on this feature.<br/>Please try again later!","CONTINUE");
         this._app.metaUI.highlight.showPopUp(this._errorPopup,true,false,0.55);
      }
      
      private function showErrorRecipientFull() : void
      {
         this._errorPopup.SetContent("GAME LIMIT REACHED","Your friend has too many games in progress.<br/>Please try again later!","CONTINUE");
         this._app.metaUI.highlight.showPopUp(this._errorPopup,true,false,0.55);
         this._errorPopup.x = Dimensions.PRELOADER_WIDTH / 2 - this._errorPopup.width / 2;
         this._errorPopup.y = Dimensions.PRELOADER_HEIGHT / 2 - this._errorPopup.height / 2;
      }
      
      private function showErrorSenderFull() : void
      {
         this._errorPopup.SetContent(this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_ERROR_PARTY_PACKED_TITLE),this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_ERROR_PARTY_PACKED_BODY),this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_STATE_STATUS_CONTINUE_BTN));
         this._app.metaUI.highlight.showPopUp(this._errorPopup,true,false,0.55);
         this._errorPopup.x = Dimensions.PRELOADER_WIDTH / 2 - this._errorPopup.width / 2;
         this._errorPopup.y = Dimensions.PRELOADER_HEIGHT / 2 - this._errorPopup.height / 2;
      }
      
      public function showFeatureUnavailable() : void
      {
         this._seriousErrorPopup.SetContent("FEATURE UNAVAILABLE","BLITZ PARTY is currently unavailable<br>Please refresh your page.","REFRESH");
         this._app.metaUI.highlight.showPopUp(this._seriousErrorPopup,true,false,0.55);
         this._seriousErrorPopup.x = Dimensions.PRELOADER_WIDTH / 2 - this._errorPopup.width / 2;
         this._seriousErrorPopup.y = Dimensions.PRELOADER_HEIGHT / 2 - this._errorPopup.height / 2;
      }
      
      private function getStakeCost(param1:uint) : Number
      {
         if(PartyServerIO.stakesArray != null && PartyServerIO.stakesArray.length > param1 && PartyServerIO.stakesArray[param1] != null)
         {
            return PartyServerIO.stakesArray[param1].stakeCost;
         }
         return 0;
      }
      
      private function stakePress(param1:int) : void
      {
         this.showExclusiveHighlight(param1);
         if(param1 == 0 && PartyServerIO.freeTokens >= 1 || PartyServerIO.purchasedTokens >= this.getStakeCost(param1))
         {
            this._app.metaUI.highlight.HighlightNothing(true);
            PartyServerIO.setIssuePartyCallback(this.onIssueComplete);
            PartyServerIO.sendIssuePartyNew(PartyData.PARTY_TYPE_TEAM,this.getStakeCost(param1));
         }
         else
         {
            this._app.party.showOutOfTokens();
         }
      }
      
      private function onIssueComplete() : void
      {
         try
         {
            this._app.metaUI.highlight.Hide();
            if(this._app.party.isDoneWithPartyTutorial())
            {
               this._app.party.hideTutorial();
            }
            if(PartyServerIO.currentPartyData.isValid)
            {
               this._app.party.showGameState(PartyServerIO.currentPartyData);
            }
            else
            {
               if(PartyServerIO.currentPartyData.isErrorCanceled())
               {
                  return;
               }
               if(PartyServerIO.currentPartyData.isErrorOutOfTokens())
               {
                  this._app.party.showOutOfTokens();
               }
               else if(PartyServerIO.currentPartyData.isErrorRecipientFull())
               {
                  this.showErrorRecipientFull();
               }
               else if(PartyServerIO.currentPartyData.isErrorSenderFull())
               {
                  this.showErrorSenderFull();
               }
               else if(PartyServerIO.currentPartyData.isFeatureUnavailable())
               {
                  this.showFeatureUnavailable();
               }
               else
               {
                  ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_RUNTIME,ErrorReporting.ERROR_LEVEL_ERROR_LOW,"PartyStateWelcome onIssueComplete server party object is invalid, cannot start newly issued game OR user canceled friend selection.");
               }
            }
         }
         catch(e:Error)
         {
            _app.displayNetworkError();
         }
      }
      
      private function handleOptionsClicked(param1:MouseEvent) : void
      {
         if(this._options.isOpen())
         {
            this._options.Hide();
         }
         else
         {
            this._options.Show();
         }
      }
      
      private function onInvitePress() : void
      {
         this._app.network.ExternalCall("inviteLink",{"source":"partyfriendscore"});
      }
   }
}
