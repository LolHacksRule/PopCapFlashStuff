package
{
   import caurina.transitions.Tweener;
   import com.popcap.flash.framework.AppUtils;
   import com.popcap.flash.framework.ads.AdAPIEvent;
   import com.popcap.flash.framework.ads.MSNAdAPI;
   import com.popcap.flash.framework.input.keyboard.CharCodeCheck;
   import com.popcap.flash.framework.input.keyboard.KeyboardCheck;
   import com.popcap.flash.framework.input.keyboard.SequenceCheck;
   import com.popcap.flash.framework.resources.localization.LocalizationManager;
   import com.popcap.flash.framework.utils.FPSMonitor;
   import com.popcap.flash.games.bej3.blitz.Blitz3Network;
   import com.popcap.flash.games.bej3.blitz.IBej3Game;
   import com.popcap.flash.games.bej3.blitz.IBej3MainMenu;
   import com.popcap.flash.games.bej3.blitz.IBlitz3NetworkHandler;
   import com.popcap.flash.games.bej3.blitz.IHelpWidget;
   import com.popcap.flash.games.blitz3.game.states.MainState;
   import com.popcap.flash.games.blitz3.session.DataStore;
   import com.popcap.flash.games.blitz3.ui.Blitz3UI;
   import com.popcap.flash.games.blitz3.ui.sprites.FadeButton;
   import com.popcap.flash.games.blitz3.ui.widgets.HelpWidget;
   import com.popcap.flash.games.blitz3.ui.widgets.MainWidget;
   import com.popcap.flash.games.blitz3.ui.widgets.StarMedalTable;
   import com.popcap.flash.games.blitz3.ui.widgets.coins.CreditsScreen;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   [SWF(backgroundColor="#C7C7C7",width="540",height="405")]
   public class Blitz3Game extends Blitz3UI implements IBlitz3NetworkHandler, IBej3Game
   {
      
      public static const SCREEN_WIDTH:int = 540;
      
      public static const SCREEN_HEIGHT:int = 405;
       
      
      private var mMark:KeyboardCheck;
      
      private var mMarkTimer:int = 0;
      
      private var mSessionId:String = "0";
      
      private var mainState:MainState;
      
      private var _refreshButton:FadeButton;
      
      public var fpsMonitor:FPSMonitor;
      
      public var m_menu:IBej3MainMenu;
      
      public function Blitz3Game()
      {
         super();
         if(stage != null)
         {
            stage.frameRate = 64;
            this.Init();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.HandleAdded);
         }
         var rect:Rectangle = new Rectangle(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
         scrollRect = rect;
      }
      
      override public function Init() : void
      {
         var parameters:Object = stage.loaderInfo.parameters;
         network = new Blitz3Network(this);
         imageManager = new Blitz3Images();
         soundManager = new Blitz3Sounds();
         fontManager = new Blitz3Fonts();
         super.Init();
         network.Init(parameters);
         network.AddHandler(this);
         currentHighScore = Number(network.parameters.theHighScore);
         if(isNaN(currentHighScore))
         {
            currentHighScore = 0;
         }
         RegisterCommand("ToggleDebugInfo",this.ToggleDebugInfo);
         starMedalTable = new StarMedalTable(this);
         ui = new MainWidget(this);
         ui.Init();
         creditsScreen = new CreditsScreen(this);
         creditsScreen.AddHandler(network);
         this.mainState = new MainState(this);
         var sequence:SequenceCheck = new SequenceCheck(true);
         sequence.AddCheck(new CharCodeCheck("q".charCodeAt(0)));
         sequence.AddCheck(new CharCodeCheck("u".charCodeAt(0)));
         sequence.AddCheck(new CharCodeCheck("a".charCodeAt(0)));
         sequence.AddCheck(new CharCodeCheck("k".charCodeAt(0)));
         sequence.AddCheck(new CharCodeCheck("e".charCodeAt(0)));
         this.mMark = sequence;
         stage.addEventListener(KeyboardEvent.KEY_UP,this.HandleKeyUp);
         addChild(ui as DisplayObject);
         addChild(creditsScreen);
         sessionData.ForceDispatchSessionData();
         this.fpsMonitor = new FPSMonitor();
         this.fpsMonitor.visible = false;
         stage.addChild(this.fpsMonitor);
         this.fpsMonitor.Start();
         if(showCartOnStart)
         {
            network.ShowCart();
         }
      }
      
      public function get sessionId() : String
      {
         return this.mSessionId;
      }
      
      public function HandleNetworkError() : void
      {
         var errorScreen:Sprite = null;
         var window:Sprite = null;
         try
         {
            throw new Error("stacktrace");
         }
         catch(err:Error)
         {
            trace(err.getStackTrace());
            errorScreen = new Sprite();
            errorScreen.graphics.beginFill(0,0.5);
            errorScreen.graphics.drawRect(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
            errorScreen.graphics.endFill();
            window = new Sprite();
            var format:TextFormat = new TextFormat();
            format.font = Blitz3Fonts.BLITZ_STANDARD;
            format.size = 12;
            format.color = 16777215;
            format.align = TextFormatAlign.CENTER;
            format.bold = true;
            var errorText:TextField = new TextField();
            errorText.defaultTextFormat = format;
            errorText.embedFonts = true;
            errorText.htmlText = locManager.GetLocString("EC_SERVER_COMMUNICATION");
            errorText.textColor = 16777215;
            errorText.height = 74;
            errorText.x = 16;
            errorText.y = 50;
            errorText.selectable = false;
            errorText.filters = [new GlowFilter(0,1,5,5,1,1,false,false)];
            errorText.multiline = true;
            errorText.wordWrap = true;
            window.x = SCREEN_WIDTH / 2 - window.width / 2;
            window.y = SCREEN_HEIGHT / 2 - window.height / 2;
            errorScreen.addChild(window);
            Stop();
            return;
         }
      }
      
      public function setBackgrounds(topClip:MovieClip, bottomClip:MovieClip) : void
      {
         ui.game.background.setBackgrounds(topClip,bottomClip);
      }
      
      public function setVolume(volume:Number) : void
      {
         sessionData.dataStore.SetIntVal(DataStore.INT_VOLUME_SETTING,volume * 100);
         soundManager.setVolume(volume);
         (ui as MainWidget).options.SetVolume(volume);
      }
      
      public function getVolume() : Number
      {
         return sessionData.dataStore.GetIntVal(DataStore.INT_VOLUME_SETTING,75) / 100;
      }
      
      public function getHelpScreen() : IHelpWidget
      {
         return new HelpWidget(this);
      }
      
      public function getLocManager() : LocalizationManager
      {
         return locManager;
      }
      
      public function setLocXML(xml:XML) : void
      {
         locManager = new Blitz3Localization();
         locManager.SetXML(xml);
      }
      
      public function startGame() : void
      {
         Start(this.mainState);
      }
      
      public function show() : void
      {
         x = 0;
         trace("Game alpha: " + this.alpha);
         Tweener.addTween(this,{
            "alpha":1,
            "time":2,
            "transition":"easeOutQuad"
         });
      }
      
      public function hide(immediate:Boolean = false) : void
      {
         if(immediate)
         {
            alpha = 0;
            x = -540;
         }
         Tweener.addTween(this,{
            "alpha":0,
            "time":1,
            "transition":"easeOutQuad",
            "onComplete":function():*
            {
               x = -540;
            }
         });
      }
      
      public function setMenu(menu:IBej3MainMenu) : void
      {
         this.m_menu = menu;
      }
      
      public function setAPI(api:MSNAdAPI) : void
      {
         mAdAPI = api;
         if(GetProperties() != null)
         {
            mAdAPI._isEnabled = AppUtils.asBoolean(GetProperties().MSN.enabled);
            trace("api enabled: " + mAdAPI._isEnabled);
         }
         if(mAdAPI._isEnabled)
         {
            mAdAPI.addEventListener(AdAPIEvent.MUTE,this.HandleMute);
            mAdAPI.addEventListener(AdAPIEvent.UNMUTE,this.HandleUnmute);
         }
         network.SetAPI(mAdAPI);
      }
      
      public function setDataXML(xml:XML) : void
      {
         SetProperties(xml);
      }
      
      public function StartSession(e:Event) : void
      {
      }
      
      public function HandleNetworkSuccess() : void
      {
      }
      
      public function HandleBuyCoinsCallback(success:Boolean) : void
      {
      }
      
      public function HandleExternalPause(isPaused:Boolean) : void
      {
      }
      
      public function HandleCartClosed(coinsPurchased:Boolean) : void
      {
      }
      
      public function HandleNetworkGameStart() : void
      {
      }
      
      private function HandleMute(e:AdAPIEvent) : void
      {
         soundManager.mute();
      }
      
      private function HandleUnmute(e:AdAPIEvent) : void
      {
         soundManager.unmute();
      }
      
      private function HandleAdded(e:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.HandleAdded);
         this.Init();
      }
      
      private function HandleKeyUp(e:KeyboardEvent) : void
      {
         if(this.mMark.Check(e))
         {
            addEventListener(Event.ENTER_FRAME,this.HandleFrame);
         }
      }
      
      private function HandleFrame(e:Event) : void
      {
         var mat:Matrix = parent.transform.matrix;
         mat.identity();
         mat.translate(Math.random() * 2 - 1,Math.random() * 2 - 1);
         parent.transform.matrix = mat;
      }
      
      private function HandleClick(e:MouseEvent) : void
      {
         network.Refresh();
      }
      
      private function ToggleDebugInfo(args:Array = null) : void
      {
         this.fpsMonitor.visible = !this.fpsMonitor.visible;
      }
   }
}
