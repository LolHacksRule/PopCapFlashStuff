package §_-FX§
{
   import com.popcap.flash.framework.resources.images.§_-ex§;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class §_-HU§ extends Sprite
   {
       
      
      private var §_-Vj§:Boolean = false;
      
      private var §_-ct§:Boolean;
      
      private var §_-Co§:int;
      
      private var §_-nr§:Sprite;
      
      private var §_-HH§:TextField;
      
      private var §_-MT§:TextField;
      
      private var §_-77§:Bitmap;
      
      private var §_-Gn§:int;
      
      private var §_-Tu§:Bitmap;
      
      private var §_-CF§:Sprite;
      
      private var mApp:Blitz3Game;
      
      private var §_-ok§:Sprite;
      
      public function §_-HU§(param1:Blitz3Game)
      {
         super();
         this.mApp = param1;
      }
      
      private function §_-gf§(param1:int, param2:int, param3:int, param4:Number, param5:Number) : Number
      {
         var _loc6_:Number = param3 - param1;
         var _loc7_:Number = param2 - param1;
         var _loc8_:Number = _loc6_ / _loc7_;
         return Number(param4 + (param5 - param4) * _loc8_);
      }
      
      public function §_-F-§(param1:int, param2:Boolean) : void
      {
         this.§_-Gn§ = 0;
         var _loc3_:BitmapData = this.mApp.§_-8d§.GetMedal(param1);
         this.§_-77§.bitmapData = _loc3_;
         this.§_-77§.x = -(this.§_-77§.width / 2);
         this.§_-77§.y = -(this.§_-77§.height / 2);
         this.§_-77§.smoothing = true;
         this.§_-MT§.text = param2 == true ? this.mApp.§_-JC§.GetLocString("UI_NEW_MEDAL") : "";
         var _loc4_:int = this.mApp.§_-8d§.GetNextThreshold(param1);
         this.§_-HH§.text = _loc4_ < param1 ? this.mApp.§_-JC§.GetLocString("UI_TOP_MEDAL") : this.mApp.§_-JC§.GetLocString("UI_NEXT_MEDAL") + _loc4_ / 1000 + this.mApp.§_-JC§.GetLocString("UI_THOUSANDS");
      }
      
      public function Draw() : void
      {
      }
      
      public function Update() : void
      {
         var _loc3_:* = false;
         if(this.mApp.logic.isPaused)
         {
            return;
         }
         var _loc1_:int = this.mApp.logic.scoreKeeper.score;
         if(_loc1_ >= this.§_-Co§ && this.§_-Co§ > 0)
         {
            _loc3_ = _loc1_ > this.mApp.§_-fV§;
            this.§_-F-§(_loc1_,_loc3_);
            this.§_-Co§ = this.mApp.§_-8d§.GetNextThreshold(_loc1_);
            alpha = 1;
            visible = true;
         }
         if(!visible)
         {
            return;
         }
         ++this.§_-Gn§;
         if(this.§_-Gn§ <= 4 * 4 && this.§_-Gn§ >= 0)
         {
            this.§_-CF§.scaleX = this.§_-gf§(1,4 * 4,this.§_-Gn§,2,1);
            this.§_-CF§.scaleY = this.§_-gf§(1,4 * 4,this.§_-Gn§,0.1,1);
         }
         else if(this.§_-Gn§ <= 8 * 4 && this.§_-Gn§ > 4 * 4)
         {
            this.§_-CF§.scaleX = this.§_-gf§(4 * 4 + 1,8 * 4,this.§_-Gn§,1,0.8);
            this.§_-CF§.scaleY = this.§_-gf§(4 * 4 + 1,8 * 4,this.§_-Gn§,1,1.35);
         }
         else if(this.§_-Gn§ <= 12 * 4 && this.§_-Gn§ > 8 * 4)
         {
            this.§_-CF§.scaleX = this.§_-gf§(8 * 4 + 1,12 * 4,this.§_-Gn§,0.8,1);
            this.§_-CF§.scaleY = this.§_-gf§(8 * 4 + 1,12 * 4,this.§_-Gn§,1.35,1);
         }
         else
         {
            this.§_-CF§.scaleX = 1;
            this.§_-CF§.scaleY = 1;
         }
         if(this.§_-Gn§ <= 48)
         {
            this.§_-HH§.alpha = this.§_-gf§(1,48,this.§_-Gn§,0,1);
         }
         else
         {
            this.§_-HH§.alpha = 1;
         }
         if(this.§_-Gn§ <= 12 * 4 && this.§_-Gn§ > 4 * 4)
         {
            this.§_-ok§.scaleX = this.§_-gf§(4 * 4 + 1,12 * 4,this.§_-Gn§,0,1.25);
            this.§_-ok§.scaleY = this.§_-gf§(4 * 4 + 1,12 * 4,this.§_-Gn§,0,1.25);
         }
         if(this.§_-Gn§ <= 48 * 4 && this.§_-Gn§ > 4 * 4)
         {
            this.§_-MT§.x = this.§_-gf§(4 * 4 + 1,48 * 4,this.§_-Gn§,100,-110);
         }
         if(this.§_-Gn§ >= 300 && this.§_-Gn§ < 500)
         {
            alpha = this.§_-gf§(300,499,this.§_-Gn§,1,0);
            if(alpha <= 0)
            {
               visible = false;
            }
         }
         if(this.§_-Gn§ >= 500)
         {
         }
      }
      
      public function Init() : void
      {
         var _loc3_:GlowFilter = null;
         this.§_-Co§ = this.mApp.§_-8d§.GetNextThreshold(0);
         var _loc1_:§_-ex§ = this.mApp.§_-QZ§;
         this.§_-CF§ = new Sprite();
         this.§_-77§ = new Bitmap();
         this.§_-CF§.x = 50;
         this.§_-CF§.y = 50;
         this.§_-CF§.addChild(this.§_-77§);
         this.§_-ok§ = new Sprite();
         this.§_-Tu§ = new Bitmap(_loc1_.getBitmapData(Blitz3Images.IMAGE_STARMEDAL_RAYS));
         this.§_-Tu§.x = -(this.§_-Tu§.width / 2);
         this.§_-Tu§.y = -(this.§_-Tu§.height / 2);
         this.§_-Tu§.smoothing = true;
         this.§_-ok§.addChild(this.§_-Tu§);
         this.§_-ok§.x = 50;
         this.§_-ok§.y = 50;
         this.§_-ok§.scaleX = 1;
         this.§_-ok§.scaleY = 1;
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.font = Blitz3Fonts.§_-Un§;
         _loc2_.size = 18;
         _loc2_.align = TextFormatAlign.CENTER;
         _loc3_ = new GlowFilter(0,1,2,2,200);
         this.§_-HH§ = new TextField();
         this.§_-HH§.embedFonts = true;
         this.§_-HH§.textColor = 16777215;
         this.§_-HH§.defaultTextFormat = _loc2_;
         this.§_-HH§.filters = [_loc3_];
         this.§_-HH§.width = 120;
         this.§_-HH§.height = 50;
         this.§_-HH§.x = -5;
         this.§_-HH§.y = 88;
         this.§_-HH§.alpha = 1;
         this.§_-HH§.selectable = false;
         this.§_-MT§ = new TextField();
         this.§_-MT§.embedFonts = true;
         this.§_-MT§.textColor = 16777215;
         this.§_-MT§.defaultTextFormat = _loc2_;
         this.§_-MT§.filters = [_loc3_];
         this.§_-MT§.width = 120;
         this.§_-MT§.height = 50;
         this.§_-MT§.x = 100;
         this.§_-MT§.y = 30;
         this.§_-MT§.selectable = false;
         this.§_-nr§ = new Sprite();
         this.§_-nr§.graphics.beginFill(0);
         this.§_-nr§.graphics.drawRect(0,0,90,60);
         this.§_-nr§.graphics.endFill();
         this.§_-nr§.x = 5;
         addChild(this.§_-HH§);
         addChild(this.§_-ok§);
         addChild(this.§_-CF§);
         addChild(this.§_-MT§);
         addChild(this.§_-nr§);
         this.§_-MT§.mask = this.§_-nr§;
         this.Reset();
         this.§_-Vj§ = true;
      }
      
      public function Reset() : void
      {
         visible = false;
         this.§_-ct§ = false;
         this.§_-Co§ = this.mApp.§_-8d§.GetNextThreshold(0);
      }
   }
}
