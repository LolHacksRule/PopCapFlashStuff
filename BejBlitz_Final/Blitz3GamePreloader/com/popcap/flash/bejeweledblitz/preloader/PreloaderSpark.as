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
      
      public function PreloaderSpark(param1:Array = null)
      {
         super();
         var _loc2_:Number = Math.random() * 2;
         graphics.beginFill(16777164,1);
         graphics.drawCircle(0,0,_loc2_);
         graphics.endFill();
         cacheAsBitmap = true;
         filters = FILTERS;
         if(param1)
         {
            filters = param1;
         }
         alpha = 0;
      }
      
      public function Init(param1:Number, param2:Number, param3:Number) : void
      {
         x = param1;
         y = param2;
         alpha = 1;
         this.xDir = Math.random() - 0.5;
         this.yDir = (param2 - param3) * 0.01 + (Math.random() - 0.5);
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
