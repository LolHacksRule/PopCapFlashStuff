package §_-P2§
{
   import §_-Xk§.§_-PP§;
   import §_-Xk§.§_-jm§;
   import §_-Xk§.§_-l3§;
   import com.popcap.flash.games.bej3.Gem;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class §_-IQ§ extends Sprite
   {
      
      public static const §_-mO§:Number = -0.2;
      
      private static const §_-Az§:§_-l3§ = new §_-l3§();
      
      private static const §_-KC§:§_-l3§ = new §_-l3§();
      
      private static const §_-g6§:§_-l3§ = new §_-l3§();
      
      {
         §_-KC§.§_-2m§ = Vector.<int>([255,192,255,0,0,255,255]);
         §_-g6§.§_-2m§ = Vector.<int>([0,96,255,255,0,0,255]);
         §_-Az§.§_-2m§ = Vector.<int>([0,0,0,0,255,255,255]);
      }
      
      private var §_-cJ§:int = 0;
      
      private var §_-9l§:int = 0;
      
      public var scale:Number = 1.0;
      
      private var §_-Hp§:Number = 1.0;
      
      private var §_-Gs§:Number = 1.0;
      
      private var §_-WU§:§_-jm§ = null;
      
      private var §_-VQ§:Boolean = false;
      
      private var §_-bP§:GlowFilter;
      
      private var §_-js§:Number = 0.0;
      
      private var §_-Ck§:Number = 0;
      
      private var §_-0I§:§_-jm§ = null;
      
      private var §_-bC§:§_-jm§ = null;
      
      private var §_-al§:TextField;
      
      public function §_-IQ§()
      {
         super();
         mouseEnabled = false;
         this.§_-0I§ = new §_-PP§();
         this.§_-bC§ = new §_-PP§();
         this.§_-WU§ = new §_-PP§();
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.font = Blitz3Fonts.§_-Un§;
         _loc1_.size = 20;
         _loc1_.align = TextFormatAlign.CENTER;
         this.§_-bP§ = new GlowFilter(0,1,3,3,10,2,false,true);
         this.§_-al§ = new TextField();
         this.§_-al§.embedFonts = true;
         this.§_-al§.textColor = 16777215;
         this.§_-al§.defaultTextFormat = _loc1_;
         this.§_-al§.width = 100;
         this.§_-al§.height = 24;
         this.§_-al§.x = -(this.§_-al§.width / 2);
         this.§_-al§.y = -(this.§_-al§.height / 2) - 4;
         this.§_-js§ = Math.random() * §_-mO§;
         this.§_-Ck§ = Math.random() * 100;
         addChild(this.§_-al§);
         cacheAsBitmap = true;
      }
      
      public function §_-Rs§(param1:int, param2:Boolean = false) : void
      {
         this.§_-VQ§ = param2;
         switch(param1)
         {
            case Gem.§_-Y7§:
               this.§_-0I§.§_-0g§(255,192);
               this.§_-bC§.§_-0g§(64,0);
               this.§_-WU§.§_-0g§(64,0);
               this.§_-Ck§ = 0 / 7;
               break;
            case Gem.§_-md§:
               this.§_-0I§.§_-0g§(255,192);
               this.§_-bC§.§_-0g§(160,96);
               this.§_-WU§.§_-0g§(64,0);
               this.§_-Ck§ = 1 / 7;
               break;
            case Gem.§_-AH§:
               this.§_-0I§.§_-0g§(255,192);
               this.§_-bC§.§_-0g§(255,192);
               this.§_-WU§.§_-0g§(64,0);
               this.§_-Ck§ = 2 / 7;
               break;
            case Gem.§_-Zz§:
               this.§_-0I§.§_-0g§(64,0);
               this.§_-bC§.§_-0g§(255,192);
               this.§_-WU§.§_-0g§(64,0);
               this.§_-Ck§ = 3 / 7;
               break;
            case Gem.§ use§:
               this.§_-0I§.§_-0g§(64,0);
               this.§_-bC§.§_-0g§(160,96);
               this.§_-WU§.§_-0g§(255,192);
               this.§_-Ck§ = 4 / 7;
               break;
            case Gem.§_-70§:
               this.§_-0I§.§_-0g§(255,192);
               this.§_-bC§.§_-0g§(64,0);
               this.§_-WU§.§_-0g§(255,192);
               this.§_-Ck§ = 5 / 7;
               break;
            case Gem.§_-8M§:
               this.§_-0I§.§_-0g§(255,192);
               this.§_-bC§.§_-0g§(255,192);
               this.§_-WU§.§_-0g§(255,192);
               this.§_-Ck§ = 6 / 7;
               break;
            default:
               this.§_-0I§.§_-0g§(255,192);
               this.§_-bC§.§_-0g§(255,192);
               this.§_-WU§.§_-0g§(255,192);
               this.§_-Ck§ = 7 / 7;
         }
         if(param2)
         {
            this.§_-0I§ = §_-KC§;
            this.§_-bC§ = §_-g6§;
            this.§_-WU§ = §_-Az§;
         }
         this.§_-al§.textColor = 16777215;
         this.§_-bP§.color = this.§_-b2§(0);
         filters = [this.§_-bP§];
      }
      
      private function §_-b2§(param1:Number) : int
      {
         if(this.§_-VQ§)
         {
            return int(§_-KC§.getOutValue(param1)) << 16 | int(§_-g6§.getOutValue(param1)) << 8 | int(§_-Az§.getOutValue(param1)) << 0;
         }
         return 0 | int(this.§_-0I§.getOutValue(param1)) << 16 | int(this.§_-bC§.getOutValue(param1)) << 8 | int(this.§_-WU§.getOutValue(param1)) << 0;
      }
      
      public function §_-0n§(param1:int) : void
      {
         this.§_-cJ§ = param1;
         this.§_-al§.text = this.§_-cJ§.toString();
      }
      
      public function §_-bg§() : int
      {
         return this.§_-cJ§;
      }
      
      public function §_-GI§(param1:int) : void
      {
         this.§_-9l§ = param1;
      }
      
      public function Update() : void
      {
         if(this.§_-9l§ == 0)
         {
            return;
         }
         var _loc1_:Number = 0;
         var _loc2_:Number = 0;
         if(this.§_-VQ§)
         {
            _loc1_ = 1 - this.§_-9l§ / 50 % 1;
            _loc2_ = (_loc1_ + this.§_-Ck§) % 1;
            this.§_-bP§.color = this.§_-b2§(_loc2_);
            filters = [this.§_-bP§];
         }
         else
         {
            _loc1_ = (this.§_-9l§ + this.§_-Ck§) / 50;
            _loc2_ = Math.abs(Math.sin(_loc1_ * Math.PI));
            this.§_-bP§.color = this.§_-b2§(_loc2_);
            filters = [this.§_-bP§];
         }
         if(this.§_-9l§ > 0)
         {
            --this.§_-9l§;
         }
         if(this.§_-9l§ < 25)
         {
            this.§_-Gs§ = this.§_-9l§ / 25;
         }
         else
         {
            this.§_-Gs§ = 1;
         }
         this.§_-Hp§ = 1;
         if(this.§_-VQ§)
         {
            this.§_-Hp§ += 0.2;
         }
         var _loc3_:Number = this.§_-Gs§ * this.§_-Hp§;
         scaleX = _loc3_;
         scaleY = _loc3_;
         y += §_-mO§ + this.§_-js§;
         if(this.§_-VQ§)
         {
            y += §_-mO§;
         }
      }
   }
}
