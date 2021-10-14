package com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects
{
   import com.popcap.flash.bejeweledblitz.Constants;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.BlendMode;
   import flash.geom.ColorTransform;
   
   public class GemShardParticle extends SpriteEffect
   {
      
      public static const GRAVITY:Number = 0.01;
      
      public static const ANIM_TIME:int = 150;
       
      
      private var vx:Number = 0;
      
      private var vy:Number = 0;
      
      private var mShardImg:ImageInst;
      
      private var mCoverImg:ImageInst;
      
      private var mShardBitmap:Bitmap;
      
      private var mCoverBitmap:Bitmap;
      
      private var mTimer:int = 0;
      
      private var mGem:Gem;
      
      private var mIsDone:Boolean = false;
      
      private var mFlickerSpeed:Number = 0;
      
      private var centerX:Number = 0;
      
      private var centerY:Number = 0;
      
      private var mGravity:Number = 0;
      
      public function GemShardParticle(param1:Blitz3App, param2:Gem)
      {
         super();
         this.mGem = param2;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0.5;
         x = Math.random() * 40 - 20;
         y = Math.random() * 40 - 20;
         var _loc6_:Number = x;
         var _loc7_:Number = y;
         var _loc8_:Gem;
         if((_loc8_ = param1.logic.board.GetGem(param2.shatterGemID)) != null && _loc8_.type == Gem.TYPE_FLAME)
         {
            _loc3_ = _loc8_.x * 40 + 20;
            _loc4_ = _loc8_.y * 40 + 20;
            _loc5_ = 2;
            this.mGravity = GRAVITY;
            _loc6_ = x + (this.mGem.x * 40 + 20);
            _loc7_ = y + (this.mGem.y * 40 + 20);
         }
         this.mShardImg = param1.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_SHARDS);
         if(!Constants.IS_HALLOWEEN)
         {
            this.mCoverImg = param1.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_SHARDS_OUTLINE);
         }
         var _loc9_:Number = Math.atan2(_loc7_ - _loc4_,_loc6_ - _loc3_);
         this.vx = Math.cos(_loc9_) * _loc5_;
         this.vy = Math.sin(_loc9_) * _loc5_;
         this.mFlickerSpeed = Math.random() * 25 + 25;
         this.mShardBitmap = new Bitmap();
         this.mCoverBitmap = new Bitmap();
         this.mCoverBitmap.blendMode = BlendMode.ADD;
         this.SetColor(param2.color);
         addChild(this.mShardBitmap);
         addChild(this.mCoverBitmap);
         this.mShardBitmap.bitmapData = this.mShardImg.pixels;
         this.mShardBitmap.x = this.mShardImg.width * -0.5;
         this.mShardBitmap.y = this.mShardImg.height * -0.5;
         if(!Constants.IS_HALLOWEEN)
         {
            this.mCoverBitmap.bitmapData = this.mCoverImg.pixels;
            this.mCoverBitmap.x = this.mCoverImg.width * -0.5;
            this.mCoverBitmap.y = this.mCoverImg.height * -0.5;
         }
      }
      
      public function SetColor(param1:int) : void
      {
         if(Constants.IS_HALLOWEEN)
         {
            return;
         }
         var _loc2_:int = 0;
         switch(param1)
         {
            case Gem.COLOR_RED:
               _loc2_ = 16711680;
               break;
            case Gem.COLOR_ORANGE:
               _loc2_ = 16744448;
               break;
            case Gem.COLOR_YELLOW:
               _loc2_ = 16776960;
               break;
            case Gem.COLOR_GREEN:
               _loc2_ = 65280;
               break;
            case Gem.COLOR_BLUE:
               _loc2_ = 255;
               break;
            case Gem.COLOR_PURPLE:
               _loc2_ = 16711935;
               break;
            case Gem.COLOR_WHITE:
               _loc2_ = 8421504;
               break;
            case Gem.COLOR_NONE:
            default:
               _loc2_ = 2105376;
         }
         var _loc3_:ColorTransform = this.mShardBitmap.transform.colorTransform;
         _loc3_.alphaMultiplier = ((_loc2_ & 4278190080) >> 24) / 255;
         _loc3_.redMultiplier = ((_loc2_ & 16711680) >> 16) / 255;
         _loc3_.greenMultiplier = ((_loc2_ & 65280) >> 8) / 255;
         _loc3_.blueMultiplier = ((_loc2_ & 255) >> 0) / 255;
         this.mShardBitmap.transform.colorTransform = _loc3_;
      }
      
      override public function IsDone() : Boolean
      {
         return this.mIsDone;
      }
      
      override public function Update() : void
      {
         if(this.mIsDone)
         {
            return;
         }
         this.vy += this.mGravity;
         x += this.vx;
         y += this.vy;
         this.mShardImg.x = x;
         this.mShardImg.y = y;
         if(!Constants.IS_HALLOWEEN)
         {
            this.mCoverImg.x = x;
            this.mCoverImg.y = y;
         }
         ++this.mTimer;
         var _loc1_:Number = this.mTimer * 0.01 * 16;
         var _loc2_:int = int(_loc1_) % this.mShardImg.mSource.mNumFrames;
         this.mShardImg.mFrame = _loc2_;
         if(!Constants.IS_HALLOWEEN)
         {
            this.mCoverImg.mFrame = _loc2_;
         }
         var _loc3_:Number = 1 - this.mTimer / ANIM_TIME;
         var _loc4_:Number = Math.sin(this.mTimer / this.mFlickerSpeed * Math.PI) + 1;
         this.mShardBitmap.alpha = _loc3_;
         this.mCoverBitmap.alpha = _loc3_ * _loc4_;
         if(this.mTimer >= ANIM_TIME)
         {
            this.mIsDone = true;
         }
      }
   }
}
