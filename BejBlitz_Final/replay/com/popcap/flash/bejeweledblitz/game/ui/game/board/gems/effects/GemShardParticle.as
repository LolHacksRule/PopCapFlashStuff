package com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.resources.images.ImageUtils;
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
      
      public function GemShardParticle(app:Blitz3App, gem:Gem)
      {
         super();
         this.mGem = gem;
         var gemX:Number = 0;
         var gemY:Number = 0;
         var power:Number = 0.5;
         x = Math.random() * 40 - 20;
         y = Math.random() * 40 - 20;
         var screenX:Number = x;
         var screenY:Number = y;
         var locus:Gem = app.logic.board.GetGem(gem.mShatterGemId);
         if(locus != null && locus.type == Gem.TYPE_FLAME)
         {
            gemX = locus.x * 40 + 20;
            gemY = locus.y * 40 + 20;
            power = 2;
            this.mGravity = GRAVITY;
            screenX = x + (this.mGem.x * 40 + 20);
            screenY = y + (this.mGem.y * 40 + 20);
         }
         this.mShardImg = app.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_SHARDS);
         this.mCoverImg = app.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_SHARDS_OUTLINE);
         var angle:Number = Math.atan2(screenY - gemY,screenX - gemX);
         this.vx = Math.cos(angle) * power;
         this.vy = Math.sin(angle) * power;
         this.mFlickerSpeed = Math.random() * 25 + 25;
         this.mShardBitmap = new Bitmap();
         this.mCoverBitmap = new Bitmap();
         this.mCoverBitmap.blendMode = BlendMode.ADD;
         this.SetColor(gem.color);
         addChild(this.mShardBitmap);
         addChild(this.mCoverBitmap);
      }
      
      public function SetColor(color:int) : void
      {
         var colorVal:int = 0;
         switch(color)
         {
            case Gem.COLOR_RED:
               colorVal = 16711680;
               break;
            case Gem.COLOR_ORANGE:
               colorVal = 16744448;
               break;
            case Gem.COLOR_YELLOW:
               colorVal = 16776960;
               break;
            case Gem.COLOR_GREEN:
               colorVal = 65280;
               break;
            case Gem.COLOR_BLUE:
               colorVal = 255;
               break;
            case Gem.COLOR_PURPLE:
               colorVal = 16711935;
               break;
            case Gem.COLOR_WHITE:
               colorVal = 8421504;
               break;
            case Gem.COLOR_NONE:
            default:
               colorVal = 2105376;
         }
         var cTrans:ColorTransform = this.mShardBitmap.transform.colorTransform;
         ImageUtils.modColor(cTrans,colorVal);
         this.mShardBitmap.transform.colorTransform = cTrans;
      }
      
      override public function IsDone() : Boolean
      {
         return this.mIsDone;
      }
      
      override public function Update() : void
      {
         var cTrans:ColorTransform = null;
         if(this.mIsDone)
         {
            return;
         }
         this.vy += this.mGravity;
         x += this.vx;
         y += this.vy;
         this.mShardImg.x = x;
         this.mShardImg.y = y;
         this.mCoverImg.x = x;
         this.mCoverImg.y = y;
         ++this.mTimer;
         var progress:Number = this.mTimer * 0.01 * 16;
         var frame:int = int(progress) % this.mShardImg.mSource.mNumFrames;
         this.mShardImg.mFrame = frame;
         this.mCoverImg.mFrame = frame;
         var alpha:Number = 1 - this.mTimer / ANIM_TIME;
         var flicker:Number = Math.sin(this.mTimer / this.mFlickerSpeed * Math.PI) + 1;
         cTrans = this.mShardBitmap.transform.colorTransform;
         cTrans.alphaMultiplier = alpha;
         this.mShardBitmap.transform.colorTransform = cTrans;
         cTrans = this.mCoverBitmap.transform.colorTransform;
         cTrans.alphaMultiplier = alpha * flicker;
         this.mCoverBitmap.transform.colorTransform = cTrans;
         this.mShardBitmap.bitmapData = this.mShardImg.pixels;
         this.mShardBitmap.x = this.mShardImg.width * -0.5;
         this.mShardBitmap.y = this.mShardImg.height * -0.5;
         this.mCoverBitmap.bitmapData = this.mCoverImg.pixels;
         this.mCoverBitmap.x = this.mCoverImg.width * -0.5;
         this.mCoverBitmap.y = this.mCoverImg.height * -0.5;
         if(this.mTimer >= ANIM_TIME)
         {
            this.mIsDone = true;
         }
      }
   }
}
