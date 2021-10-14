package §_-FX§
{
   import §_-4M§.§_-Ze§;
   import com.popcap.flash.framework.events.EventContext;
   import com.popcap.flash.framework.events.§_-3D§;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import com.popcap.flash.games.blitz3.ui.widgets.boosts.§_-7C§;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class §_-RG§ extends Sprite
   {
      
      public static const §_-7k§:int = 300;
      
      public static const §_-U8§:int = 50;
      
      private static const §_-TF§:Class = §_-BW§;
       
      
      private var §_-YD§:int = 0;
      
      private var §_-mP§:TextFormat;
      
      private var §_-DD§:int = 0;
      
      private var §_-Gt§:int = 0;
      
      private var §_-r§:int = -1;
      
      private var §_-YF§:int = 0;
      
      private var §_-SK§:Sprite;
      
      private var §_-P§:Sprite;
      
      private var §_-SE§:§_-7C§;
      
      private var mApp:§_-0Z§;
      
      private var §_-Ok§:int = 0;
      
      private var §break§:Bitmap;
      
      public function §_-RG§(param1:§_-0Z§)
      {
         super();
         this.mApp = param1;
         this.§break§ = new §_-TF§();
         this.§_-SE§ = new §_-7C§();
         this.§_-SK§ = new Sprite();
         this.§_-P§ = new Sprite();
         §_-3D§.§_-Tj§().§_-3T§("CoinTokenCollectAnimStartEvent",this.§_-MG§);
         §_-3D§.§_-Tj§().§_-3T§("CoinTokenCollectAnimCompleteEvent",this.§_-I8§);
      }
      
      public function Reset() : void
      {
         this.§_-r§ = this.mApp.§_-3A§;
         this.§_-YF§ = this.mApp.§_-3A§;
         this.§_-Ok§ = this.mApp.§_-3A§;
         var _loc1_:String = §_-Ze§.§_-2P§(this.§_-Ok§);
         this.§_-SE§.SetText(_loc1_);
         this.§_-YD§ = 0;
         this.§_-Gt§ = 0;
         this.§_-P§.x = -this.§break§.width * 2;
      }
      
      private function §_-bV§(param1:Number) : Number
      {
         return Math.sin(param1 * Math.PI * 0.5);
      }
      
      private function §_-I8§(param1:EventContext) : void
      {
         var _loc2_:int = this.§_-r§ + 100;
         if(this.§_-r§ != _loc2_)
         {
            this.§_-YF§ = this.§_-Ok§;
            this.§_-r§ = _loc2_;
            this.§_-DD§ = 0;
         }
      }
      
      public function Update() : void
      {
         var _loc3_:String = null;
         if(this.mApp.logic.isPaused)
         {
            return;
         }
         var _loc1_:Number = 0;
         if(this.§_-YD§ > 0)
         {
            --this.§_-YD§;
            ++this.§_-Gt§;
            this.§_-Gt§ = Math.min(this.§_-Gt§,§_-U8§);
            _loc1_ = this.§_-bV§(this.§_-Gt§ / §_-U8§);
            this.§_-P§.x = (1 - _loc1_) * (-this.§break§.width * 2);
         }
         else
         {
            --this.§_-Gt§;
            this.§_-Gt§ = Math.max(this.§_-Gt§,0);
            _loc1_ = this.§_-bV§(this.§_-Gt§ / §_-U8§);
            this.§_-P§.x = (1 - _loc1_) * (-this.§break§.width * 2);
         }
         var _loc2_:Boolean = false;
         if(this.§_-Ok§ < this.§_-r§)
         {
            ++this.§_-DD§;
            _loc1_ = this.§_-DD§ / §_-U8§;
            _loc1_ = _loc1_ > 1 ? Number(1) : Number(_loc1_);
            this.§_-Ok§ = (this.§_-r§ - this.§_-YF§) * _loc1_ + this.§_-YF§;
            _loc2_ = true;
         }
         else if(this.§_-Ok§ > this.§_-r§)
         {
            this.§_-Ok§ = this.§_-r§;
            _loc2_ = true;
         }
         if(_loc2_)
         {
            _loc3_ = §_-Ze§.§_-2P§(this.§_-Ok§);
            this.§_-SE§.SetText(_loc3_);
         }
      }
      
      public function Init() : void
      {
         cacheAsBitmap = true;
         this.§_-mP§ = new TextFormat();
         this.§_-mP§.font = Blitz3Fonts.§_-Un§;
         this.§_-mP§.size = 16;
         this.§_-mP§.align = TextFormatAlign.CENTER;
         this.§_-SE§.§_-NW§(this.§break§.width,26);
         this.§_-SE§.x = 0;
         this.§_-SE§.y = 22;
         this.§_-SE§.SetText("0");
         addChild(this.§_-P§);
         this.§_-P§.addChild(this.§_-SK§);
         this.§_-P§.x = -this.§break§.width * 2;
         this.§_-SK§.addChild(this.§break§);
         this.§_-SK§.addChild(this.§_-SE§);
         this.§_-SK§.x = -(this.§_-SK§.width / 2);
         this.§_-SK§.y = -(this.§_-SK§.height / 2);
      }
      
      private function §_-MG§(param1:EventContext) : void
      {
         this.§_-YD§ = §_-7k§;
      }
   }
}
