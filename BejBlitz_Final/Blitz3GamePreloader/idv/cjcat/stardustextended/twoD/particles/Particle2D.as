package idv.cjcat.stardustextended.twoD.particles
{
   import idv.cjcat.stardustextended.common.particles.Particle;
   
   public class Particle2D extends Particle
   {
       
      
      public var x:Number;
      
      public var y:Number;
      
      public var vx:Number;
      
      public var vy:Number;
      
      public var rotation:Number;
      
      public var omega:Number;
      
      public function Particle2D()
      {
         super();
      }
      
      override public function init() : void
      {
         super.init();
         this.x = 0;
         this.y = 0;
         this.vx = 0;
         this.vy = 0;
         this.rotation = 0;
         this.omega = 0;
      }
   }
}
