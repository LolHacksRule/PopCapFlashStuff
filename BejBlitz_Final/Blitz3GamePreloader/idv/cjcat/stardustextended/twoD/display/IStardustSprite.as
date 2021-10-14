package idv.cjcat.stardustextended.twoD.display
{
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.particles.Particle;
   
   public interface IStardustSprite
   {
       
      
      function init(param1:Particle) : void;
      
      function update(param1:Emitter, param2:Particle, param3:Number) : void;
      
      function disable() : void;
   }
}
