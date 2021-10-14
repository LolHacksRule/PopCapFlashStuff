package idv.cjcat.stardustextended.common.math
{
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   
   public class UniformRandom extends Random
   {
       
      
      public var center:Number;
      
      public var radius:Number;
      
      public function UniformRandom(param1:Number = 0.5, param2:Number = 0)
      {
         super();
         this.center = param1;
         this.radius = param2;
      }
      
      override public final function random() : Number
      {
         if(this.radius)
         {
            return this.radius * 2 * (Math.random() - 0.5) + this.center;
         }
         return this.center;
      }
      
      override public function setRange(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = param2 - param1;
         this.radius = 0.5 * _loc3_;
         this.center = param1 + this.radius;
      }
      
      override public function getRange() : Array
      {
         return [this.center - this.radius,this.center + this.radius];
      }
      
      override public function getXMLTagName() : String
      {
         return "UniformRandom";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@center = this.center;
         _loc1_.@radius = this.radius;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@center.length())
         {
            this.center = parseFloat(param1.@center);
         }
         if(param1.@radius.length())
         {
            this.radius = parseFloat(param1.@radius);
         }
      }
   }
}
