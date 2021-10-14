package idv.cjcat.stardustextended.twoD.display.bitmapParticle
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.PixelSnapping;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   
   public class BitmapParticle extends Sprite implements IBitmapParticle
   {
      
      private static const slicedSpriteCache:Dictionary = new Dictionary();
       
      
      private const bmp:Bitmap = new Bitmap();
      
      private var currFrame:uint = 0;
      
      private var spriteCache:SpriteSheetBitmapSlicedCache;
      
      private var animSpeed:uint;
      
      private var isSpriteSheet:Boolean;
      
      private var totalFrames:uint;
      
      private var smoothing:Boolean;
      
      public function BitmapParticle()
      {
         super();
         addChild(this.bmp);
         this.bmp.pixelSnapping = PixelSnapping.NEVER;
      }
      
      public static function clearBitmapCache() : void
      {
         var _loc1_:* = undefined;
         for(_loc1_ in slicedSpriteCache)
         {
            delete slicedSpriteCache[_loc1_];
         }
      }
      
      public function initWithSingleBitmap(param1:BitmapData, param2:Boolean) : void
      {
         this.bmp.bitmapData = param1;
         this.bmp.smoothing = param2;
         this.smoothing = param2;
         this.bmp.x = -this.bmp.width * 0.5;
         this.bmp.y = -this.bmp.height * 0.5;
         this.isSpriteSheet = false;
         this.spriteCache = null;
      }
      
      public function initWithSpriteSheet(param1:int, param2:int, param3:uint, param4:Boolean, param5:BitmapData, param6:Boolean) : void
      {
         if(param1 > param5.width || param2 > param5.height)
         {
            return;
         }
         this.setupSpriteSheetType(this.animSpeed);
         if(!slicedSpriteCache[param5])
         {
            slicedSpriteCache[param5] = new Dictionary();
         }
         var _loc7_:Number = param1 * 10000000 + param2;
         if(!slicedSpriteCache[param5][_loc7_])
         {
            slicedSpriteCache[param5][_loc7_] = new SpriteSheetBitmapSlicedCache(param5,param1,param2);
         }
         this.spriteCache = slicedSpriteCache[param5][_loc7_];
         this.smoothing = param6;
         this.bmp.x = -param1 / 2;
         this.bmp.y = -param2 / 2;
         this.totalFrames = this.animSpeed * this.spriteCache.bds.length;
         this.startFromRandomFrame = param4;
         this.bmp.bitmapData = this.spriteCache.bds[uint(this.currFrame / this.animSpeed)];
         this.bmp.smoothing = this.smoothing;
      }
      
      private function setupSpriteSheetType(param1:uint) : void
      {
         this.isSpriteSheet = true;
         if(param1 == 0)
         {
            this.isSpriteSheet = false;
            this.animSpeed = 1;
         }
      }
      
      public function stepSpriteSheet(param1:uint) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         if(this.isSpriteSheet)
         {
            _loc2_ = (this.currFrame + param1) % this.totalFrames;
            _loc3_ = uint(_loc2_ / this.animSpeed);
            _loc4_ = uint(this.currFrame / this.animSpeed);
            if(_loc3_ != _loc4_)
            {
               this.bmp.bitmapData = this.spriteCache.bds[_loc3_];
               this.bmp.smoothing = this.smoothing;
            }
            this.currFrame = _loc2_;
         }
      }
      
      public function set animationSpeed(param1:uint) : void
      {
         this.animSpeed = param1 > 0 ? uint(param1) : uint(1);
         this.totalFrames = this.spriteCache.bds.length * this.animSpeed;
      }
      
      public function set startFromRandomFrame(param1:Boolean) : void
      {
         if(param1)
         {
            this.currFrame = Math.random() * this.totalFrames;
         }
         else
         {
            this.currFrame = 0;
         }
      }
   }
}
