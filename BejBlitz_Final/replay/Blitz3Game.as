package
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.dailyspin.DailySpinWidget;
   import com.popcap.flash.bejeweledblitz.friendscore.FriendscoreWidget;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.IBlitz3NetworkHandler;
   import com.popcap.flash.bejeweledblitz.game.states.MainState;
   import com.popcap.flash.bejeweledblitz.game.tutorial.TutorialWatcher;
   import com.popcap.flash.bejeweledblitz.game.ui.StarMedalFactory;
   import com.popcap.flash.bejeweledblitz.game.ui.UIFactory;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButton;
   import com.popcap.flash.bejeweledblitz.game.ui.meta.MetaUI;
   import com.popcap.flash.bejeweledblitz.leaderboard.LeaderboardWidget;
   import com.popcap.flash.bejeweledblitz.navigation.NavigationWidget;
   import com.popcap.flash.framework.keyboard.CharCodeCheck;
   import com.popcap.flash.framework.keyboard.KeyboardCheck;
   import com.popcap.flash.framework.keyboard.SequenceCheck;
   import com.popcap.flash.framework.utils.FPSMonitor;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.system.Security;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class Blitz3Game extends Blitz3App implements IBlitz3NetworkHandler
   {
      
      private static const VERSION_NAME:String = "Bejeweled Blitz";
      
      public static const AUTOPLAY:Boolean = false;
       
      
      private var mMark:KeyboardCheck;
      
      private var mMarkTimer:int = 0;
      
      public var navigation:NavigationWidget;
      
      public var leaderboard:LeaderboardWidget;
      
      public var friendscore:FriendscoreWidget;
      
      public var dailyspin:DailySpinWidget;
      
      public var metaUI:MetaUI;
      
      public var tutorial:TutorialWatcher;
      
      public var mainState:MainState;
      
      public var fpsMonitor:FPSMonitor;
      
      public function Blitz3Game()
      {
         var domain:String = null;
         super(VERSION_NAME);
         for each(domain in ALLOW_DOMAINS)
         {
            Security.allowDomain(domain);
         }
         addEventListener(Event.ADDED_TO_STAGE,this.HandleAdded);
         y = Dimensions.NAVIGATION_HEIGHT;
         x = Dimensions.LEFT_BORDER_WIDTH;
      }
      
      override public function Init() : void
      {
         super.Init();
         LoadData(network.GetFlashPath());
         RegisterCommand("ToggleDebugInfo",this.ToggleDebugInfo);
         var sequence:SequenceCheck = new SequenceCheck(true);
         sequence.AddCheck(new CharCodeCheck("q".charCodeAt(0)));
         sequence.AddCheck(new CharCodeCheck("u".charCodeAt(0)));
         sequence.AddCheck(new CharCodeCheck("a".charCodeAt(0)));
         sequence.AddCheck(new CharCodeCheck("k".charCodeAt(0)));
         sequence.AddCheck(new CharCodeCheck("e".charCodeAt(0)));
         this.mMark = sequence;
         stage.addEventListener(KeyboardEvent.KEY_UP,this.HandleKeyUp);
         starMedalTable = new StarMedalFactory(this);
         uiFactory = new UIFactory(this);
         ui = uiFactory.GetMainWidget();
         this.navigation = new NavigationWidget(this);
         this.leaderboard = new LeaderboardWidget(this);
         this.friendscore = new FriendscoreWidget(this);
         this.dailyspin = new DailySpinWidget(this);
         this.metaUI = new MetaUI(this);
         this.tutorial = new TutorialWatcher(this);
         ui.Init();
         this.leaderboard.Init();
         this.friendscore.Init();
         this.dailyspin.Init();
         this.metaUI.Init();
         this.tutorial.Init();
         this.navigation.Init();
         addChild(ui);
         addChild(this.navigation);
         addChild(this.leaderboard);
         addChild(this.friendscore);
         addChild(this.metaUI);
         this.fpsMonitor = new FPSMonitor();
         this.fpsMonitor.visible = false;
         addChild(this.fpsMonitor);
         this.fpsMonitor.Start();
         this.mainState = new MainState(this);
         network.AddHandler(this);
      }
      
      public function StartNow() : void
      {
         network.HandleGameLoaded();
         sessionData.ForceDispatchSessionData();
         Start(this.mainState);
      }
      
      public function HandleNetworkError() : void
      {
         var background:Bitmap = null;
         var errorText:TextField = null;
         try
         {
            throw new Error("stacktrace");
         }
         catch(err:Error)
         {
            trace(err.getStackTrace());
            var refreshButton:GenericButton = new GenericButton(this);
            refreshButton.SetText(TextManager.GetLocString(Blitz3GameLoc.LOC_EC_REFRESH_BUTTON));
            background = new Bitmap(ImageManager.getBitmapData(Blitz3GameImages.IMAGE_ERROR_DIALOG_BACKGROUND));
            var format:TextFormat = new TextFormat();
            format.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
            format.size = 12;
            format.color = 16777215;
            format.align = TextFormatAlign.CENTER;
            format.bold = true;
            errorText = new TextField();
            errorText.defaultTextFormat = format;
            errorText.embedFonts = true;
            errorText.htmlText = TextManager.GetLocString(Blitz3GameLoc.LOC_EC_SERVER_COMMUNICATION);
            errorText.textColor = 16777215;
            errorText.width = background.width - 30;
            errorText.height = 74;
            errorText.x = 16;
            errorText.y = 50;
            errorText.selectable = false;
            errorText.filters = [new GlowFilter(0,1,5,5,1,1,false,false)];
            errorText.multiline = true;
            errorText.wordWrap = true;
            refreshButton.x = background.width * 0.5 - refreshButton.width * 0.5;
            refreshButton.y = background.height - refreshButton.height - 20;
            var window:Sprite = new Sprite();
            window.addChild(background);
            window.addChild(errorText);
            window.addChild(refreshButton);
            window.x = Dimensions.GAME_WIDTH * 0.5 - window.width * 0.5;
            window.y = Dimensions.GAME_HEIGHT * 0.5 - window.height * 0.5;
            var errorScreen:Sprite = new Sprite();
            errorScreen.graphics.beginFill(0,0.5);
            errorScreen.graphics.drawRect(0,0,Dimensions.GAME_WIDTH,Dimensions.GAME_HEIGHT);
            errorScreen.graphics.endFill();
            errorScreen.addChild(window);
            addChild(errorScreen);
            refreshButton.addEventListener(MouseEvent.CLICK,this.HandleClick);
            Stop();
            return;
         }
      }
      
      public function HandleNetworkSuccess(response:XML) : void
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
