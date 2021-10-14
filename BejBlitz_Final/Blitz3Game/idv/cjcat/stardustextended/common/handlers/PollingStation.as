package idv.cjcat.stardustextended.common.handlers
{
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.particles.Particle;
   
   public final class PollingStation extends ParticleHandler
   {
       
      
      private var _particlesAdded:Vector.<Particle>;
      
      private var _particlesRemoved:Vector.<Particle>;
      
      private var _emitter:Emitter;
      
      public function PollingStation()
      {
         this._particlesAdded = new Vector.<Particle>();
         this._particlesRemoved = new Vector.<Particle>();
         super();
      }
      
      public final function get particlesAdded() : Vector.<Particle>
      {
         return this._particlesAdded;
      }
      
      public final function get particlesRemoved() : Vector.<Particle>
      {
         return this._particlesRemoved;
      }
      
      public final function get particles() : Vector.<Particle>
      {
         return !!Boolean(this._emitter) ? this._emitter.particles : null;
      }
      
      override public final function stepBegin(param1:Emitter, param2:Vector.<Particle>, param3:Number) : void
      {
         this._particlesAdded = new Vector.<Particle>();
         this._particlesRemoved = new Vector.<Particle>();
         this._emitter = param1;
      }
      
      override public final function particleAdded(param1:Particle) : void
      {
         this._particlesAdded.push(param1);
      }
      
      override public final function particleRemoved(param1:Particle) : void
      {
         this._particlesRemoved.push(param1);
      }
      
      override public function getXMLTagName() : String
      {
         return "PollingStation";
      }
   }
}
