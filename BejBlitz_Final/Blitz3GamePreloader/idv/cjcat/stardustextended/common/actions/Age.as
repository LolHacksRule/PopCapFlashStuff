package idv.cjcat.stardustextended.common.actions
{
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   
   public class Age extends Action
   {
       
      
      public var multiplier:Number;
      
      public function Age(param1:Number = 1)
      {
         super();
         this.multiplier = param1;
      }
      
      override public final function update(param1:Emitter, param2:Particle, param3:Number, param4:Number) : void
      {
         param2.life -= param3 * this.multiplier;
         if(param2.life < 0)
         {
            param2.life = 0;
         }
      }
      
      override public function getXMLTagName() : String
      {
         return "Age";
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
