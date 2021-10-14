package §_-bW§
{
   import §_-Xk§.§_-Hd§;
   import §_-Xk§.§_-LE§;
   import com.popcap.flash.framework.resources.images.§_-ex§;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.Sprite;
   import mx.core.BitmapAsset;
   
   public class §_-YV§ extends Sprite
   {
      
      private static const IMAGE_BG_X1:Class = BackgroundWidget_IMAGE_BG_X1;
      
      private static const IMAGE_BG_X2:Class = BackgroundWidget_IMAGE_BG_X2;
      
      private static const IMAGE_BG_X3:Class = BackgroundWidget_IMAGE_BG_X3;
      
      private static const IMAGE_BG_X4:Class = BackgroundWidget_IMAGE_BG_X4;
      
      private static const IMAGE_BG_X5:Class = BackgroundWidget_IMAGE_BG_X5;
      
      private static const IMAGE_BG_X6:Class = BackgroundWidget_IMAGE_BG_X6;
      
      private static const IMAGE_BG_X7:Class = BackgroundWidget_IMAGE_BG_X7;
      
      private static const IMAGE_BG_X8:Class = BackgroundWidget_IMAGE_BG_X8;
      
      public static const §_-Cs§:int = 8;
      
      public static const §_-U8§:int = 50;
       
      
      private var §_-2F§:Bitmap;
      
      private var §_-E6§:§_-Hd§;
      
      private var §_-Cq§:int = 0;
      
      private var §_-Vj§:Boolean = false;
      
      private var §_-XU§:Vector.<BitmapData>;
      
      private var mApp:§_-0Z§;
      
      private var §_-Lt§:int = 1;
      
      private var §break§:Bitmap;
      
      private var §_-Gn§:int = 0;
      
      public function §_-YV§(param1:§_-0Z§)
      {
         super();
         this.mApp = param1;
      }
      
      public function Update() : void
      {
         if(this.§_-Gn§ > 0)
         {
            --this.§_-Gn§;
            if(this.§_-Gn§ == 40)
            {
               this.§_-Cq§ = this.§_-Lt§ - 1;
               this.§break§.bitmapData = this.§_-XU§[this.§_-Cq§];
               this.§break§.smoothing = true;
            }
            if(this.§_-Gn§ == 0)
            {
               this.§_-2F§.visible = false;
            }
         }
         if(this.mApp.logic.multiLogic.multiplier > this.§_-Lt§)
         {
            this.§_-Lt§ = this.mApp.logic.multiLogic.multiplier;
            this.§_-Gn§ = §_-U8§;
            this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_BACKGROUND_CHANGE);
            this.§_-2F§.bitmapData = this.§_-XU§[this.§_-Lt§ - 1];
            this.§_-2F§.visible = true;
            this.§break§.bitmapData = this.§_-XU§[this.§_-Lt§ - 2];
            this.§break§.smoothing = true;
         }
         else if(this.mApp.logic.multiLogic.multiplier < this.§_-Lt§)
         {
            this.§_-Lt§ = this.mApp.logic.multiLogic.multiplier;
            this.§_-Cq§ = this.§_-Lt§ - 1;
            this.§break§.bitmapData = this.§_-XU§[this.§_-Cq§];
            this.§break§.smoothing = true;
            this.§_-2F§.bitmapData = this.§_-XU§[this.§_-Cq§];
            this.§_-Gn§ = 0;
         }
      }
      
      public function Draw() : void
      {
         if(this.§_-Gn§ == 0)
         {
            return;
         }
         var _loc1_:Number = 1 - this.§_-Gn§ / §_-U8§;
         var _loc2_:Number = 2 * this.§_-E6§.getOutValue(_loc1_);
         this.§_-2F§.alpha = _loc2_;
      }
      
      public function Reset() : void
      {
         this.§_-Cq§ = 0;
         this.§_-Lt§ = 1;
         this.§break§.bitmapData = this.§_-XU§[this.§_-Cq§];
      }
      
      public function Init() : void
      {
         var _loc1_:§_-ex§ = this.mApp.§_-QZ§;
         this.§_-XU§ = new Vector.<BitmapData>(§_-Cs§,true);
         this.§_-XU§[0] = (new IMAGE_BG_X1() as BitmapAsset).bitmapData;
         this.§_-XU§[1] = (new IMAGE_BG_X2() as BitmapAsset).bitmapData;
         this.§_-XU§[2] = (new IMAGE_BG_X3() as BitmapAsset).bitmapData;
         this.§_-XU§[3] = (new IMAGE_BG_X4() as BitmapAsset).bitmapData;
         this.§_-XU§[4] = (new IMAGE_BG_X5() as BitmapAsset).bitmapData;
         this.§_-XU§[5] = (new IMAGE_BG_X6() as BitmapAsset).bitmapData;
         this.§_-XU§[6] = (new IMAGE_BG_X7() as BitmapAsset).bitmapData;
         this.§_-XU§[7] = (new IMAGE_BG_X8() as BitmapAsset).bitmapData;
         this.§_-2F§ = new Bitmap(this.§_-XU§[0]);
         this.§_-2F§.blendMode = BlendMode.ADD;
         this.§_-2F§.alpha = 0;
         this.§_-E6§ = new §_-Hd§();
         this.§_-E6§.§_-9O§(0,1);
         this.§_-E6§.§_-0g§(0,1);
         this.§_-E6§.§_-c3§(true,new §_-LE§(0,0,0),new §_-LE§(0.1,1,0),new §_-LE§(0.334,0,0),new §_-LE§(0.43,0.5,0),new §_-LE§(0.666,0,0),new §_-LE§(0.766,0.25,0),new §_-LE§(1,0,0));
         this.§break§ = new Bitmap(this.§_-XU§[0]);
         this.§break§.smoothing = true;
         addChild(this.§break§);
         addChild(this.§_-2F§);
         this.§_-Vj§ = true;
      }
   }
}
