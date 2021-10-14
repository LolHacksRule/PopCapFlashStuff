package com.popcap.flash.bejeweledblitz.preloader
{
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.PixelSnapping;
   import flash.display.Sprite;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   
   public class PreloaderProgressBar extends Sprite
   {
      
      public static const GEM_SIZE:int = 40;
       
      
      private var m_Background:PreloaderBackground;
      
      private var m_Logo:PreloaderLogo;
      
      private var m_Bar:Sprite;
      
      private var m_LeftBaseCap:Bitmap;
      
      private var m_RightBaseCap:Bitmap;
      
      private var m_BarBaseFill:Bitmap;
      
      private var m_LeftProgressFill:Bitmap;
      
      private var m_RightProgressFill:Bitmap;
      
      private var m_ProgressFill:Bitmap;
      
      private var m_Sparkler:PreloaderSparkler;
      
      private var m_StartX:int;
      
      private var m_EndX:int;
      
      private var m_GemClasses:Vector.<Class>;
      
      private var m_GemClassIndex:int = 0;
      
      private var m_NewGemCountdown:int = 0;
      
      private var m_Gems:Vector.<MovieClip>;
      
      public function PreloaderProgressBar()
      {
         super();
         this.m_Background = new PreloaderBackground();
         this.m_Background.filters = [new GlowFilter(0,1,6,6,1.5,BitmapFilterQuality.MEDIUM,true)];
         this.m_Logo = new PreloaderLogo();
         this.m_Logo.filters = [new GlowFilter(2229813,1,8,8,1.5,BitmapFilterQuality.MEDIUM)];
         this.m_Bar = new Sprite();
         this.m_LeftBaseCap = new Bitmap(new PreloaderBarBaseCap());
         this.m_RightBaseCap = new Bitmap(new PreloaderBarBaseCap());
         this.m_RightBaseCap.scaleX = -1;
         this.m_RightBaseCap.x = this.m_RightBaseCap.width;
         this.m_BarBaseFill = new Bitmap(new PreloaderBarBaseFill());
         this.m_LeftBaseCap.pixelSnapping = PixelSnapping.ALWAYS;
         this.m_RightBaseCap.pixelSnapping = PixelSnapping.ALWAYS;
         this.m_BarBaseFill.pixelSnapping = PixelSnapping.ALWAYS;
         this.m_LeftProgressFill = new Bitmap(new PreloaderBarCap());
         this.m_RightProgressFill = new Bitmap(new PreloaderBarCap());
         this.m_RightProgressFill.scaleX = -1;
         this.m_RightProgressFill.x = this.m_RightProgressFill.width;
         this.m_ProgressFill = new Bitmap(new PreloaderBarFill());
         this.m_LeftProgressFill.pixelSnapping = PixelSnapping.ALWAYS;
         this.m_RightProgressFill.pixelSnapping = PixelSnapping.ALWAYS;
         this.m_ProgressFill.pixelSnapping = PixelSnapping.ALWAYS;
         this.m_Bar.addChild(this.m_LeftBaseCap);
         this.m_Bar.addChild(this.m_BarBaseFill);
         this.m_Bar.addChild(this.m_RightBaseCap);
         this.m_Bar.addChild(this.m_LeftProgressFill);
         this.m_Bar.addChild(this.m_ProgressFill);
         this.m_Bar.addChild(this.m_RightProgressFill);
         this.m_Sparkler = new PreloaderSparkler();
         addChild(this.m_Background);
         addChild(this.m_Logo);
         addChild(this.m_Bar);
         addChild(this.m_Sparkler);
         this.m_Gems = new Vector.<MovieClip>();
         this.m_GemClasses = new Vector.<Class>();
         this.m_GemClasses.push(PreloaderBlueGem,PreloaderGreenGem,PreloaderOrangeGem,PreloaderPurpleGem,PreloaderRedGem,PreloaderWhiteGem,PreloaderYellowGem);
      }
      
      public function Init(w:int, h:int, xOffset:int = 0, yOffset:int = 0) : void
      {
         x = xOffset;
         y = yOffset;
         scrollRect = new Rectangle(xOffset,yOffset,w - xOffset,h);
         this.m_Background.x = xOffset - 1;
         this.m_Background.y = yOffset - 1;
         this.m_Background.width = w - xOffset + 2;
         this.m_Background.height = h + 2;
         this.m_Logo.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_Logo.width * 0.5;
         this.m_Logo.y = this.m_Background.y + this.m_Background.height * 0.5 - this.m_Logo.height;
         this.m_BarBaseFill.width = this.m_Background.width - (this.m_LeftBaseCap.width + this.m_RightBaseCap.width);
         this.m_BarBaseFill.x += this.m_LeftBaseCap.width;
         this.m_BarBaseFill.y -= this.m_BarBaseFill.height;
         this.m_ProgressFill.x = this.m_BarBaseFill.x + 1;
         this.m_ProgressFill.y = this.m_BarBaseFill.y + 8;
         this.m_LeftBaseCap.y -= this.m_LeftBaseCap.height - 6;
         this.m_LeftProgressFill.x = this.m_LeftBaseCap.x + 36;
         this.m_LeftProgressFill.y = this.m_LeftBaseCap.y + 15;
         this.m_RightBaseCap.x += this.m_RightBaseCap.width + this.m_BarBaseFill.width;
         this.m_RightBaseCap.y -= this.m_RightBaseCap.height - 6;
         this.m_RightProgressFill.x = this.m_RightBaseCap.x - 36;
         this.m_RightProgressFill.y = this.m_RightBaseCap.y + 15;
         this.m_RightProgressFill.visible = false;
         this.m_Bar.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_Bar.width * 0.5;
         this.m_Bar.y = this.m_Logo.y + this.m_Logo.height + this.m_Bar.height + 20;
         this.m_Sparkler.y = this.m_Bar.y - 50;
         this.m_StartX = this.m_LeftProgressFill.x;
         this.m_EndX = this.m_RightProgressFill.x + this.m_ProgressFill.width - this.m_LeftProgressFill.width - this.m_RightProgressFill.width - 1;
      }
      
      public function SetValue(value:Number, elapsed:int) : void
      {
         var gem:MovieClip = null;
         var leadSpace:int = 0;
         value = Math.min(Math.max(value,0),1);
         this.m_ProgressFill.scaleX = (this.m_EndX - this.m_StartX) * value;
         if(value == 1)
         {
            this.m_RightProgressFill.visible = true;
            if(this.m_Sparkler != null)
            {
               removeChild(this.m_Sparkler);
               this.m_Sparkler = null;
            }
         }
         else
         {
            leadSpace = width * 0.012;
            this.m_Sparkler.Update(this.m_ProgressFill.x + this.m_ProgressFill.scaleX + leadSpace,this.m_ProgressFill.height);
         }
         this.m_NewGemCountdown -= elapsed;
         if(this.m_NewGemCountdown <= 0)
         {
            this.m_NewGemCountdown = 300;
            gem = new this.m_GemClasses[this.m_GemClassIndex++]();
            this.m_Gems.push(gem);
            addChildAt(gem,1);
            gem.width = gem.height = GEM_SIZE * Math.random() + GEM_SIZE;
            gem.x = this.m_Background.x + this.m_Background.width * Math.random();
            gem.y = -gem.height;
            gem.d_Velocity = 0;
            gem.d_Rotation = (Math.random() - 0.5) * 720;
            if(this.m_GemClassIndex >= this.m_GemClasses.length)
            {
               this.m_GemClassIndex = 0;
            }
         }
         var elapsedPercent:Number = elapsed / 1000;
         for each(gem in this.m_Gems)
         {
            gem.y += gem.d_Velocity * elapsedPercent;
            gem.d_Velocity += 300 * elapsedPercent;
            gem.rotation += gem.d_Rotation * elapsedPercent;
            if(gem.y - gem.height >= this.m_Background.y + this.m_Background.height)
            {
               this.m_Gems.splice(this.m_Gems.indexOf(gem),1);
               removeChild(gem);
            }
         }
      }
   }
}
