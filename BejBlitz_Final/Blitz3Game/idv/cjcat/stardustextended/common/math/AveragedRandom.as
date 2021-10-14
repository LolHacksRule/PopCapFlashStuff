package idv.cjcat.stardustextended.common.math
{
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   
   public class AveragedRandom extends Random
   {
       
      
      public var randomObj:Random;
      
      public var sampleCount:int;
      
      public function AveragedRandom(param1:Random = null, param2:int = 3)
      {
         super();
         this.randomObj = param1;
         this.sampleCount = param2;
      }
      
      override public final function random() : Number
      {
         if(!this.randomObj)
         {
            return 0;
         }
         var _loc1_:Number = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.sampleCount)
         {
            _loc1_ += this.randomObj.random();
            _loc2_++;
         }
         return _loc1_ / this.sampleCount;
      }
      
      override public function getRelatedObjects() : Array
      {
         return [this.randomObj];
      }
      
      override public function getXMLTagName() : String
      {
         return "AveragedRandom";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@randomObj = this.randomObj.name;
         _loc1_.@sampleCount = this.sampleCount;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@randomObj.length())
         {
            this.randomObj = param2.getElementByName(param1.@randomObj) as Random;
         }
         if(param1.@sampleCount.length())
         {
            this.sampleCount = parseInt(param1.@sampleCount);
         }
      }
   }
}
