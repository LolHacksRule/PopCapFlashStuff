package com.popcap.flash.bejeweledblitz.party
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.dailyspin.IDailySpinWidgetHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin2.UI.SpinBoardUIController;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.TwoButtonDialog;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzScoreKeeperHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ILastHurrahLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreData;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class PartyWidget extends Sprite implements IBlitzLogicHandler, ILastHurrahLogicHandler, IBlitzScoreKeeperHandler, IDailySpinWidgetHandler
   {
      
      private static var _STATE_WELCOME:String = "PartyState:Welcome";
      
      private static var _STATE_STATUS:String = "PartyState:Status";
      
      private static var _STATE_RESULTS:String = "PartyState:Results";
      
      private static var _STATE_SIDE_LIST:String = "PartySideState:List";
      
      private static var _STATE_SIDE_LIST_STATUS:String = "PartySideState:ListStatus";
      
      private static var _STATE_SIDE_GAME:String = "PartySideState:Game";
       
      
      private var _app:Blitz3Game;
      
      private var _currentPartyData:PartyData;
      
      private var _isPartyLoaded:Boolean = false;
      
      private var _isHandlingLogic:Boolean = false;
      
      private var _leaderboardFBIDArray:Vector.<String>;
      
      private var _scorelessLeaderboardFBIDArray:Vector.<String>;
      
      private var _haveLeaderboardData:Boolean = false;
      
      private var _haveFriendData:Boolean = false;
      
      private var _tutorial:PartyTutorial;
      
      private var _stateControllerMain:PartyStateController;
      
      private var _stateWelcome:PartyStateWelcome;
      
      private var _stateStatus:PartyStateStatus;
      
      private var _stateResults:PartyStateResults;
      
      private var _stateControllerSide:PartyStateController;
      
      private var _stateSideList:PartyStateSideList;
      
      private var _stateSideListStatus:PartyStateSideListStatus;
      
      private var _stateSideGame:PartyStateSideGame;
      
      private var _outOfTokensPrompt:TwoButtonDialog;
      
      public var enteredFromRequest:Boolean = false;
      
      private var _partystatestatusBG:Bitmap;
      
      private var _sideGameHolder:MovieClip;
      
      public function PartyWidget(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._currentPartyData = new PartyData(this._app.sessionData.userData.GetFUID());
         this._app.logic.AddHandler(this);
         this._app.logic.lastHurrahLogic.AddHandler(this);
         this._app.logic.GetScoreKeeper().AddHandler(this);
         var _loc2_:MainWidgetGame = this._app.ui as MainWidgetGame;
         PartyServerIO.init(this._app);
         this._sideGameHolder = new MovieClip();
         this._stateWelcome = new PartyStateWelcome(this._app);
         this._stateStatus = new PartyStateStatus(this._app);
         this._stateResults = new PartyStateResults(this._app);
         this._stateSideList = new PartyStateSideList(this._app);
         this._stateSideListStatus = new PartyStateSideListStatus(this._app);
         this._stateSideGame = new PartyStateSideGame(this._app);
         this._stateControllerMain = new PartyStateController();
         this._stateControllerMain.addState(_STATE_WELCOME,this._stateWelcome);
         this._stateControllerMain.addState(_STATE_STATUS,this._stateStatus);
         this._stateControllerMain.addState(_STATE_RESULTS,this._stateResults);
         this._stateControllerMain.hideAllStates();
         this._stateControllerSide = new PartyStateController();
         this._stateControllerSide.addState(_STATE_SIDE_LIST,this._stateSideList);
         this._stateControllerSide.addState(_STATE_SIDE_LIST_STATUS,this._stateSideListStatus);
         this._stateControllerSide.addState(_STATE_SIDE_GAME,this._stateSideGame);
         this._stateControllerSide.hideAllStates();
         this._outOfTokensPrompt = new TwoButtonDialog(this._app,16);
         this._outOfTokensPrompt.Init();
         this._outOfTokensPrompt.SetDimensions(420,216);
         this._outOfTokensPrompt.SetContent(this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_NEG_BALANCE_TOKENS_TITLE),this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_NEG_BALANCE_TOKENS_BODY),this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_NEG_BALANCE_TOKENS_ACCEPT),this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_NEG_BALANCE_TOKENS_DECLINE));
         this._outOfTokensPrompt.x = Dimensions.LEFT_BORDER_WIDTH + Dimensions.GAME_WIDTH / 2 - this._outOfTokensPrompt.width / 2;
         this._outOfTokensPrompt.y = Dimensions.TOP_BORDER_WIDTH + Dimensions.PARTY_HEIGHT / 2 - this._outOfTokensPrompt.height / 2;
         this._outOfTokensPrompt.AddAcceptButtonHandler(this.tokensAcceptPress);
         this._outOfTokensPrompt.AddDeclineButtonHandler(this.tokensDeclinePress);
         this.scrollRect = new Rectangle(0,0,Dimensions.PRELOADER_WIDTH,Dimensions.PRELOADER_HEIGHT);
         this._tutorial = new PartyTutorial(this._app);
         this._scorelessLeaderboardFBIDArray = new Vector.<String>();
         this._leaderboardFBIDArray = new Vector.<String>();
         this._partystatestatusBG = new Bitmap(new BJBBackground());
      }
      
      public static function getTitleText(param1:String) : TextField
      {
         var _loc2_:TextField = null;
         _loc2_ = new TextField();
         _loc2_.defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_FLARE_GOTHIC,32,16764239,null,null,null,null,null,TextFormatAlign.CENTER);
         _loc2_.autoSize = TextFieldAutoSize.CENTER;
         _loc2_.embedFonts = true;
         _loc2_.multiline = true;
         _loc2_.selectable = false;
         _loc2_.mouseEnabled = false;
         _loc2_.filters = [new GlowFilter(10838300,1,7,7,1.65,BitmapFilterQuality.HIGH,true),new DropShadowFilter(-1,90,16776103,1,2,2,2.07,BitmapFilterQuality.HIGH,true),new DropShadowFilter(1,77,2754823,1,4,4,10,BitmapFilterQuality.HIGH),new GlowFilter(854298,1,38,38,0.81,BitmapFilterQuality.HIGH)];
         _loc2_.htmlText = param1;
         _loc2_.x = 0;
         return _loc2_;
      }
      
      public static function getLabelText(param1:String, param2:int = 14, param3:String = "center") : TextField
      {
         var _loc4_:TextField;
         (_loc4_ = new TextField()).defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,param2,16777215,null,null,null,null,null,param3,null,null,null,-6);
         _loc4_.autoSize = TextFieldAutoSize.CENTER;
         _loc4_.multiline = true;
         _loc4_.wordWrap = false;
         _loc4_.embedFonts = true;
         _loc4_.selectable = false;
         _loc4_.mouseEnabled = false;
         _loc4_.filters = [new GlowFilter(0,1,2,2,4)];
         _loc4_.htmlText = param1;
         _loc4_.x = 0;
         return _loc4_;
      }
      
      public function setupPartyViews() : void
      {
         (this._app.ui as MainWidgetGame).menu.PartnerupPlaceHolder.PartyAnimPlaceHolder.addChild(this._partystatestatusBG);
         this.togglePartyBGVisibility(false);
         (this._app.ui as MainWidgetGame).menu.PartnerupPlaceHolder.PartyAnimPlaceHolder.addChild(this._stateSideList);
         (this._app.ui as MainWidgetGame).menu.PartnerupPlaceHolder.PartyAnimPlaceHolder.addChild(this._stateSideListStatus);
         this._sideGameHolder.addChild(this._stateSideGame);
         (this._app.ui as MainWidgetGame).menu.PartnerupPlaceHolder.PartyAnimPlaceHolder.addChild(this._sideGameHolder);
         (this._app.ui as MainWidgetGame).menu.PartnerupPlaceHolder.PartyAnimPlaceHolder.addChild(this._stateWelcome);
         (this._app.ui as MainWidgetGame).menu.PartnerupPlaceHolder.PartyAnimPlaceHolder.addChild(this._stateStatus);
         (this._app.ui as MainWidgetGame).menu.PartnerupPlaceHolder.PartyAnimPlaceHolder.addChild(this._stateResults);
         addChild(this._tutorial);
         var _loc1_:Number = Dimensions.LEADERBOARD_X + Dimensions.LEFT_BORDER_WIDTH;
         this._partystatestatusBG.x = -226;
         this._partystatestatusBG.y = -59;
         this._stateSideList.x = _loc1_;
         this._stateSideListStatus.x = _loc1_ - 10;
         this._sideGameHolder.x = _loc1_ - 30;
         this._stateSideList.y = 20;
         this._stateSideGame.y = 0;
         this._stateSideListStatus.y = 0;
         this._stateResults.x = -5;
         this._stateResults.y = 112;
      }
      
      public function getPartyData() : PartyData
      {
         return this._currentPartyData;
      }
      
      public function getSideGame() : PartyStateSideGame
      {
         return this._stateSideGame;
      }
      
      public function reAlignSideGame() : void
      {
         Utils.removeAllChildrenFrom(this._sideGameHolder);
         this._sideGameHolder.addChild(this._stateSideGame);
         this._stateSideGame.x = 0;
         this._stateSideGame.y = 0;
      }
      
      public function update() : void
      {
      }
      
      public function removeListBox(param1:String) : void
      {
         this._stateSideList.removeListBox(param1);
         PartyServerIO.removeListBox(param1);
      }
      
      public function showMe(param1:String = "") : void
      {
         if(!this._app.isMultiplayerGame())
         {
            this._app.setMultiplayerGame(true);
            this._app.sessionData.rareGemManager.Init();
         }
         var _loc2_:MainWidgetGame = this._app.ui as MainWidgetGame;
         SpinBoardUIController.GetInstance().CloseSpinBoard();
         (this._app.ui as MainWidgetGame).game.reset();
         this.showBoard(false);
         this._app.questManager.forceCompleteForParty();
         this._currentPartyData.reset();
         var _loc3_:PartyData = PartyServerIO.getOpenToPlayParty(param1);
         if(param1 != null && param1 != "" && _loc3_.isValid)
         {
            this.enteredFromRequest = true;
            this.showGameState(_loc3_);
         }
         else
         {
            this.enteredFromRequest = false;
            this.showWelcomeState();
         }
         this._app.getChildByName("PartnerupPlaceHolder").visible = true;
         this.reAlignSideGame();
         visible = true;
         this._app.mainmenuLeaderboard.Hide();
      }
      
      public function hideMe() : void
      {
         this._app.getChildByName("PartnerupPlaceHolder").visible = false;
         visible = false;
      }
      
      public function showTutorial(param1:int = -1) : void
      {
         this._tutorial.showTutorialPage(param1);
      }
      
      public function hideTutorial() : void
      {
         this._tutorial.hide(null);
      }
      
      public function isDoneWithPartyTutorial() : Boolean
      {
         return this._tutorial.isDoneWithPartyTutorial();
      }
      
      public function isPartyNinjaDoneWithPartyTutorial() : Boolean
      {
         return this._tutorial.isPartyNinjaDoneWithPartyTutorial();
      }
      
      public function copyParty(param1:PartyData) : void
      {
         this._currentPartyData.copyFrom(param1);
      }
      
      public function showWelcomeState(param1:Boolean = true) : void
      {
         if(this._app.isMultiplayerGame())
         {
            this._currentPartyData.deregisterAllListeners();
         }
         this.showBoard(false);
         this._stateControllerMain.showUniqueState(_STATE_WELCOME,true);
         if(param1)
         {
            this._stateSideList.forceRefresh();
         }
         this._stateControllerSide.showUniqueState(_STATE_SIDE_LIST,true);
      }
      
      public function showPlayerRareGem(param1:String) : void
      {
         this._currentPartyData.getCurrentPartyPlayerData().rareGemID = param1;
         this._stateSideGame.playerRareGemIcon.gotoAndStop(this._currentPartyData.getCurrentPartyPlayerData().getRareGemFrameName());
      }
      
      public function showSideList() : void
      {
         this._stateControllerSide.showUniqueState(_STATE_SIDE_LIST);
      }
      
      public function showSideListStatus(param1:PartyData) : void
      {
         this._currentPartyData.copyFrom(param1);
         this._stateControllerSide.showUniqueState(_STATE_SIDE_LIST_STATUS);
      }
      
      public function showGameState(param1:PartyData) : void
      {
         this._app.setMultiplayerGame();
         this._currentPartyData.copyFrom(param1);
         if(!this._currentPartyData.getCurrentPartyPlayerData().isFinalized)
         {
            this._currentPartyData.getCurrentPartyPlayerData().startGame();
         }
         this.updateSideStatus();
         this._stateControllerMain.hideAllStates();
         this._stateWelcome.exitState();
         this._stateControllerSide.showUniqueState(_STATE_SIDE_GAME);
         this._currentPartyData.canReplay = true;
         this.showBoard(false);
         (this._app.ui as MainWidgetGame).menu.leftPanel.showSpinButton(false);
         (this._app.ui as MainWidgetGame).menu.leftPanel.showMessagesButton(false);
         (this._app.ui as MainWidgetGame).menu.leftPanel.showInventoryButton(false);
         (this._app.ui as MainWidgetGame).menu.leftPanel.showMainButton(false);
         (this._app.ui as MainWidgetGame).menu.leftPanel.showKeyStoneButton(false);
         this._app.mainState.StartPreGameMenu();
         this._tutorial.showTutorialPage();
      }
      
      public function isGameState() : Boolean
      {
         return this._stateControllerMain.isHidden();
      }
      
      public function showRetry() : void
      {
         this.togglePartyBGVisibility(false);
         this._currentPartyData.getCurrentPartyPlayerData().startGame();
         this.reAlignSideGame();
         this._stateSideGame.reset();
         this.updateSideStatus();
         this._stateControllerMain.hideAllStates();
         this._stateControllerSide.showUniqueState(_STATE_SIDE_GAME,true);
         this._currentPartyData.canReplay = true;
         this.showBoard(false);
         this._app.mainState.StartPreGameMenu();
      }
      
      public function stopStatusCountdown() : void
      {
         if(this._stateControllerMain.isState(_STATE_STATUS))
         {
            this._stateStatus.stopCountdown();
         }
      }
      
      public function startStatusCountdown() : void
      {
         if(this._stateControllerMain.isState(_STATE_STATUS))
         {
            this._stateStatus.startCountdown();
         }
      }
      
      public function setStatusDoneCallback(param1:Function = null) : void
      {
         this._stateStatus.setDoneCallback(param1);
      }
      
      public function showStatusState() : void
      {
         this.showBoard(false);
         visible = true;
         this._stateControllerMain.showUniqueState(_STATE_STATUS,true);
         if(this._app.sessionData.configManager.GetInt(ConfigManager.INT_FINISHED_BLITZ_PARTY_TUTORIAL) == 0)
         {
            this._tutorial.showTutorialPage();
         }
      }
      
      public function setResultsDoneCallback(param1:Function = null) : void
      {
         this._stateResults.setDoneCallback(param1);
      }
      
      public function isLastStateStatus() : Boolean
      {
         return this._stateControllerMain.lastStateID == _STATE_STATUS;
      }
      
      public function showResultsState(param1:PartyData = null) : void
      {
         if(param1 != null)
         {
            this._currentPartyData.copyFrom(param1);
         }
         this.showBoard(false);
         visible = true;
         this._stateControllerMain.showUniqueState(_STATE_RESULTS,true);
         this._stateControllerSide.showUniqueState(_STATE_SIDE_GAME);
         this._app.metaUI.highlight.stopNetworkTimeoutDialog();
         this._app.metaUI.highlight.Hide(true);
      }
      
      public function isStatePartyResultStatus() : Boolean
      {
         if(this._stateControllerMain.currentStateID && this._stateControllerMain.currentStateID == _STATE_STATUS)
         {
            return true;
         }
         return false;
      }
      
      public function returnToMain() : Boolean
      {
         if(this._stateControllerMain.currentStateID)
         {
            this._stateControllerMain.exitState(this._stateControllerMain.currentStateID);
            this._app.setMultiplayerGame(false);
            this.hideMe();
            this._app.mainmenuLeaderboard.Show();
            this._app.mainState.onEnter();
            return true;
         }
         return false;
      }
      
      public function handleLastHurrahBegin() : void
      {
         if(this._app.isMultiplayerGame())
         {
            this._currentPartyData.getCurrentPartyPlayerData().comboData.deregisterMultiListener();
         }
      }
      
      public function handleLastHurrahEnd() : void
      {
      }
      
      public function handlePreCoinHurrah() : void
      {
      }
      
      public function canBeginCoinHurrah() : Boolean
      {
         return true;
      }
      
      public function HandleGameLoad() : void
      {
      }
      
      public function HandleGameBegin() : void
      {
         if(this._app.isMultiplayerGame())
         {
            this._currentPartyData.getCurrentPartyPlayerData().comboData.registerAllListeners(this._app);
            this._currentPartyData.getCurrentPartyPlayerData().comboData.scanBoard();
            this.updateSideStatus();
         }
         else
         {
            this.hideMe();
         }
      }
      
      public function HandleGameEnd() : void
      {
         if(this._app.isMultiplayerGame())
         {
            this._currentPartyData.getCurrentPartyPlayerData().comboData.deregisterMultiListener();
         }
      }
      
      public function HandleGameAbort() : void
      {
         if(!this._app.mIsReplay && this._app.isMultiplayerGame())
         {
            if(this._currentPartyData != null && this._currentPartyData.getCurrentPartyPlayerData() != null)
            {
               this._currentPartyData.getCurrentPartyPlayerData().comboData.deregisterMultiListener();
            }
            this.reAlignSideGame();
            this._stateSideGame.reset();
         }
      }
      
      public function HandleGamePaused() : void
      {
      }
      
      public function HandleGameResumed() : void
      {
      }
      
      public function HandleBlockingEvent() : void
      {
      }
      
      public function updateSideStatus() : void
      {
         if(this._app.isMultiplayerGame())
         {
            this._stateSideGame.update();
         }
      }
      
      public function HandleScore(param1:ScoreValue) : void
      {
         if(this._app.isMultiplayerGame())
         {
            this._currentPartyData.getCurrentPartyPlayerData().playerScore = this._app.logic.GetScoreKeeper().GetScore();
            this.updateSideStatus();
         }
      }
      
      public function HandlePointsScored(param1:ScoreData) : void
      {
         if(this._app.isMultiplayerGame())
         {
            this._currentPartyData.getCurrentPartyPlayerData().playerScore = this._app.logic.GetScoreKeeper().GetScore();
            this.updateSideStatus();
         }
      }
      
      public function HandleDailySpinShown() : void
      {
         this.tokensDeclinePress(null);
      }
      
      public function HandleDailySpinHidden() : void
      {
      }
      
      public function showOutOfTokens(param1:Boolean = true) : void
      {
         if(param1)
         {
            this._app.metaUI.highlight.showPopUp(this._outOfTokensPrompt,true,true,0.55);
         }
         else
         {
            this._app.metaUI.highlight.hidePopUp();
         }
      }
      
      public function showErrorThrottle() : void
      {
         this._stateWelcome.showErrorThrottle();
      }
      
      public function showFeatureUnavailable() : void
      {
         this._stateWelcome.showFeatureUnavailable();
      }
      
      public function reset() : void
      {
         this._currentPartyData.reset();
         this._outOfTokensPrompt.Reset();
      }
      
      private function tokensAcceptPress(param1:MouseEvent) : void
      {
         this.showOutOfTokens(false);
         PartyServerIO.sendBuyTokens();
      }
      
      private function tokensDeclinePress(param1:MouseEvent) : void
      {
         this.showOutOfTokens(false);
         this.startStatusCountdown();
      }
      
      private function showBoard(param1:Boolean = true) : void
      {
         if(!param1)
         {
            this._app.mainmenuLeaderboard.Hide();
            (this._app.ui as MainWidgetGame).game.Hide();
         }
      }
      
      public function togglePartyBGVisibility(param1:Boolean) : void
      {
         if(this._partystatestatusBG != null)
         {
            this._partystatestatusBG.visible = param1;
         }
      }
      
      public function HandleGameTimeDelayed() : void
      {
      }
   }
}
