package idv.cjcat.stardustextended.twoD.actions
{
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   public class Spin extends Action2D
   {
       
      
      public var multiplier:Number;
      
      private var p2D:Particle2D;
      
      private var factor:Number;
      
      public function Spin(param1:Number = 1)
      {
         super();
         priority = -4;
         this.multiplier = param1;
      }
      
      override public function preUpdate(param1:Emitter, param2:Number) : void
      {
         this.factor = param2 * this.multiplier;
      }
      
      override public function update(param1:Emitter, param2:Particle, param3:Number, param4:Number) : void
      {
         this.p2D = Particle2D(param2);
         this.p2D.rotation += this.p2D.omega * this.factor;
      }
      
      override public function getXMLTagName() : String
      {
         return "Spin";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@multiplier = this.multiplier;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@multiplier.length())
         {
            this.multiplier = parseFloat(param1.@multiplier);
         }
      }
   }
}
