package idv.cjcat.stardustextended.twoD.initializers
{
   import idv.cjcat.stardustextended.common.math.Random;
   import idv.cjcat.stardustextended.common.math.UniformRandom;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   public class Omega extends Initializer2D
   {
       
      
      private var _random:Random;
      
      public function Omega(param1:Random = null)
      {
         super();
         this.random = param1;
      }
      
      override public function initialize(param1:Particle) : void
      {
         var _loc2_:Particle2D = Particle2D(param1);
         _loc2_.omega = this._random.random();
      }
      
      public function get random() : Random
      {
         return this._random;
      }
      
      public function set random(param1:Random) : void
      {
         if(!param1)
         {
            param1 = new UniformRandom(0,0);
         }
         this._random = param1;
      }
      
      override public function getRelatedObjects() : Array
      {
         return [this._random];
      }
      
      override public function getXMLTagName() : String
      {
         return "Omega";
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
