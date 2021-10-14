package com.popcap.flash.bejeweledblitz.game.ui.menu
{
   import com.adobe.utils.StringUtil;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.Version;
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardController;
   import com.popcap.flash.bejeweledblitz.dailyspin2.UI.SpinBoardUIController;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ftue.FTUEManager;
   import com.popcap.flash.bejeweledblitz.game.session.Blitz3Network;
   import com.popcap.flash.bejeweledblitz.game.session.IHandleNetworkAdStateChangeCallback;
   import com.popcap.flash.bejeweledblitz.game.session.ThrottleManager;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.session.feature.FeatureManager;
   import com.popcap.flash.bejeweledblitz.game.session.feature.IFeatureManagerHandler;
   import com.popcap.flash.bejeweledblitz.game.states.MainState;
   import com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity.TournamentRuntimeEntity;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.bejeweledblitz.game.ui.options.OptionMenuWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.tournament.TournamentMainMenu;
   import com.popcap.flash.bejeweledblitz.leaderboard.MainMenuLeaderboardWidget;
   import com.popcap.flash.bejeweledblitz.leaderboard.PlayersData;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.navigation.INavigationBadgeCounter;
   import com.popcap.flash.bejeweledblitz.particles.GlowEmitBottomParticle;
   import com.popcap.flash.bejeweledblitz.particles.GlowEmitTopParticle;
   import com.popcap.flash.bejeweledblitz.party.PartyServerIO;
   import com.popcap.flash.games.blitz3.BejeweledViewMain;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TextEvent;
   import flash.events.TimerEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class MenuWidget extends BejeweledViewMain implements IFeatureManagerHandler, IHandleNetworkAdStateChangeCallback, INavigationBadgeCounter
   {
      
      public static const TIMER_UPDATE_INTERVAL_MILLISECONDS:int = 1000;
      
      public static const MODE_LB:String = "leaderboardMode";
      
      public static const MODE_EVENTS:String = "eventsMode";
      
      public static const MODE_PARTY:String = "partyMode";
      
      public static const MODE_DAILYCHALLENGE:String = "dailyChallengeMode";
      
      public static const MODE_TOURNAMENT:String = "tournamentMode";
      
      private static const _GET_SEASONAL_SALE_CONFIG:String = "getSeasonalSaleConfig";
      
      public static const NUMBER_OF_MODES:int = 4;
       
      
      private var _app:Blitz3Game;
      
      private var _isDailyChallenge:Boolean = false;
      
      private var _isMultiplayer:Boolean = false;
      
      private var _btnStandard:GenericButtonClip;
      
      private var _btnLBMode:GenericButtonClip;
      
      private var _btnParty:GenericButtonClip;
      
      private var _btnDailyChallenge:GenericButtonClip;
      
      private var _btnEvents:GenericButtonClip;
      
      private var _btnTournamnet:GenericButtonClip;
      
      private var _btnFreeCoins:GenericButtonClip;
      
      private var _btnLTO:GenericButtonClip;
      
      private var _qualityModeText:TextField;
      
      private var _optionsButton:GenericButtonClip;
      
      public var options:OptionMenuWidget;
      
      private var _partyEnabled:Boolean = false;
      
      private var _ltoTicker:Number = 0;
      
      private var _ltoTimer:Timer = null;
      
      public var leaderboard:MainMenuLeaderboardWidget;
      
      public var tournamentMenu:TournamentMainMenu;
      
      public var isStoreEnabled:Boolean;
      
      private var _happyHourBanner:HappyHourSale;
      
      private var _happyHourTimer:Timer;
      
      private var _isHappyHour:Boolean;
      
      private var _isSale:Boolean;
      
      private var _saleText:String;
      
      private var _saleImageUrl:String;
      
      private var _happyHourEndTime:uint;
      
      public var leftPanel:LeftMenuPanel;
      
      public var store:GenericButtonClip;
      
      private var _currentMode:String = "";
      
      private var _prevMode:String = "";
      
      private var _imageLoader:Loader;
      
      private var _saleTagBitmapData:BitmapData;
      
      private var _bitmapDataConsumers:Vector.<Bitmap>;
      
      private var _isLoading:Boolean = false;
      
      private var _isLoaded:Boolean = false;
      
      private var _imageRetryLoad:Boolean = true;
      
      private var _imageRedirectLoad:Boolean = true;
      
      private var _saleTagBitmap:Bitmap;
      
      private var _ftueOverride:Boolean = false;
      
      private var _claimChestTag:MovieClip;
      
      private var _isFreeChestAvailable:Boolean = false;
      
      private var _tournamentBgAnimationFinished:Boolean = true;
      
      public function MenuWidget(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         leftpanel.visible = false;
         this._btnFreeCoins = new GenericButtonClip(this._app,this.freeCoinsButton,true);
         this._btnFreeCoins.setPress(this.HandleAdButtonClicked);
         if(this.isLTOAvailable())
         {
            this.initLTO();
         }
         else
         {
            this.LTOButton.visible = false;
         }
         this._claimChestTag = this.ClaimChestTag;
         this._claimChestTag.cacheAsBitmap = true;
         this._claimChestTag.visible = false;
         this._saleTagBitmapData = null;
         this._saleTagBitmap = new Bitmap();
         this._saleTagBitmap.smoothing = true;
         Happyhoursaletag.SaleTag.addChild(this._saleTagBitmap);
         Happyhoursaletag.SaleTag.cacheAsBitmap = true;
         this._bitmapDataConsumers = new Vector.<Bitmap>();
         this._imageLoader = new Loader();
         this._imageLoader.contentLoaderInfo.addEventListener(Event.INIT,this.handleSaleTagImageComplete);
         this._imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.handleSaleTagImageIOError);
         this._imageLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.handleSaleTagImageSecurityError);
         this._btnLBMode = new GenericButtonClip(this._app,this.mcBannerMain,true);
         this._btnLBMode.setRelease(this.leaderboardModePress);
         this._btnLBMode.setRollOut(this.updateModeUIStates);
         this._currentMode = MODE_LB;
         this._btnParty = new GenericButtonClip(this._app,this.mcBannerChallenge,true);
         this._btnParty.setRelease(this.partyPress);
         this._btnParty.setRollOut(this.updateModeUIStates);
         this._app.network.AddAdStateChangHandler(this);
         freeCoinsButton.visible = false;
         this.options = new OptionMenuWidget(param1);
         this.options.Init();
         this._optionsButton = new GenericButtonClip(this._app,this.settings,true);
         this._optionsButton.setRelease(this.showOptions);
         this.leaderboard = new MainMenuLeaderboardWidget(this._app);
         PlayersData.init(this._app,this.leaderboard);
         this.LeaderboardPlaceHolder.addChild(this.leaderboard);
         this.tournamentMenu = new TournamentMainMenu(this._app);
         this.tournamentMenu.init();
         this.tournamentMenu.setVisibility(false);
         this.LeaderboardPlaceHolder.addChild(this.tournamentMenu);
      }
      
      public function ShowParticles() : void
      {
         if(this._app.isLQMode)
         {
            return;
         }
         var _loc1_:GlowEmitTopParticle = new GlowEmitTopParticle();
         this.ParticleMainMenu1.addChild(_loc1_);
         var _loc2_:GlowEmitBottomParticle = new GlowEmitBottomParticle();
         this.ParticleMainMenu2.addChild(_loc2_);
      }
      
      public function HideParticles() : void
      {
         if(this._app.isLQMode)
         {
            return;
         }
         this.ParticleMainMenu1.removeChildren();
         this.ParticleMainMenu2.removeChildren();
      }
      
      public function Init() : void
      {
         this.AddMultiplayer();
         this.AddDailyChallenges();
         this._app.sessionData.featureManager.AddHandler(this);
         this._app.quest.Hide();
         this._btnDailyChallenge = new GenericButtonClip(this._app,this.mcBannerDailyChallenge,true);
         this._btnDailyChallenge.setPressAudio(Blitz3GameSounds.SOUND_DAILY_CHALLENGE_PLAY_BUTTON);
         this._btnDailyChallenge.setPress(this.dailyChallengePress);
         this._btnDailyChallenge.setRollOut(this.updateModeUIStates);
         this._btnEvents = new GenericButtonClip(this._app,this.mcBannerEvents,true);
         this._btnEvents.setRelease(this.eventsPress);
         this._btnEvents.setRollOut(this.updateModeUIStates);
         this._btnEvents.activate();
         this._btnTournamnet = new GenericButtonClip(this._app,this.mcBannerChampions,true);
         this._btnTournamnet.setRelease(this.tournamentPress);
         this._btnTournamnet.setRollOut(this.updateModeUIStates);
         this._btnTournamnet.activate();
         this.setBanners();
      }
      
      public function Update() : void
      {
      }
      
      public function updateBanners() : void
      {
         var _loc1_:String = String(PartyServerIO.getNotificationCount());
         this.updateNotificationText();
         var _loc2_:String = this.getSinglePartyRareGemName();
         if(this._app.party.isDoneWithPartyTutorial() && this._app.sessionData.rareGemManager.isPartyServerForced() && this.isSinglePartyWeight() && _loc2_ != "" && !this._app.logic.rareGemsLogic.isDynamicID(_loc2_))
         {
            this.mcBannerChallenge.rareGemClip.gotoAndStop(_loc2_.toLowerCase());
            this.mcBannerChallenge.rareGemClip.visible = true;
            this.mcBannerChallenge.burstMC.visible = true;
            this.mcBannerChallenge.rareGemNameMC.gotoAndStop(_loc2_.toLowerCase());
         }
         else
         {
            this.mcBannerChallenge.rareGemClip.visible = false;
            this.mcBannerChallenge.burstMC.visible = false;
         }
         this.setBanners();
      }
      
      private function setBanners() : void
      {
         var _loc1_:Boolean = this.isDCFeatureUnlocked();
         var _loc2_:Boolean = this._app.canShowEvents();
         if(_loc2_)
         {
            mcBannerEvents.newEvent.visible = this._app.eventsView.isNotificationAvailable;
            if(this._app.eventsView.eventName)
            {
               mcBannerEvents.eventName.nameText.text = this._app.eventsView.eventName;
            }
            else
            {
               mcBannerEvents.eventName.nameText.text = "";
            }
            if(this._app.eventsView.eventDesc)
            {
               mcBannerEvents.eventDesc.descText.text = this._app.eventsView.eventDesc;
            }
            else
            {
               mcBannerEvents.eventDesc.descText.text = "";
            }
         }
         this.updateTournamentNewTag();
         this.disableEventsButton(!_loc2_);
         this.disableDCButton(!_loc1_);
         this.updateModeUIStates();
      }
      
      public function updateTournamentNewTag() : void
      {
         if(!this._app.sessionData.throttleManager.IsEnabled(ThrottleManager.THROTTLE_ENABLE_TOURNAMENT) || this._app.sessionData.ftueManager.IsFlowCompleted(9) == false)
         {
            this._app.sessionData.tournamentController.DataManager.canShowNewTag = false;
            this._app.sessionData.tournamentController.DataManager.canShowExclamationTag = false;
         }
         mcBannerChampions.newBCEvent.visible = this._app.sessionData.tournamentController.DataManager.canShowNewTag;
         mcBannerChampions.Indicator.visible = this._app.sessionData.tournamentController.DataManager.canShowExclamationTag;
      }
      
      private function isSinglePartyWeight() : Boolean
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc1_:Dictionary = this._app.sessionData.rareGemManager.GetCatalog();
         var _loc2_:Dictionary = this._app.sessionData.configManager.GetDictionary(ConfigManager.DICT_RARE_GEM_WEIGHTS_PARTY);
         var _loc3_:Vector.<String> = new Vector.<String>();
         for(_loc4_ in _loc1_)
         {
            if(_loc4_)
            {
               _loc5_ = 0;
               if(_loc4_ in _loc2_)
               {
                  _loc5_ = _loc2_[_loc4_];
               }
               if(_loc5_ > 0)
               {
                  _loc3_.push(_loc4_);
               }
            }
         }
         return _loc3_.length == 1;
      }
      
      private function getSinglePartyRareGemName() : String
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc1_:Dictionary = this._app.sessionData.rareGemManager.GetCatalog();
         var _loc2_:Dictionary = this._app.sessionData.configManager.GetDictionary(ConfigManager.DICT_RARE_GEM_WEIGHTS_PARTY);
         var _loc3_:Vector.<String> = new Vector.<String>();
         for(_loc4_ in _loc1_)
         {
            if(_loc4_)
            {
               _loc5_ = 0;
               if(_loc4_ in _loc2_)
               {
                  _loc5_ = _loc2_[_loc4_];
               }
               if(_loc5_ > 0)
               {
                  _loc3_.push(_loc4_);
               }
            }
         }
         if(_loc3_.length == 1)
         {
            return _loc3_[0];
         }
         return "";
      }
      
      public function HandleFeatureEnabled(param1:String) : void
      {
         if(param1 == FeatureManager.FEATURE_MULTIPLAYER && this._app.sessionData.featureManager.isFeatureEnabled(FeatureManager.FEATURE_BOOSTS) || param1 == FeatureManager.FEATURE_BOOSTS && this._app.sessionData.featureManager.isFeatureEnabled(FeatureManager.FEATURE_MULTIPLAYER))
         {
            this._partyEnabled = true;
         }
         this.updateBanners();
      }
      
      private function updateNotificationText() : void
      {
         var _loc1_:Boolean = false;
         if(this._partyEnabled)
         {
            this.mcChallengeLock.visible = false;
            this.mcBannerChallenge.visible = true;
            if(PartyServerIO.getNumNotificationCollect() > 0)
            {
               _loc1_ = true;
               this.mcBannerChallenge.partyStatus.gotoAndStop("coins");
            }
            else if(PartyServerIO.getNumNotificationPlay() > 0)
            {
               _loc1_ = true;
               this.mcBannerChallenge.partyStatus.gotoAndStop("friendsWaiting");
            }
            else if(PartyServerIO.freeTokens > 0)
            {
               _loc1_ = true;
               this.mcBannerChallenge.partyStatus.gotoAndStop("freeGame");
            }
         }
         else
         {
            this.mcBannerChallenge.visible = false;
            this.mcChallengeLock.visible = true;
         }
         if(!_loc1_)
         {
            this.mcBannerChallenge.partyStatus.gotoAndStop("blank");
         }
      }
      
      private function AddDailyChallenges() : void
      {
         if(this._isDailyChallenge)
         {
            return;
         }
         this._isDailyChallenge = true;
      }
      
      private function AddMultiplayer() : void
      {
         if(this._isMultiplayer)
         {
            return;
         }
         this._isMultiplayer = true;
         var _loc1_:int = PartyServerIO.getNotificationCount();
         if(this._app.sessionData.featureManager.isFeatureEnabled(FeatureManager.FEATURE_MULTIPLAYER) && this._app.sessionData.featureManager.isFeatureEnabled(FeatureManager.FEATURE_BOOSTS) || _loc1_ > 0 && this._app.questManager.IsFeatureUnlockComplete())
         {
            this.mcChallengeLock.visible = false;
         }
         else
         {
            this.mcChallengeLock.visible = true;
         }
      }
      
      private function optionsOver(param1:MouseEvent) : void
      {
         this.settings.gotoAndPlay("over");
      }
      
      private function optionsOut(param1:MouseEvent) : void
      {
         this.settings.gotoAndStop(0);
      }
      
      private function optionsPress(param1:MouseEvent) : void
      {
         this.showOptions();
      }
      
      private function qualityTextClick(param1:TextEvent) : void
      {
      }
      
      private function showOptions() : void
      {
         this.options.Show();
      }
      
      private function standardPress() : void
      {
         this.leftPanel.showMainButton(true);
         this._app.logic.SetConfig(BlitzLogic.DEFAULT_CONFIG);
         if(this._app.isMultiplayerGame())
         {
            this._app.setMultiplayerGame(false);
            this._app.sessionData.rareGemManager.Init();
         }
         this._app.quest.Show(true);
         this._app.mainState.onLeaveMainMenu();
      }
      
      private function partyPress() : void
      {
         var joined:Boolean = false;
         var joinCost:Number = NaN;
         var retryCost:Number = NaN;
         this._app.logic.SetConfig(BlitzLogic.DEFAULT_CONFIG);
         if(this.mcChallengeLock.visible)
         {
            return;
         }
         this._app.metaUI.highlight.Hide(true);
         this._app.metaUI.tutorial.HideArrow();
         var gameWidget:MainWidgetGame = this._app.ui as MainWidgetGame;
         var curTournament:TournamentRuntimeEntity = this._app.sessionData.tournamentController.getCurrentTournament();
         var isFromTournament:Boolean = curTournament != null;
         if(isFromTournament)
         {
            joined = this._app.sessionData.tournamentController.UserProgressManager && this._app.sessionData.tournamentController.UserProgressManager.hasUserJoinedTournament(curTournament.Id);
            joinCost = curTournament.Data.JoiningCost.mAmount;
            retryCost = curTournament.Data.RetryCost.mAmount;
            if(joined && retryCost > 0)
            {
               isFromTournament = true;
            }
            else if(!joined && joinCost > 0)
            {
               isFromTournament = true;
            }
            else
            {
               isFromTournament = false;
            }
         }
         if(gameWidget.boostDialog.visible && (this._app.sessionData.rareGemManager.GetCurrentOffer().IsHarvested() || isFromTournament))
         {
            gameWidget.boostDialog.ShowAbandonBoostsDialog(function():void
            {
               _app.sessionData.rareGemManager.revertFromInventory();
               _app.sessionData.rareGemManager.SellRareGem();
               setCurrentMode(MODE_PARTY);
               _app.mainState.showParty();
            });
         }
         else
         {
            this.setCurrentMode(MODE_PARTY);
            this._app.mainState.showParty();
         }
         this.leftPanel.ensureStandardBoostManager();
      }
      
      private function dailyChallengePress() : void
      {
         var joined:Boolean = false;
         var joinCost:Number = NaN;
         var retryCost:Number = NaN;
         if(this._currentMode == MODE_DAILYCHALLENGE)
         {
            return;
         }
         var gameWidget:MainWidgetGame = this._app.ui as MainWidgetGame;
         var curTournament:TournamentRuntimeEntity = this._app.sessionData.tournamentController.getCurrentTournament();
         var isFromTournament:Boolean = curTournament != null;
         if(isFromTournament)
         {
            joined = this._app.sessionData.tournamentController.UserProgressManager && this._app.sessionData.tournamentController.UserProgressManager.hasUserJoinedTournament(curTournament.Id);
            joinCost = curTournament.Data.JoiningCost.mAmount;
            retryCost = curTournament.Data.RetryCost.mAmount;
            if(joined && retryCost > 0)
            {
               isFromTournament = true;
            }
            else if(!joined && joinCost > 0)
            {
               isFromTournament = true;
            }
            else
            {
               isFromTournament = false;
            }
         }
         if(gameWidget.boostDialog.visible && (this._app.sessionData.rareGemManager.GetCurrentOffer().IsHarvested() || isFromTournament))
         {
            gameWidget.boostDialog.ShowAbandonBoostsDialog(function():void
            {
               _app.sessionData.rareGemManager.revertFromInventory();
               _app.sessionData.rareGemManager.SellRareGem();
               setCurrentMode(MODE_DAILYCHALLENGE);
               _app.mainState.gotoDailyChallenges();
            });
         }
         else
         {
            this.setCurrentMode(MODE_DAILYCHALLENGE);
            this._app.mainState.gotoDailyChallenges();
         }
      }
      
      private function eventsPress() : void
      {
         if(this._currentMode == MODE_EVENTS || this._app.eventsView == null)
         {
            return;
         }
         this.setCurrentMode(MODE_EVENTS);
         this._app.eventsNextLaunchUrl = "";
         this._app.eventsView.LaunchEventsView(true);
      }
      
      public function tournamentPress() : void
      {
         var joined:Boolean = false;
         var joinCost:Number = NaN;
         var retryCost:Number = NaN;
         if(this._btnTournamnet.IsDisabled())
         {
            return;
         }
         var gameWidget:MainWidgetGame = this._app.ui as MainWidgetGame;
         var curTournament:TournamentRuntimeEntity = this._app.sessionData.tournamentController.getCurrentTournament();
         var isFromTournament:Boolean = curTournament != null;
         if(isFromTournament)
         {
            joined = this._app.sessionData.tournamentController.UserProgressManager && this._app.sessionData.tournamentController.UserProgressManager.hasUserJoinedTournament(curTournament.Id);
            joinCost = curTournament.Data.JoiningCost.mAmount;
            retryCost = curTournament.Data.RetryCost.mAmount;
            if(joined && retryCost > 0)
            {
               isFromTournament = true;
            }
            else if(!joined && joinCost > 0)
            {
               isFromTournament = true;
            }
            else
            {
               isFromTournament = false;
            }
         }
         if(gameWidget.boostDialog.visible && (this._app.sessionData.rareGemManager.GetCurrentOffer().IsHarvested() || isFromTournament))
         {
            gameWidget.boostDialog.ShowAbandonBoostsDialog(function():void
            {
               _app.sessionData.rareGemManager.revertFromInventory();
               _app.sessionData.rareGemManager.SellRareGem();
               setCurrentMode(MODE_TOURNAMENT);
               _app.sessionData.tournamentController.onTournamentClicked();
               updateTournamentNewTag();
               _app.mainState.gotoTournamentScreen();
               leftPanel.showKeyStoneButton(true,false,true);
               _btnTournamnet.clipListener.gotoAndStop("active");
               (_app as Blitz3App).network.SendUIMetrics("Tournaments","MainMenu","");
               _tournamentBgAnimationFinished = false;
            });
         }
         else
         {
            this.setCurrentMode(MODE_TOURNAMENT);
            this._app.sessionData.tournamentController.onTournamentClicked();
            this.updateTournamentNewTag();
            this._app.mainState.gotoTournamentScreen();
            this.leftPanel.showKeyStoneButton(true,false,true);
            this._btnTournamnet.clipListener.gotoAndStop("active");
            (this._app as Blitz3App).network.SendUIMetrics("Tournaments","MainMenu","");
            this._tournamentBgAnimationFinished = false;
         }
      }
      
      public function HandleAdsStateChanged(param1:Boolean) : void
      {
         this.ValidateFreeCoins(param1);
      }
      
      public function HandleAdComplete(param1:String) : void
      {
         if(param1 == Blitz3Network.MAINMENU_PLACEMENT)
         {
            this._app.adFrequencyManager.decrementRemainingUsesByPlacement(param1);
         }
      }
      
      public function HandleAdCapExhausted(param1:String) : void
      {
         this.ValidateFreeCoins(false);
      }
      
      private function HandleAdButtonClicked() : void
      {
         this._app.network.showAd(Blitz3Network.MAINMENU_PLACEMENT,2000);
      }
      
      private function ValidateFreeCoins(param1:Boolean) : void
      {
         if(param1 && this._app.adFrequencyManager.canShowRetry(Blitz3Network.MAINMENU_PLACEMENT))
         {
            freeCoinsButton.visible = true;
         }
         else
         {
            freeCoinsButton.visible = false;
         }
      }
      
      private function initLTO() : void
      {
         this._btnLTO = new GenericButtonClip(this._app,this.LTOButton,true);
         this._btnLTO.setPress(this.HandleLTOButtonClicked);
         this._ltoTicker = Number(this._app.network.parameters.timeLeftLTO);
         this.LTOButton.TimerTxt.text = Utils.getHourStringFromSeconds(this._ltoTicker);
         this.runLTOTimer();
         this._app.bjbEventDispatcher.addEventListener("SHOW_LTO",this.HandleLTOButtonClicked);
      }
      
      private function HandleLTOButtonClicked(param1:Event = null) : void
      {
         var _loc2_:Object = null;
         if(this.isLTOAvailable())
         {
            _loc2_ = new Object();
            _loc2_.timer = this._ltoTicker;
            _loc2_.version = Version.version;
            this._app.network.SensitiveExternalCall("showLTO",_loc2_);
         }
      }
      
      private function isLTOAvailable() : Boolean
      {
         if(this._ltoTimer == null)
         {
            return this._app.sessionData.throttleManager.IsEnabled(ThrottleManager.THROTTLE_ENABLE_LTO) && this._app.network.parameters.timeLeftLTO != null && Number(this._app.network.parameters.timeLeftLTO) > 0;
         }
         return this._ltoTicker > 0;
      }
      
      private function runLTOTimer() : void
      {
         this._ltoTimer = new Timer(1000,this._ltoTicker);
         this._ltoTimer.addEventListener(TimerEvent.TIMER,this.onLTOTimerUpdate);
         this._ltoTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onLTOTimerUpdateComplete);
         this._ltoTimer.start();
      }
      
      private function onLTOTimerUpdate(param1:TimerEvent) : void
      {
         if(this._ltoTicker > 0)
         {
            --this._ltoTicker;
            this.LTOButton.TimerTxt.text = Utils.getHourStringFromSeconds(this._ltoTicker);
         }
      }
      
      private function onLTOTimerUpdateComplete(param1:TimerEvent) : void
      {
         this._ltoTimer.stop();
         this._ltoTicker = 0;
         this._btnLTO.destroy();
         this.LTOButton.visible = false;
      }
      
      public function setupHUD() : void
      {
         this.FetchSaleConfig();
         this.leftPanel = new LeftMenuPanel(this._app);
         this.leftPanel.Init();
         addChild(this.leftPanel);
         this.leftPanel.x = -38.95;
         this.leftPanel.y = 186.95;
         this._app.network.AddNavigationBagdeCounterHandler(this);
         this.setStoreEnabled(true);
         this._happyHourBanner = Happyhoursaletag;
         this._happyHourEndTime = 0;
         this._happyHourBanner.gotoAndStop(0);
         this._happyHourTimer = new Timer(TIMER_UPDATE_INTERVAL_MILLISECONDS,0);
         this._happyHourTimer.addEventListener(TimerEvent.TIMER,this.OnTimerTick);
         this._happyHourTimer.start();
         this._isHappyHour = this._app.network.IsHappyHour();
         this._happyHourEndTime = this._app.network.GetHappyHourEndTime();
         this._isFreeChestAvailable = false;
         this.updateSaleTag();
         this.tournamentMenu.setupInfoView();
      }
      
      public function handleStoreOpen() : void
      {
         if(!this.isStoreEnabled)
         {
            return;
         }
         this._app.party.stopStatusCountdown();
         if(this._isFreeChestAvailable)
         {
            this._app.network.ShowCart("claimFreeChest",CurrencyManager.TYPE_SHARDS);
         }
         else
         {
            this._app.network.ShowCart("navBuyCoins");
         }
      }
      
      public function setStoreEnabled(param1:Boolean) : void
      {
         if(this.store == null)
         {
            this.store = new GenericButtonClip(this._app,Store);
            this.store.setRelease(this.handleStoreOpen);
            this.store.activate();
         }
         this.isStoreEnabled = param1;
         this.store.SetDisabled(!this.isStoreEnabled);
      }
      
      private function OnTimerTick(param1:TimerEvent) : void
      {
         this.ValidateHappyHourBanner();
      }
      
      private function ValidateHappyHourBanner() : void
      {
         var _loc1_:Date = null;
         var _loc2_:Number = NaN;
         var _loc3_:uint = 0;
         if(this._isHappyHour)
         {
            if(!this._happyHourBanner.visible)
            {
               this._happyHourBanner.visible = true;
            }
            if(this._happyHourEndTime == 0)
            {
               this._happyHourBanner.mHappyHourTimerText.visible = false;
               return;
            }
            _loc1_ = new Date();
            _loc2_ = _loc1_.getTime().valueOf() / 1000;
            if(_loc2_ >= this._happyHourEndTime)
            {
               this._isHappyHour = false;
               this._happyHourEndTime = 0;
               this.updateSaleTag();
               return;
            }
            _loc3_ = this._happyHourEndTime - _loc2_;
            this._happyHourBanner.mHappyHourTimerText.text = Utils.getHourStringFromSeconds(_loc3_);
         }
         else
         {
            this._isHappyHour = this._app.network.IsHappyHour();
            if(this._isHappyHour)
            {
               this._happyHourEndTime = this._app.network.GetHappyHourEndTime();
            }
            this.updateSaleTag();
         }
      }
      
      private function updateSaleTag() : void
      {
         this._happyHourBanner.mHappyHourText.visible = this._isHappyHour;
         this._happyHourBanner.mHappyHourTimerText.visible = this._isHappyHour;
         this._happyHourBanner.mSaleText.visible = this._isSale;
         this._happyHourBanner.visible = this._isHappyHour || this._isSale;
         this._isFreeChestAvailable = !(this._isHappyHour || this._isSale) && this.canClaimFreeChest();
         this._happyHourBanner.mSaleText.text = this._saleText;
         if(this._isHappyHour)
         {
            this._happyHourBanner.mHappyHourTimerText.text = "";
            this._happyHourBanner.mSaleText.visible = true;
         }
         if(this._isSale)
         {
            this._happyHourBanner.mSaleText.visible = true;
         }
         this._claimChestTag.visible = this._isFreeChestAvailable;
      }
      
      public function canClaimFreeChest() : Boolean
      {
         var _loc2_:Date = null;
         var _loc3_:Number = NaN;
         var _loc4_:uint = 0;
         var _loc1_:Boolean = false;
         if(this._app.sessionData.throttleManager.IsEnabled(ThrottleManager.THROTTLE_ENABLE_CLAIM_FREE_CHEST))
         {
            _loc2_ = new Date();
            _loc3_ = _loc2_.getTime().valueOf() / 1000;
            _loc4_ = this._app.network.GetFreeChestEndTime();
            if(_loc3_ >= _loc4_)
            {
               _loc1_ = true;
            }
         }
         return _loc1_;
      }
      
      public function enablePurchaseButtons(param1:Boolean) : void
      {
         this.setStoreEnabled(param1);
         if(this._app.topHUD)
         {
            this._app.topHUD.enableCurrencyPurchaseButtons(param1);
         }
      }
      
      public function leaderboardModePress() : void
      {
         var joined:Boolean = false;
         var joinCost:Number = NaN;
         var retryCost:Number = NaN;
         if(!this._btnLBMode || !this._btnLBMode.isActive())
         {
            return;
         }
         this._app.metaUI.highlight.Hide(true);
         this._app.metaUI.tutorial.HideArrow();
         SpinBoardUIController.GetInstance().CloseSpinBoard();
         this._app.ui.ClearMessages();
         var gameWidget:MainWidgetGame = this._app.ui as MainWidgetGame;
         var curTournament:TournamentRuntimeEntity = this._app.sessionData.tournamentController.getCurrentTournament();
         var isFromTournament:Boolean = curTournament != null;
         if(isFromTournament)
         {
            joined = this._app.sessionData.tournamentController.UserProgressManager && this._app.sessionData.tournamentController.UserProgressManager.hasUserJoinedTournament(curTournament.Id);
            joinCost = curTournament.Data.JoiningCost.mAmount;
            retryCost = curTournament.Data.RetryCost.mAmount;
            if(joined && retryCost > 0)
            {
               isFromTournament = true;
            }
            else if(!joined && joinCost > 0)
            {
               isFromTournament = true;
            }
            else
            {
               isFromTournament = false;
            }
         }
         if(gameWidget.boostDialog.visible && (this._app.sessionData.rareGemManager.GetCurrentOffer().IsHarvested() || isFromTournament))
         {
            gameWidget.boostDialog.ShowAbandonBoostsDialog(function():void
            {
               _app.sessionData.rareGemManager.revertFromInventory();
               _app.sessionData.rareGemManager.SellRareGem();
               setCurrentMode(MODE_LB);
               _app.mainState.GotoMainMenu();
            });
         }
         else
         {
            this.setCurrentMode(MODE_LB);
            if(!this._app.mainState.isMenuState())
            {
               this._app.mainState.GotoMainMenu();
            }
            this._app.quest.Hide();
         }
         SpinBoardController.GetInstance().CloseSpinBoard();
         (this._app as Blitz3App).network.SendUIMetrics("WeeklyLeaderboard","MainMenu","");
      }
      
      public function harvestGemFromEvents(param1:String, param2:int, param3:int, param4:Boolean) : void
      {
         var joined:Boolean = false;
         var joinCost:Number = NaN;
         var retryCost:Number = NaN;
         var gemId:String = param1;
         var delay:int = param2;
         var streakNum:int = param3;
         var isDiscount:Boolean = param4;
         if(!this._btnLBMode || !this._btnLBMode.isActive())
         {
            return;
         }
         this._app.metaUI.highlight.Hide(true);
         this._app.metaUI.tutorial.HideArrow();
         SpinBoardUIController.GetInstance().CloseSpinBoard();
         this._app.ui.ClearMessages();
         var gameWidget:MainWidgetGame = this._app.ui as MainWidgetGame;
         var curTournament:TournamentRuntimeEntity = this._app.sessionData.tournamentController.getCurrentTournament();
         var isFromTournament:Boolean = curTournament != null;
         if(isFromTournament)
         {
            joined = this._app.sessionData.tournamentController.UserProgressManager && this._app.sessionData.tournamentController.UserProgressManager.hasUserJoinedTournament(curTournament.Id);
            joinCost = curTournament.Data.JoiningCost.mAmount;
            retryCost = curTournament.Data.RetryCost.mAmount;
            if(joined && retryCost > 0)
            {
               isFromTournament = true;
            }
            else if(!joined && joinCost > 0)
            {
               isFromTournament = true;
            }
            else
            {
               isFromTournament = false;
            }
         }
         if(gameWidget.boostDialog.visible && (this._app.sessionData.rareGemManager.GetCurrentOffer().IsHarvested() || isFromTournament))
         {
            this.setCurrentMode(MODE_LB);
            gameWidget.boostDialog.ShowAbandonBoostsDialog(function():void
            {
               _app.sessionData.rareGemManager.revertFromInventory();
               _app.sessionData.rareGemManager.SellRareGem();
               transitiontoHarvest(gemId,delay,streakNum,isDiscount);
            });
         }
         else
         {
            this.setCurrentMode(MODE_LB);
            this.transitiontoHarvest(gemId,delay,streakNum,isDiscount);
            this._app.quest.Hide();
         }
      }
      
      public function transitiontoHarvest(param1:String, param2:int, param3:int, param4:Boolean) : void
      {
         this._app.mainState.GotoMainMenu();
         this._app.mainmenuLeaderboard.Hide();
         this._app.eventsView.eventlaunchURL = this._app.eventsView.launchURL;
         this._app.sessionData.rareGemManager.ForceOffer(param1,param2,param3,param4);
         if(this._app.logic.isActive && !this._app.logic.IsGameOver())
         {
            this._app.sessionData.AbortGame();
            this._app.network.AbortGame();
         }
         var _loc5_:Blitz3Game;
         if((_loc5_ = this._app as Blitz3Game) != null)
         {
            _loc5_.mainState.game.dispatchEvent(new Event(MainState.SIGNAL_QUIT));
         }
      }
      
      private function exitPrevState() : void
      {
         if(this._prevMode == "")
         {
            return;
         }
         switch(this._prevMode)
         {
            case MODE_LB:
               this._app.mainmenuLeaderboard.Hide();
               break;
            case MODE_EVENTS:
               break;
            case MODE_PARTY:
               this._app.party.hideMe();
               break;
            case MODE_DAILYCHALLENGE:
               break;
            case MODE_TOURNAMENT:
               if(this.Bgmode.tournamentBG != null)
               {
                  this.Bgmode.tournamentBG.gotoAndPlay("outro");
                  this.Bgmode.tournamentBG.addFrameScript(this.Bgmode.tournamentBG.totalFrames - 1,function():void
                  {
                     _tournamentBgAnimationFinished = true;
                     updateModeUIStates();
                  });
                  this.disableTournamentButton(false);
               }
               this._app.sessionData.tournamentController.RevertJoinRetryCost();
               this.tournamentMenu.forceCloseHistory();
               this.leftPanel.showKeyStoneButton(true,false,false);
         }
         this.updateModeUIStates();
      }
      
      private function updateModeUIStates() : void
      {
         if(this._prevMode == MODE_TOURNAMENT && !this._tournamentBgAnimationFinished)
         {
            return;
         }
         var _loc1_:Boolean = this.isDCFeatureUnlocked();
         this.disableDCButton(!_loc1_);
         this._btnLBMode.clipListener.gotoAndStop("up");
         this.disableEventsButton(!this._app.canShowEvents());
         this.disablePartyButton(!this._partyEnabled);
         this.disableTournamentButton(false);
         switch(this._currentMode)
         {
            case MODE_LB:
               this.Bgmode.gotoAndStop(1);
               this._btnLBMode.clipListener.gotoAndPlay("active");
               break;
            case MODE_EVENTS:
               if(this._btnEvents.isActive())
               {
                  this._btnEvents.clipListener.gotoAndPlay("active");
               }
               break;
            case MODE_PARTY:
               if(this._partyEnabled)
               {
                  this.Bgmode.gotoAndStop(2);
                  this._btnParty.clipListener.gotoAndPlay("active");
               }
               break;
            case MODE_DAILYCHALLENGE:
               this.Bgmode.gotoAndStop(1);
               this._btnDailyChallenge.clipListener.gotoAndPlay("active");
               break;
            case MODE_TOURNAMENT:
               this.Bgmode.gotoAndStop(4);
               this._btnTournamnet.clipListener.gotoAndPlay("active");
               break;
            default:
               this.Bgmode.gotoAndStop(1);
               this._btnLBMode.clipListener.gotoAndPlay("active");
         }
      }
      
      public function disableBottomNavigationPanel() : void
      {
         this.disableDCButton(true);
         this._btnLBMode.SetDisabled(true);
         this.disableEventsButton(true);
         this.disablePartyButton(true);
         this.disableTournamentButton(true);
      }
      
      public function setCurrentMode(param1:String) : void
      {
         if(param1 == this._currentMode)
         {
            return;
         }
         this._prevMode = this._currentMode;
         this._currentMode = param1;
         this.exitPrevState();
      }
      
      public function onEventsClosed() : void
      {
         var _loc1_:MainWidgetGame = this._app.ui as MainWidgetGame;
         if(this._prevMode == MODE_LB)
         {
            this.setCurrentMode(this._prevMode);
            if(!_loc1_.boostDialog.visible)
            {
               this._app.mainState.GotoMainMenu();
            }
         }
         else if(this._prevMode == MODE_PARTY)
         {
            this.setCurrentMode(this._prevMode);
            if(!_loc1_.boostDialog.visible)
            {
               this._app.mainState.showParty();
            }
         }
         else if(this._prevMode == MODE_TOURNAMENT)
         {
            this.setCurrentMode(MODE_TOURNAMENT);
            if(!_loc1_.boostDialog.visible)
            {
               this._app.sessionData.tournamentController.onTournamentClicked();
               this.updateTournamentNewTag();
               this._app.mainState.gotoTournamentScreen();
               this.leftPanel.showKeyStoneButton(true,false,true);
               this._btnTournamnet.clipListener.gotoAndStop("active");
               (this._app as Blitz3App).network.SendUIMetrics("Tournaments","MainMenu","");
               this._tournamentBgAnimationFinished = false;
            }
         }
      }
      
      public function updateLeaderboardTimerText(param1:String) : void
      {
         param1 = "Resets in " + param1;
         this.mcBannerMain.txtEnds.text = param1;
      }
      
      public function enableBottomNavigationPanel() : void
      {
         this.disableDCButton(false);
         this._btnLBMode.SetDisabled(false);
         this.disableEventsButton(false);
         this.disablePartyButton(false);
         this.disableTournamentButton(false);
         this.updateModeUIStates();
      }
      
      public function FetchSaleConfig() : void
      {
         var _loc1_:Object = this._app.network.ExternalCall(_GET_SEASONAL_SALE_CONFIG);
         if(_loc1_ != null)
         {
            this._isSale = _loc1_.saleEnabled;
            this._saleText = "SALE";
            this._saleImageUrl = "";
            if(this._isSale)
            {
               this._saleText = _loc1_.saleText != "" ? _loc1_.saleText : "SALE";
               this._saleImageUrl = _loc1_.saleImageUrl;
            }
            if(this._saleImageUrl != "")
            {
               this.LoadSaleTagImage();
            }
         }
      }
      
      public function LoadSaleTagImage() : void
      {
         this.copyBitmapDataTo(this._saleTagBitmap);
         this._saleTagBitmap.smoothing = true;
      }
      
      public function copyBitmapDataTo(param1:Bitmap) : void
      {
         if(this._isLoaded && this._saleTagBitmapData != null)
         {
            param1.bitmapData = this._saleTagBitmapData.clone();
         }
         else
         {
            this._bitmapDataConsumers.push(param1);
            if(!this._isLoading)
            {
               this.loadImage();
            }
         }
      }
      
      private function loadImage() : void
      {
         if(this._saleImageUrl != "")
         {
            this.doLoad();
         }
      }
      
      private function doLoad() : void
      {
         if(!this._isLoaded && !this._isLoading && this._saleImageUrl != "")
         {
            this._isLoading = true;
            this._imageRetryLoad = true;
            this._imageLoader.load(new URLRequest(this._saleImageUrl),new LoaderContext(true));
         }
      }
      
      private function makeImageConsumerCallbacks() : void
      {
         var _loc1_:Bitmap = null;
         for each(_loc1_ in this._bitmapDataConsumers)
         {
            _loc1_.bitmapData = this._saleTagBitmapData.clone();
         }
      }
      
      private function handleSaleTagImageComplete(param1:Event) : void
      {
         var event:Event = param1;
         this._isLoading = false;
         this._isLoaded = true;
         var info:LoaderInfo = event.target as LoaderInfo;
         if(info == null)
         {
            return;
         }
         try
         {
            this._saleTagBitmapData = (this._imageLoader.content as Bitmap).bitmapData.clone();
         }
         catch(e:Error)
         {
            _isLoaded = false;
            if(_imageRedirectLoad)
            {
               _imageRedirectLoad = false;
               if(_imageLoader.contentLoaderInfo.isURLInaccessible)
               {
                  Security.allowDomain(_imageLoader.contentLoaderInfo.url);
                  Security.allowInsecureDomain(_imageLoader.contentLoaderInfo.url);
                  Security.loadPolicyFile(_imageLoader.contentLoaderInfo.url + "crossdomain.xml");
               }
               else
               {
                  _saleImageUrl = _imageLoader.contentLoaderInfo.url;
               }
               _saleImageUrl = StringUtil.trim(_saleImageUrl);
               _isLoading = true;
               _imageLoader.load(new URLRequest(_saleImageUrl),new LoaderContext(true));
            }
            return;
         }
         if(this._saleTagBitmapData != null)
         {
            this._imageLoader.contentLoaderInfo.removeEventListener(Event.INIT,this.handleSaleTagImageComplete);
            this._imageLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.handleSaleTagImageIOError);
            this._imageLoader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.handleSaleTagImageSecurityError);
            this.makeImageConsumerCallbacks();
         }
      }
      
      private function handleSaleTagImageIOError(param1:IOErrorEvent) : void
      {
         if(this._imageRetryLoad)
         {
            this._imageRetryLoad = false;
            this._imageLoader.load(new URLRequest(this._saleImageUrl),new LoaderContext(true));
         }
         else
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"Error loading Sale Tag image: " + this._saleImageUrl + " " + param1.toString());
            this._isLoading = false;
         }
      }
      
      private function handleSaleTagImageSecurityError(param1:SecurityErrorEvent) : void
      {
         if(this._imageRetryLoad)
         {
            this._imageRetryLoad = false;
            this._imageLoader.load(new URLRequest(this._saleImageUrl),new LoaderContext(true));
         }
         else
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_SECURITY,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"Security error loading Sale Tag image: " + this._saleImageUrl + " " + param1.toString());
            this._isLoading = false;
         }
      }
      
      public function ForceDisableBottomPanelButtons(param1:Boolean) : void
      {
         if(param1)
         {
            this.disableEventsButton(true);
            this.disableDCButton(true);
            this.disablePartyButton(true);
            this.disableTournamentButton(true);
            this._ftueOverride = true;
         }
         else
         {
            this._ftueOverride = false;
            this.disableEventsButton(!this._app.canShowEvents());
            this.disableDCButton(!this.isDCFeatureUnlocked());
            this.disablePartyButton(!this._partyEnabled);
            this.disableTournamentButton(false);
         }
      }
      
      private function disableEventsButton(param1:Boolean) : void
      {
         if(this._ftueOverride)
         {
            return;
         }
         if(param1)
         {
            this._btnEvents.SetDisabled(param1);
         }
         else
         {
            this._btnEvents.SetDisabled(false);
            this._btnEvents.clipListener.gotoAndStop("up");
         }
      }
      
      private function disableDCButton(param1:Boolean) : void
      {
         if(this._ftueOverride)
         {
            return;
         }
         if(param1)
         {
            this._btnDailyChallenge.SetDisabled(param1);
         }
         else
         {
            this._btnDailyChallenge.SetDisabled(false);
            this._btnDailyChallenge.clipListener.gotoAndStop("up");
         }
      }
      
      private function isDCFeatureUnlocked() : Boolean
      {
         return this._app.questManager.IsFeatureUnlockComplete() && this._app.sessionData.throttleManager.IsEnabled(ThrottleManager.THROTTLE_DAILY_CHALLENGES);
      }
      
      private function disablePartyButton(param1:Boolean) : void
      {
         if(this._ftueOverride)
         {
            return;
         }
         if(param1)
         {
            this._btnParty.SetDisabled(param1);
         }
         else
         {
            this._btnParty.SetDisabled(false);
            this._btnParty.clipListener.gotoAndStop("up");
         }
      }
      
      public function HandleAdClosed(param1:String) : void
      {
      }
      
      private function disableTournamentButton(param1:Boolean) : void
      {
         if(this._ftueOverride)
         {
            return;
         }
         var _loc2_:FTUEManager = this._app.sessionData.ftueManager;
         if(_loc2_.IsFlowCompleted(9) == false)
         {
            this.setTournamentButtonStatusForFTUE();
            return;
         }
         if(param1)
         {
            this._btnTournamnet.SetDisabled(param1);
         }
         else
         {
            this._btnTournamnet.SetDisabled(false);
            this._btnTournamnet.clipListener.gotoAndStop("up");
         }
      }
      
      public function setTournamentButtonStatusForFTUE(param1:Boolean = false) : void
      {
         var _loc2_:FTUEManager = this._app.sessionData.ftueManager;
         var _loc3_:ThrottleManager = this._app.sessionData.throttleManager;
         if(_loc3_.IsEnabled(ThrottleManager.THROTTLE_ENABLE_TOURNAMENT))
         {
            if(param1 || _loc2_.getCurrentFlow() != null && _loc2_.getCurrentFlow().GetFlowId() == 9)
            {
               this._btnTournamnet.SetDisabled(false);
            }
            else
            {
               this._btnTournamnet.SetDisabled(true);
               this.mcBannerChampions.gotoAndPlay("locked");
               this.mcBannerChampions.unlockText.text = "Play more to unlock";
            }
         }
         else
         {
            this._btnTournamnet.SetDisabled(true);
            this.mcBannerChampions.gotoAndPlay("locked");
            this.mcBannerChampions.unlockText.text = "Coming soon";
         }
      }
      
      public function getCurrentMenuMode() : String
      {
         return this._currentMode;
      }
      
      public function updateBadgeCounter(param1:Object) : void
      {
         if(this.leftPanel != null)
         {
            this.leftPanel.handleSetCounter(param1);
         }
      }
      
      public function SendAdAvailableReport() : void
      {
         if(!freeCoinsButton.visible)
         {
            (this._app as Blitz3App).network.SendAdAvailabilityMetrics(Blitz3Network.MAINMENU_PLACEMENT);
         }
      }
   }
}
