package §_-P2§
{
   import com.popcap.flash.framework.resources.images.§_-ex§;
   import com.popcap.flash.games.bej3.blitz.§_-df§;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.Bitmap;
   import flash.display.BlendMode;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   
   public class §_-Ms§ extends Sprite
   {
       
      
      private var §break§:Bitmap;
      
      private var §_-Vj§:Boolean = false;
      
      private var §_-TZ§:ColorTransform;
      
      private var §_-Pt§:Boolean = false;
      
      private var mApp:§_-0Z§;
      
      public function §_-Ms§(param1:§_-0Z§)
      {
         super();
         this.§break§ = new Bitmap();
         this.mApp = param1;
      }
      
      public function Draw() : void
      {
      }
      
      public function Update() : void
      {
         var _loc1_:ColorTransform = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         if(this.mApp.logic.isPaused)
         {
            return;
         }
         var _loc2_:Number = this.mApp.logic.blazingSpeedBonus.§_-8v§();
         if(_loc2_ > 0)
         {
            this.§_-Pt§ = true;
            _loc3_ = _loc2_ / §_-df§.§_-hs§;
            _loc4_ = 4 * _loc3_;
            _loc5_ = _loc2_ / 50 * Math.PI;
            _loc6_ = 1 + (1 - Math.cos(_loc5_)) / 2 * (_loc4_ + 1);
            _loc1_ = transform.colorTransform;
            _loc1_.redMultiplier = _loc6_;
            if(_loc1_.redOffset < 128)
            {
               _loc1_.redOffset += 2;
            }
            _loc1_.greenMultiplier = _loc6_ * 0.5;
            if(_loc1_.greenOffset < 64)
            {
               _loc1_.greenOffset += 1;
            }
            transform.colorTransform = _loc1_;
         }
         else if(this.§_-Pt§ == true)
         {
            this.§_-Pt§ = false;
            transform.colorTransform = this.§_-TZ§;
         }
      }
      
      public function Init() : void
      {
         var _loc1_:§_-ex§ = this.mApp.§_-QZ§;
         this.§break§.bitmapData = _loc1_.getBitmapData(Blitz3Images.IMAGE_CHECKERBOARD);
         this.§break§.smoothing = true;
         this.§break§.alpha = 0.667;
         this.§break§.blendMode = BlendMode.NORMAL;
         addChild(this.§break§);
         this.§_-TZ§ = transform.colorTransform;
         this.§_-Vj§ = true;
      }
      
      public function Reset() : void
      {
         this.§_-Pt§ = false;
         transform.colorTransform = this.§_-TZ§;
      }
   }
}
