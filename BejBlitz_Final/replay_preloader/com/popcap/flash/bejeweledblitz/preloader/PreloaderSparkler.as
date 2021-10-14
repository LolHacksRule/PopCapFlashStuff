package com.popcap.flash.bejeweledblitz.preloader
{
   import flash.display.Sprite;
   
   public class PreloaderSparkler extends Sprite
   {
       
      
      public function PreloaderSparkler()
      {
         super();
         for(var i:int = 1; i < 256; i++)
         {
            addChild(new PreloaderSpark());
         }
      }
      
      public function Update(xPos:Number, h:Number) : void
      {
         var spark:PreloaderSpark = null;
         for(var i:int = 0; i < numChildren; i++)
         {
            spark = getChildAt(i) as PreloaderSpark;
            if(spark.alpha <= 0)
            {
               spark.Init(xPos,i % h,h * 0.5);
            }
            spark.Update();
         }
      }
   }
}
