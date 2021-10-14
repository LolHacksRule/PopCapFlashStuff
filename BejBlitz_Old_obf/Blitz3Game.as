package
{
   import §_-4M§.§_-mM§;
   import §_-u§.§_-67§;
   import §_-u§.§_-Nj§;
   import §case §.§_-Zh§;
   import com.popcap.flash.framework.input.keyboard.KeyboardCheck;
   import com.popcap.flash.framework.input.keyboard.§_-4Y§;
   import com.popcap.flash.framework.input.keyboard.§_-pA§;
   import com.popcap.flash.games.bej3.blitz.IBlitz3NetworkHandler;
   import com.popcap.flash.games.bej3.blitz.§_-Bw§;
   import com.popcap.flash.games.blitz3.§_-79§;
   import com.popcap.flash.games.blitz3.§_-lK§;
   import com.popcap.flash.games.blitz3.game.states.§_-pB§;
   import com.popcap.flash.games.blitz3.ui.sprites.§_-25§;
   import com.popcap.flash.games.blitz3.ui.widgets.coins.each;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.system.Security;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.utils.Dictionary;
   
   public class Blitz3Game extends §_-Zh§ implements IBlitz3NetworkHandler
   {
      
      public static const §_-GN§:int = 384;
      
      private static const §_-Jv§:Class = Blitz3Game_REFRESH_OVER_RGB;
      
      public static const §_-h8§:int = 510;
      
      private static const §_-ds§:Class = Blitz3Game_BACKGROUND_RGB;
      
      private static const §_-VA§:Class = Blitz3Game_REFRESH_UP_RGB;
       
      
      private var §_-Cf§:Boolean = true;
      
      private var §_-n5§:Boolean = false;
      
      private var §_-oo§:int = 0;
      
      private var §_-M3§:§_-pB§;
      
      private var §_-Ty§:KeyboardCheck;
      
      private var §_-d§:String = "0";
      
      private var §_-UV§:§_-25§;
      
      public var fpsMonitor:§_-mM§;
      
      private var §_-fv§:Function = null;
      
      private var §_-o7§:Function = null;
      
      public function Blitz3Game()
      {
         super();
         Security.allowDomain("labs.test.vte.internal.popcap.com","labs.eric.popcap.com","labs.popcap.com","www.popcap.com","dl.labs.popcap.com");
         if(stage != null)
         {
            stage.frameRate = 64;
            this.Init();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.§_-Ma§);
         }
         var _loc1_:Rectangle = new Rectangle(0,0,§_-h8§,§_-GN§);
         scrollRect = _loc1_;
      }
      
      private function §_-pc§(param1:Event) : void
      {
         var _loc2_:Matrix = parent.transform.matrix;
         _loc2_.identity();
         _loc2_.translate(Math.random() * 2 - 1,Math.random() * 2 - 1);
         parent.transform.matrix = _loc2_;
      }
      
      public function §_-Kw§(param1:int) : void
      {
         §_-3A§ = param1;
      }
      
      private function ToggleDebugInfo(param1:Array = null) : void
      {
         this.fpsMonitor.visible = !this.fpsMonitor.visible;
      }
      
      private function §_-E3§(param1:Event) : void
      {
         §_-gN§.Show();
      }
      
      public function get §_-X3§() : String
      {
         return this.§_-d§;
      }
      
      public function §_-Pa§() : void
      {
         this.§_-Cf§ = true;
      }
      
      public function §_-2x§(param1:Function, param2:Function = null) : void
      {
         this.§_-fv§ = param1;
         this.§_-o7§ = param2;
         this.StartGame();
      }
      
      private function §_-DW§(param1:MouseEvent) : void
      {
         network.Refresh();
      }
      
      private function StartGame() : void
      {
         if(network.isOffline)
         {
            if(this.§_-fv§ != null)
            {
               this.§_-fv§();
               this.§_-fv§ = null;
               this.§_-o7§ = null;
            }
            return;
         }
         if(§_-3A§ < 0)
         {
            if(this.§_-Cf§)
            {
               §_-gN§.Show(§_-3A§,this.StartGame);
               §_-Qi§.playSound(Blitz3Sounds.SOUND_BUTTON_PRESS);
               network.BackupBoosts();
               this.§_-Cf§ = false;
            }
            else
            {
               this.§_-Cf§ = true;
               if(this.§_-o7§ != null)
               {
                  this.§_-o7§();
               }
            }
         }
         else
         {
            if(§_-cA§)
            {
               §_-Ba§.ShowNetworkWait();
               this.§_-n5§ = true;
               network.ForceServerSync();
               return;
            }
            if(this.§_-fv§ != null)
            {
               this.§_-fv§();
               this.§_-fv§ = null;
               this.§_-o7§ = null;
            }
         }
      }
      
      public function §_-ey§(param1:Dictionary) : void
      {
         var _loc2_:* = null;
         logic.boostLogic.ClearQueue();
         for(_loc2_ in param1)
         {
            logic.boostLogic.QueueBoost(_loc2_);
         }
      }
      
      private function §_-Ma§(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.§_-Ma§);
         this.Init();
      }
      
      public function §_-fX§() : void
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(0,0.5);
         _loc1_.graphics.drawRect(0,0,§_-h8§,§_-GN§);
         _loc1_.graphics.endFill();
         var _loc2_:Sprite = new Sprite();
         var _loc3_:TextFormat = new TextFormat();
         _loc3_.font = Blitz3Fonts.§_-Un§;
         _loc3_.size = 12;
         _loc3_.color = 16777215;
         _loc3_.align = TextFormatAlign.CENTER;
         _loc3_.bold = true;
         var _loc4_:§_-25§;
         (_loc4_ = new §_-25§(this)).§_-G0§.addChild(new §_-VA§());
         _loc4_.§_-5H§.addChild(new §_-Jv§());
         var _loc5_:Bitmap = new §_-ds§();
         var _loc6_:TextField;
         (_loc6_ = new TextField()).defaultTextFormat = _loc3_;
         _loc6_.embedFonts = true;
         _loc6_.text = §_-JC§.GetLocString("EC_SERVER_COMMUNICATION");
         _loc6_.textColor = 16777215;
         _loc6_.width = _loc5_.width - 30;
         _loc6_.height = 74;
         _loc6_.x = 16;
         _loc6_.y = 50;
         _loc6_.selectable = false;
         _loc6_.filters = [new GlowFilter(0,1,5,5,1,1,false,false)];
         _loc6_.multiline = true;
         _loc6_.wordWrap = true;
         _loc4_.x = _loc5_.width / 2 - _loc4_.width / 2;
         _loc4_.y = _loc5_.height - _loc4_.height - 8;
         _loc2_.addChild(_loc5_);
         _loc2_.addChild(_loc6_);
         _loc2_.addChild(_loc4_);
         _loc2_.x = §_-h8§ / 2 - _loc2_.width / 2;
         _loc2_.y = §_-GN§ / 2 - _loc2_.height / 2;
         _loc1_.addChild(_loc2_);
         addChild(_loc1_);
         _loc4_.addEventListener(MouseEvent.CLICK,this.§_-DW§);
         Stop();
         this.§_-UV§ = _loc4_;
      }
      
      public function §use§(param1:Dictionary) : void
      {
      }
      
      public function §_-M-§(param1:Boolean) : void
      {
      }
      
      private function §_-UN§(param1:KeyboardEvent) : void
      {
         if(this.§_-Ty§.§_-m6§(param1))
         {
            addEventListener(Event.ENTER_FRAME,this.§_-pc§);
         }
      }
      
      public function §_-2i§() : void
      {
         if(this.§_-n5§)
         {
            §_-Ba§.HideNetworkWait();
            §_-cA§ = false;
            this.§_-n5§ = false;
            if(this.§_-fv§ != null)
            {
               this.§_-fv§();
               this.§_-fv§ = null;
            }
         }
      }
      
      override public function Init() : void
      {
         var _loc1_:Object = stage.loaderInfo.parameters;
         §_-FC§ = new §_-lK§();
         §_-FC§.Init(_loc1_);
         network = new §_-Bw§(this);
         network.Init(_loc1_);
         network.AddHandler(this);
         §_-fV§ = Number(network.parameters.theHighScore);
         if(isNaN(§_-fV§))
         {
            §_-fV§ = 0;
         }
         §_-kP§("ToggleDebugInfo",this.ToggleDebugInfo);
         §_-QZ§ = new Blitz3Images();
         §_-Qi§ = new Blitz3Sounds();
         §_-SQ§ = new Blitz3Fonts();
         §_-JC§ = new Blitz3Localization();
         super.Init();
         §_-8d§ = new §_-67§(this);
         if(§_-FL§.GetFlag(§_-79§.§_-5E§,false))
         {
            §_-Qi§.mute();
         }
         §_-Ba§ = new §_-Nj§(this);
         §_-Ba§.Init();
         this.§_-M3§ = new §_-pB§(this);
         var _loc2_:§_-pA§ = new §_-pA§(true);
         _loc2_.§_-Vv§(new §_-4Y§("q".charCodeAt(0)));
         _loc2_.§_-Vv§(new §_-4Y§("u".charCodeAt(0)));
         _loc2_.§_-Vv§(new §_-4Y§("a".charCodeAt(0)));
         _loc2_.§_-Vv§(new §_-4Y§("k".charCodeAt(0)));
         _loc2_.§_-Vv§(new §_-4Y§("e".charCodeAt(0)));
         this.§_-Ty§ = _loc2_;
         stage.addEventListener(KeyboardEvent.KEY_UP,this.§_-UN§);
         addChild(§_-Ba§ as DisplayObject);
         §_-gN§ = new each(this);
         addChild(§_-gN§);
         §_-Ba§.boosts.addEventListener(§_-4I§,this.§_-E3§);
         this.fpsMonitor = new §_-mM§();
         this.fpsMonitor.visible = false;
         stage.addChild(this.fpsMonitor);
         this.fpsMonitor.§_-AN§();
         §_-AN§(this.§_-M3§);
         if(§_-CG§)
         {
            §_-gN§.Show(0,null,true);
         }
      }
      
      public function §_-Ae§(param1:int) : void
      {
      }
   }
}
