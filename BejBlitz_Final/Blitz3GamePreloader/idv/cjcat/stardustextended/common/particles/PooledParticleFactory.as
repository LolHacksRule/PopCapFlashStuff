package idv.cjcat.stardustextended.common.particles
{
   public class PooledParticleFactory extends ParticleFactory
   {
       
      
      protected var particlePool:ParticlePool;
      
      public function PooledParticleFactory()
      {
         super();
         this.particlePool = ParticlePool.getInstance();
      }
      
      override protected final function createNewParticle() : Particle
      {
         return this.particlePool.get();
      }
      
      public final function recycle(param1:Particle) : void
      {
         this.particlePool.recycle(param1);
      }
   }
}
