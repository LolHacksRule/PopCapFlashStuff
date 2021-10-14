package §_-4M§
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.getTimer;
   
   public class §_-mM§ extends Sprite
   {
      
      private static const §_-GS§:uint = 4278223103;
      
      private static const §_-IP§:int = 100;
      
      private static const §_-H0§:int = 100;
      
      private static const §_-IT§:uint = 4278190080;
      
      private static const §_-2§:uint = 4278255360;
      
      private static const §_-2Q§:uint = 4294901760;
      
      private static const §_-0t§:uint = 4294902015;
       
      
      private var §_-87§:int = 0;
      
      private var §_-o8§:int = 0;
      
      private var §_-3L§:int = 0;
      
      private var §_-2k§:TextField;
      
      private var §_-TG§:Number;
      
      private var §_-BZ§:int;
      
      private var §_-2J§:int = 0;
      
      private var §_-Gn§:int;
      
      private var §_-h5§:int;
      
      private var §_-Qb§:int = 0;
      
      private var §_-Aq§:int;
      
      private var §_-oV§:Bitmap;
      
      private var §_-8H§:Array;
      
      private var §_-64§:Number;
      
      private var §_-n2§:BitmapData;
      
      private var §_-nG§:int = 0;
      
      private var §_-Fg§:Number;
      
      private var §_-RJ§:Array;
      
      public function §_-mM§()
      {
         this.§_-8H§ = [];
         this.§_-RJ§ = [];
         super();
         this.§_-ls§();
      }
      
      private function §_-ls§() : void
      {
         this.§_-n2§ = new BitmapData(§_-IP§,§_-H0§,true,§_-IT§);
         this.§_-oV§ = new Bitmap(this.§_-n2§);
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.color = 4294967295;
         _loc1_.font = "Verdana";
         _loc1_.size = 10;
         _loc1_.bold = true;
         this.§_-2k§ = new TextField();
         this.§_-2k§.defaultTextFormat = _loc1_;
         this.§_-2k§.autoSize = "left";
         this.§_-2k§.selectable = false;
         addChild(this.§_-oV§);
         addChild(this.§_-2k§);
      }
      
      public function GetAverageFPS() : int
      {
         return this.§_-nG§ / this.§_-2J§;
      }
      
      private function §_-pc§(param1:Event) : void
      {
         var _loc2_:int = getTimer();
         var _loc3_:int = _loc2_ - this.§_-BZ§;
         this.§_-h5§ += _loc3_;
         this.§_-h5§ -= int(this.§_-8H§[this.§_-Aq§]);
         this.§_-8H§[this.§_-Aq§] = _loc3_;
         var _loc4_:Number = this.§_-8H§.length * (1000 / this.§_-h5§);
         var _loc5_:Number = this.§_-h5§ / this.§_-8H§.length;
         this.§_-Aq§ = (this.§_-Aq§ + 1) % this.§_-Qb§;
         ++this.§_-64§;
         this.§_-Gn§ += _loc3_;
         while(this.§_-Gn§ >= 1000)
         {
            this.§_-nG§ += this.§_-64§;
            this.§_-2J§ += 1;
            this.§_-o8§ = Math.max(this.§_-64§,this.§_-o8§);
            this.§_-3L§ = Math.min(this.§_-64§,this.§_-3L§);
            this.§_-Fg§ = this.§_-64§;
            this.§_-64§ = 0;
            this.§_-Gn§ -= 1000;
            this.§_-TG§ = this.§_-Fg§;
         }
         if(visible)
         {
            this.§_-n2§.scroll(1,0);
            this.§_-n2§.setPixel32(1,this.§_-VI§(this.§_-Fg§,this.§_-Qb§),§_-0t§);
            this.§_-n2§.setPixel32(1,this.§_-VI§(_loc3_,this.§_-87§ << 3),§_-GS§);
            this.§_-n2§.setPixel32(1,this.§_-VI§(_loc4_,this.§_-Qb§),§_-2Q§);
            this.§_-n2§.setPixel32(1,this.§_-VI§(_loc5_,this.§_-87§ << 3),§_-2§);
            this.§_-2k§.text = "FPS: " + this.§_-Fg§;
         }
         this.§_-BZ§ = getTimer();
      }
      
      public function §_-AN§() : void
      {
         this.§_-Qb§ = Math.min(120,stage.frameRate);
         this.§_-87§ = 1000 / this.§_-Qb§;
         this.§_-8H§.length = 0;
         this.§_-RJ§.length = 0;
         this.§_-Aq§ = 0;
         this.§_-BZ§ = getTimer();
         this.§_-Gn§ = 0;
         this.§_-h5§ = 0;
         this.§_-TG§ = 0;
         this.§_-Fg§ = 0;
         this.§_-64§ = 0;
         this.§_-dK§();
         addEventListener(Event.ENTER_FRAME,this.§_-pc§);
      }
      
      public function GetFPSHigh() : int
      {
         return this.§_-o8§;
      }
      
      public function §_-dK§() : void
      {
         this.§_-nG§ = 0;
         this.§_-2J§ = 0;
         this.§_-o8§ = int.MIN_VALUE;
         this.§_-3L§ = int.MAX_VALUE;
      }
      
      public function GetFPSLow() : int
      {
         return this.§_-3L§;
      }
      
      public function Stop() : void
      {
         if(hasEventListener(Event.ENTER_FRAME))
         {
            removeEventListener(Event.ENTER_FRAME,this.§_-pc§);
         }
      }
      
      private function §_-VI§(param1:Number, param2:Number) : int
      {
         var _loc3_:int = Math.min(param2,Math.max(0,param1));
         _loc3_ = _loc3_ / param2 * §_-H0§;
         return §_-H0§ - _loc3_;
      }
   }
}
