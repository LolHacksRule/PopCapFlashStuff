package idv.cjcat.stardustextended.twoD.emitters
{
   import flash.errors.IllegalOperationError;
   import flash.utils.getQualifiedClassName;
   import idv.cjcat.stardustextended.common.actions.Action;
   import idv.cjcat.stardustextended.common.clocks.Clock;
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.handlers.ParticleHandler;
   import idv.cjcat.stardustextended.common.initializers.Initializer;
   import idv.cjcat.stardustextended.twoD.particles.PooledParticle2DFactory;
   
   public class Emitter2D extends Emitter
   {
       
      
      public function Emitter2D(param1:Clock = null, param2:ParticleHandler = null)
      {
         super(param1,param2);
         factory = new PooledParticle2DFactory();
      }
      
      override public function addAction(param1:Action) : void
      {
         if(!param1.supports2D)
         {
            throw new IllegalOperationError("This action does not support 2D: " + getQualifiedClassName(Object(param1).constructor as Class));
         }
         super.addAction(param1);
      }
      
      override public function addInitializer(param1:Initializer) : void
      {
         if(!param1.supports2D)
         {
            throw new IllegalOperationError("This initializer does not support 2D: " + getQualifiedClassName(Object(param1).constructor as Class));
         }
         super.addInitializer(param1);
      }
      
      override public function getXMLTagName() : String
      {
         return "Emitter2D";
      }
   }
}
