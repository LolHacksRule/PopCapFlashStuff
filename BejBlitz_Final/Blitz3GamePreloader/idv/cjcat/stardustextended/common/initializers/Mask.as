package idv.cjcat.stardustextended.common.initializers
{
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   
   public class Mask extends Initializer
   {
       
      
      private var _mask:int;
      
      public function Mask(param1:int = 1)
      {
         super();
         priority = 1;
         this._mask = param1;
      }
      
      override public final function initialize(param1:Particle) : void
      {
         param1.mask = this._mask;
      }
      
      public function get mask() : int
      {
         return this._mask;
      }
      
      public function set mask(param1:int) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         this._mask = param1;
      }
      
      override public function getXMLTagName() : String
      {
         return "Mask";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@mask = this.mask;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@mask.length())
         {
            this.mask = parseInt(param1.@mask);
         }
      }
   }
}
