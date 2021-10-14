package §_-GT§
{
   import §_-4M§.§_-Ze§;
   import com.popcap.flash.games.bej3.blitz.IBlitz3NetworkHandler;
   import com.popcap.flash.games.blitz3.ui.sprites.§_-6K§;
   import com.popcap.flash.games.blitz3.ui.sprites.§_-Vw§;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.utils.Dictionary;
   
   public class §_-XQ§ extends Sprite implements IBlitz3NetworkHandler
   {
      
      private static const §_-0a§:Class = §_-At§;
      
      private static const §_-Ye§:Class = §_-dA§;
      
      private static const §_-ds§:Class = §_-FD§;
      
      private static const §_-8F§:Class = §_-03§;
      
      private static const §_-3x§:Class = §_-ZF§;
      
      private static const §_-TN§:Class = §_-Qs§;
      
      private static const §_-2N§:Class = §_-eq§;
       
      
      protected var §_-hJ§:§_-6K§;
      
      protected var §_-Om§:TextField;
      
      protected var §_-Pr§:DisplayObject;
      
      protected var §_-07§:Dictionary;
      
      protected var §_-Vh§:DisplayObject;
      
      protected var §_-k§:TextField;
      
      protected var §_-Lp§:Blitz3Game;
      
      protected var §_-AD§:§_-Vw§;
      
      protected var §_-O2§:DisplayObject;
      
      public function §_-XQ§(param1:Blitz3Game)
      {
         super();
         this.§_-Lp§ = param1;
         var _loc2_:Array = [new GlowFilter(0,1,2,2,4,1,false,false)];
         this.§_-Vh§ = new §_-ds§();
         this.§_-hJ§ = new §_-6K§(param1);
         this.§_-hJ§.SetText(this.§_-Lp§.§_-JC§.GetLocString("RG_BTN_ACCEPT"));
         this.§_-hJ§.addEventListener(MouseEvent.CLICK,this.§_-76§);
         this.§_-AD§ = new §_-Vw§(param1);
         this.§_-AD§.SetText(this.§_-Lp§.§_-JC§.GetLocString("RG_BTN_DECLINE"));
         this.§_-AD§.addEventListener(MouseEvent.CLICK,this.§_-Fw§);
         this.§_-Pr§ = new §_-TN§();
         this.§_-O2§ = new §_-2N§();
         this.§_-Om§ = new TextField();
         this.§_-Om§.defaultTextFormat = new TextFormat(Blitz3Fonts.§_-Un§,14,16777215);
         this.§_-Om§.defaultTextFormat.align = TextFormatAlign.CENTER;
         this.§_-Om§.selectable = false;
         this.§_-Om§.mouseEnabled = false;
         this.§_-Om§.embedFonts = true;
         this.§_-Om§.multiline = false;
         this.§_-Om§.autoSize = TextFieldAutoSize.CENTER;
         this.§_-Om§.htmlText = this.§_-Lp§.§_-JC§.GetLocString("RG_TITLE");
         this.§_-Om§.filters = _loc2_;
         this.§_-Om§.cacheAsBitmap = true;
         this.§_-k§ = new TextField();
         this.§_-k§.defaultTextFormat = new TextFormat(Blitz3Fonts.§_-Un§,12,16777215);
         this.§_-k§.defaultTextFormat.align = TextFormatAlign.CENTER;
         this.§_-k§.selectable = false;
         this.§_-k§.mouseEnabled = false;
         this.§_-k§.embedFonts = true;
         this.§_-k§.multiline = true;
         this.§_-k§.wordWrap = true;
         this.§_-k§.autoSize = TextFieldAutoSize.CENTER;
         this.§_-k§.htmlText = this.§_-Lp§.§_-JC§.GetLocString("RG_COPY_MOONSTONE");
         this.§_-k§.width = 504 * 0.65;
         this.§_-k§.filters = _loc2_;
         this.§_-k§.cacheAsBitmap = true;
         this.§_-Lp§.network.AddHandler(this);
      }
      
      public function §_-M-§(param1:Boolean) : void
      {
      }
      
      protected function §_-Fw§(param1:MouseEvent) : void
      {
         this.§_-Lp§.§_-o3§.OnRareGemAwarded(false);
         this.§_-hJ§.visible = false;
         this.§_-AD§.visible = false;
         this.§_-Lp§.§_-Ba§.stats.playAgainButton.SetEnabled(true);
         this.§_-k§.htmlText = this.§_-Lp§.§_-JC§.GetLocString("RG_COPY_MOONSTONE_DECLINE");
         this.§_-Om§.htmlText = this.§_-Lp§.§_-JC§.GetLocString("RG_TITLE_DECLINE");
         this.§_-5V§();
      }
      
      public function §_-Kw§(param1:int) : void
      {
      }
      
      public function §_-ey§(param1:Dictionary) : void
      {
      }
      
      protected function §_-76§(param1:MouseEvent) : void
      {
         this.§_-Lp§.§_-o3§.OnRareGemAwarded(true);
         this.§_-hJ§.visible = false;
         this.§_-AD§.visible = false;
         this.§_-Lp§.§_-Ba§.stats.playAgainButton.SetEnabled(true);
         this.§_-k§.htmlText = this.§_-Lp§.§_-JC§.GetLocString("RG_COPY_MOONSTONE_ACCEPT");
         this.§_-Om§.htmlText = this.§_-Lp§.§_-JC§.GetLocString("RG_TITLE_ACCEPT");
         this.§_-5V§();
         this.§_-Lp§.§_-Qi§.playSound(Blitz3Sounds.SOUND_RG_MOONSTONE_HARVEST);
      }
      
      public function §use§(param1:Dictionary) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         this.§_-07§ = new Dictionary();
         for(_loc2_ in param1)
         {
            _loc3_ = this.§_-Lp§.logic.boostLogic.GetBoostOrderingIDFromStringID(_loc2_);
            this.§_-07§[_loc2_] = param1[_loc2_];
         }
      }
      
      public function Show() : void
      {
         visible = true;
         this.§_-Lp§.§_-Ba§.stats.playAgainButton.SetEnabled(false);
         var _loc1_:String = this.§_-Lp§.§_-JC§.GetLocString("RG_BTN_ACCEPT");
         _loc1_ = _loc1_.replace("%s",§_-Ze§.§_-2P§(this.§_-07§["Moonstone"]));
         this.§_-hJ§.SetText(_loc1_);
         this.§_-hJ§.x = 335 - this.§_-hJ§.width * 0.5;
         this.§_-Lp§.§_-Qi§.playSound(Blitz3Sounds.SOUND_RG_MOONSTONE_APPEAR);
      }
      
      public function §_-2i§() : void
      {
      }
      
      public function §_-fX§() : void
      {
      }
      
      public function Reset() : void
      {
         visible = false;
         this.§_-k§.htmlText = this.§_-Lp§.§_-JC§.GetLocString("RG_COPY_MOONSTONE");
         this.§_-Om§.htmlText = this.§_-Lp§.§_-JC§.GetLocString("RG_TITLE");
         this.§_-hJ§.visible = true;
         this.§_-AD§.visible = true;
         this.§_-hJ§.Reset();
         this.§_-AD§.Reset();
         this.§_-5V§();
      }
      
      public function §_-Ae§(param1:int) : void
      {
      }
      
      protected function §_-5V§() : void
      {
         this.§_-Om§.x = 335 - this.§_-Om§.width * 0.5;
         this.§_-Om§.y = 2;
         this.§_-k§.x = 335 - this.§_-k§.width * 0.5;
         var _loc1_:Number = this.§_-Vh§.height - 25;
         if(this.§_-AD§.visible)
         {
            _loc1_ = this.§_-AD§.y;
         }
         if(this.§_-hJ§.visible)
         {
            _loc1_ = this.§_-hJ§.y;
         }
         _loc1_ -= this.§_-O2§.y + this.§_-O2§.height;
         this.§_-k§.y = this.§_-O2§.y + this.§_-O2§.height + _loc1_ * 0.5 - this.§_-k§.height * 0.5;
      }
      
      public function Init() : void
      {
         addChild(this.§_-Vh§);
         addChild(this.§_-Pr§);
         addChild(this.§_-O2§);
         addChild(this.§_-Om§);
         addChild(this.§_-k§);
         addChild(this.§_-hJ§);
         addChild(this.§_-AD§);
         this.§_-hJ§.Init();
         this.§_-AD§.Init();
         this.§_-Vh§.y = -3;
         this.§_-hJ§.§_-GD§(335,130);
         this.§_-AD§.§_-GD§(335,143 + this.§_-hJ§.height * 0.5);
         this.§_-Pr§.x = 504 * 0.175 - this.§_-Pr§.width * 0.5;
         this.§_-Pr§.y = 188 * 0.5 - this.§_-Pr§.height * 0.5;
         this.§_-O2§.x = 335 - this.§_-O2§.width * 0.5;
         this.§_-O2§.y = 188 * 0.23 - this.§_-O2§.height * 0.5;
         this.§_-5V§();
         this.Reset();
      }
   }
}
