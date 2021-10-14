package com.popcap.flash.bejeweledblitz.game.ui.game.board.gems
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import flash.display.Bitmap;
   import flash.display.BlendMode;
   import flash.display.PixelSnapping;
   import flash.display.Sprite;
   
   public class GemSprite extends Sprite
   {
      
      public static const GEM_SIZE:int = 40;
      
      public static const GEM_COLOR_VALUES:Vector.<int> = new Vector.<int>(8,true);
      
      public static const GEM_ACOLOR_VALUES:Vector.<int> = new Vector.<int>(8,true);
      
      {
         GEM_COLOR_VALUES[Gem.COLOR_NONE] = 2105376;
         GEM_COLOR_VALUES[Gem.COLOR_RED] = 16711680;
         GEM_COLOR_VALUES[Gem.COLOR_ORANGE] = 16744448;
         GEM_COLOR_VALUES[Gem.COLOR_YELLOW] = 16776960;
         GEM_COLOR_VALUES[Gem.COLOR_GREEN] = 65280;
         GEM_COLOR_VALUES[Gem.COLOR_BLUE] = 255;
         GEM_COLOR_VALUES[Gem.COLOR_PURPLE] = 16711935;
         GEM_COLOR_VALUES[Gem.COLOR_WHITE] = 8421504;
         GEM_ACOLOR_VALUES[Gem.COLOR_NONE] = 0;
         GEM_ACOLOR_VALUES[Gem.COLOR_RED] = 4294901760;
         GEM_ACOLOR_VALUES[Gem.COLOR_ORANGE] = 4294934528;
         GEM_ACOLOR_VALUES[Gem.COLOR_YELLOW] = 4294967040;
         GEM_ACOLOR_VALUES[Gem.COLOR_GREEN] = 4278255360;
         GEM_ACOLOR_VALUES[Gem.COLOR_BLUE] = 4278190335;
         GEM_ACOLOR_VALUES[Gem.COLOR_PURPLE] = 4294902015;
         GEM_ACOLOR_VALUES[Gem.COLOR_WHITE] = 4294967295;
      }
      
      public var postFX:Boolean = false;
      
      public var animTime:int = 0;
      
      public var gem:Gem = null;
      
      private var sImg:Bitmap;
      
      private var mImg:Bitmap;
      
      private var eImg:Bitmap;
      
      private var mScale:Number = 1.0;
      
      public function GemSprite()
      {
         super();
         this.sImg = new Bitmap();
         this.mImg = new Bitmap();
         this.eImg = new Bitmap();
         addChild(this.sImg);
         addChild(this.mImg);
         addChild(this.eImg);
         this.sImg.pixelSnapping = PixelSnapping.ALWAYS;
         this.mImg.pixelSnapping = PixelSnapping.ALWAYS;
         this.eImg.pixelSnapping = PixelSnapping.ALWAYS;
         this.mImg.smoothing = true;
      }
      
      public function Hide() : void
      {
         visible = false;
      }
      
      public function Show() : void
      {
         visible = true;
      }
      
      public function SetRenderState(xPos:Number, yPos:Number, scale:Number, shadowImg:ImageInst, mainImg:ImageInst, effectImg:ImageInst) : void
      {
         x = xPos;
         y = yPos;
         if(scale != this.mScale)
         {
            this.mScale = scale;
            scaleX = this.mScale;
            scaleY = this.mScale;
         }
         if(shadowImg == null)
         {
            if(this.sImg.bitmapData != null)
            {
               this.sImg.visible = false;
               this.sImg.bitmapData = null;
            }
         }
         else if(this.sImg.bitmapData != shadowImg.pixels)
         {
            this.sImg.visible = true;
            this.sImg.bitmapData = shadowImg.pixels;
            this.sImg.x = -(this.sImg.width * 0.5);
            this.sImg.y = -(this.sImg.height * 0.5);
         }
         if(mainImg == null)
         {
            if(this.mImg.bitmapData != null)
            {
               this.mImg.visible = false;
               this.mImg.bitmapData = null;
            }
         }
         else if(this.mImg.bitmapData != mainImg.pixels)
         {
            this.mImg.visible = true;
            this.mImg.bitmapData = mainImg.pixels;
            this.mImg.x = -(this.mImg.width * 0.5);
            this.mImg.y = -(this.mImg.height * 0.5) + mainImg.y;
         }
         if(effectImg == null)
         {
            if(this.eImg.bitmapData != null)
            {
               this.eImg.visible = false;
               this.eImg.bitmapData = null;
            }
         }
         else if(this.eImg.bitmapData != effectImg.pixels)
         {
            this.eImg.visible = true;
            this.eImg.bitmapData = effectImg.pixels;
            this.eImg.x = -(this.eImg.width * 0.5);
            this.eImg.y = -(this.eImg.height * 0.5);
            this.eImg.blendMode = !!effectImg.mIsAdditive ? BlendMode.ADD : BlendMode.NORMAL;
         }
      }
      
      public function Update() : void
      {
         if(this.animTime > 0)
         {
            --this.animTime;
         }
      }
   }
}
