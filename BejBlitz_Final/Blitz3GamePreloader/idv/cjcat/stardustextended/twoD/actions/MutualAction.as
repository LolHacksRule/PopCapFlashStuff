package idv.cjcat.stardustextended.twoD.actions
{
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   public class MutualAction extends Action2D
   {
       
      
      public var maxDistance:Number;
      
      public function MutualAction()
      {
         super();
      }
      
      override public function update(param1:Emitter, param2:Particle, param3:Number, param4:Number) : void
      {
      }
      
      protected function doMutualAction(param1:Particle2D, param2:Particle2D, param3:Number) : void
      {
      }
      
      override public final function get needsSortedParticles() : Boolean
      {
         return active;
      }
      
      override public function getXMLTagName() : String
      {
         return "MutualAction";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@maxDistance = this.maxDistance;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@maxDistance.length())
         {
            this.maxDistance = parseFloat(param1.@maxDistance);
         }
      }
   }
}
