package com.popcap.flash.bejeweledblitz.game.ui.game.board.gems
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import flash.display.Bitmap;
   import flash.display.BlendMode;
   import flash.display.PixelSnapping;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class GemSprite extends Sprite
   {
      
      public static const GEM_SIZE:int = 40;
      
      public static const GEM_COLOR_VALUES:Vector.<int> = new Vector.<int>(8,true);
      
      public static const GEM_ACOLOR_VALUES:Vector.<int> = new Vector.<int>(8,true);
      
      public static const GEM_HALLOWEEN_COLOR:uint = 4294934041;
      
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
      
      public var multiTextField:TextField;
      
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
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
         _loc1_.size = 17;
         _loc1_.color = 16777215;
         _loc1_.align = TextFormatAlign.CENTER;
         _loc1_.bold = true;
         this.multiTextField = new TextField();
         this.multiTextField.defaultTextFormat = _loc1_;
         this.multiTextField.embedFonts = true;
         this.multiTextField.textColor = 16777215;
         this.multiTextField.x = 0;
         this.multiTextField.y = 0;
         this.multiTextField.selectable = false;
         this.multiTextField.filters = [new DropShadowFilter(0,90,0,1,8,8,2)];
         this.multiTextField.text = "";
         addChild(this.multiTextField);
         this.multiTextField.x -= this.multiTextField.width / 2;
         this.multiTextField.y -= 13;
      }
      
      public function Hide() : void
      {
         visible = false;
         this.multiTextField.text = "";
      }
      
      public function Show() : void
      {
         visible = true;
      }
      
      public function SetPos(param1:Number, param2:Number, param3:Number) : void
      {
         x = param1;
         y = param2;
         if(param3 != this.mScale)
         {
            this.mScale = scaleX = scaleY = param3;
         }
      }
      
      public function SetRenderState(param1:Number, param2:Number, param3:Number, param4:ImageInst, param5:ImageInst, param6:ImageInst) : void
      {
         x = param1;
         y = param2;
         if(param3 != this.mScale)
         {
            this.mScale = scaleX = scaleY = param3;
         }
         if(param4 == null)
         {
            if(this.sImg.bitmapData != null)
            {
               this.sImg.visible = false;
               this.sImg.bitmapData = null;
            }
         }
         else if(this.sImg.bitmapData != param4.pixels)
         {
            this.sImg.visible = true;
            this.sImg.bitmapData = param4.pixels;
            this.sImg.x = -(this.sImg.width * 0.5);
            this.sImg.y = -(this.sImg.height * 0.5);
         }
         if(param5 == null)
         {
            if(this.mImg.bitmapData != null)
            {
               this.mImg.visible = false;
               this.mImg.bitmapData = null;
            }
         }
         else if(this.mImg.bitmapData != param5.pixels)
         {
            this.mImg.visible = true;
            this.mImg.bitmapData = param5.pixels;
            this.mImg.x = -(this.mImg.width * 0.5);
            this.mImg.y = -(this.mImg.height * 0.5) + param5.y;
         }
         if(param6 == null)
         {
            if(this.eImg.bitmapData != null)
            {
               this.eImg.visible = false;
               this.eImg.bitmapData = null;
            }
         }
         else if(this.eImg.bitmapData != param6.pixels)
         {
            this.eImg.visible = true;
            this.eImg.bitmapData = param6.pixels;
            this.eImg.x = -(this.eImg.width * 0.5);
            this.eImg.y = -(this.eImg.height * 0.5);
            this.eImg.blendMode = !!param6.mIsAdditive ? BlendMode.ADD : BlendMode.NORMAL;
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
