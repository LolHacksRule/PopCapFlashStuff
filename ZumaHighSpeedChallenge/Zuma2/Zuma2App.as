package
{
   import com.popcap.flash.framework.BaseApp;
   import com.popcap.flash.framework.Canvas;
   import com.popcap.flash.framework.resources.fonts.FontManager;
   import com.popcap.flash.framework.resources.images.ImageManager;
   import com.popcap.flash.framework.resources.sounds.SoundManager;
   import com.popcap.flash.framework.utils.FPSMonitor;
   import com.popcap.flash.games.zuma2.logic.LayerSprite;
   import com.popcap.flash.games.zuma2.logic.LevelMgr;
   import com.popcap.flash.games.zuma2.logic.Zuma2Fonts;
   import com.popcap.flash.games.zuma2.logic.Zuma2Images;
   import com.popcap.flash.games.zuma2.logic.Zuma2LevelData;
   import com.popcap.flash.games.zuma2.logic.Zuma2Sounds;
   import com.popcap.flash.games.zuma2.states.MainState;
   import com.popcap.flash.games.zuma2.widgets.GameBoardWidget;
   import com.popcap.flash.games.zuma2.widgets.ZumaWidget;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.net.SharedObject;
   import flash.system.Security;
   
   public class Zuma2App extends BaseApp
   {
      
      public static const Blue_Ball:int = 0;
      
      public static const STATE_LOADING:String = "Loading";
      
      public static const SCREEN_WIDTH:int = 540;
      
      public static const White_Ball:int = 5;
      
      public static const STATE_MAIN_MENU:String = "MainMenu";
      
      public static const APP_ID:String = "Zuma2";
      
      public static const SCREEN_HEIGHT:int = 405;
      
      public static const STATE_LEVEL_INTRO:String = "LevelIntro";
      
      public static const STATE_PLAY_LEVEL:String = "PlayLevel";
      
      public static const STATE_TITLE_SCREEN:String = "TitleScreen";
      
      public static const Purple_Ball:int = 4;
      
      public static const Yellow_Ball:int = 1;
      
      public static const MY_PI:Number = 3.14159;
      
      public static const Red_Ball:int = 2;
      
      public static const SHRINK_PERCENT:Number = 0.675;
      
      public static const DEG_TO_RAD:Number = MY_PI / 180;
      
      public static const RAD_TO_DEG:Number = 180 / MY_PI;
      
      public static const Green_Ball:int = 3;
       
      
      public var mLevelMgr:LevelMgr;
      
      public var gStopSuckbackImmediately:Boolean = false;
      
      public var mSharedObject:SharedObject;
      
      public var imageManager:ImageManager;
      
      public var gSuckMode:Boolean;
      
      public var gDieAtEnd:Boolean;
      
      public var canvas:Canvas;
      
      public var gGotPowerUp:Array;
      
      public var gBallColors:Array;
      
      public var fontManager:FontManager;
      
      public var mLevelData:Zuma2LevelData;
      
      public var fpsMon:FPSMonitor;
      
      public var gUpdateBalls:Boolean;
      
      public var mHideHelp:Boolean = false;
      
      public var mHighScore:int = 0;
      
      public var widgets:ZumaWidget;
      
      public var gForceFruit:Boolean;
      
      public var mLayers:Vector.<LayerSprite>;
      
      public var gDarkBallColors:Array;
      
      public var soundManager:SoundManager;
      
      public var mBoard:GameBoardWidget;
      
      public var gAddBalls:Boolean;
      
      public var gBrightBallColors:Array;
      
      public function Zuma2App()
      {
         this.gBallColors = new Array(1671423,16776960,16711680,65280,16711935,16777215);
         this.gBrightBallColors = new Array(8454143,16777024,16755370,8454016,16744703,16777215);
         this.gDarkBallColors = new Array(2299513,6312202,10489620,2114594,5641795,3676962);
         this.mLayers = new Vector.<LayerSprite>();
         this.gGotPowerUp = new Array();
         super();
         Security.allowDomain("labs.test.vte.internal.popcap.com","labs.eric.popcap.com","labs.popcap.com","www.popcap.com","dl.labs.popcap.com");
         if(stage)
         {
            this.Init();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.HandleAdded);
         }
      }
      
      public function HandleAdded(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.HandleAdded);
         this.Init();
      }
      
      public function Init(param1:Event = null) : void
      {
         this.mSharedObject = SharedObject.getLocal("ZumasRevenge");
         if(this.mSharedObject.data.help == null)
         {
            this.mSharedObject.data.help = true;
         }
         if(this.mSharedObject.data.highscore == null)
         {
            this.mSharedObject.data.highscore = 0;
         }
         this.mHighScore = this.mSharedObject.data.highscore;
         this.canvas = new Canvas(SCREEN_WIDTH,SCREEN_HEIGHT);
         this.widgets = new ZumaWidget(this);
         this.imageManager = new Zuma2Images();
         this.fontManager = new Zuma2Fonts();
         this.mLevelData = new Zuma2LevelData();
         this.soundManager = new Zuma2Sounds();
         var _loc2_:MainState = new MainState(this);
         this.addChild(new Bitmap(this.canvas.getData()));
         var _loc3_:int = 0;
         while(_loc3_ < 5)
         {
            this.mLayers[_loc3_] = new LayerSprite();
            addChild(this.mLayers[_loc3_]);
            _loc3_++;
         }
         this.gAddBalls = true;
         this.gDieAtEnd = true;
         this.gSuckMode = false;
         this.gUpdateBalls = true;
         this.gForceFruit = false;
         init(_loc2_);
      }
   }
}
