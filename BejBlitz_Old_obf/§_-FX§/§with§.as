package §_-FX§
{
   import §_-4M§.§_-Ze§;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class §with§ extends Sprite
   {
      
      public static const §_-U8§:int = 50;
       
      
      private var §_-2w§:int = 0;
      
      private var §_-1a§:int = 0;
      
      private var §_-Vj§:Boolean = false;
      
      private var §_-Gn§:int = 0;
      
      private var §_-p8§:TextField;
      
      private var §_-dQ§:Bitmap;
      
      private var §_-Dp§:int = -1;
      
      private var mApp:§_-0Z§;
      
      private var §_-L2§:int = 0;
      
      private var §_-aI§:TextField;
      
      private var §_-YY§:GlowFilter;
      
      public function §with§(param1:§_-0Z§)
      {
         this.§_-YY§ = new GlowFilter(0);
         super();
         this.mApp = param1;
      }
      
      public function Update() : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:String = null;
         if(this.mApp.logic.isPaused)
         {
            return;
         }
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:int = this.mApp.logic.GetScore();
         if(this.§_-Dp§ != _loc3_)
         {
            this.§_-L2§ = this.§_-2w§;
            this.§_-Dp§ = _loc3_;
            this.§_-Gn§ = 0;
         }
         if(this.§_-2w§ < this.§_-Dp§)
         {
            ++this.§_-Gn§;
            _loc4_ = (_loc4_ = Number(this.§_-Gn§ / §_-U8§)) > 1 ? Number(1) : Number(_loc4_);
            this.§_-2w§ = (this.§_-Dp§ - this.§_-L2§) * _loc4_ + this.§_-L2§;
            _loc1_ = true;
         }
         else if(this.§_-2w§ > this.§_-Dp§)
         {
            this.§_-2w§ = this.§_-Dp§;
            _loc1_ = true;
         }
         if(this.§_-1a§ != this.mApp.logic.coinTokenLogic.§_-hA§)
         {
            this.§_-1a§ = this.mApp.logic.coinTokenLogic.§_-hA§;
            _loc2_ = true;
         }
         if(_loc1_)
         {
            _loc5_ = §_-Ze§.§_-2P§(this.§_-2w§);
            this.§_-aI§.text = _loc5_;
         }
         if(_loc2_)
         {
            this.§_-p8§.text = "x" + this.§_-1a§;
            this.§_-p8§.visible = this.§_-1a§ > 0;
         }
      }
      
      public function Draw() : void
      {
      }
      
      public function Reset() : void
      {
         this.§_-Dp§ = -1;
         this.§_-2w§ = 0;
         this.§_-L2§ = 0;
         this.§_-Gn§ = 0;
         this.§_-1a§ = 0;
         this.§_-aI§.text = "0";
         this.§_-p8§.text = "x1";
      }
      
      public function Init() : void
      {
         this.§_-dQ§ = new Bitmap(this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_UI_SCORE));
         this.§_-dQ§.smoothing = true;
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.font = Blitz3Fonts.§_-Un§;
         _loc1_.size = 16;
         _loc1_.align = TextFormatAlign.CENTER;
         this.§_-aI§ = new TextField();
         this.§_-aI§.embedFonts = true;
         this.§_-aI§.textColor = 16777215;
         this.§_-aI§.defaultTextFormat = _loc1_;
         this.§_-aI§.filters = [this.§_-YY§];
         this.§_-aI§.selectable = false;
         this.§_-aI§.x = 8;
         this.§_-aI§.y = 5;
         this.§_-aI§.width = 106;
         this.§_-aI§.height = 24;
         this.§_-p8§ = new TextField();
         this.§_-p8§.embedFonts = true;
         this.§_-p8§.textColor = 16777215;
         this.§_-p8§.defaultTextFormat = _loc1_;
         this.§_-p8§.filters = [this.§_-YY§];
         this.§_-p8§.selectable = false;
         this.§_-p8§.x = 44;
         this.§_-p8§.y = 33;
         this.§_-p8§.width = 32;
         this.§_-p8§.height = 22;
         addChild(this.§_-dQ§);
         addChild(this.§_-aI§);
         addChild(this.§_-p8§);
         this.Reset();
         this.§_-Vj§ = true;
      }
   }
}
