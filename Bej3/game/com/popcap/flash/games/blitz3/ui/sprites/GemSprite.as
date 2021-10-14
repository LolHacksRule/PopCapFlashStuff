package com.popcap.flash.games.blitz3.ui.sprites
{
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.display.Bitmap;
   import flash.display.BlendMode;
   import flash.display.Sprite;
   
   public class GemSprite extends Sprite
   {
       
      
      public var shadow:Sprite;
      
      public var main:Sprite;
      
      public var effect:Sprite;
      
      public var sImg:Bitmap;
      
      public var mImg:Bitmap;
      
      public var eImg:Bitmap;
      
      public var postFX:Boolean = false;
      
      public var animTime:int = 0;
      
      public var gem:Gem = null;
      
      private var mApp:Blitz3App;
      
      private var mIsInited:Boolean = false;
      
      private var mX:Number = 0;
      
      private var mY:Number = 0;
      
      private var mScale:Number = 1.0;
      
      public function GemSprite(app:Blitz3App)
      {
         super();
         this.mApp = app;
         this.shadow = new Sprite();
         this.main = new Sprite();
         this.effect = new Sprite();
         this.sImg = new Bitmap();
         this.sImg.smoothing = true;
         this.mImg = new Bitmap();
         this.mImg.smoothing = true;
         this.eImg = new Bitmap();
         this.eImg.smoothing = true;
         this.shadow.addChild(this.sImg);
         this.main.addChild(this.mImg);
         this.effect.addChild(this.eImg);
         this.main.addChild(this.effect);
      }
      
      public function Hide() : void
      {
         this.shadow.visible = false;
         this.main.visible = false;
      }
      
      public function Show() : void
      {
         this.shadow.visible = true;
         this.main.visible = true;
      }
      
      public function SetRenderState(x:Number, y:Number, scale:Number, shadowImg:ImageInst, mainImg:ImageInst, effectImg:ImageInst) : void
      {
         if(x != this.mX)
         {
            this.mX = x;
            this.shadow.x = this.mX;
            this.main.x = this.mX;
         }
         if(y != this.mY)
         {
            this.mY = y;
            this.shadow.y = this.mY;
            this.main.y = this.mY;
         }
         if(scale != this.mScale)
         {
            this.mScale = scale;
            this.shadow.scaleX = this.mScale;
            this.shadow.scaleY = this.mScale;
            this.main.scaleX = this.mScale;
            this.main.scaleY = this.mScale;
            this.effect.scaleX = this.mScale;
            this.effect.scaleY = this.mScale;
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
            this.sImg.x = -(this.sImg.width / 2);
            this.sImg.y = -(this.sImg.height / 2);
            this.sImg.smoothing = true;
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
            this.mImg.x = -(this.mImg.width / 2);
            this.mImg.y = -(this.mImg.height / 2) + mainImg.y;
            this.mImg.smoothing = true;
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
            this.eImg.x = -(this.eImg.width / 2);
            this.eImg.y = -(this.eImg.height / 2);
            this.eImg.blendMode = !!effectImg.mIsAdditive ? BlendMode.ADD : BlendMode.NORMAL;
            this.eImg.smoothing = true;
         }
      }
      
      public function Init() : void
      {
         this.mIsInited = true;
      }
      
      public function Reset() : void
      {
      }
      
      public function Update() : void
      {
         if(this.animTime > 0)
         {
            --this.animTime;
         }
      }
      
      public function Draw() : void
      {
      }
   }
}
