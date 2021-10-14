package idv.cjcat.stardustextended.twoD.actions
{
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   public class Damping extends Action2D
   {
       
      
      public var damping:Number;
      
      private var damp:Number;
      
      public function Damping(param1:Number = 0)
      {
         super();
         priority = -1;
         this.damping = param1;
      }
      
      override public function preUpdate(param1:Emitter, param2:Number) : void
      {
         this.damp = 1;
         if(this.damping)
         {
            this.damp = Math.pow(1 - this.damping,param2);
         }
      }
      
      override public function update(param1:Emitter, param2:Particle, param3:Number, param4:Number) : void
      {
         var _loc5_:Particle2D = Particle2D(param2);
         _loc5_.vx *= this.damp;
         _loc5_.vy *= this.damp;
      }
      
      override public function getXMLTagName() : String
      {
         return "Damping";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@damping = this.damping;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@damping.length())
         {
            this.damping = parseFloat(param1.@damping);
         }
      }
   }
}
