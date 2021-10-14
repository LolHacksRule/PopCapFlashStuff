package idv.cjcat.stardustextended.common.clocks
{
   import idv.cjcat.stardustextended.common.math.Random;
   import idv.cjcat.stardustextended.common.math.UniformRandom;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   
   public class RandomClock extends Clock
   {
       
      
      private var _random:Random;
      
      public function RandomClock(param1:Random = null)
      {
         super();
         this.random = param1;
      }
      
      override public final function getTicks(param1:Number) : int
      {
         var _loc2_:Number = this.random.random() * param1;
         var _loc3_:* = _loc2_ | 0;
         return _loc3_ + int(_loc2_ - _loc3_ > Math.random() ? 1 : 0);
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
         return "RandomClock";
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
