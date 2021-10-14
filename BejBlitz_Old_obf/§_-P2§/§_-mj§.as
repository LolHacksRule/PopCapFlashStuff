package §_-P2§
{
   import com.popcap.flash.framework.resources.images.§_-ex§;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   
   public class §_-mj§ extends Sprite
   {
      
      private static const §_-R4§:int = 60;
      
      private static const §_-cd§:int = 0;
      
      private static const §catch§:int = 100;
      
      private static const §_-9P§:int = 1500;
       
      
      private var §_-EQ§:int = 0;
      
      private var §_-Vj§:Boolean = false;
      
      private var §_-G7§:Bitmap;
      
      private var §_-DY§:Sprite;
      
      private var §_-iY§:int = 100;
      
      private var §_-MN§:int = 0;
      
      private var §_-fR§:Bitmap;
      
      private var §_-aw§:Bitmap;
      
      private var §_-bS§:Bitmap;
      
      private var §_-6t§:BitmapData;
      
      private var §_-KR§:Matrix;
      
      private var mApp:§_-0Z§;
      
      private var §_-oX§:Sprite;
      
      public function §_-mj§(param1:§_-0Z§)
      {
         super();
         this.mApp = param1;
         this.§_-KR§ = new Matrix();
      }
      
      private function §_-4x§(param1:Number) : void
      {
         this.§_-oX§.graphics.clear();
         this.§_-oX§.graphics.beginBitmapFill(this.§_-6t§,this.§_-KR§,true,false);
         this.§_-oX§.graphics.drawRect(0,0,this.§_-fR§.width * param1,this.§_-fR§.height);
         this.§_-oX§.graphics.endFill();
      }
      
      public function Init() : void
      {
         var _loc1_:§_-ex§ = this.mApp.§_-QZ§;
         this.§_-bS§ = new Bitmap(_loc1_.getBitmapData(Blitz3Images.IMAGE_UI_FRAME_TOP));
         this.§_-fR§ = new Bitmap(_loc1_.getBitmapData(Blitz3Images.IMAGE_UI_FRAME_BOTTOM_BACK));
         this.§_-G7§ = new Bitmap(_loc1_.getBitmapData(Blitz3Images.IMAGE_UI_FRAME_BOTTOM_FRONT));
         this.§_-aw§ = new Bitmap(_loc1_.getBitmapData(Blitz3Images.IMAGE_UI_FRAME_BOTTOM_FLASH));
         this.§_-fR§.x = 6;
         this.§_-fR§.y = 4;
         this.§_-oX§ = new Sprite();
         this.§_-6t§ = _loc1_.getBitmapData(Blitz3Images.IMAGE_UI_FRAME_BOTTOM_FILL);
         this.§_-oX§.x = 6;
         this.§_-oX§.y = 4;
         this.§_-DY§ = new Sprite();
         this.§_-DY§.addChild(this.§_-fR§);
         this.§_-DY§.addChild(this.§_-oX§);
         this.§_-DY§.addChild(this.§_-G7§);
         this.§_-DY§.addChild(this.§_-aw§);
         this.§_-bS§.x = -10;
         this.§_-bS§.y = -8;
         this.§_-DY§.x = -10;
         this.§_-DY§.y = 318;
         addChild(this.§_-bS§);
         addChild(this.§_-DY§);
         this.Reset();
         this.§_-Vj§ = true;
      }
      
      public function Update() : void
      {
         var _loc1_:Number = NaN;
         this.§_-EQ§ = this.mApp.logic.GetTimeRemaining();
         if(this.§_-EQ§ <= §_-9P§ && this.§_-EQ§ > §_-cd§)
         {
            --this.§_-iY§;
         }
         else
         {
            this.§_-MN§ = §catch§;
            this.§_-iY§ = this.§_-MN§;
         }
         if(this.§_-iY§ <= 0)
         {
            _loc1_ = this.§_-EQ§ / §_-9P§;
            this.§_-MN§ = (§catch§ - §_-R4§) * _loc1_ + §_-R4§;
            this.§_-iY§ = this.§_-MN§;
            this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_WARNING);
         }
      }
      
      public function Draw() : void
      {
         var _loc3_:Number = NaN;
         var _loc1_:Number = this.§_-EQ§ / this.mApp.logic.GetGameDuration();
         this.§_-4x§(_loc1_);
         _loc1_ = this.§_-iY§ / this.§_-MN§;
         var _loc2_:Number = _loc1_ * Math.PI;
         if(this.§_-EQ§ <= 1400 && this.§_-EQ§ > 0)
         {
            this.§_-aw§.visible = true;
            _loc3_ = 1 - Math.abs(Math.cos(_loc2_));
            this.§_-aw§.alpha = _loc3_;
         }
         else
         {
            this.§_-aw§.visible = false;
         }
      }
      
      public function Reset() : void
      {
         this.§_-aw§.visible = false;
         this.§_-EQ§ = this.mApp.logic.GetGameDuration();
         this.§_-4x§(1);
      }
   }
}
