package §_-FX§
{
   import §_-4M§.§_-Ze§;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class §_-Od§ extends Sprite
   {
       
      
      private var mApp:Blitz3Game;
      
      private var §_-Wd§:int = -1;
      
      private var §_-Vj§:Boolean = false;
      
      private var §_-mP§:TextFormat;
      
      private var §_-O5§:Sprite;
      
      private var §_-al§:TextField;
      
      private var §_-Q§:Sprite;
      
      public function §_-Od§(param1:Blitz3Game)
      {
         super();
         this.mApp = param1;
      }
      
      public function Update() : void
      {
      }
      
      public function Init() : void
      {
         this.§_-Q§ = new Sprite();
         with(this.§_-Q§.graphics)
         {
            beginFill(0,0.01);
            drawRoundRect(0,0,110,46,8,8);
            endFill();
         }
         this.§_-Q§.x = -(this.§_-Q§.width / 2);
         this.§_-Q§.y = -(this.§_-Q§.height / 2);
         this.§_-mP§ = new TextFormat();
         this.§_-mP§.font = Blitz3Fonts.§_-Un§;
         this.§_-mP§.size = 10;
         this.§_-mP§.align = TextFormatAlign.CENTER;
         this.§_-al§ = new TextField();
         this.§_-al§.embedFonts = true;
         this.§_-al§.textColor = 16777215;
         this.§_-al§.defaultTextFormat = this.§_-mP§;
         this.§_-al§.width = this.§_-Q§.width;
         this.§_-al§.height = 100;
         this.§_-al§.x = 0;
         this.§_-al§.y = 0;
         this.§_-al§.filters = [new GlowFilter(0)];
         this.§_-al§.selectable = false;
         addChild(this.§_-Q§);
         addChild(this.§_-al§);
         this.Reset();
         this.§_-Vj§ = true;
      }
      
      public function Draw() : void
      {
      }
      
      public function Reset() : void
      {
         var _loc2_:* = null;
         var _loc1_:int = this.mApp.§_-fV§;
         if(_loc1_ > this.§_-Wd§)
         {
            this.§_-Wd§ = _loc1_;
            _loc2_ = "HIGH SCORE";
            if(this.mApp.network.isOffline)
            {
               _loc2_ += "\nFOR THIS SESSION";
               this.§_-mP§.size = 10;
               this.§_-al§.defaultTextFormat = this.§_-mP§;
            }
            else
            {
               this.§_-mP§.size = 12;
               this.§_-al§.defaultTextFormat = this.§_-mP§;
            }
            _loc2_ += "\n" + §_-Ze§.§_-2P§(this.§_-Wd§);
            this.§_-al§.text = _loc2_;
            this.§_-al§.x = -(this.§_-al§.width / 2);
            this.§_-al§.y = -(this.§_-al§.textHeight / 2);
         }
      }
   }
}
