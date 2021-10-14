package idv.cjcat.stardustextended.common.particles
{
   import idv.cjcat.stardustextended.common.initializers.Initializer;
   import idv.cjcat.stardustextended.common.initializers.InitializerCollection;
   import idv.cjcat.stardustextended.common.initializers.InitializerCollector;
   import idv.cjcat.stardustextended.sd;
   
   use namespace sd;
   
   public class ParticleFactory implements InitializerCollector
   {
       
      
      sd var initializerCollection:InitializerCollection;
      
      public function ParticleFactory()
      {
         super();
         this.initializerCollection = new InitializerCollection();
      }
      
      public final function createParticles(param1:int, param2:Number) : Vector.<Particle>
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:Particle = null;
         var _loc5_:Vector.<Particle> = new Vector.<Particle>();
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            (_loc7_ = this.createNewParticle()).init();
            _loc5_.push(_loc7_);
            _loc3_++;
         }
         var _loc6_:Array = this.initializerCollection.initializers;
         _loc3_ = 0;
         _loc4_ = _loc6_.length;
         while(_loc3_ < _loc4_)
         {
            Initializer(_loc6_[_loc3_]).doInitialize(_loc5_,param2);
            _loc3_++;
         }
         return _loc5_;
      }
      
      protected function createNewParticle() : Particle
      {
         return new Particle();
      }
      
      public function addInitializer(param1:Initializer) : void
      {
         this.initializerCollection.addInitializer(param1);
      }
      
      public final function removeInitializer(param1:Initializer) : void
      {
         this.initializerCollection.removeInitializer(param1);
      }
      
      public final function clearInitializers() : void
      {
         this.initializerCollection.clearInitializers();
      }
   }
}
