package idv.cjcat.stardustextended.twoD.display.bitmapParticle
{
   import flash.display.BitmapData;
   
   public interface IBitmapParticle extends IAnimatedParticle
   {
       
      
      function initWithSingleBitmap(param1:BitmapData, param2:Boolean) : void;
      
      function initWithSpriteSheet(param1:int, param2:int, param3:uint, param4:Boolean, param5:BitmapData, param6:Boolean) : void;
   }
}
