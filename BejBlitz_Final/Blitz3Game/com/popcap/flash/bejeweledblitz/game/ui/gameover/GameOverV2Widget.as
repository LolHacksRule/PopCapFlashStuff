package com.popcap.flash.bejeweledblitz.game.ui.gameover
{
   import com.caurina.transitions.Tweener;
   import com.popcap.flash.bejeweledblitz.BJBDataEvent;
   import com.popcap.flash.bejeweledblitz.Constants;
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.DynamicRGInterface;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.Version;
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.game.boostV2.parser.BoostUIInfo;
   import com.popcap.flash.bejeweledblitz.game.dialogs.RequiresUpdateDialog;
   import com.popcap.flash.bejeweledblitz.game.ftue.impl.FTUEEvents;
   import com.popcap.flash.bejeweledblitz.game.quests.IQuestManagerHandler;
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestManager;
   import com.popcap.flash.bejeweledblitz.game.session.Blitz3Network;
   import com.popcap.flash.bejeweledblitz.game.session.FriendPopupServerIO;
   import com.popcap.flash.bejeweledblitz.game.session.IHandleNetworkAdStateChangeCallback;
   import com.popcap.flash.bejeweledblitz.game.session.UserData;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.session.feature.FeatureManager;
   import com.popcap.flash.bejeweledblitz.game.tournament.controllers.TournamentController;
   import com.popcap.flash.bejeweledblitz.game.tournament.controllers.TournamentLeaderboardController;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentCommonInfo;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentLeaderboardData;
   import com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity.TournamentRuntimeEntity;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.boosts.BoostIconState;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.InsufficientFundsDialog;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.SingleButtonDialog;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.TwoButtonCheckBoxDialog;
   import com.popcap.flash.bejeweledblitz.game.ui.finisher.FinisherFacade;
   import com.popcap.flash.bejeweledblitz.game.ui.game.sidebar.RareGemWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.api.IGameOverCurrencyContainerAnimListener;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.api.IPostGameScrollWidgetHandler;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.api.IPostGameStatsHandler;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.levels.LevelView;
   import com.popcap.flash.bejeweledblitz.game.ui.menu.LeftMenuPanel;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemLoader;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.tournament.TournamentInfoWidget;
   import com.popcap.flash.bejeweledblitz.leaderboard.PlayerData;
   import com.popcap.flash.bejeweledblitz.leaderboard.PlayersData;
   import com.popcap.flash.bejeweledblitz.logic.boostV2.BoostV2;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreData;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import com.popcap.flash.bejeweledblitz.logic.raregems.RGLogic;
   import com.popcap.flash.bejeweledblitz.navigation.INavigationBadgeCounter;
   import com.popcap.flash.bejeweledblitz.particles.ConfettiTypeOneParticle;
   import com.popcap.flash.bejeweledblitz.particles.ConfettiTypeTwoParticle;
   import com.popcap.flash.bejeweledblitz.particles.GlowBustParticle;
   import com.popcap.flash.bejeweledblitz.particles.MainMenuParticle;
   import com.popcap.flash.bejeweledblitz.quest.IQuestRewardWidgetHandler;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.games.blitz3.leaderboard.PostgameViewWidget;
   import com.popcap.flash.games.blitz3.leaderboard.view.fla.HarvestAnimationsClip;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class GameOverV2Widget extends Sprite implements IQuestManagerHandler, IQuestRewardWidgetHandler, IBlitzLogicHandler, IPostGameScrollWidgetHandler, IGameOverCurrencyContainerAnimListener, IHandleNetworkAdStateChangeCallback, INavigationBadgeCounter
   {
      
      private static const _SUPPORTED_REWARDS:Vector.<String> = Vector.<String>(["coin","coin_message","token","token_message","xp","xp_message"]);
      
      private static const _MAX_SCREEN_BOXES:Number = 5;
      
      public static const BOX_HEIGHT:Number = 36;
      
      public static var START_Y:Number = 0;
      
      public static var _LB_CONTAINER_Y:Number = -42;
       
      
      private var _app:Blitz3Game;
      
      private var _handlers:Vector.<IPostGameStatsHandler>;
      
      private var _logic:BlitzLogic;
      
      private var _currentLevelXP:Number;
      
      private var _totalLevelXP:Number;
      
      private var _progressButtonArray:Vector.<GenericButtonClip>;
      
      private var _claimButtonArray:Vector.<GenericButtonClip>;
      
      private var _btnPlayAgain:GenericButtonClip;
      
      private var _btnShareScore:GenericButtonClip;
      
      private var _btnHome:GenericButtonClip;
      
      private var _btnShareRG:GenericButtonClip;
      
      private var _crappyFPSDialog:TwoButtonCheckBoxDialog;
      
      private var showFPSDialog:int = 0;
      
      private var _recentlyCompletedQuests:Vector.<Quest>;
      
      private var _recentlyExpiredQuests:Vector.<Quest>;
      
      private var _gameOverScreen:PostgameViewWidget;
      
      private var _keystonesMC:Postgamekeystones;
      
      private var _gameoverBG:Bitmap;
      
      private const showBoost1AnimEndFrame:int = 59;
      
      private const showBoost2AnimEndFrame:int = 63;
      
      private const showBoost3AnimEndFrame:int = 67;
      
      private const showErrorMessageFrame:int = 104;
      
      private var currAnimEndFrame:int = -1;
      
      private var animEndCallBack:Function = null;
      
      private var finalAnimDone:Boolean = false;
      
      private var rareGemAnimation:MovieClip;
      
      private var isRGShareable:Boolean = false;
      
      private var boostsUsed:Vector.<Boolean>;
      
      private var postGameScrollWidget:PostGameScrollWidget;
      
      private var previousUsedRG:String;
      
      private var starMedalFrame:String;
      
      private var COLOR_YELLOW:uint = 16776960;
      
      private var friendFuidList:Vector.<String>;
      
      private var _boxContainer:MovieClip;
      
      private var _leaderboardListBoxArray:Vector.<PostGameLeaderboardListBox>;
      
      private var isLeaderboardSetupSuccessful:Boolean = false;
      
      private var shouldScrollToPlayer:Boolean = false;
      
      private var coinCurrencyContainer:GameOverCurrencyContainer;
      
      private var tokenPayout:Number = 0;
      
      private var lightseedPayout:Number = 0;
      
      private var percentXPFrame:Number = 0;
      
      private var stateManager:GameOverWidgetStateManager;
      
      private var _questRaregemRewardDialog:SingleButtonDialog;
      
      private var _loader:MovieClip;
      
      private var _tournamentTitle:TextField;
      
      private var _errorText:TextField;
      
      private var _btnTournamentLeaderboard:GenericButtonClip;
      
      private var _weeklyLeaderboardText:TextField;
      
      private var _currentTournament:TournamentRuntimeEntity;
      
      private var _tournamentInfoView:TournamentInfoWidget;
      
      private var _tournamentTimer:Timer;
      
      private var _timerText:TextField;
      
      private var _currencyPlaceholder:MovieClip;
      
      private var _leftmenuPanel:LeftMenuPanel;
      
      public function GameOverV2Widget(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._logic = param1.logic;
         this._handlers = new Vector.<IPostGameStatsHandler>();
         this._progressButtonArray = new Vector.<GenericButtonClip>(3);
         this._claimButtonArray = new Vector.<GenericButtonClip>(3);
         this.rareGemAnimation = new HarvestAnimationsClip();
         this.boostsUsed = new Vector.<Boolean>(3);
         this.previousUsedRG = "";
         this.friendFuidList = new Vector.<String>();
         this._leaderboardListBoxArray = new Vector.<PostGameLeaderboardListBox>();
         this.stateManager = new GameOverWidgetStateManager();
         this._currentTournament = null;
         this._tournamentInfoView = null;
         this._tournamentTimer = new Timer(1000);
         this._tournamentTimer.addEventListener(TimerEvent.TIMER,this.updateComputingResultText);
      }
      
      public function Init() : void
      {
         this._recentlyCompletedQuests = new Vector.<Quest>();
         this._recentlyExpiredQuests = new Vector.<Quest>();
         var _loc1_:MainWidgetGame = this._app.ui as MainWidgetGame;
         this._app.metaUI.questReward.AddHandler(this);
         this._app.logic.AddHandler(this);
         this._app.questManager.AddHandler(this);
         this._app.bjbEventDispatcher.addEventListener(PlayersData.LEADERBOARD_UPDATED,this.OnLeaderboardUpdated);
         this._app.network.AddAdStateChangHandler(this);
         this.stateManager.Init(this);
      }
      
      public function showBackground(param1:Boolean) : void
      {
         if(this._gameOverScreen)
         {
            this._gameOverScreen.bgClip.visible = param1;
         }
      }
      
      private function OnLeaderboardUpdated(param1:BJBDataEvent) : void
      {
         this._app.bjbEventDispatcher.removeEventListener(PlayersData.LEADERBOARD_UPDATED,this.OnLeaderboardUpdated);
         this.friendFuidList = param1.data as Vector.<String>;
         this.BuildLeaderboard();
      }
      
      private function setupBoostsPanel() : void
      {
         var _loc5_:MovieClip = null;
         var _loc6_:TextField = null;
         var _loc7_:int = 0;
         var _loc8_:MovieClip = null;
         var _loc9_:BoostUIInfo = null;
         var _loc10_:int = 0;
         var _loc11_:Boolean = false;
         var _loc12_:String = null;
         var _loc1_:int = this.boostsUsed.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this.boostsUsed[_loc2_] = false;
            _loc2_++;
         }
         var _loc3_:String = "";
         var _loc4_:Vector.<BoostV2>;
         if((_loc4_ = this._app.sessionData.boostV2Manager.getEquippedBoosts()) != null)
         {
            _loc5_ = new MovieClip();
            _loc6_ = new TextField();
            _loc7_ = 0;
            while(_loc7_ < 3)
            {
               switch(_loc7_)
               {
                  case 0:
                     _loc5_ = this._gameOverScreen.Boost1panel.Booster1Placeholder;
                     _loc6_ = this._gameOverScreen.Boost1panel.Leveltext.TextBoostLevel;
                     break;
                  case 1:
                     _loc5_ = this._gameOverScreen.Boost2panel.Booster2Placeholder;
                     _loc6_ = this._gameOverScreen.Boost2panel.Leveltext.TextBoostLevel;
                     break;
                  case 2:
                     _loc5_ = this._gameOverScreen.Boost3panel.Booster3Placeholder;
                     _loc6_ = this._gameOverScreen.Boost3panel.Leveltext.TextBoostLevel;
                     break;
               }
               Utils.removeAllChildrenFrom(_loc5_);
               _loc1_ = _loc4_.length;
               if(_loc7_ < _loc1_)
               {
                  _loc3_ = _loc4_[_loc7_].getId();
                  if(_loc3_ != "")
                  {
                     (_loc8_ = this._app.sessionData.boostV2Manager.boostV2Icons.getUIBoostIconMC(_loc3_)).scaleX = 0.7;
                     _loc8_.scaleY = 0.7;
                     _loc8_.gotoAndPlay(BoostIconState.POSTGAME);
                     _loc5_.addChild(_loc8_);
                     _loc9_ = this._app.sessionData.boostV2Manager.getBoostUIInfoFromBoostId(_loc3_);
                     _loc10_ = this._app.sessionData.userData.GetBoostLevel(_loc3_);
                     _loc12_ = !!(_loc11_ = Boolean(_loc9_.IsLevelMaxLevel(_loc10_))) ? "Max LVL" : "LVL " + _loc10_.toString();
                     _loc6_.text = _loc12_;
                     this.boostsUsed[_loc7_] = true;
                  }
               }
               _loc7_++;
            }
         }
      }
      
      private function playBoostLevelAnim(param1:Number, param2:MovieClip) : void
      {
         if(this.boostsUsed[param1])
         {
            param2.gotoAndPlay("levelintro");
         }
      }
      
      private function setUpLeaderboardButton() : void
      {
         this._gameOverScreen.sharebutton.visible = false;
         if(this._currentTournament.IsComputingResults())
         {
            this._gameOverScreen.leaderboardButton.visible = false;
         }
         else
         {
            this._gameOverScreen.leaderboardButton.visible = true;
            this._btnTournamentLeaderboard = new GenericButtonClip(this._app,this._gameOverScreen.leaderboardButton);
            this._btnTournamentLeaderboard.setRelease(this.handleLeaderboardButtonClicked);
            this._btnTournamentLeaderboard.activate();
         }
      }
      
      private function setupShareButton(param1:int) : void
      {
         this._btnShareScore = new GenericButtonClip(this._app,this._gameOverScreen.sharebutton);
         this._btnShareScore.setRelease(this.handleShareClicked);
         if(param1 < 25000)
         {
            this._btnShareScore.SetDisabled(true);
         }
         else
         {
            this._btnShareScore.activate();
         }
      }
      
      private function setupPlayAgainButton() : void
      {
         var _loc1_:String = null;
         var _loc2_:MovieClip = null;
         if(this._currentTournament == null)
         {
            this._gameOverScreen.mcBannerplayagain.visible = true;
            this._btnPlayAgain = new GenericButtonClip(this._app,this._gameOverScreen.mcBannerplayagain);
            this._btnPlayAgain.setRelease(this.continuePress);
            this._btnPlayAgain.activate();
         }
         else
         {
            this._tournamentTimer.start();
            this._gameOverScreen.mcBannerplayagain.visible = false;
            if(this._currentTournament.HasEnded())
            {
               this._gameOverScreen.retryBtn.visible = false;
               this._gameOverScreen.CaliberationText.txtcaliberation.visible = false;
            }
            else if(this._currentTournament.IsComputingResults())
            {
               this._gameOverScreen.retryBtn.visible = false;
               this._gameOverScreen.CaliberationText.txtcaliberation.visible = true;
            }
            else
            {
               this._gameOverScreen.retryBtn.visible = true;
               this._gameOverScreen.retryBtn.btnData.ReplayStatic.visible = false;
               this._gameOverScreen.retryBtn.btnData.mcTxtPlay.visible = false;
               this._gameOverScreen.retryBtn.btnData.retryCostT.text = "";
               Utils.removeAllChildrenFrom(this._gameOverScreen.retryBtn.btnData.Currency_Placeholder);
               this._gameOverScreen.CaliberationText.txtcaliberation.visible = false;
               this._btnPlayAgain = new GenericButtonClip(this._app,this._gameOverScreen.retryBtn);
               this._btnPlayAgain.setRelease(this.continueTournamentPress);
               this._btnPlayAgain.activate();
               if(this._currentTournament.Data.RetryCost.mAmount > 0)
               {
                  _loc1_ = this._currentTournament.Data.RetryCost.mCurrencyType;
                  _loc2_ = CurrencyManager.getImageByType(_loc1_,false);
                  _loc2_.smoothing = true;
                  this._gameOverScreen.retryBtn.btnData.Currency_Placeholder.addChild(_loc2_);
                  this._gameOverScreen.retryBtn.btnData.retryCostT.text = Utils.formatNumberToBJBNumberString(this._currentTournament.Data.RetryCost.mAmount);
                  this._gameOverScreen.retryBtn.btnData.mcTxtPlay.visible = true;
               }
               else
               {
                  this._gameOverScreen.retryBtn.btnData.ReplayStatic.visible = true;
                  this._gameOverScreen.retryBtn.btnData.retryCostT.text = "";
               }
            }
         }
      }
      
      private function setupHomeButton() : void
      {
         this._btnHome = new GenericButtonClip(this._app,this._gameOverScreen.MainmenuButton);
         this._btnHome.setRelease(this.handleHomeBtnClicked);
         this._btnHome.activate();
      }
      
      private function setupFinisherPanel() : void
      {
         var _loc1_:String = null;
         var _loc2_:FinisherFacade = null;
         var _loc3_:MovieClip = null;
         Utils.removeAllChildrenFrom(this._gameOverScreen.Finisherpanel.FinisherlPlaceholder);
         if(this._app.sessionData.finisherSessionData.IsFinisherPurchased())
         {
            _loc1_ = this._app.sessionData.finisherSessionData.GetFinisherName();
            _loc2_ = this._app.sessionData.finisherManager.GetCurrentFinisherFromSessionData();
            if(_loc2_ != null)
            {
               _loc3_ = _loc2_.getFinisherBadge();
               if(_loc3_ != null)
               {
                  this._gameOverScreen.Finisherpanel.FinisherlPlaceholder.addChild(_loc3_);
               }
            }
         }
         else
         {
            this._gameOverScreen.Finisherpanel.FinisherlPlaceholder.visible = false;
         }
      }
      
      private function setupShareRGButton() : void
      {
         this._btnShareRG = new GenericButtonClip(this._app,this._gameOverScreen.Raregempanel.Sharebutton);
         this._btnShareRG.setRelease(this.OnRGShareClicked);
         this._btnShareRG.activate();
      }
      
      private function setupCurrencyButtons() : void
      {
         var _loc4_:GameOverCurrencyContainer = null;
         var _loc1_:uint = this._app.logic.coinTokenLogic.collectedCoinArray.length * 100;
         var _loc2_:Object = DynamicRareGemWidget.getCachedPrizeData();
         var _loc3_:uint = 0;
         if(_loc2_ != null)
         {
            this.tokenPayout = _loc2_[CurrencyManager.TYPE_COINS];
            this.lightseedPayout = _loc2_[CurrencyManager.TYPE_SHARDS];
         }
         else
         {
            _loc3_ = this._app.logic.rareGemsLogic.getGenericPayout(this._app.logic.rareGemTokenLogic.getTotalTokensCollected());
            this.lightseedPayout += this._app.logic.rareGemsLogic.getGenericPayoutCurrency3(this._app.logic.rareGemTokenLogic.getTotalTokensCollected());
         }
         this.tokenPayout = _loc1_ + this.tokenPayout + _loc3_;
         this.coinCurrencyContainer = new GameOverCurrencyContainer(this._app,CurrencyManager.TYPE_COINS,this);
         this.coinCurrencyContainer.updateValue(this.tokenPayout);
         if(this.lightseedPayout > 0)
         {
            this._gameOverScreen.Currencypanel.currencypalceholder2.addChild(this.coinCurrencyContainer);
            (_loc4_ = new GameOverCurrencyContainer(this._app,CurrencyManager.TYPE_SHARDS,null)).updateValue(this.lightseedPayout);
            this._gameOverScreen.Currencypanel.currencypalceholder3.addChild(_loc4_);
         }
         else
         {
            this._gameOverScreen.Currencypanel.currencypalceholder1.addChild(this.coinCurrencyContainer);
         }
      }
      
      private function setupStarMedal(param1:int) : void
      {
         var _loc2_:* = this._app.logic.timerLogic.GetTimeElapsed() > this._app.logic.config.timerLogicBaseGameDuration;
         var _loc3_:int = this._app.starMedalFactory.GetThreshold(param1);
         this.starMedalFrame = "";
         if(_loc3_ < 25000)
         {
            this._gameOverScreen.Medelpanel.gotoAndStop(1);
            return;
         }
         if(_loc3_ < 1000000)
         {
            this.starMedalFrame = String(_loc3_ * 0.001) + "K";
         }
         else if(_loc3_ < 3000000)
         {
            this.starMedalFrame = String("1M");
         }
         else if(_loc3_ < 5000000)
         {
            this.starMedalFrame = String("3M");
         }
         else if(_loc3_ < 10000000)
         {
            this.starMedalFrame = String("5M");
         }
         else
         {
            this.starMedalFrame = String("10M");
         }
         this._gameOverScreen.Medelpanel.gotoAndStop(this.starMedalFrame);
      }
      
      private function BuildTournamentLeaderboard() : void
      {
         var _loc1_:TournamentController = null;
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc5_:PostGameLeaderboardListBox = null;
         var _loc6_:TournamentLeaderboardData = null;
         var _loc7_:Vector.<PlayerData> = null;
         var _loc8_:PlayerData = null;
         if(this._currentTournament != null)
         {
            _loc1_ = this._app.sessionData.tournamentController;
            this._loader.visible = false;
            this._errorText.visible = false;
            _loc2_ = this._leaderboardListBoxArray.length - 1;
            while(_loc2_ >= 0)
            {
               delete this._leaderboardListBoxArray[_loc2_];
               _loc2_--;
            }
            this._leaderboardListBoxArray.splice(0,this._leaderboardListBoxArray.length);
            Utils.removeAllChildrenFrom(this._boxContainer);
            if(this._gameOverScreen != null)
            {
               START_Y = this._gameOverScreen.Postgameassetspanel.Leaderboardswiper.leaderboardContainer.templateClip.y;
               this._boxContainer = this._gameOverScreen.Postgameassetspanel.Leaderboardswiper.leaderboardContainer;
               _loc3_ = this._gameOverScreen.Postgameassetspanel.Leaderboardswiper.leaderboardContainer.templateClip.x;
               _loc7_ = (_loc6_ = _loc1_.LeaderboardController.getLeaderboard(this._currentTournament.Data.Id)).UserList;
               _loc2_ = 0;
               while(_loc2_ < _loc7_.length)
               {
                  _loc8_ = _loc7_[_loc2_];
                  (_loc5_ = new PostGameLeaderboardListBox(this._app,_loc8_,this._currentTournament)).x = _loc3_;
                  _loc5_.y = START_Y + _loc2_ * BOX_HEIGHT;
                  _loc5_.init();
                  this._leaderboardListBoxArray.push(_loc5_);
                  this._boxContainer.addChild(_loc5_);
                  _loc2_++;
               }
               if(_loc7_.length > 0)
               {
                  this.isLeaderboardSetupSuccessful = true;
                  this.shouldScrollToPlayer = false;
               }
               this.showLeaderboard();
               this.finalAnimDone = true;
               if(this._app.eventsNextLaunchUrl != "")
               {
                  this.showEventsScreen();
               }
            }
         }
      }
      
      private function BuildLeaderboard() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:PlayerData = null;
         var _loc3_:PostGameLeaderboardListBox = null;
         var _loc4_:int = 0;
         if(this._gameOverScreen != null && !this.isLeaderboardSetupSuccessful)
         {
            START_Y = this._gameOverScreen.Postgameassetspanel.Leaderboardswiper.leaderboardContainer.templateClip.y;
            this._boxContainer = this._gameOverScreen.Postgameassetspanel.Leaderboardswiper.leaderboardContainer;
            _loc1_ = this._gameOverScreen.Postgameassetspanel.Leaderboardswiper.leaderboardContainer.templateClip.x;
            _loc4_ = 0;
            while(_loc4_ < this.friendFuidList.length)
            {
               _loc2_ = PlayersData.getPlayerData(this.friendFuidList[_loc4_]);
               _loc3_ = new PostGameLeaderboardListBox(this._app,_loc2_);
               _loc3_.x = _loc1_;
               _loc3_.y = START_Y + _loc4_ * BOX_HEIGHT;
               _loc3_.init();
               this._leaderboardListBoxArray.push(_loc3_);
               this._boxContainer.addChild(_loc3_);
               _loc4_++;
            }
            if(this.friendFuidList.length > 0)
            {
               this.isLeaderboardSetupSuccessful = true;
            }
         }
      }
      
      private function showLeaderboardWithAnimation() : void
      {
         var _loc1_:PostGameLeaderboardListBox = null;
         for each(_loc1_ in this._leaderboardListBoxArray)
         {
            _loc1_.updateRankAndLBPosition();
         }
         this.scrollToPlayer();
      }
      
      private function showLeaderboard() : void
      {
         var _loc1_:PostGameLeaderboardListBox = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TournamentLeaderboardController = null;
         var _loc5_:TournamentLeaderboardData = null;
         if(!this.shouldScrollToPlayer && this._leaderboardListBoxArray.length > _MAX_SCREEN_BOXES)
         {
            this.shouldScrollToPlayer = true;
            if(this._currentTournament != null)
            {
               if((_loc4_ = this._app.sessionData.tournamentController.LeaderboardController) != null)
               {
                  if((_loc5_ = _loc4_.getLeaderboard(this._currentTournament.Id)) != null)
                  {
                     _loc2_ = _loc5_.getCurrentPlayerIndex();
                  }
               }
            }
            else
            {
               _loc2_ = PlayersData.getCurrentPlayerIndexInLeaderboard();
            }
            _loc3_ = Math.max(0,_loc2_ - Math.floor(_MAX_SCREEN_BOXES / 2));
            this._boxContainer.y = _LB_CONTAINER_Y - _loc3_ * BOX_HEIGHT;
         }
         for each(_loc1_ in this._leaderboardListBoxArray)
         {
            _loc1_.updateRank();
         }
      }
      
      private function scrollToPlayer() : void
      {
         var _loc1_:int = PlayersData.getCurrentPlayerIndexInLeaderboard();
         var _loc2_:int = Math.max(0,_loc1_ - Math.floor(_MAX_SCREEN_BOXES / 2));
         var _loc3_:Number = _LB_CONTAINER_Y - _loc2_ * BOX_HEIGHT;
         Tweener.removeTweens(this._boxContainer);
         Tweener.addTween(this._boxContainer,{
            "y":_loc3_,
            "time":2,
            "onComplete":this.lbTweenComplete
         });
         this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_POST_GAME_POSITION_RISE);
      }
      
      private function lbTweenComplete() : void
      {
         this.postGameScrollWidget.ScrollToPanel(PostGameScrollWidget.USERRANK_SCREEN);
         this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_POST_GAME_SCOREBOARD_SWIPE);
      }
      
      private function HideLeaderboard() : void
      {
         this.friendFuidList = PlayersData.GetList();
      }
      
      private function HasBeatenFriend() : Boolean
      {
         if(this._app.logic.GetScoreKeeper().GetScore() == 0)
         {
            return false;
         }
         var _loc1_:int = PlayersData.getCurrentPlayerIndexInLeaderboard();
         var _loc2_:String = this._app.sessionData.userData.GetFUID();
         var _loc3_:int = this.friendFuidList.indexOf(_loc2_,0);
         return _loc1_ < _loc3_;
      }
      
      private function setupXPPanel() : void
      {
         var _loc1_:UserData = this._app.sessionData.userData;
         var _loc2_:int = _loc1_.GetLevel();
         var _loc3_:int = Math.max(Math.min(_loc2_ - 1,LevelView.MAX_LEVEL - 1),0);
         var _loc4_:String = Constants.LEVEL_NAMES[_loc3_].toUpperCase();
         var _loc5_:String = "Rank " + _loc2_;
         var _loc6_:LeaderboardSwiper;
         (_loc6_ = this._gameOverScreen.Postgameassetspanel.Leaderboardswiper).txtGameXP.text = "GAME XP";
         _loc6_.txtJewel.text = _loc4_;
         _loc6_.txtrank.textColor = this.COLOR_YELLOW;
         _loc6_.txtrank.text = _loc5_;
         _loc6_.Texvalue.text = Utils.grandifyXP(this._currentLevelXP) + " / " + Utils.grandifyXP(this._totalLevelXP) + " XP\r";
         _loc6_.levelBadgeMC.gotoAndStop(_loc2_);
         var _loc7_:Number = this._currentLevelXP / this._totalLevelXP;
         var _loc8_:Number = Math.floor(100 * (this._currentLevelXP / this._totalLevelXP));
         this.percentXPFrame = Math.max(1,Math.min(_loc8_,100));
      }
      
      private function OnPresentingXPScreen() : void
      {
         Tweener.removeAllTweens();
         Tweener.addTween(this._gameOverScreen.Postgameassetspanel.Leaderboardswiper.GamexpBar,{
            "_frame":this.percentXPFrame,
            "time":2,
            "transition":"linear",
            "onComplete":this.levelProgressTweenComplete
         });
         this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_POST_GAME_BAR_RISER);
      }
      
      private function setupStatsPanel() : void
      {
         var _loc8_:FinisherFacade = null;
         var _loc1_:int = this._app.logic.multiLogic.GetMaxMultiplier();
         var _loc2_:int = this._app.logic.GetNumMatches();
         var _loc3_:Number = new Number(this._app.logic.timerLogic.GetTimeElapsed());
         if(this._app.sessionData.finisherSessionData.IsFinisherPurchased())
         {
            if((_loc8_ = this._app.sessionData.finisherManager.GetCurrentFinisherFromSessionData()) != null && _loc8_.GetFinisherConfig() != null)
            {
               _loc3_ += _loc8_.GetFinisherConfig().GetExtraTime();
            }
         }
         var _loc4_:Number = _loc2_ * Blitz3Game.TICK_MULTIPLIER / _loc3_;
         var _loc5_:int = this._app.logic.GetNumRareGemDestroyed();
         var _loc6_:int = this._app.logic.flameGemLogic.GetNumDestroyed() + this._app.logic.starGemLogic.GetNumDestroyed() + this._app.logic.hypercubeLogic.GetNumDestroyed();
         var _loc7_:LeaderboardSwiper;
         (_loc7_ = this._gameOverScreen.Postgameassetspanel.Leaderboardswiper).txtNumberofmatches.text = _loc4_.toFixed(3).toString();
         _loc7_.txtMaxmultiplier.text = _loc1_.toString();
         _loc7_.txtMatchespersecond.text = _loc2_.toString();
         _loc7_.txtRaregemdestroyed.text = _loc5_.toString();
         _loc7_.txtSpecialgemsdestroyed.text = _loc6_.toString();
      }
      
      public function ShowShareButton() : void
      {
         if(this.isRGShareable)
         {
            this._gameOverScreen.Raregempanel.gotoAndPlay("sharebuttonintro");
         }
         this.stateManager.GotoNextState();
      }
      
      private function addRGIconToRGPanel() : void
      {
         var _loc2_:MovieClip = null;
         this.isRGShareable = false;
         this.previousUsedRG = this._app.sessionData.rareGemManager.getAndClearRGUsedInPreviousGame();
         var _loc1_:RGLogic = this._app.logic.rareGemsLogic.GetRareGemByStringID(this.previousUsedRG);
         Utils.removeAllChildrenFrom(this._gameOverScreen.Raregempanel.ReregemPlaceholder);
         if(this.previousUsedRG != "" && _loc1_ != null)
         {
            this.isRGShareable = this._app.sessionData.rareGemManager.IsRareGemShareable(this.previousUsedRG);
            if(_loc1_.isDynamicGem())
            {
               _loc2_ = new MovieClip();
               DynamicRGInterface.attachMovieClip(this.previousUsedRG,"Gameoverheader",_loc2_);
               this._gameOverScreen.Raregempanel.ReregemPlaceholder.addChild(_loc2_);
               this._gameOverScreen.Raregempanel.ReregemPlaceholder.scaleY = 0.8;
               this._gameOverScreen.Raregempanel.ReregemPlaceholder.scaleX = 0.8;
            }
            else
            {
               this._gameOverScreen.Raregempanel.ReregemPlaceholder.scaleX = 0.6;
               this._gameOverScreen.Raregempanel.ReregemPlaceholder.scaleY = 0.6;
               this._gameOverScreen.Raregempanel.ReregemPlaceholder.addChild(this.rareGemAnimation);
               if(this._app.sessionData.rareGemManager.IsRareGemAvailable(this.previousUsedRG))
               {
                  this.rareGemAnimation.gotoAndPlay(_loc1_.getStringID().toLowerCase());
               }
            }
            if(this.isRGShareable)
            {
               this._gameOverScreen.Raregempanel.ReregemPlaceholder.y -= 20;
               this.setupShareRGButton();
            }
            this._gameOverScreen.Raregempanel.RGEmpty.visible = false;
         }
      }
      
      private function setUpScore(param1:Number) : void
      {
         var _loc5_:TournamentLeaderboardData = null;
         var _loc6_:PlayerData = null;
         var _loc7_:ConfettiTypeOneParticle = null;
         var _loc8_:ConfettiTypeTwoParticle = null;
         var _loc9_:MainMenuParticle = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc2_:Boolean = this._app.sessionData.userData.NewHighScore;
         var _loc3_:TextField = this._gameOverScreen.Highscoretext.txtPointsScored;
         var _loc4_:TextField = this._gameOverScreen.Playerscore.txtPlayerScoreNum;
         this._gameOverScreen.Highscoretext.txtBCPointsScored.visible = false;
         this._gameOverScreen.Playerscore.txtBCPlayerScoreNum.visible = false;
         this._gameOverScreen.GemCounter_Bkr.visible = false;
         if(this._currentTournament != null)
         {
            if((_loc5_ = this._app.sessionData.tournamentController.LeaderboardController.getLeaderboard(this._currentTournament.Data.Id)) != null)
            {
               if((_loc6_ = _loc5_.CurrentUser) != null)
               {
                  _loc2_ = this._currentTournament.Data.Objective.Type == TournamentCommonInfo.OBJECTIVE_SCORE ? Boolean(_loc6_.currentChampionshipData.isHighScore) : false;
               }
               else
               {
                  _loc2_ = this._currentTournament.Data.Objective.Type == TournamentCommonInfo.OBJECTIVE_SCORE ? true : false;
               }
            }
            if(this._currentTournament.Data.Objective.Type != TournamentCommonInfo.OBJECTIVE_SCORE)
            {
               param1 = this._currentTournament.Data.Objective.GetScoreAccordingToObjective();
            }
            _loc3_.visible = false;
            _loc3_ = this._gameOverScreen.Highscoretext.txtBCPointsScored;
            _loc3_.visible = true;
            _loc4_.visible = false;
            (_loc4_ = this._gameOverScreen.Playerscore.txtBCPlayerScoreNum).visible = true;
         }
         _loc4_.text = Utils.commafy(param1);
         if(_loc2_)
         {
            this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_VOICE_NEW_HIGH_SCORE);
            _loc3_.text = "NEW HIGH SCORE";
            _loc3_.textColor = this.COLOR_YELLOW;
            _loc4_.textColor = this.COLOR_YELLOW;
            this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_POST_GAME_CELEBRATORY);
            if(!this._app.isLQMode)
            {
               this._gameOverScreen.ParticleConfetti.removeChildren();
               _loc7_ = new ConfettiTypeOneParticle();
               _loc8_ = new ConfettiTypeTwoParticle();
               _loc9_ = new MainMenuParticle();
               this._gameOverScreen.ParticleConfetti.addChild(_loc7_);
               this._gameOverScreen.ParticleConfetti.addChild(_loc8_);
               this._gameOverScreen.ParticleConfetti.addChild(_loc9_);
               _loc7_.AutoDelete(3333);
               _loc8_.AutoDelete(3333);
            }
         }
         else
         {
            _loc3_.text = "Your Score";
            if(this._currentTournament != null)
            {
               if(this._currentTournament.Data.Objective.Type == TournamentCommonInfo.OBJECTIVE_GEMS_DESTROYED)
               {
                  _loc3_.text = "Total Gems Collected";
                  this._gameOverScreen.GemCounter_Bkr.visible = true;
               }
               else if(this._currentTournament.Data.Objective.Type == TournamentCommonInfo.OBJECTIVE_COLORED_GEMS_DESTROYED)
               {
                  _loc11_ = (_loc10_ = this._currentTournament.Data.Objective.ColorName).substr(0,1);
                  _loc12_ = _loc10_.substr(1,_loc10_.length);
                  _loc3_.text = _loc11_.toUpperCase() + _loc12_ + " Color Gems Collected";
                  this._gameOverScreen.GemCounter_Bkr.visible = true;
               }
               else if(this._currentTournament.Data.Objective.Type == TournamentCommonInfo.OBJECTIVE_SPECIAL_GEMS_DESTROYED)
               {
                  _loc3_.text = "Special Gems Collected";
                  this._gameOverScreen.GemCounter_Bkr.visible = true;
               }
               else if(this._currentTournament.Data.Objective.Type == TournamentCommonInfo.OBJECTIVE_RARE_GEMS_DESTROYED)
               {
                  _loc3_.text = "Rare Gems Collected";
                  this._gameOverScreen.GemCounter_Bkr.visible = true;
               }
            }
            this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_POST_GAME_NORMAL);
         }
      }
      
      public function GameOverWidgetPlayAnim(param1:String, param2:Function) : void
      {
         if(this._gameOverScreen)
         {
            this.currAnimEndFrame = Utils.GetAnimationLastFrame(this._gameOverScreen,param1);
            this.animEndCallBack = param2;
            this._gameOverScreen.gotoAndPlay(param1);
            this.addEventListener(Event.ENTER_FRAME,this.GameOverWidgetAnimationUpdate,false,0,true);
         }
      }
      
      private function GameOverWidgetAnimationUpdate(param1:Event) : void
      {
         if(this._gameOverScreen)
         {
            switch(this._gameOverScreen.currentFrame)
            {
               case this.showBoost1AnimEndFrame:
                  this.playBoostLevelAnim(0,this._gameOverScreen.Boost1panel);
                  break;
               case this.showBoost2AnimEndFrame:
                  this.playBoostLevelAnim(1,this._gameOverScreen.Boost2panel);
                  break;
               case this.showBoost3AnimEndFrame:
                  this.playBoostLevelAnim(2,this._gameOverScreen.Boost3panel);
                  break;
               case this.showErrorMessageFrame:
                  if(this._currentTournament != null && this._currentTournament.HasEnded())
                  {
                     this._errorText.visible = true;
                     this.finalAnimDone = true;
                  }
            }
            if(this._gameOverScreen.currentFrame == this.currAnimEndFrame)
            {
               this.removeEventListener(Event.ENTER_FRAME,this.GameOverWidgetAnimationUpdate,false);
               if(this.animEndCallBack != null)
               {
                  this.animEndCallBack();
               }
            }
         }
      }
      
      public function OnHighScoreAnimEnd() : void
      {
         this.stateManager.GotoNextState();
      }
      
      public function OnCurrencyPanelAnimEnd() : void
      {
         if(this._currentTournament == null)
         {
            if(!this.HasBeatenFriend())
            {
               this.friendFuidList = PlayersData.GetList();
               this.postGameScrollWidget.GoToPanel(PostGameScrollWidget.USERRANK_SCREEN);
            }
         }
         else
         {
            this.postGameScrollWidget.GoToPanel(PostGameScrollWidget.LEADERBOARD_SCREEN);
         }
         if(this.tokenPayout > 0)
         {
            this._gameOverScreen.gotoAndPlay("introcurrencyend");
            this.coinCurrencyContainer.ShowWatchAdButtonIfAdAvailable();
         }
         else
         {
            this.OnShowWatchAdButtonDone();
         }
      }
      
      public function OnLeaderboardPanelAnimEnd() : void
      {
         if(this.lightseedPayout > 0)
         {
            this._app.bjbEventDispatcher.SendEvent(FTUEEvents.FTUE_SHARDS_WON,null);
         }
         if(this._currentTournament == null)
         {
            if(this.HasBeatenFriend())
            {
               this.postGameScrollWidget.GoToPanel(PostGameScrollWidget.LEADERBOARD_SCREEN);
               this.showLeaderboardWithAnimation();
            }
         }
         else
         {
            this.postGameScrollWidget.GoToPanel(PostGameScrollWidget.LEADERBOARD_SCREEN);
         }
         this.stateManager.GotoNextState();
      }
      
      private function OnShareScoreButtonClicked() : void
      {
         if(this._app.sessionData.rareGemManager.showFriendPopup)
         {
            this._app.sessionData.rareGemManager.showFriendPopup = false;
            FriendPopupServerIO.showPopup(this._app,FriendPopupServerIO.INDEX_ON_RARE_STREAK);
         }
         else
         {
            FriendPopupServerIO.showPopup(this._app,FriendPopupServerIO.INDEX_ON_GAME_END);
         }
      }
      
      public function show() : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TournamentLeaderboardController = null;
         var _loc7_:TournamentLeaderboardData = null;
         this._currentTournament = this._app.sessionData.tournamentController.getCurrentTournament();
         if(this._currentTournament != null)
         {
            this._app.bjbEventDispatcher.removeEventListener(PlayersData.LEADERBOARD_UPDATED,this.OnLeaderboardUpdated);
         }
         (this._app.ui as MainWidgetGame).menu.enablePurchaseButtons(true);
         this._crappyFPSDialog = new TwoButtonCheckBoxDialog(this._app);
         this._crappyFPSDialog.Init();
         this._crappyFPSDialog.SetDimensions(380,240);
         this._crappyFPSDialog.x = Dimensions.GAME_WIDTH * 0.5 - this._crappyFPSDialog.width * 0.5;
         this._crappyFPSDialog.y = Dimensions.GAME_HEIGHT * 0.5 - this._crappyFPSDialog.height * 0.5;
         this._crappyFPSDialog.SetContent(this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOST_MENU_LQMODE_TITLE),this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOST_MENU_LQMODE_BODY),this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOST_ABANDON_CONFIRM),this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOST_ABANDON_DECLINE));
         this._crappyFPSDialog.AddAcceptButtonHandler(this.handleAcceptGoLQModeClick);
         this._crappyFPSDialog.AddDeclineButtonHandler(this.handleDeclineGoLQModeClick);
         var _loc1_:Number = this._app.logic.GetScoreKeeper().GetScore();
         this._gameoverBG = new Bitmap(new BJBBackground());
         this._gameoverBG.x = 7;
         this._gameoverBG.y = Dimensions.NAVIGATION_HEIGHT;
         addChild(this._gameoverBG);
         this._gameOverScreen = new PostgameViewWidget();
         this._keystonesMC = new Postgamekeystones();
         this.addChild(this._keystonesMC);
         this._keystonesMC.visible = false;
         this._leftmenuPanel = new LeftMenuPanel(this._app);
         this._leftmenuPanel.Init();
         this._leftmenuPanel.setMainButtonClickCallback(this.handleHomeBtnClicked);
         this.addChild(this._leftmenuPanel);
         this._leftmenuPanel.x = -28.95;
         this._leftmenuPanel.y = 186.95 + Dimensions.NAVIGATION_HEIGHT;
         this._leftmenuPanel.hideLeftPanel();
         this._app.network.AddNavigationBagdeCounterHandler(this);
         this.isLeaderboardSetupSuccessful = false;
         var _loc2_:MainWidgetGame = this._app.ui as MainWidgetGame;
         this.addChild(this._gameOverScreen);
         if(this._app.isMultiplayerGame())
         {
            _loc4_ = this._app.party.getSideGame().parent.x + _loc2_.menu.PartnerupPlaceHolder.PartyAnimPlaceHolder.x;
            _loc5_ = 140;
            this.addChild(this._app.party.getSideGame());
            this._app.party.getSideGame().x = _loc4_;
            this._app.party.getSideGame().y = _loc5_;
         }
         this._gameOverScreen.x = _loc2_.menu.PostgameplaceHolder.x;
         this._gameOverScreen.y = _loc2_.menu.PostgameplaceHolder.y;
         this._keystonesMC.y = Dimensions.GAME_HEIGHT / 2;
         this.postGameScrollWidget = new PostGameScrollWidget(this._app,this,this._gameOverScreen.Postgameassetspanel,this._gameOverScreen.Postgameassetspanel.btnLeft,this._gameOverScreen.Postgameassetspanel.btnRight,3);
         var _loc3_:UserData = this._app.sessionData.userData;
         this._currentLevelXP = _loc3_.GetXP() - _loc3_.GetPrevLevelCutoff();
         this._totalLevelXP = _loc3_.GetNextLevelCutoff() - _loc3_.GetPrevLevelCutoff();
         this._loader = this._gameOverScreen.loadingClip;
         this._tournamentTitle = this._gameOverScreen.Tournamenttext.txtBCname;
         this._errorText = this._gameOverScreen.txterror;
         this._weeklyLeaderboardText = this._gameOverScreen.Postgameassetspanel.Leaderboardswiper.txtLeaderboard;
         this._timerText = this._gameOverScreen.BCTimerText.time;
         this._loader.visible = false;
         this._tournamentTitle.visible = false;
         this._gameOverScreen.leaderboardButton.visible = false;
         this._gameOverScreen.retryBtn.visible = false;
         this._errorText.visible = false;
         this._gameOverScreen.CaliberationText.txtcaliberation.visible = false;
         this._timerText.visible = false;
         this.addRGIconToRGPanel();
         this.setupBoostsPanel();
         this.setupCurrencyButtons();
         this.setupPlayAgainButton();
         this.setupHomeButton();
         this.setupFinisherPanel();
         this.setupXPPanel();
         this.setupStatsPanel();
         this._gameOverScreen.addEventListener(MouseEvent.CLICK,this.OnClickSkipAnimations);
         if(this._currentTournament == null)
         {
            this.setupShareButton(_loc1_);
         }
         else
         {
            this._tournamentTitle.visible = true;
            this._tournamentTitle.text = this._currentTournament.Data.Name;
            this._weeklyLeaderboardText.text = "LEADERBOARD";
            this.setUpLeaderboardButton();
         }
         this.setupStarMedal(_loc1_);
         if(this._currentTournament == null)
         {
            this.BuildLeaderboard();
         }
         else
         {
            if(this._tournamentInfoView == null)
            {
               this._tournamentInfoView = this._app.tournamentInfoView;
            }
            this._tournamentInfoView.setVisibility(false);
            if(this._currentTournament.HasEnded())
            {
               this._errorText.text = "This Contest has ended. Come back soon to play the next one!";
            }
            else
            {
               if((_loc7_ = (_loc6_ = this._app.sessionData.tournamentController.LeaderboardController).getLeaderboard(this._currentTournament.Id)) != null)
               {
                  _loc7_.setOnUserListChanged(this.BuildTournamentLeaderboard);
               }
               this.BuildTournamentLeaderboard();
            }
            this.showTournamentObjective();
         }
         this.setUpScore(_loc1_);
         this.stateManager.ProcessState();
         this._app.quest.Hide();
         this._app.metaUI.highlight.Hide(true);
         if(!this._app.isTournamentScreenOrMode())
         {
            this.displayKeystones();
         }
         else
         {
            this.displayLeftPanel();
         }
         this.turnOffKeystoneToolTipHandCursors();
         this.checkAndShowForceUpdateDialog();
         this.ShowRareGemAnimation();
      }
      
      public function ShowRareGemAnimation() : void
      {
         var _loc1_:int = this._app.sessionData.rareGemManager.GetStreakNum();
         var _loc2_:String = this.previousUsedRG;
         var _loc3_:RGLogic = this._app.logic.rareGemsLogic.GetRareGemByStringID(this.previousUsedRG);
         this._gameOverScreen.playAgainStreakMC.RareGemStreakMC.mouseEnabled = false;
         if(_loc1_ > 0)
         {
            this._gameOverScreen.playAgainStreakMC.visible = true;
            Utils.removeAllChildrenFrom(this._gameOverScreen.playAgainStreakMC.RareGemStreakMC.dynamicContainer);
            if(_loc3_ == null || this._app.logic.rareGemsLogic.isDynamicID(_loc2_))
            {
               this._gameOverScreen.playAgainStreakMC.RareGemStreakMC.gotoAndStop("off");
               DynamicRGInterface.attachMovieClip(_loc2_,"Gameoverfooter",this._gameOverScreen.playAgainStreakMC.RareGemStreakMC.dynamicContainer);
            }
            else
            {
               this._gameOverScreen.playAgainStreakMC.RareGemStreakMC.gotoAndStop(_loc2_.toLowerCase());
            }
         }
         else
         {
            this._gameOverScreen.playAgainStreakMC.visible = false;
         }
      }
      
      public function hide() : void
      {
         this._gameOverScreen.removeEventListener(MouseEvent.CLICK,this.OnClickSkipAnimations);
         var _loc1_:MainWidgetGame = this._app.ui as MainWidgetGame;
         this.removeChild(this._gameoverBG);
         this._gameoverBG = null;
         this._leaderboardListBoxArray.splice(0,this._leaderboardListBoxArray.length);
         Utils.removeAllChildrenFrom(this._boxContainer);
         this.removeChild(this._gameOverScreen);
         this._gameOverScreen = null;
         this.removeChild(this._keystonesMC);
         this._keystonesMC = null;
         this.resetGameOverWidget();
         this.postGameScrollWidget = null;
         this.tokenPayout = 0;
         this.lightseedPayout = 0;
         this.shouldScrollToPlayer = false;
         this.finalAnimDone = false;
         this.animEndCallBack = null;
         this.currAnimEndFrame = -1;
         this.stateManager.Reset();
         this._recentlyCompletedQuests = new Vector.<Quest>();
         this._recentlyExpiredQuests = new Vector.<Quest>();
         DynamicRareGemWidget.resetCachePrizeData();
         this._tournamentTimer.stop();
         this._leftmenuPanel.hideLeftPanel();
      }
      
      private function showEventsScreen() : void
      {
         if(this._app.canShowEvents())
         {
            this._app.eventsView.LaunchEventsView(false);
         }
      }
      
      private function checkAndShowForceUpdateDialog() : void
      {
         if(RequiresUpdateDialog.IsForceUpdateRequired())
         {
            RequiresUpdateDialog.show();
         }
      }
      
      public function AddHandler(param1:IPostGameStatsHandler) : void
      {
         this._handlers.push(param1);
      }
      
      public function resetGameOverWidget() : void
      {
         this.friendFuidList.splice(0,this.friendFuidList.length);
      }
      
      private function handleAcceptGoLQModeClick(param1:MouseEvent) : void
      {
         this._crappyFPSDialog.isChecked;
         this._app.isLQMode = !this._app.isLQMode;
         this._app.network.ExternalCall("GoogleAnalyticsTracker.report","LQModeAcceptClick");
         this._app.network.Refresh();
      }
      
      private function handleDeclineGoLQModeClick(param1:MouseEvent) : void
      {
         this._app.sessionData.configManager.SetFlag(ConfigManager.FLAG_HIDE_LQ_DIALOG_WARNING,this._crappyFPSDialog.isChecked);
         this._app.sessionData.configManager.CommitChanges();
         this._app.metaUI.highlight.hidePopUp();
         this._app.network.ExternalCall("GoogleAnalyticsTracker.report","LQModeDeclineClick");
      }
      
      private function DispatchContinueClicked() : void
      {
         var _loc1_:IPostGameStatsHandler = null;
         for each(_loc1_ in this._handlers)
         {
            _loc1_.HandlePostGameContinueClicked();
         }
      }
      
      private function handleShareClicked() : void
      {
         if(!this.finalAnimDone)
         {
            return;
         }
         this._app.network.PostMedal();
      }
      
      private function handleLeaderboardButtonClicked() : void
      {
         this._tournamentInfoView.setData(this._currentTournament);
         this._tournamentInfoView.Show(TournamentInfoWidget.LEADERBOARD_TAB,TournamentCommonInfo.FROM_POSTGAME);
         this._app.network.SendUIMetrics("Tournaments Leaderboard","Tournaments Game End",this._currentTournament.Id);
      }
      
      private function continuePress() : void
      {
         if(!this.finalAnimDone)
         {
            return;
         }
         if(this._app.isMultiplayerGame())
         {
            this._app.party.reAlignSideGame();
         }
         this.DispatchContinueClicked();
      }
      
      private function continueTournamentPress() : void
      {
         var _loc1_:String = null;
         var _loc2_:InsufficientFundsDialog = null;
         var _loc3_:TournamentController = null;
         if(!this.finalAnimDone)
         {
            return;
         }
         if(!this._app.sessionData.tournamentController.ValidateJoinAndRetryCost(false))
         {
            _loc1_ = this._app.sessionData.tournamentController.getCurrentTournament().Data.RetryCost.mCurrencyType;
            _loc2_ = new InsufficientFundsDialog(this._app,_loc1_);
            _loc2_.Show();
         }
         else
         {
            if(this._app.isMultiplayerGame())
            {
               this._app.party.reAlignSideGame();
            }
            _loc3_ = this._app.sessionData.tournamentController;
            _loc3_.HandleJoinRetryCost(false);
            this.DispatchContinueClicked();
         }
         this._tournamentTimer.stop();
         this._leftmenuPanel.hideLeftPanel();
      }
      
      private function handleHomeBtnClicked() : void
      {
         if(!this.finalAnimDone)
         {
            return;
         }
         if(this._app.isMultiplayerGame())
         {
            this._app.party.reAlignSideGame();
         }
         if(this._currentTournament == null)
         {
            this._app.mainState.GotoMainMenu();
         }
         else
         {
            this._app.mainState.gotoTournamentScreen();
            this._app.network.SendUIMetrics("Tournaments Homebutton","Tournaments Game End",this._currentTournament.Id);
         }
         this._tournamentTimer.stop();
         this._leftmenuPanel.hideLeftPanel();
      }
      
      private function OnRGShareClicked() : void
      {
         if(!this.finalAnimDone)
         {
            return;
         }
         this._app.network.ShowRGShareScreen();
      }
      
      private function displayLeftPanel() : void
      {
         this._keystonesMC.visible = false;
         this._leftmenuPanel.showLeftPanel();
         this._leftmenuPanel.showAll(false,false);
         this._leftmenuPanel.showMainButton(true,false);
      }
      
      private function displayKeystones() : void
      {
         var _loc6_:MovieClip = null;
         var _loc7_:Quest = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         this._keystonesMC.visible = true;
         var _loc1_:Quest = null;
         var _loc2_:Quest = null;
         var _loc3_:Vector.<Quest> = this.getDisplayableQuests();
         var _loc5_:int = 0;
         if(!this._app.questManager.IsFeatureUnlockComplete())
         {
            if(this._recentlyCompletedQuests.length > 0)
            {
               this._keystonesMC.keyClip0.gotoAndStop("easy_complete");
               _loc1_ = this._recentlyCompletedQuests[this._recentlyCompletedQuests.length - 1];
               this.displayQuest(_loc1_,0);
            }
            else
            {
               _loc1_ = _loc3_[_loc5_];
               this.displayQuest(_loc1_,0);
            }
            _loc5_ = 1;
         }
         else
         {
            _loc5_ = 0;
            while(_loc5_ < 3)
            {
               _loc1_ = this.checkIfRecentlyCompleteQuestSlot(_loc5_);
               _loc2_ = this.checkIfRecentlyExpiredQuestSlot(_loc5_);
               _loc6_ = this._keystonesMC["bottomTextMC" + _loc5_];
               if(_loc1_ != null)
               {
                  _loc6_.gotoAndPlay("complete");
                  _loc6_.clipComplete.mouseChildren = false;
                  _loc6_.clipComplete.mouseEnabled = false;
                  if(_loc5_ == 0)
                  {
                     this._keystonesMC["keyClip" + _loc5_].gotoAndStop("easy_complete");
                  }
                  else if(_loc5_ == 1)
                  {
                     this._keystonesMC["keyClip" + _loc5_].gotoAndStop("medium_complete");
                  }
                  else if(_loc5_ == 2)
                  {
                     this._keystonesMC["keyClip" + _loc5_].gotoAndStop("hard_complete");
                  }
                  _loc8_ = (_loc7_ = _loc3_[_loc5_]).getRewardType();
                  this._claimButtonArray[_loc5_] = new GenericButtonClip(this._app,_loc6_.btnClaim);
                  this._claimButtonArray[_loc5_].setRelease(this.claimPress,{
                     "rewardType":_loc8_,
                     "difficultyLevel":_loc7_.GetData().id
                  });
                  this._claimButtonArray[_loc5_].activate();
                  _loc6_.claimTextMC.RewardTweenMC.rewardT.htmlText = _loc1_.GetRewardString();
                  _loc6_.claimTextMC.mouseChildren = false;
                  _loc6_.claimTextMC.mouseEnabled = false;
                  _loc6_.claimTextMC.RewardTweenMC.rewardMC.gotoAndStop("off");
                  this._keystonesMC["keystoneT_" + _loc5_].htmlText = "";
                  this._keystonesMC["keystoneT_" + _loc5_].mouseEnabled = false;
                  if(this.isCurrentRewardRareGem(_loc8_))
                  {
                     (this._app.ui as MainWidgetGame).menu.leftPanel.showInventoryBlingButton();
                  }
               }
               else if(_loc2_ != null)
               {
                  _loc6_.gotoAndStop("expired");
                  if(_loc5_ == 0)
                  {
                     this._keystonesMC["keyClip" + _loc5_].gotoAndStop("easy");
                  }
                  else if(_loc5_ == 1)
                  {
                     this._keystonesMC["keyClip" + _loc5_].gotoAndStop("medium");
                  }
                  else if(_loc5_ == 2)
                  {
                     this._keystonesMC["keyClip" + _loc5_].gotoAndStop("hard");
                  }
                  this._keystonesMC["keystoneT_" + _loc5_].htmlText = _loc2_.GetGoalString();
                  this._keystonesMC["keystoneT_" + _loc5_].mouseEnabled = false;
                  _loc6_.RewardTweenMC.rewardT.htmlText = _loc2_.GetRewardString();
                  _loc6_.RewardTweenMC.mouseChildren = false;
                  _loc6_.RewardTweenMC.mouseEnabled = false;
                  _loc6_.RewardTweenMC.rewardMC.gotoAndStop("off");
               }
               else
               {
                  if(_loc5_ >= _loc3_.length)
                  {
                     break;
                  }
                  _loc1_ = _loc3_[_loc5_];
                  this.displayQuest(_loc1_,_loc5_);
                  if(_loc5_ == 0)
                  {
                     this._keystonesMC["keyClip" + _loc5_].gotoAndStop("easy");
                  }
                  else if(_loc5_ == 1)
                  {
                     this._keystonesMC["keyClip" + _loc5_].gotoAndStop("medium");
                  }
                  else if(_loc5_ == 2)
                  {
                     this._keystonesMC["keyClip" + _loc5_].gotoAndStop("hard");
                  }
               }
               _loc5_++;
            }
         }
         while(_loc5_ < 3)
         {
            _loc9_ = "Reveal at Rank %rank%";
            if(_loc5_ == 0)
            {
               this._keystonesMC["keystoneT_" + _loc5_].htmlText = "All Features Unlocked";
               _loc9_ = "Congratulations!";
               this._keystonesMC["keyClip" + _loc5_].gotoAndStop("easy_complete");
            }
            else if(_loc5_ == 1)
            {
               this._keystonesMC["keystoneT_" + _loc5_].htmlText = "LOCKED";
               _loc9_ = _loc9_.replace("%rank%",UserData.QUEST_SLOT_MEDIUM_LEVEL);
               this._keystonesMC["keyClip" + _loc5_].gotoAndStop("locked");
            }
            else if(_loc5_ == 2)
            {
               this._keystonesMC["keystoneT_" + _loc5_].htmlText = "LOCKED";
               _loc9_ = _loc9_.replace("%rank%",UserData.QUEST_SLOT_HARD_LEVEL);
               this._keystonesMC["keyClip" + _loc5_].gotoAndStop("locked");
            }
            this._keystonesMC["bottomTextMC" + _loc5_].gotoAndStop("reward");
            this._keystonesMC["bottomTextMC" + _loc5_].RewardTweenMC.rewardMC.gotoAndStop("off");
            this._keystonesMC["bottomTextMC" + _loc5_].RewardTweenMC.rewardT.htmlText = _loc9_;
            _loc5_++;
         }
      }
      
      private function getDisplayableQuests() : Vector.<Quest>
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:Quest = null;
         var _loc2_:Vector.<Quest> = this._app.questManager.GetActiveQuests();
         var _loc3_:Vector.<Quest> = new Vector.<Quest>();
         var _loc4_:Boolean = this._app.sessionData.featureManager.isFeatureEnabled(FeatureManager.FEATURE_DYNAMIC_EASY_QUESTS);
         if(!this._app.questManager.IsFeatureUnlockComplete())
         {
            _loc3_.push(_loc2_[0]);
         }
         else
         {
            _loc5_ = _loc2_.length;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc1_ = _loc2_[_loc6_];
               if(this._app.questManager.IsDynamicQuest(_loc1_.GetData().id))
               {
                  _loc3_.push(_loc1_);
               }
               _loc6_++;
            }
         }
         return _loc3_;
      }
      
      private function displayQuest(param1:Quest, param2:int) : void
      {
         var _loc6_:String = null;
         var _loc7_:Number = NaN;
         this._keystonesMC.visible = true;
         this._keystonesMC["keystoneT_" + param2].htmlText = param1.GetGoalString();
         var _loc3_:MovieClip = this._keystonesMC["bottomTextMC" + param2];
         _loc3_.gotoAndStop("reward");
         var _loc4_:String = param1.GetRewardString();
         _loc3_.RewardTweenMC.rewardT.htmlText = _loc4_;
         var _loc5_:String = param1.getRewardType();
         if(this.hasDisplayIcon(_loc5_))
         {
            _loc3_.RewardTweenMC.rewardMC.gotoAndStop(_loc5_);
            _loc6_ = param1.GetProgressString();
            if(this._progressButtonArray[param2] != null)
            {
               this._progressButtonArray[param2].destroy();
               this._progressButtonArray[param2] = null;
            }
            if(_loc6_ != "")
            {
               this._progressButtonArray[param2] = new GenericButtonClip(this._app,_loc3_.btnProgress);
               this._progressButtonArray[param2].setShowGraphics(false);
               this._progressButtonArray[param2].clearAudio();
               this._progressButtonArray[param2].clipListener.useHandCursor = false;
               this._progressButtonArray[param2].setRollOver(_loc3_.gotoAndPlay,"progressOn");
               this._progressButtonArray[param2].setRollOut(_loc3_.gotoAndPlay,"progressOff");
               this._progressButtonArray[param2].setDragOut(_loc3_.gotoAndPlay,"progressOff");
               this._progressButtonArray[param2].activate();
               _loc3_.progressTweenMC.progressT.htmlText = _loc6_;
               if((_loc7_ = param1.GetProgress() / param1.GetGoal()) > 1)
               {
                  _loc7_ = 1;
               }
               _loc3_.progressTweenMC.progressBarMC.width = _loc7_ * 135;
            }
         }
         else
         {
            _loc3_.RewardTweenMC.rewardMC.gotoAndStop("off");
            _loc3_.RewardTweenMC.rewardT.htmlText = _loc4_;
         }
      }
      
      private function turnOffKeystoneToolTipHandCursors() : void
      {
         this._keystonesMC.toolTipButton0.useHandCursor = false;
         this._keystonesMC.toolTipButton1.useHandCursor = false;
         this._keystonesMC.toolTipButton2.useHandCursor = false;
      }
      
      private function checkIfRecentlyCompleteQuestSlot(param1:int) : Quest
      {
         var _loc4_:Quest = null;
         var _loc5_:String = null;
         var _loc2_:int = this._recentlyCompletedQuests.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if((_loc5_ = (_loc4_ = this._recentlyCompletedQuests[_loc3_]).GetData().id) == QuestManager.QUEST_DYNAMIC_EASY && param1 == 0 || _loc5_ == QuestManager.QUEST_DYNAMIC_MEDIUM && param1 == 1 || _loc5_ == QuestManager.QUEST_DYNAMIC_HARD && param1 == 2)
            {
               return _loc4_;
            }
            _loc3_++;
         }
         return null;
      }
      
      private function checkIfRecentlyExpiredQuestSlot(param1:int) : Quest
      {
         var _loc3_:Quest = null;
         var _loc4_:String = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._recentlyExpiredQuests.length)
         {
            _loc3_ = this._recentlyExpiredQuests[_loc2_];
            if((_loc4_ = _loc3_.GetData().id) == QuestManager.QUEST_DYNAMIC_EASY && param1 == 0 || _loc4_ == QuestManager.QUEST_DYNAMIC_MEDIUM && param1 == 1 || _loc4_ == QuestManager.QUEST_DYNAMIC_HARD && param1 == 2)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      private function hasDisplayIcon(param1:String) : Boolean
      {
         var _loc2_:String = null;
         for each(_loc2_ in _SUPPORTED_REWARDS)
         {
            if(_loc2_.toLowerCase() == param1.toLowerCase())
            {
               return true;
            }
         }
         return false;
      }
      
      private function isCurrentRewardRareGem(param1:String) : Boolean
      {
         var _loc2_:Dictionary = null;
         var _loc3_:* = null;
         param1 = param1.toLowerCase();
         _loc2_ = this._app.sessionData.configManager.GetDictionary(ConfigManager.DICT_RARE_GEM_WEIGHTS_PARTY);
         for(_loc3_ in _loc2_)
         {
            if(_loc3_.toLowerCase() == param1)
            {
               return true;
            }
         }
         _loc2_ = this._app.sessionData.configManager.GetDictionary(ConfigManager.DICT_RARE_GEM_WEIGHTS);
         for(_loc3_ in _loc2_)
         {
            if(_loc3_.toLowerCase() == param1)
            {
               return true;
            }
         }
         _loc2_ = this._app.sessionData.rareGemManager.GetCatalog();
         for(_loc3_ in _loc2_)
         {
            if(_loc3_.toLowerCase() == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      private function levelProgressTweenComplete() : void
      {
         if(!this._gameOverScreen)
         {
            return;
         }
         this.finalAnimDone = true;
         if(this._app.eventsNextLaunchUrl != "")
         {
            this.showEventsScreen();
         }
         this._app.SoundManager.stopSound(Blitz3GameSounds.SOUND_POST_GAME_BAR_RISER);
         if(this._app.isLQMode)
         {
            return;
         }
         var _loc1_:GlowBustParticle = new GlowBustParticle();
         this._gameOverScreen.Postgameassetspanel.Leaderboardswiper.ParticleRankUp.addChild(_loc1_);
      }
      
      private function killClaimButtons() : void
      {
         var _loc2_:Quest = null;
         this._app.questManager.UpdateQuestCompletion("onGameOverKeyStoneClaimed");
         var _loc1_:Vector.<Quest> = this.getDisplayableQuests();
         var _loc3_:int = _loc1_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _loc1_[_loc4_];
            this.displayQuest(_loc2_,_loc4_);
            if(_loc4_ == 0)
            {
               this._keystonesMC["keyClip" + _loc4_].gotoAndStop("easy");
            }
            else if(_loc4_ == 1)
            {
               this._keystonesMC["keyClip" + _loc4_].gotoAndStop("medium");
            }
            else if(_loc4_ == 2)
            {
               this._keystonesMC["keyClip" + _loc4_].gotoAndStop("hard");
            }
            _loc4_++;
         }
      }
      
      private function claimPress(param1:Object) : void
      {
         var _loc6_:String = null;
         var _loc7_:* = null;
         if(!this.finalAnimDone)
         {
            return;
         }
         var _loc2_:String = param1["difficultyLevel"];
         var _loc3_:String = param1["rewardType"];
         var _loc4_:int = this._recentlyCompletedQuests.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if(this._recentlyCompletedQuests[_loc5_].GetData().id == _loc2_)
            {
               this._recentlyCompletedQuests.splice(_loc5_,1);
               break;
            }
            _loc5_++;
         }
         this.killClaimButtons();
         if(this.isCurrentRewardRareGem(_loc3_))
         {
            _loc7_ = (_loc6_ = this._app.sessionData.rareGemManager.GetLocalizedRareGemName(_loc3_)) + "  is added to your inventory.";
            this._questRaregemRewardDialog = new SingleButtonDialog(this._app);
            this._questRaregemRewardDialog.Init();
            this._questRaregemRewardDialog.SetDimensions(400,200);
            this._questRaregemRewardDialog.SetContent("YOU WON A RARE GEM!",_loc7_,"OK");
            this._questRaregemRewardDialog.AddContinueButtonHandler(this.closeRewardDialog);
            this._app.metaUI.highlight.showPopUp(this._questRaregemRewardDialog,true,true,0.55);
         }
         else
         {
            this._app.network.ExternalCall("showMessageCenter",{
               "clientVersion":Version.version,
               "rivals":this._app.mainmenuLeaderboard.GetCurrentRivalCount(),
               "userId":this._app.mainmenuLeaderboard.currentPlayerFUID,
               "friendsInvited":0,
               "lbPosition":this._app.mainmenuLeaderboard.getCurrentPlayerData().rank,
               "messageCount":(this._app.ui as MainWidgetGame).menu.leftPanel.getNotificationCount()
            });
         }
      }
      
      private function closeRewardDialog(param1:MouseEvent) : void
      {
         this._app.metaUI.highlight.hidePopUp();
      }
      
      public function HandleQuestComplete(param1:Quest) : void
      {
         if(param1.GetData().id != QuestManager.QUEST_STRONG_MILESTONE && param1.GetData().id != QuestManager.QUEST_WEAK_MILESTONE)
         {
            this._recentlyCompletedQuests.push(param1);
         }
      }
      
      public function HandleQuestExpire(param1:Quest) : void
      {
         if(param1.GetData().id != QuestManager.QUEST_STRONG_MILESTONE && param1.GetData().id != QuestManager.QUEST_WEAK_MILESTONE)
         {
            this._recentlyExpiredQuests.push(param1);
         }
      }
      
      public function HandleQuestsUpdated(param1:Boolean) : void
      {
      }
      
      public function CanShowQuestReward() : Boolean
      {
         return true;
      }
      
      public function HandleQuestRewardClosed(param1:String) : void
      {
      }
      
      public function HandleQuestRewardOpened() : void
      {
      }
      
      public function HandleGameLoad() : void
      {
      }
      
      public function HandleGameBegin() : void
      {
         this._recentlyCompletedQuests = new Vector.<Quest>();
         this._recentlyExpiredQuests = new Vector.<Quest>();
      }
      
      public function HandleGameEnd() : void
      {
      }
      
      public function HandleGameAbort() : void
      {
      }
      
      public function HandleGamePaused() : void
      {
      }
      
      public function HandleGameResumed() : void
      {
      }
      
      public function HandleScore(param1:ScoreValue) : void
      {
      }
      
      public function HandlePointsScored(param1:ScoreData) : void
      {
      }
      
      public function HandleBlockingEvent() : void
      {
      }
      
      public function HandleScrollBeginToPage(param1:int) : void
      {
         if(this._gameOverScreen == null)
         {
            return;
         }
         if(this._currentTournament != null)
         {
            if(param1 == 2)
            {
               this.OnPresentingXPScreen();
            }
            return;
         }
         switch(param1)
         {
            case 1:
               this.BuildLeaderboard();
               break;
            case 2:
               this.BuildLeaderboard();
               this.OnPresentingXPScreen();
               break;
            case 3:
         }
      }
      
      public function HandleScrolledToPage(param1:int) : void
      {
         if(this._gameOverScreen == null)
         {
            return;
         }
         switch(param1)
         {
            case 1:
               this.showLeaderboard();
               break;
            case 2:
               this.HideLeaderboard();
               break;
            case 3:
         }
      }
      
      public function OnShowWatchAdButtonDone() : void
      {
         this.stateManager.GotoNextState();
      }
      
      public function HandleAdComplete(param1:String) : void
      {
         if(param1 == Blitz3Network.POSTGAME_PLACEMENT)
         {
            if(this.coinCurrencyContainer != null)
            {
               this.coinCurrencyContainer.updateValue(this.tokenPayout * 2);
            }
            this._app.adFrequencyManager.decrementRemainingUsesByPlacement(param1);
         }
      }
      
      public function HandleAdsStateChanged(param1:Boolean) : void
      {
      }
      
      public function HandleAdCapExhausted(param1:String) : void
      {
         if(param1 == Blitz3Network.POSTGAME_PLACEMENT)
         {
            this.coinCurrencyContainer.ShowWatchAdButtonIfAdAvailable(false);
         }
      }
      
      private function OnClickSkipAnimations(param1:MouseEvent) : void
      {
         this._gameOverScreen.removeEventListener(MouseEvent.CLICK,this.OnClickSkipAnimations);
         this.stateManager.OnSkipClicked();
      }
      
      public function SkipToFinalFrame() : void
      {
         if(this._gameOverScreen.currentFrame < this._gameOverScreen.totalFrames)
         {
            this._gameOverScreen.gotoAndStop(this._gameOverScreen.totalFrames);
         }
      }
      
      public function OnRGShareScreenDismissed(param1:Boolean) : void
      {
         this._btnShareRG.clipListener.visible = !param1;
      }
      
      public function ExternCallRefreshKeystones() : void
      {
         if(this._recentlyCompletedQuests.length > 0)
         {
            this._recentlyCompletedQuests.splice(0,this._recentlyCompletedQuests.length);
            this.killClaimButtons();
         }
      }
      
      public function IsShown() : Boolean
      {
         return this._gameOverScreen != null;
      }
      
      public function HandleGameTimeDelayed() : void
      {
      }
      
      public function HandleAdClosed(param1:String) : void
      {
      }
      
      public function updateComputingResultText(param1:TimerEvent) : void
      {
         var _loc4_:String = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc2_:Date = new Date();
         var _loc3_:Number = _loc2_.getTime().valueOf() / 1000;
         if(this._currentTournament.IsComputingResults())
         {
            if(this._gameOverScreen != null)
            {
               this._gameOverScreen.CaliberationText.txtcaliberation.visible = true;
               this._timerText.visible = false;
               _loc4_ = "Your results are loading.\nThis should take ";
               if((_loc5_ = this._currentTournament.getExpectedResultsAvailableTime() - _loc3_) > 0)
               {
                  _loc4_ += Utils.getHourStringFromSeconds(_loc5_);
               }
               this._gameOverScreen.CaliberationText.txtcaliberation.text = _loc4_;
               this._gameOverScreen.retryBtn.visible = false;
               this._gameOverScreen.leaderboardButton.visible = false;
            }
         }
         else if(this._currentTournament.IsRunning())
         {
            if(this._gameOverScreen != null)
            {
               this._gameOverScreen.CaliberationText.txtcaliberation.visible = false;
               this._timerText.visible = true;
               if((_loc6_ = this._currentTournament.RemainingTime) > 0)
               {
                  this._timerText.text = "Ends in " + Utils.getHourStringFromSeconds(_loc6_);
               }
            }
         }
         else if(this._currentTournament.HasEnded())
         {
            if(this._gameOverScreen != null)
            {
               this._gameOverScreen.CaliberationText.txtcaliberation.visible = false;
               this._timerText.visible = true;
               this._timerText.text = "Contest results are ready!";
               if(this._gameOverScreen.retryBtn != null)
               {
                  this._gameOverScreen.retryBtn.visible = false;
               }
               this._gameOverScreen.leaderboardButton.visible = false;
            }
            this._tournamentTimer.stop();
         }
      }
      
      public function showTournamentObjective() : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:RGLogic = null;
         var _loc5_:Number = NaN;
         var _loc6_:RareGemWidget = null;
         var _loc7_:int = 0;
         var _loc8_:ImageInst = null;
         var _loc9_:Bitmap = null;
         var _loc1_:TournamentRuntimeEntity = this._app.sessionData.tournamentController.getCurrentTournament();
         if(_loc1_ != null)
         {
            _loc2_ = _loc1_.Data.Objective.Type;
            if(_loc2_ == TournamentCommonInfo.OBJECTIVE_RARE_GEMS_DESTROYED)
            {
               this._gameOverScreen.GemcounterIcon.gotoAndStop("placeholder");
               Utils.removeAllChildrenFrom(this._gameOverScreen.GemcounterIcon.Placeholder);
               _loc3_ = this._app.sessionData.rareGemManager.GetCurrentOffer().GetID();
               _loc4_ = this._app.logic.rareGemsLogic.GetRareGemByStringID(_loc3_);
               _loc5_ = 0.8;
               (_loc6_ = new RareGemWidget(this._app,new DynamicRareGemLoader(this._app),"small",0,0,_loc5_,_loc5_,false)).reset(_loc4_);
               this._gameOverScreen.GemcounterIcon.Placeholder.addChild(_loc6_);
            }
            else if(_loc2_ == TournamentCommonInfo.OBJECTIVE_COLORED_GEMS_DESTROYED)
            {
               this._gameOverScreen.GemcounterIcon.gotoAndStop("placeholder");
               Utils.removeAllChildrenFrom(this._gameOverScreen.GemcounterIcon.Placeholder);
               _loc7_ = _loc1_.Data.Objective.ColorIndex;
               _loc8_ = null;
               if(_loc7_ == 1)
               {
                  _loc8_ = this._app.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_RED);
               }
               else if(_loc7_ == 2)
               {
                  _loc8_ = this._app.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_ORANGE);
               }
               else if(_loc7_ == 3)
               {
                  _loc8_ = this._app.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_YELLOW);
               }
               else if(_loc7_ == 4)
               {
                  _loc8_ = this._app.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_GREEN);
               }
               else if(_loc7_ == 5)
               {
                  _loc8_ = this._app.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_BLUE);
               }
               else if(_loc7_ == 6)
               {
                  _loc8_ = this._app.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_PURPLE);
               }
               else if(_loc7_ == 7)
               {
                  _loc8_ = this._app.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_WHITE);
               }
               if(_loc8_ != null)
               {
                  (_loc9_ = new Bitmap()).smoothing = true;
                  _loc9_.scaleX = 32 / _loc8_.width;
                  _loc9_.scaleY = 32 / _loc8_.height;
                  this._gameOverScreen.GemcounterIcon.Placeholder.addChild(_loc9_);
                  this._gameOverScreen.GemcounterIcon.Placeholder.scrollRect = new Rectangle(0,0,32,32);
                  this._gameOverScreen.GemcounterIcon.Placeholder.cacheAsBitmap = true;
                  _loc9_.bitmapData = _loc8_.pixels.clone();
               }
            }
            else if(_loc2_ == TournamentCommonInfo.OBJECTIVE_GEMS_DESTROYED)
            {
               this._gameOverScreen.GemcounterIcon.gotoAndStop("AllGems");
            }
            else if(_loc2_ == TournamentCommonInfo.OBJECTIVE_SPECIAL_GEMS_DESTROYED)
            {
               this._gameOverScreen.GemcounterIcon.gotoAndStop("AllSpecialGems");
            }
         }
      }
      
      public function updateBadgeCounter(param1:Object) : void
      {
         if(this._leftmenuPanel != null)
         {
            this._leftmenuPanel.handleSetCounter(param1);
         }
      }
   }
}
