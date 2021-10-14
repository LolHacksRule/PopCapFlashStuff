package idv.cjcat.stardustextended.twoD.particles
{
   import idv.cjcat.stardustextended.common.particles.PooledParticleFactory;
   
   public class PooledParticle2DFactory extends PooledParticleFactory
   {
       
      
      public function PooledParticle2DFactory()
      {
         super();
         particlePool = Particle2DPool.getInstance();
      }
   }
}
