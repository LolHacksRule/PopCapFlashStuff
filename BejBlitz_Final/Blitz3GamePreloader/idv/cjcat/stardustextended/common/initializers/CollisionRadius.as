package idv.cjcat.stardustextended.common.initializers
{
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   
   public class CollisionRadius extends Initializer
   {
       
      
      public var radius:Number;
      
      public function CollisionRadius(param1:Number = 0)
      {
         super();
         this.radius = param1;
      }
      
      override public final function initialize(param1:Particle) : void
      {
         param1.collisionRadius = this.radius;
      }
      
      override public function getXMLTagName() : String
      {
         return "CollisionRadius";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@radius = this.radius;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@radius.length())
         {
            this.radius = parseFloat(param1.@radius);
         }
      }
   }
}
