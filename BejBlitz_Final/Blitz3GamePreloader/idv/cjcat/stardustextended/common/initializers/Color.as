package idv.cjcat.stardustextended.common.initializers
{
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   
   public class Color extends Initializer
   {
       
      
      public var color:uint;
      
      public function Color(param1:uint = 16777215)
      {
         super();
         this.color = param1;
      }
      
      override public final function initialize(param1:Particle) : void
      {
         param1.color = this.color;
      }
      
      override public function getXMLTagName() : String
      {
         return "Color";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@color = this.color.toString(16);
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@color.length())
         {
            this.color = parseInt(param1.@color,16);
         }
      }
   }
}
