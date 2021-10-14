package com.popcap.flash.bejeweledblitz.dailychallenge
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.IServerIO;
   import com.popcap.flash.bejeweledblitz.ServerIO;
   import com.popcap.flash.bejeweledblitz.ServerIOInstantiable;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.error.ErrorReportingManager;
   import com.popcap.flash.bejeweledblitz.game.session.Blitz3Network;
   import com.popcap.flash.bejeweledblitz.game.session.IBlitz3NetworkHandler;
   import com.popcap.flash.bejeweledblitz.game.session.IHandleNetworkAdStateChangeCallback;
   import com.popcap.flash.bejeweledblitz.game.session.ISessionData;
   import com.popcap.flash.bejeweledblitz.game.session.UserData;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.InsufficientFundsDialog;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.TwoButtonDialog;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemLoader;
   import com.popcap.flash.bejeweledblitz.logic.DailyChallengeConfigValidator;
   import com.popcap.flash.bejeweledblitz.logic.DailyChallengeLogicConfig;
   import com.popcap.flash.bejeweledblitz.logic.GemColors;
   import com.popcap.flash.bejeweledblitz.logic.IDailyChallengeRewardDisplay;
   import com.popcap.flash.bejeweledblitz.logic.IErrorLogger;
   import com.popcap.flash.bejeweledblitz.logic.boostV2.BoostV2;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class DailyChallengeManager extends MovieClip implements IBlitz3NetworkHandler, IHandleNetworkAdStateChangeCallback
   {
      
      private static const EXPIRING_SOON_TIME:int = 5 * 60 * 1000;
      
      private static const STAR_CAT_FLASH_VAR:String = "starCats";
      
      private static const DAILY_CHALLENGED_TODAY_FLASH_VAR:String = "challengedToday";
       
      
      private var _app:Blitz3Game;
      
      private var _logic:BlitzLogic;
      
      private var _network:Blitz3Network;
      
      private var _userData:UserData;
      
      private var _sessionData:ISessionData;
      
      private var _gemColors:GemColors;
      
      private var _serverIO:IServerIO;
      
      private var _errorReportingManager:ErrorReportingManager;
      
      private var _dialogView:DailyChallengeDialogWrapper;
      
      private var _dailyChallengeMetricsPayload:Object;
      
      private var _dailyChallengeConfigProvider:IDailyChallengeConfigProvider;
      
      private var _dailyChallengeConfigList:DailyChallengeConfigList;
      
      private var _dailyChallengeRGName:String = "";
      
      private var _dailyChallengeRGOfferDialog:TwoButtonDialog;
      
      private var _dailyChallengeConfigReader:IDailyChallengeConfigReader;
      
      private var _dailyChallengeConfigValidator:IDailyChallengeConfigValidator;
      
      private var _timeToLiveTimer:Timer;
      
      private var _playDailyChallengeButton:PlayDailyChallengeMainScreenButton;
      
      private var _rareGemGeneratedInSession:Boolean = false;
      
      private var _dcFactory:MovieClipDailyChallengeRewardDisplayFactory;
      
      private var _dailyChallengeRewardDisplay:IDailyChallengeRewardDisplay;
      
      private var _isWatchAdFreeRetry:Boolean;
      
      private var _isWatchAdClicked:Boolean;
      
      public function DailyChallengeManager(param1:Blitz3Game, param2:BlitzLogic, param3:Blitz3Network, param4:ISessionData, param5:GemColors, param6:IServerIO, param7:ErrorReportingManager, param8:DailyChallengeLogicConfig, param9:IDailyChallengeConfigProvider, param10:IDailyChallengeConfigReader, param11:IDailyChallengeConfigValidator, param12:PlayDailyChallengeMainScreenButton)
      {
         super();
         this.isWatchAdFreeRetry = false;
         this._app = param1;
         this._logic = param2;
         this._network = param3;
         this._network.AddHandler(this);
         this._userData = param4.userData;
         this._sessionData = param4;
         this._gemColors = param5;
         this._serverIO = param6;
         this._errorReportingManager = param7;
         this._dailyChallengeConfigList = new DailyChallengeConfigList();
         this._dailyChallengeConfigList.add(param8);
         this._dailyChallengeConfigProvider = param9;
         this._userData.StarCats = this._network.parameters[STAR_CAT_FLASH_VAR];
         this._dailyChallengeConfigReader = param10;
         this._dailyChallengeConfigValidator = param11;
         this._playDailyChallengeButton = param12;
         this._timeToLiveTimer = new Timer(DailyChallengeLogicConfig.TIMER_UPDATE_INTERVAL_MILLISECONDS,0);
         this._timeToLiveTimer.addEventListener(TimerEvent.TIMER,this.handleTimerEvent,false,0,true);
         this._timeToLiveTimer.start();
         var _loc13_:Object;
         (_loc13_ = new Object()).caller = "init";
         this._dailyChallengeConfigProvider.fetchDailyChallenge(this.onGetDailyChallenge,_loc13_);
         var _loc14_:MovieClip;
         (_loc14_ = (this._app.ui as MainWidgetGame).menu.mcBannerDailyChallenge).addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverDailyChallengeBanner);
         _loc14_.addEventListener(MouseEvent.MOUSE_OUT,this.validateDailyChallengeButton);
         this._app.network.AddAdStateChangHandler(this);
      }
      
      public static function build(param1:Blitz3Game) : DailyChallengeManager
      {
         var _loc2_:GemColors = new GemColors();
         var _loc3_:ServerIOInstantiable = new ServerIOInstantiable();
         var _loc4_:ErrorReportingManager = new ErrorReportingManager(param1);
         var _loc5_:IErrorLogger = new DailyChallengeErrorLogger(_loc4_);
         var _loc6_:DailyChallengeConfigValidator = new DailyChallengeConfigValidator(_loc2_,_loc5_,new DailyChallengeRewardFactory(param1.sessionData.rareGemManager));
         var _loc7_:MovieClip = (param1.ui as MainWidgetGame).menu.mcBannerDailyChallenge;
         return new DailyChallengeManager(param1,param1.logic,param1.network,param1.sessionData,_loc2_,_loc3_,_loc4_,new DailyChallengeLogicConfig(),new ServerIODailyChallengeConfigProvider(_loc3_),new DailyChallengeConfigReader(param1.sessionData.rareGemManager,_loc2_),new DailyChallengeConfigValidatorProxy(_loc6_,_loc5_),new PlayDailyChallengeMainScreenButton(_loc7_));
      }
      
      public function getDailyChallengeConfigList() : DailyChallengeConfigList
      {
         return this._dailyChallengeConfigList;
      }
      
      public function getDailyChallengeConfig(param1:String) : void
      {
         var _loc2_:Object = new Object();
         _loc2_.caller = param1;
         this._dailyChallengeConfigProvider.fetchDailyChallenge(this.onGetDailyChallenge,_loc2_);
      }
      
      public function playEarnedRareGem(param1:MouseEvent) : void
      {
         this._dailyChallengeMetricsPayload.RareGemUsed = true;
         this.Hide();
         this.hideDailyChallengeRGOfferDialog();
         this.tearDownState();
         this._app.mainState.GotoMainMenu();
         this._sessionData.rareGemManager.SetRareGemForDailyChallenges(this._dailyChallengeRGName);
         var _loc4_:Object;
         (_loc4_ = new Object()).messageId = "uberGemInventory-" + this._dailyChallengeRGName + "-grant";
         _loc4_.rareGemCost = "free";
         _loc4_.rareGemName = this._dailyChallengeRGName;
         _loc4_.harvestSource = "DailyChallenge";
         this._sessionData.rareGemManager.HandleRareGemGrant(_loc4_);
         this._app.mainState.HandleQuit();
         this._dailyChallengeRGName = "";
      }
      
      public function bankEarnedRareGem(param1:MouseEvent) : void
      {
         if(this._dailyChallengeMetricsPayload != null)
         {
            this._dailyChallengeMetricsPayload.RareGemUsed = false;
         }
         this.hideDailyChallengeRGOfferDialog();
         this._dailyChallengeRGName = "";
         (this._app.ui as MainWidgetGame).menu.leftPanel.showInventoryBlingButton();
      }
      
      public function hideDailyChallengeRGOfferDialog() : void
      {
         this._app.metaUI.highlight.hidePopUp();
         ServerIO.sendToServer("sendDailyChallengeMetric",this._dailyChallengeMetricsPayload);
         this._dailyChallengeMetricsPayload = null;
      }
      
      public function showDailyChallengeRGOfferDialog() : void
      {
         this._dailyChallengeRGOfferDialog = new TwoButtonDialog(this._app,16);
         this._dailyChallengeRGOfferDialog.Init();
         this._dailyChallengeRGOfferDialog.SetDimensions(420,216);
         var _loc1_:String = this._sessionData.rareGemManager.GetTaglessRareGemNameWithTitleCasing(this._dailyChallengeRGName);
         this._dailyChallengeRGOfferDialog.SetContent("Rare Gem","You\'ve earned a " + _loc1_ + "!!  Leave Daily Challenge mode and play it now?","Play Now!","Bank it");
         this._dailyChallengeRGOfferDialog.x = Dimensions.LEFT_BORDER_WIDTH + Dimensions.GAME_WIDTH / 2 - this._dailyChallengeRGOfferDialog.width / 2;
         this._dailyChallengeRGOfferDialog.y = Dimensions.TOP_BORDER_WIDTH + Dimensions.GAME_HEIGHT / 2 - this._dailyChallengeRGOfferDialog.height / 2;
         this._dailyChallengeRGOfferDialog.AddAcceptButtonHandler(this.playEarnedRareGem);
         this._dailyChallengeRGOfferDialog.AddDeclineButtonHandler(this.bankEarnedRareGem);
         this._app.metaUI.highlight.showPopUp(this._dailyChallengeRGOfferDialog,true,true,0.55);
      }
      
      public function show() : void
      {
         if(!this._dialogView)
         {
            return;
         }
         this.displayStarCats();
         if(this._app.logic.IsDailyChallengeGame())
         {
            (this._app.ui as MainWidgetGame).game.showDailyChallengeCover(false);
            this._playDailyChallengeButton.SetNumberOfStarCatsWon(this.getNumStarCats());
         }
         else if(this._dailyChallengeRGName != "")
         {
            this.showDailyChallengeRGOfferDialog();
         }
         this.setUpState();
         this._dialogView.setScore(this._logic.GetScoreKeeper().GetScore());
         this._dialogView.setStarCatRewards(this._dailyChallengeConfigList.getActive());
         this.handleTimerEvent(null);
         addChild(this._dialogView.dialog);
         this.validateIfDCIsFree();
         if(this._dialogView.isWatchAdBtnHidden())
         {
            this._app.network.SendAdAvailabilityMetrics(Blitz3Network.DC_PLACEMENT);
         }
      }
      
      private function onMouseOverDailyChallengeBanner(param1:Event) : void
      {
         var _loc2_:MovieClip = (this._app.ui as MainWidgetGame).menu.mcBannerDailyChallenge;
         _loc2_.freeDCText.visible = false;
      }
      
      private function validateDailyChallengeButton(param1:Event) : void
      {
         this.validateIfDCIsFree();
      }
      
      private function validateIfDCIsFree() : void
      {
         var _loc1_:DailyChallengeLogicConfig = this._dailyChallengeConfigList.getActive();
         var _loc2_:MovieClip = (this._app.ui as MainWidgetGame).menu.mcBannerDailyChallenge;
         var _loc3_:* = _loc1_.retryCost == 0;
         if(_loc2_.freeDCText)
         {
            _loc2_.freeDCText.visible = _loc3_;
         }
         if(_loc2_.freeDCBanner)
         {
            _loc2_.freeDCBanner.visible = _loc3_;
         }
      }
      
      private function handleTimerEvent(param1:TimerEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:DailyChallengeLogicConfig = this._dailyChallengeConfigList.getActive();
         this._dailyChallengeConfigList.incrementConfigs();
         if(this._dialogView == null)
         {
            return;
         }
         if(_loc2_.timeUntilNextChallenge() <= 0)
         {
            this._dialogView.setExpired(_loc2_);
            this._playDailyChallengeButton.TrySetDailyChallengeTimeRemaining("Expired");
         }
         else if(_loc2_.timeUntilNextChallenge() < EXPIRING_SOON_TIME)
         {
            this._dialogView.setExpiringSoon(_loc2_);
            this._playDailyChallengeButton.TrySetDailyChallengeTimeRemaining("Expiring Soon!");
         }
         else
         {
            _loc3_ = Utils.getHourStringFromSeconds(_loc2_.secondsUntilNextChallenge());
            this._dialogView.setActive(_loc2_,_loc3_);
            this._playDailyChallengeButton.TrySetDailyChallengeTimeRemaining("Ends in: " + _loc3_);
         }
      }
      
      private function displayStarCats() : void
      {
         var _loc1_:int = this.getNumStarCats();
         var _loc2_:DailyChallengeLogicConfig = this._dailyChallengeConfigList.getActive();
         this._dialogView.setStarCatDisplay(_loc1_);
         this._dialogView.showPlayButton(_loc2_);
         this._playDailyChallengeButton.SetNumberOfStarCatsWon(_loc1_);
         this.validateIfDCIsFree();
      }
      
      private function displayStarCatInterstitial() : void
      {
         var _loc1_:DailyChallengeLogicConfig = this._dailyChallengeConfigList.getActive();
         var _loc2_:int = this._app.logic.GetScoreKeeper().GetScore();
         var _loc3_:int = _loc1_.starCatsEarned(_loc2_);
         this._dialogView.showInterstitial(_loc2_,_loc3_);
      }
      
      private function dismissStarCatInterstitial(param1:MouseEvent) : void
      {
         if(this._dailyChallengeRGName != "")
         {
            this.showDailyChallengeRGOfferDialog();
         }
         this._dialogView.hideInterstitial();
         this.buildDialogView();
         this.displayStarCats();
      }
      
      private function getNumStarCats() : int
      {
         return this._userData.StarCats;
      }
      
      public function Hide() : void
      {
         if(this.contains(this._dialogView.dialog))
         {
            removeChild(this._dialogView.dialog);
         }
         this._dialogView.hideInterstitial();
      }
      
      private function onWatchAdClicked(param1:MouseEvent) : void
      {
         this._isWatchAdClicked = true;
         (this._app.ui as MainWidgetGame).networkWait.Show(this);
         this._app.network.showAd(Blitz3Network.DC_PLACEMENT,1);
      }
      
      private function initiateDailyChallengeGame(param1:MouseEvent) : void
      {
         var _loc6_:InsufficientFundsDialog = null;
         var _loc7_:String = null;
         var _loc8_:BoostV2 = null;
         var _loc9_:int = 0;
         this._isWatchAdClicked = false;
         var _loc2_:DailyChallengeLogicConfig = this._dailyChallengeConfigList.getActive();
         this._dailyChallengeConfigList.incrementActiveGamesPlayed();
         if(_loc2_.hasBeenPlayedOnce() || this.isWatchAdFreeRetry)
         {
            if(this.isWatchAdFreeRetry)
            {
               this.isWatchAdFreeRetry = false;
            }
         }
         else
         {
            if(this._userData.currencyManager.GetCurrencyByType(CurrencyManager.TYPE_COINS) < _loc2_.retryCost)
            {
               (_loc6_ = new InsufficientFundsDialog(this._app,CurrencyManager.TYPE_COINS)).Show();
               return;
            }
            this._userData.currencyManager.SetCurrencyByType(this._userData.currencyManager.GetCurrencyByType(CurrencyManager.TYPE_COINS) - this._dailyChallengeConfigList.getActive().retryCost,CurrencyManager.TYPE_COINS);
            ServerIO.sendToServer("buyDailyChallengeRetry");
         }
         this.setUpState();
         this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_BACKGROUND_CHANGE);
         var _loc3_:String = this._logic.configDailyChallenge.rareGem;
         if(_loc3_ != "")
         {
            this._sessionData.rareGemManager.SetRareGemForDailyChallenges(_loc3_);
            this._rareGemGeneratedInSession = true;
         }
         var _loc4_:Vector.<BoostV2> = new Vector.<BoostV2>();
         var _loc5_:int = 0;
         while(_loc5_ < this._logic.configDailyChallenge.boosts.length)
         {
            if(this._logic.configDailyChallenge.boosts[_loc5_] != null)
            {
               _loc7_ = this._logic.configDailyChallenge.boosts[_loc5_].type;
               if((_loc8_ = this._app.sessionData.boostV2Manager.getBoostV2FromBoostId(_loc7_,true)) != null)
               {
                  _loc9_ = this._logic.configDailyChallenge.boosts[_loc5_].level;
                  _loc8_.InitWithLevel(_loc9_);
                  _loc4_.push(_loc8_);
               }
            }
            _loc5_++;
         }
         this._sessionData.boostV2Manager.setEquippedBoosts(_loc4_);
         this._app.mainState.StartGame();
         this.Hide();
      }
      
      private function onCancelButtonClick(param1:MouseEvent) : void
      {
         this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_GENERIC_TAP);
         this.tearDownState();
         this.Hide();
         this._app.mainState.GotoMainMenu();
      }
      
      private function onRefreshButtonClick(param1:MouseEvent) : void
      {
         this._logic.GetScoreKeeper().Reset();
         this._app.metaUI.highlight.showLoadingWheel();
         this.getDailyChallengeConfig("refreshClicked");
      }
      
      private function onGetDailyChallenge(param1:Object) : void
      {
         var _loc2_:DailyChallengeLogicConfig = null;
         var _loc3_:String = null;
         this._app.metaUI.highlight.Hide();
         if(param1.data != null)
         {
            if(!this._dailyChallengeConfigValidator.ValidateData(param1))
            {
               return;
            }
            _loc2_ = this._dailyChallengeConfigReader.ReadConfig(param1);
            this._dailyChallengeConfigList.add(_loc2_);
            _loc3_ = param1.params.caller;
            if(_loc3_ == "init")
            {
               this._dailyChallengeConfigList.clearExpiredElements();
               if(this._network.parameters[DAILY_CHALLENGED_TODAY_FLASH_VAR] == "true")
               {
                  this._dailyChallengeConfigList.incrementActiveGamesPlayed();
               }
               this.buildDialogView();
            }
            else if(_loc3_ == "refreshClicked")
            {
               this._dailyChallengeConfigList.clearExpiredElements();
               this._userData.StarCats = 0;
               this.buildDialogView();
               this.show();
            }
            else if(_loc3_ == "gameOver")
            {
               this.buildDialogView();
               this.show();
               this.displayStarCatInterstitial();
               if(this._rareGemGeneratedInSession)
               {
                  this._rareGemGeneratedInSession = false;
                  this._app.sessionData.rareGemManager.GetCurrentOffer().Consume();
               }
            }
         }
      }
      
      private function buildDialogView() : void
      {
         var _loc1_:DailyChallengeLogicConfig = this._dailyChallengeConfigList.getActive();
         this._playDailyChallengeButton.SetNumberOfStarCatsWon(this.getNumStarCats());
         this._logic.configDailyChallenge = _loc1_;
         if(this._dialogView == null)
         {
            this._dialogView = new DailyChallengeDialogWrapper(this._app,this._app.sessionData.rareGemManager,new DynamicRareGemLoader(this._app),new DynamicRareGemLoader(this._app));
            this._dialogView.setClickHandler("continueB",this.initiateDailyChallengeGame);
            this._dialogView.setClickHandler("retryBtn",this.initiateDailyChallengeGame);
            this._dialogView.setClickHandler("retryBtn_watchAd",this.initiateDailyChallengeGame,"watchAdRetryPanel");
            this._dialogView.setClickHandler("watchAdBtn",this.onWatchAdClicked,"watchAdRetryPanel");
            this._dialogView.setClickHandler("cancelB",this.onCancelButtonClick);
            this._dialogView.setClickHandler("refreshButton",this.onRefreshButtonClick);
            this._dialogView.setClickHandler("interstitualMC",this.dismissStarCatInterstitial);
         }
         this._dialogView.setTitle(_loc1_.challengeTitle);
         this._dialogView.setDescription(_loc1_.challengeBody);
         this._dialogView.setStarCatGoals(_loc1_.starCatGoals[0],_loc1_.starCatGoals[1],_loc1_.starCatGoals[2]);
         this._dialogView.setRareGem(_loc1_);
         this._dialogView.setStarCatRewards(_loc1_);
         this.validateIfDCIsFree();
      }
      
      public function HandleNetworkSuccess(param1:XML) : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:String = null;
         var _loc2_:DailyChallengeLogicConfig = this._dailyChallengeConfigList.getActive();
         this._dailyChallengeMetricsPayload = null;
         if(!this._logic.IsDailyChallengeGame())
         {
            return;
         }
         var _loc3_:String = param1.attribute("id");
         if(_loc3_ == "report_score")
         {
            _loc4_ = false;
            this._dailyChallengeRGName = "";
            _loc5_ = 0;
            _loc6_ = new Array(0,0,0);
            _loc7_ = new Array(null,null,null);
            if(this._userData.StarCatsThresholdsPayed)
            {
               _loc5_ = this._userData.StarCatsThresholdsPayed.length;
               _loc8_ = 0;
               while(_loc8_ < _loc5_)
               {
                  _loc9_ = this._userData.StarCatsThresholdsPayed[_loc8_];
                  _loc10_ = _loc2_.starCatRewards[_loc9_].GetCoinsEarned();
                  if((_loc11_ = _loc2_.starCatRewards[_loc9_].GetMyRewardName()) != "coins")
                  {
                     this._dailyChallengeRGName = _loc11_;
                  }
                  _loc6_[_loc9_] = _loc10_;
                  _loc7_[_loc9_] = _loc11_;
                  _loc8_++;
               }
            }
            this._dailyChallengeMetricsPayload = new Object();
            this._dailyChallengeMetricsPayload.Score = this._logic.GetScoreKeeper().GetScore();
            this._dailyChallengeMetricsPayload.StarsEarned = _loc5_;
            this._dailyChallengeMetricsPayload.Payouts = _loc6_;
            this._dailyChallengeMetricsPayload.PayoutTypes = _loc7_;
            if(this._dailyChallengeRGName == "")
            {
               this._dailyChallengeMetricsPayload.RareGemUsed = false;
               ServerIO.sendToServer("sendDailyChallengeMetric",this._dailyChallengeMetricsPayload);
               this._dailyChallengeMetricsPayload = null;
            }
            this.getDailyChallengeConfig("gameOver");
         }
      }
      
      public function HandleCartClosed(param1:Boolean) : void
      {
      }
      
      private function setUpState() : void
      {
         this._logic.SetConfig(BlitzLogic.DAILYCHALLENGE_CONFIG);
      }
      
      private function tearDownState() : void
      {
         this._logic.SetConfig(BlitzLogic.DEFAULT_CONFIG);
      }
      
      public function get isWatchAdFreeRetry() : Boolean
      {
         return this._isWatchAdFreeRetry;
      }
      
      public function set isWatchAdFreeRetry(param1:Boolean) : void
      {
         this._isWatchAdFreeRetry = param1;
      }
      
      public function HandleAdsStateChanged(param1:Boolean) : void
      {
      }
      
      public function HandleAdComplete(param1:String) : void
      {
         if(param1 == Blitz3Network.DC_PLACEMENT && this._isWatchAdClicked)
         {
            ServerIO.sendToServer("retryDailyChallengeByAD");
         }
      }
      
      public function HandleAdCapExhausted(param1:String) : void
      {
      }
      
      public function onFreeDCRewarded(param1:Object) : void
      {
         (this._app.ui as MainWidgetGame).networkWait.Hide(this);
         if(param1["success"])
         {
            this._app.adFrequencyManager.decrementRemainingUsesByPlacement(Blitz3Network.DC_PLACEMENT);
            this.isWatchAdFreeRetry = true;
            this.initiateDailyChallengeGame(null);
         }
         else
         {
            this.isWatchAdFreeRetry = false;
         }
      }
      
      public function HandleAdClosed(param1:String) : void
      {
         if(param1 == Blitz3Network.DC_PLACEMENT)
         {
            (this._app.ui as MainWidgetGame).networkWait.Hide(this);
         }
      }
   }
}
