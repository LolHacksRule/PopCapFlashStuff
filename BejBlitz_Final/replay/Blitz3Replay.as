package
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.logic.game.ReplayData;
   import com.popcap.flash.bejeweledblitz.replay.CommandSerializer;
   import com.popcap.flash.bejeweledblitz.replay.states.MainState;
   import com.popcap.flash.bejeweledblitz.replay.ui.UIFactoryReplay;
   import com.popcap.flash.framework.keyboard.CharCodeCheck;
   import com.popcap.flash.framework.keyboard.KeyboardCheck;
   import com.popcap.flash.framework.keyboard.SequenceCheck;
   import com.popcap.flash.framework.utils.Base64;
   import com.popcap.flash.framework.utils.FPSMonitor;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.geom.Matrix;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.system.Security;
   import flash.utils.ByteArray;
   
   public class Blitz3Replay extends Blitz3App
   {
      
      private static const VERSION_NAME:String = "Bejeweled Blitz Replay";
       
      
      public var mainState:MainState;
      
      private var mMark:KeyboardCheck;
      
      private var mMarkTimer:int = 0;
      
      private var m_Loader:URLLoader;
      
      public var fpsMonitor:FPSMonitor;
      
      public var autoLoad:Boolean = true;
      
      public function Blitz3Replay()
      {
         var domain:String = null;
         super(VERSION_NAME);
         for each(domain in ALLOW_DOMAINS)
         {
            Security.allowDomain(domain);
         }
         isReplayer = true;
         addEventListener(Event.ADDED_TO_STAGE,this.HandleAdded);
      }
      
      override public function Init() : void
      {
         super.Init();
         RegisterCommand("ToggleDebugInfo",this.ToggleDebugInfo);
         var sequence:SequenceCheck = new SequenceCheck(true);
         sequence.AddCheck(new CharCodeCheck("q".charCodeAt(0)));
         sequence.AddCheck(new CharCodeCheck("u".charCodeAt(0)));
         sequence.AddCheck(new CharCodeCheck("a".charCodeAt(0)));
         sequence.AddCheck(new CharCodeCheck("k".charCodeAt(0)));
         sequence.AddCheck(new CharCodeCheck("e".charCodeAt(0)));
         this.mMark = sequence;
         stage.addEventListener(KeyboardEvent.KEY_UP,this.HandleKeyUp);
         if(sessionData.configManager.GetFlag(ConfigManager.FLAG_MUTE))
         {
            SoundManager.mute();
         }
         uiFactory = new UIFactoryReplay(this);
         ui = uiFactory.GetMainWidget();
         ui.Init();
         addChild(ui);
         this.mainState = new MainState(this);
         this.fpsMonitor = new FPSMonitor();
         this.fpsMonitor.visible = false;
         stage.addChild(this.fpsMonitor);
         this.fpsMonitor.Start();
         this.Reset();
      }
      
      public function StartNow() : void
      {
         Start(this.mainState);
      }
      
      public function Reset() : void
      {
         var data:String = null;
         var didLoad:Boolean = false;
         if(stage.loaderInfo && stage.loaderInfo.parameters)
         {
            data = stage.loaderInfo.parameters.Replay;
            if(data != null)
            {
               this.LoadURLEncodedReplay(data);
               didLoad = true;
            }
            else
            {
               data = stage.loaderInfo.parameters.ReplayID;
               if(data != null)
               {
                  this.Load(data);
                  didLoad = true;
               }
            }
         }
         if(!didLoad && this.autoLoad)
         {
            this.LoadURLEncodedReplay("eNoVjj1IQgEABq/PL1F5PMK/0qcQbc5CS4PNieDiVkOzNDcFFQYtrU0trYkIDhKRUy1tNTUGBW39DOUm5ZuOu+n+Kjezs5k8QVky+GBBERX8KTXZwrsJrdPCNasa9werzQ7+WVSHKn5KajvmRkplSvgkpZAAn6d1yBEuBVpjFY8CnbKHM6GuGOKXUGMG+G5J17H3sjomjxs5TbjFm3n16OL7gob08WVRjzzj7rL6XMz/VvTOG66X9c0X3o/0wSueRnP/5R8IzC1I");
         }
      }
      
      override public function Stop() : void
      {
         super.Stop();
         stage.removeEventListener(KeyboardEvent.KEY_UP,this.HandleKeyUp);
         removeEventListener(Event.ENTER_FRAME,this.HandleFrame);
      }
      
      public function LoadURLEncodedReplay(replay:String) : void
      {
         var bytes:ByteArray = Base64.DecodeString(replay);
         bytes.position = 0;
         var commands:Vector.<ReplayData> = CommandSerializer.DeserializeCommands(bytes);
         logic.SetReplayData(commands);
         this.mainState.Start();
      }
      
      public function Load(rplFile:String) : void
      {
         this.m_Loader = new URLLoader();
         this.m_Loader.dataFormat = URLLoaderDataFormat.BINARY;
         this.m_Loader.addEventListener(Event.COMPLETE,this.OnLoadComplete);
         this.m_Loader.load(new URLRequest(rplFile));
      }
      
      private function OnLoadComplete(e:Event) : void
      {
         this.m_Loader.removeEventListener(Event.COMPLETE,this.OnLoadComplete);
         var commands:Vector.<ReplayData> = CommandSerializer.DeserializeCommands(this.m_Loader.data as ByteArray);
         logic.SetReplayData(commands);
         this.mainState.Start();
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
      
      private function ToggleDebugInfo(args:Array = null) : void
      {
         this.fpsMonitor.visible = !this.fpsMonitor.visible;
      }
   }
}
