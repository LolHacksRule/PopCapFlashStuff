package com.popcap.flash.bejeweledblitz.game
{
   import com.popcap.flash.bejeweledblitz.AdFrequencyManager;
   import com.popcap.flash.bejeweledblitz.BJBEventDispatcher;
   import com.popcap.flash.bejeweledblitz.Constants;
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.session.Blitz3Network;
   import com.popcap.flash.bejeweledblitz.game.session.SessionData;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.ui.ChestRewardsWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.factories.FlameBordersFactory;
   import com.popcap.flash.bejeweledblitz.game.ui.factories.FlameGemFactory;
   import com.popcap.flash.bejeweledblitz.game.ui.factories.PhoenixPrismGemFactory;
   import com.popcap.flash.bejeweledblitz.game.ui.factories.StarGemFactory;
   import com.popcap.flash.bejeweledblitz.game.ui.factories.StarMedalFactory;
   import com.popcap.flash.bejeweledblitz.game.ui.factories.UIFactory;
   import com.popcap.flash.bejeweledblitz.game.ui.whatsNew.WhatsNewWidget;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.BaseApp;
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.StageQuality;
   
   public class Blitz3App extends BaseApp
   {
      
      public static const GAME_MODE_SINGLEPLAYER:int = 0;
      
      public static const GAME_MODE_MULTIPLAYER:int = 1;
      
      public static const REDUCED_EXPLOSION_VOLUME:Number = 0.7;
      
      public static const SHOW_WHATS_NEW:String = "SHOW WHATS NEW";
      
      public static const CLOSE_WHATS_NEW:String = "CLOSE WHATS NEW";
      
      public static var app:Blitz3App;
       
      
      private var _LQMode:Boolean = true;
      
      public var logic:BlitzLogic;
      
      public var network:Blitz3Network;
      
      public var sessionData:SessionData;
      
      public var logicAdapter:BlitzLogicAdapter;
      
      public var bjbEventDispatcher:BJBEventDispatcher;
      
      public var tester:LogicTester;
      
      public var ui:MainWidget;
      
      public var uiFactory:UIFactory;
      
      public var chestRewardsWidget:ChestRewardsWidget;
      
      public var whatsNewWidget:WhatsNewWidget;
      
      public var adFrequencyManager:AdFrequencyManager;
      
      public var backgroundScrim:Shape;
      
      public var flameBordersFactory:FlameBordersFactory;
      
      public var starMedalFactory:StarMedalFactory;
      
      public var starGemFactory:StarGemFactory;
      
      public var flameGemFactory:FlameGemFactory;
      
      public var phoenixPrismGemFactory:PhoenixPrismGemFactory;
      
      public var GameMode:int = 0;
      
      public var topLayer:MovieClip;
      
      public var eventsNextLaunchUrl:String = "";
      
      protected var _isConfigLoaded:Boolean = false;
      
      public var mIsReplay:Boolean = false;
      
      public function Blitz3App(param1:String)
      {
         super(param1);
         Blitz3App.app = this;
         Constants.IS_DEBUG = false;
         this.topLayer = new MovieClip();
         this.mIsReplay = false;
      }
      
      public function isConfigLoaded() : Boolean
      {
         return this._isConfigLoaded;
      }
      
      public function setConfigLoaded() : void
      {
         this._isConfigLoaded = true;
      }
      
      public function isAutoplay() : Boolean
      {
         return false;
      }
      
      public function Init() : void
      {
         StringUtils.thousandsSeparator = TextManager.GetLocString(Blitz3GameLoc.LOC_THOUSAND_SEP);
         this.bjbEventDispatcher = new BJBEventDispatcher();
         this.backgroundScrim = new Shape();
         this.backgroundScrim.graphics.beginFill(0,0.95);
         this.backgroundScrim.graphics.drawRect(0,0,Dimensions.PRELOADER_WIDTH,Dimensions.PRELOADER_HEIGHT);
         this.backgroundScrim.visible = false;
         this.logic = new BlitzLogic();
         this.whatsNewWidget = new WhatsNewWidget(this);
         this.whatsNewWidget.Init();
         this.adFrequencyManager = new AdFrequencyManager();
         this.adFrequencyManager.Init();
         this.network = new Blitz3Network(this);
         this.sessionData = new SessionData(this);
         this.logicAdapter = new BlitzLogicAdapter(this);
         this.network.Init(stage.loaderInfo.parameters);
         this.sessionData.finisherManager.AddHandler(this.OnFinisherConfigLoaded);
         this.sessionData.Init();
         this._LQMode = this.sessionData.configManager.GetFlag(ConfigManager.FLAG_LQ_MODE);
         if(this._LQMode)
         {
            stage.quality = StageQuality.MEDIUM;
         }
         else
         {
            stage.quality = StageQuality.HIGH;
         }
         this.flameBordersFactory = new FlameBordersFactory(this);
         this.starGemFactory = new StarGemFactory(this);
         this.flameGemFactory = new FlameGemFactory(this);
         this.phoenixPrismGemFactory = new PhoenixPrismGemFactory(this);
         if(Constants.IS_DEBUG)
         {
            this.tester = new LogicTester(this.logic);
         }
         this.logicAdapter.Init();
         addChild(this.topLayer);
      }
      
      public function toggleScrimVisibilty(param1:Boolean) : void
      {
         this.backgroundScrim.visible = param1;
      }
      
      public function setMultiplayerGame(param1:Boolean = true) : void
      {
         if(param1)
         {
            this.GameMode = GAME_MODE_MULTIPLAYER;
         }
         else
         {
            this.GameMode = GAME_MODE_SINGLEPLAYER;
         }
      }
      
      public function isMultiplayerGame() : Boolean
      {
         return this.GameMode == GAME_MODE_MULTIPLAYER;
      }
      
      public function isDailyChallengeGame() : Boolean
      {
         return this.logic.IsDailyChallengeGame();
      }
      
      public function get isLQMode() : Boolean
      {
         return this._LQMode;
      }
      
      public function set isLQMode(param1:Boolean) : void
      {
         this.sessionData.configManager.SetFlag(ConfigManager.FLAG_LQ_MODE,param1);
         this.sessionData.configManager.CommitChanges();
      }
      
      public function SetAutoplay() : void
      {
      }
      
      private function OnFinisherConfigLoaded() : void
      {
         this.sessionData.finisherManager.LoadFinisherGraphics();
      }
   }
}
