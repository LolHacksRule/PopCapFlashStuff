package com.popcap.flash.bejeweledblitz.preloader
{
   import flash.display.Sprite;
   
   public class PreloaderSparkler extends Sprite
   {
       
      
      public function PreloaderSparkler(param1:Array = null)
      {
         super();
         var _loc2_:int = 1;
         while(_loc2_ < 256)
         {
            addChild(new PreloaderSpark(param1));
            _loc2_++;
         }
      }
      
      public function Update(param1:Number, param2:Number) : void
      {
         var _loc4_:PreloaderSpark = null;
         var _loc3_:int = 0;
         while(_loc3_ < numChildren)
         {
            if((_loc4_ = getChildAt(_loc3_) as PreloaderSpark).alpha <= 0)
            {
               _loc4_.Init(param1,_loc3_ % param2,param2 * 0.5);
            }
            _loc4_.Update();
            _loc3_++;
         }
      }
   }
}
