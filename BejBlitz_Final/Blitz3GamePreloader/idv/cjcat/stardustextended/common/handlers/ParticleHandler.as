package idv.cjcat.stardustextended.common.handlers
{
   import idv.cjcat.stardustextended.common.StardustElement;
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.particles.Particle;
   
   public class ParticleHandler extends StardustElement
   {
      
      private static var _singleton:ParticleHandler;
       
      
      public function ParticleHandler()
      {
         super();
      }
      
      public static function getSingleton() : ParticleHandler
      {
         if(!_singleton)
         {
            _singleton = new ParticleHandler();
         }
         return _singleton;
      }
      
      public function stepBegin(param1:Emitter, param2:Vector.<Particle>, param3:Number) : void
      {
      }
      
      public function stepEnd(param1:Emitter, param2:Vector.<Particle>, param3:Number) : void
      {
      }
      
      public function particleAdded(param1:Particle) : void
      {
      }
      
      public function particleRemoved(param1:Particle) : void
      {
      }
      
      public function readParticle(param1:Particle) : void
      {
      }
      
      override public function getXMLTagName() : String
      {
         return "ParticleHandler";
      }
      
      override public function getElementTypeXMLTag() : XML
      {
         return <handlers/>;
      }
   }
}
