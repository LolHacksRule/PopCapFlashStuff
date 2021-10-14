package com.popcap.flash.bejeweledblitz.preloader
{
   import flash.display.Shape;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   
   public class PreloaderSpark extends Shape
   {
      
      private static const FILTERS:Array = [new GlowFilter(16764108,1,8,8,4,BitmapFilterQuality.LOW)];
       
      
      private var xDir:Number = 0;
      
      private var yDir:Number = 0;
      
      private var wiggle:Number = 0;
      
      public function PreloaderSpark()
      {
         super();
         var size:Number = Math.random() * 2;
         graphics.beginFill(16777164,1);
         graphics.drawCircle(0,0,size);
         graphics.endFill();
         cacheAsBitmap = true;
         filters = FILTERS;
         alpha = 0;
      }
      
      public function Init(xPos:Number, yPos:Number, yCenter:Number) : void
      {
         x = xPos;
         y = yPos;
         alpha = 1;
         this.xDir = Math.random() - 0.5;
         this.yDir = (yPos - yCenter) * 0.01 + (Math.random() - 0.5);
         this.wiggle = Math.random();
      }
      
      public function Update() : void
      {
         x += this.xDir * (5 + Math.random() * 5);
         y += this.yDir * (5 + (Math.sin(this.wiggle = this.wiggle * 3) - 0.5) * 3);
         alpha -= Math.random() * 0.13;
      }
   }
}
