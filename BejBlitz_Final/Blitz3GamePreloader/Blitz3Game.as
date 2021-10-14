package
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.dailychallenge.DailyChallengeManager;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.events.EventWebView;
   import com.popcap.flash.bejeweledblitz.game.ftue.impl.FTUEWidget;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestManager;
   import com.popcap.flash.bejeweledblitz.game.session.FriendPopupServerIO;
   import com.popcap.flash.bejeweledblitz.game.session.IBlitz3NetworkHandler;
   import com.popcap.flash.bejeweledblitz.game.session.ThrottleManager;
   import com.popcap.flash.bejeweledblitz.game.session.config.LiveCheatsForPopCapFBIDs;
   import com.popcap.flash.bejeweledblitz.game.session.feature.FeatureManager;
   import com.popcap.flash.bejeweledblitz.game.states.MainState;
   import com.popcap.flash.bejeweledblitz.game.tutorial.TutorialWatcher;
   import com.popcap.flash.bejeweledblitz.game.ui.ChestRewardsWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.ToastWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButton;
   import com.popcap.flash.bejeweledblitz.game.ui.factories.StarMedalFactory;
   import com.popcap.flash.bejeweledblitz.game.ui.factories.UIFactory;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.GameOverV2Widget;
   import com.popcap.flash.bejeweledblitz.game.ui.menu.MenuWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.meta.MetaUI;
   import com.popcap.flash.bejeweledblitz.game.ui.tournament.InGameTournamentLeaderboardWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.tournament.TournamentInfoWidget;
   import com.popcap.flash.bejeweledblitz.leaderboard.ILeaderboardUpdateEvents;
   import com.popcap.flash.bejeweledblitz.leaderboard.InGameLeaderboardWidget;
   import com.popcap.flash.bejeweledblitz.leaderboard.MainMenuLeaderboardWidget;
   import com.popcap.flash.bejeweledblitz.leaderboard.PlayerData;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import com.popcap.flash.bejeweledblitz.party.PartyServerIO;
   import com.popcap.flash.bejeweledblitz.party.PartyWidget;
   import com.popcap.flash.bejeweledblitz.quest.QuestWidget;
   import com.popcap.flash.bejeweledblitz.topHUD.HUDWidget;
   import com.popcap.flash.framework.keyboard.KeyboardCheck;
   import com.popcap.flash.framework.utils.FPSMonitor;
   import com.popcap.flash.framework.utils.FlashPlayerCapabilities;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.system.Security;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.utils.getTimer;
   
   public class Blitz3Game extends Blitz3App implements IBlitz3NetworkHandler, IBlitzLogicHandler
   {
      
      private static const _VERSION_NAME:String = "Bejeweled Blitz";
      
      private static const _INACTIVITY_TIME:Number = 3 * 60 * 1000;
      
      public static const TICK_MULTIPLIER:int = 100;
       
      
      private var mMark:KeyboardCheck;
      
      private var _isStartCalled:Boolean = false;
      
      private var _isPartyEnabled:Boolean = false;
      
      private var _isPartyLoaded:Boolean = false;
      
      private var _isLoaded:Boolean = false;
      
      private var _usedRetry:Boolean = false;
      
      private var _errorScreen:Sprite;
      
      private var _lastActivity:Number = 0;
      
      private var _lbDataHandlers:Vector.<ILeaderboardUpdateEvents>;
      
      public var mainmenuLeaderboard:MainMenuLeaderboardWidget;
      
      public var ingameLeaderboard:InGameLeaderboardWidget;
      
      public var ingameTournamentLeaderboard:InGameTournamentLeaderboardWidget;
      
      public var tournamentInfoView:TournamentInfoWidget;
      
      public var quest:QuestWidget;
      
      public var topHUD:HUDWidget;
      
      public var metaUI:MetaUI;
      
      public var tutorial:TutorialWatcher;
      
      public var party:PartyWidget;
      
      public var questManager:QuestManager;
      
      public var gameOver:GameOverV2Widget;
      
      public var dailySpinContainer:MovieClip;
      
      public var toastWidget:ToastWidget;
      
      public var networkPopupContainer:MovieClip;
      
      public var mainState:MainState;
      
      public var fpsMonitor:FPSMonitor;
      
      public var ftueWidget:FTUEWidget;
      
      public var mDSPlaceholder:DailySpinPlaceholder;
      
      public var dailyChallengeManager:DailyChallengeManager;
      
      public var eventsView:EventWebView;
      
      public var loadTime:int = 0;
      
      public var mLastEquippedBoostIds:Array;
      
      public function Blitz3Game()
      {
         var _loc2_:String = null;
         this.mLastEquippedBoostIds = [];
         super(_VERSION_NAME);
         var _loc1_:FlashPlayerCapabilities = new FlashPlayerCapabilities();
         if(!_loc1_.isRunningInAdobeAir())
         {
            for each(_loc2_ in ALLOW_DOMAINS)
            {
               Security.allowDomain(_loc2_);
               Security.allowInsecureDomain(_loc2_);
            }
         }
         addEventListener(Event.ADDED_TO_STAGE,this.HandleAdded,false,0,true);
         y = 0;
         x = 0;
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.onGenericClick);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onGenericClick);
      }
      
      public function isLoaded() : Boolean
      {
         return this._isLoaded;
      }
      
      override protected function doVariableUpdate(param1:int) : void
      {
         this.fpsMonitor.HandleUpdate(null);
         super.doVariableUpdate(param1);
         sessionData.tournamentController.update(param1);
      }
      
      override protected function doFixedUpdate() : void
      {
         super.doFixedUpdate();
         if(this._isLoaded && !this.mainState.isCurrentStateGame() && getTimer() - this._lastActivity > _INACTIVITY_TIME)
         {
            this._lastActivity = getTimer();
            FriendPopupServerIO.showPopup(this,FriendPopupServerIO.INDEX_ON_INACTIVE);
         }
      }
      
      override public function Init() : void
      {
         super.Init();
         frameRateInit = 30;
         frameRateMax = 30;
         frameRateMin = 20;
         this._lbDataHandlers = new Vector.<ILeaderboardUpdateEvents>();
         starMedalFactory = new StarMedalFactory(this);
         uiFactory = new UIFactory(this);
         this.metaUI = new MetaUI(this);
         this.party = new PartyWidget(this);
         this.quest = new QuestWidget(this);
         this.tutorial = new TutorialWatcher(this);
         this.questManager = new QuestManager(this);
         this.gameOver = new GameOverV2Widget(this);
         ui = uiFactory.GetMainWidget();
         this.tournamentInfoView = new TournamentInfoWidget(this);
         this.mainmenuLeaderboard = (ui as MainWidgetGame).menu.leaderboard;
         this.ingameLeaderboard = (ui as MainWidgetGame).game.ingameLeaderboard;
         this.ingameTournamentLeaderboard = (ui as MainWidgetGame).game.ingameTournamentLeaderboard;
         this.dailySpinContainer = new MovieClip();
         this.networkPopupContainer = new MovieClip();
         this.toastWidget = new ToastWidget(this);
         ui.Init();
         this.mainmenuLeaderboard.Init();
         this.ingameLeaderboard.Init();
         this.quest.Init();
         this.metaUI.Init();
         this.tutorial.Init();
         this.questManager.Init();
         (ui as MainWidgetGame).menu.setupHUD();
         (ui as MainWidgetGame).game.initLeftPanel();
         this.topHUD = new HUDWidget(this);
         this.topHUD.Init();
         this.eventsView = new EventWebView(this);
         this.eventsView.Init();
         chestRewardsWidget = new ChestRewardsWidget(this);
         addChild(ui);
         this.gameOver.Init();
         this.gameOver.x = -Dimensions.LEFT_BORDER_WIDTH;
         this.gameOver.y = -Dimensions.NAVIGATION_HEIGHT;
         this._isPartyEnabled = true;
         (ui as MainWidgetGame).menu.PartnerupPlaceHolder.addChild(this.party);
         addChild((ui as MainWidgetGame).menu.PartnerupPlaceHolder);
         PartyServerIO.setGetPartyCallback(this.onPartyLoadedCallback);
         PartyServerIO.sendGetParty(true);
         this.party.setupPartyViews();
         addChild((ui as MainWidgetGame).menu.leftpanel);
         (ui as MainWidgetGame).menu.QuestsAssetsPlaceHolder.addChild(this.quest);
         addChild((ui as MainWidgetGame).menu.QuestsAssetsPlaceHolder);
         this.quest.Hide();
         if(sessionData.throttleManager.IsEnabled(ThrottleManager.THROTTLE_DAILY_CHALLENGES))
         {
            this.dailyChallengeManager = DailyChallengeManager.build(this);
            addChild(this.dailyChallengeManager);
         }
         addChild(this.gameOver);
         (ui as MainWidgetGame).menu.HUDPlaceHolder.addChild(this.topHUD);
         addChild((ui as MainWidgetGame).menu.HUDPlaceHolder);
         this.mDSPlaceholder = new DailySpinPlaceholder();
         this.addChild(this.mDSPlaceholder);
         this.mDSPlaceholder.x = 270;
         this.mDSPlaceholder.y = -83;
         (ui as MainWidgetGame).menu.GenericPopupPlaceHolder.addChild(backgroundScrim);
         backgroundScrim.x = -(ui as MainWidgetGame).menu.GenericPopupPlaceHolder.x;
         backgroundScrim.y = -(ui as MainWidgetGame).menu.GenericPopupPlaceHolder.y;
         (ui as MainWidgetGame).menu.GenericPopupPlaceHolder.addChild((ui as MainWidgetGame).pause);
         addChild((ui as MainWidgetGame).menu.GenericPopupPlaceHolder);
         addChild(this.metaUI);
         this.ftueWidget = new FTUEWidget(this);
         addChild(this.ftueWidget);
         addChild(this.dailySpinContainer);
         addChild(this.networkPopupContainer);
         this.toastWidget.y = 7.5;
         addChild(this.toastWidget);
         addChild(topLayer);
         this.fpsMonitor = new FPSMonitor();
         this.fpsMonitor.visible = false;
         addChild(this.fpsMonitor);
         this.fpsMonitor.Start();
         this.mainState = new MainState(this);
         network.AddHandler(this);
         logic.AddHandler(this);
         var _loc1_:VersionMC = new VersionMC();
         if(_loc1_)
         {
            setContextMenuItem("ResourcesSWC " + _loc1_.versionT.text);
         }
         else
         {
            setContextMenuItem("ResourcesSWC ???");
         }
      }
      
      override public function isAutoplay() : Boolean
      {
         return false;
      }
      
      override public function SetAutoplay() : void
      {
      }
      
      public function EnableFastForwardMode(param1:Boolean) : void
      {
      }
      
      public function isFastForwardEnabled() : Boolean
      {
         return false;
      }
      
      public function onPartyLoadedCallback() : void
      {
         this._isPartyLoaded = true;
         if(this._isStartCalled)
         {
            this.beginGame();
         }
      }
      
      public function StartNow() : void
      {
         this._isStartCalled = true;
         if(!this._isPartyEnabled)
         {
            this.beginGame();
         }
         if(this._isPartyLoaded)
         {
            this.beginGame();
         }
      }
      
      private function beginGame() : void
      {
         this._isLoaded = true;
         var _loc1_:* = getTimer();
         this.loadTime = _loc1_ - this.loadTime;
         this.loadTime /= 1000;
         var _loc2_:Object = {"LoadTime":int(this.loadTime)};
         network.HandleGameLoaded(_loc2_);
         sessionData.ForceDispatchSessionData();
         LiveCheatsForPopCapFBIDs.init(this);
         Start(this.mainState);
         if(!(this.tutorial != null && this.tutorial.shouldShowTutorial))
         {
            bjbEventDispatcher.SendEvent(SHOW_WHATS_NEW,null);
         }
         FriendPopupServerIO.showPopup(this,FriendPopupServerIO.INDEX_ON_GAME_LOADED);
      }
      
      public function displayNetworkError(param1:Boolean = false) : void
      {
         this.handleNetworkError(param1);
      }
      
      private function handleNetworkError(param1:Boolean = false) : void
      {
         var isOffline:Boolean = param1;
         try
         {
            throw new Error("stacktrace");
         }
         catch(err:Error)
         {
            if(!isOffline)
            {
               ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"Blitz3Game::handleNetworkError called. stacktrace: " + err.getStackTrace());
            }
            var refreshButton:GenericButton = new GenericButton(this);
            var background:Bitmap = new Bitmap(ImageManager.getBitmapData(Blitz3GameImages.IMAGE_ERROR_DIALOG_BACKGROUND));
            var format:TextFormat = new TextFormat();
            format.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
            format.size = 12;
            format.color = 16777215;
            format.align = TextFormatAlign.CENTER;
            format.bold = true;
            var errorText:TextField = new TextField();
            errorText.defaultTextFormat = format;
            errorText.embedFonts = true;
            errorText.textColor = 16777215;
            errorText.width = background.width - 30;
            errorText.height = 74;
            errorText.x = 16;
            errorText.y = 70;
            errorText.selectable = false;
            errorText.filters = [new GlowFilter(0,1,5,5,1,1,false,false)];
            errorText.multiline = true;
            errorText.wordWrap = true;
            refreshButton.x = background.width * 0.5 - refreshButton.width;
            refreshButton.y = background.height - refreshButton.height - 50;
            var window:Sprite = new Sprite();
            window.addChild(background);
            window.addChild(errorText);
            window.addChild(refreshButton);
            window.x = Dimensions.PRELOADER_WIDTH * 0.5 - window.width * 0.5;
            window.y = Dimensions.PRELOADER_HEIGHT * 0.5 - window.height * 0.5;
            this._errorScreen = new Sprite();
            this._errorScreen.graphics.beginFill(0,0.5);
            this._errorScreen.graphics.drawRect(0,0,Dimensions.PRELOADER_WIDTH,Dimensions.PRELOADER_HEIGHT);
            this._errorScreen.graphics.endFill();
            this._errorScreen.addChild(window);
            addChild(this._errorScreen);
            refreshButton.SetText(TextManager.GetLocString(Blitz3GameLoc.LOC_EC_REFRESH_BUTTON));
            errorText.htmlText = TextManager.GetLocString(Blitz3GameLoc.LOC_EC_NO_INTERNET);
            refreshButton.addEventListener(MouseEvent.CLICK,this.onRefreshPress,false,0,true);
            return;
         }
      }
      
      public function HandleNetworkSuccess(param1:XML) : void
      {
      }
      
      public function HandleCartClosed(param1:Boolean) : void
      {
         this.party.startStatusCountdown();
      }
      
      public function HandleGameLoad() : void
      {
      }
      
      public function HandleGameBegin() : void
      {
         this.fpsMonitor.setDynamicFPS(true);
         this.questManager.UpdateQuestCompletion("GameBegin");
         sessionData.configManager.CommitChanges();
      }
      
      public function HandleGameEnd() : void
      {
         sessionData.configManager.CommitChanges();
      }
      
      public function HandleGameAbort() : void
      {
         if(!mIsReplay)
         {
            sessionData.configManager.CommitChanges();
         }
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
      
      public function HandleBlockingEvent() : void
      {
      }
      
      private function HandleAdded(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.HandleAdded);
         this.Init();
      }
      
      private function onRefreshPress(param1:MouseEvent) : void
      {
         network.Refresh();
      }
      
      private function onGenericClick(param1:MouseEvent) : void
      {
         this.updateLastActivityTime();
      }
      
      public function updateLastActivityTime() : void
      {
         this._lastActivity = getTimer();
      }
      
      private function ToggleDebugInfo(param1:Array = null) : void
      {
         this.fpsMonitor.visible = !this.fpsMonitor.visible;
      }
      
      public function AddLBDataHandler(param1:ILeaderboardUpdateEvents) : void
      {
         this._lbDataHandlers.push(param1);
      }
      
      public function DisptachHandleScoreUpdated(param1:int) : void
      {
         var _loc2_:ILeaderboardUpdateEvents = null;
         for each(_loc2_ in this._lbDataHandlers)
         {
            _loc2_.HandleScoreUpdated(param1);
         }
      }
      
      public function DispatchHandleBasicLoadComplete() : void
      {
         var _loc1_:ILeaderboardUpdateEvents = null;
         for each(_loc1_ in this._lbDataHandlers)
         {
            _loc1_.HandleBasicLoadComplete();
         }
      }
      
      public function DispatchUpdatePokeAndRivalStatus() : void
      {
         var _loc1_:ILeaderboardUpdateEvents = null;
         for each(_loc1_ in this._lbDataHandlers)
         {
            _loc1_.updatePokeAndRivalStatus();
         }
      }
      
      public function DispatchShowTourneyRefresh() : void
      {
         var _loc1_:ILeaderboardUpdateEvents = null;
         for each(_loc1_ in this._lbDataHandlers)
         {
            _loc1_.showTourneyRefresh();
         }
      }
      
      public function DispatchShowLeaderboardRefresh() : void
      {
         var _loc1_:ILeaderboardUpdateEvents = null;
         for each(_loc1_ in this._lbDataHandlers)
         {
            _loc1_.showLeaderboardRefresh();
         }
      }
      
      public function DispatchValidatePokeAndFlagButtonsForPlayer(param1:PlayerData) : void
      {
         var _loc2_:ILeaderboardUpdateEvents = null;
         for each(_loc2_ in this._lbDataHandlers)
         {
            _loc2_.validatePokeAndFlagButtonsForPlayer(param1);
         }
      }
      
      public function canShowEvents() : Boolean
      {
         var _loc1_:Boolean = false;
         if(sessionData && sessionData.featureManager.isFeatureEnabled(FeatureManager.FEATURE_RARE_GEMS) && this.eventsView && this.eventsView.areEventsAvailable)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function HandleGameTimeDelayed() : void
      {
      }
      
      public function isTournamentScreenOrMode() : Boolean
      {
         if((app.ui as MainWidgetGame).menu.getCurrentMenuMode() == MenuWidget.MODE_TOURNAMENT && (app.sessionData.tournamentController && app.sessionData.tournamentController.getCurrentTournamentId() != ""))
         {
            return true;
         }
         return false;
      }
   }
}
