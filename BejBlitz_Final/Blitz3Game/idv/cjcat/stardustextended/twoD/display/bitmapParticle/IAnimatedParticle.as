package idv.cjcat.stardustextended.twoD.display.bitmapParticle
{
   public interface IAnimatedParticle
   {
       
      
      function stepSpriteSheet(param1:uint) : void;
      
      function set animationSpeed(param1:uint) : void;
      
      function set startFromRandomFrame(param1:Boolean) : void;
   }
}
