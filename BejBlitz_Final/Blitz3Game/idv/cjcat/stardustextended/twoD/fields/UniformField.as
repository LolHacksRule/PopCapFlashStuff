package idv.cjcat.stardustextended.twoD.fields
{
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.geom.MotionData2D;
   import idv.cjcat.stardustextended.twoD.geom.MotionData2DPool;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   public class UniformField extends Field
   {
       
      
      public var x:Number;
      
      public var y:Number;
      
      public function UniformField(param1:Number = 0, param2:Number = 0)
      {
         super();
         this.x = param1;
         this.y = param2;
      }
      
      override protected function calculateMotionData2D(param1:Particle2D) : MotionData2D
      {
         return MotionData2DPool.get(this.x,this.y);
      }
      
      override public function getXMLTagName() : String
      {
         return "UniformField";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@x = this.x;
         _loc1_.@y = this.y;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@x.length())
         {
            this.x = parseFloat(param1.@x);
         }
         if(param1.@y.length())
         {
            this.y = parseFloat(param1.@y);
         }
      }
   }
}
