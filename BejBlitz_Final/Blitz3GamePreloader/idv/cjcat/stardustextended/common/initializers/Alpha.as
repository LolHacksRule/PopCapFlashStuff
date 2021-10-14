package idv.cjcat.stardustextended.common.initializers
{
   import idv.cjcat.stardustextended.common.math.Random;
   import idv.cjcat.stardustextended.common.math.UniformRandom;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   
   public class Alpha extends Initializer
   {
       
      
      private var _random:Random;
      
      public function Alpha(param1:Random = null)
      {
         super();
         this.random = param1;
      }
      
      override public final function initialize(param1:Particle) : void
      {
         param1.initAlpha = param1.alpha = this.random.random();
      }
      
      public function get random() : Random
      {
         return this._random;
      }
      
      public function set random(param1:Random) : void
      {
         if(!param1)
         {
            param1 = new UniformRandom(1,0);
         }
         this._random = param1;
      }
      
      override public function getRelatedObjects() : Array
      {
         return [this._random];
      }
      
      override public function getXMLTagName() : String
      {
         return "Alpha";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@random = this._random.name;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@random.length())
         {
            this.random = param2.getElementByName(param1.@random) as Random;
         }
      }
   }
}
