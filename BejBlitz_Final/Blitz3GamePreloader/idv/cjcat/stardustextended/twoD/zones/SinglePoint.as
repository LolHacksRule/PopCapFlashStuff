package idv.cjcat.stardustextended.twoD.zones
{
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.geom.MotionData2D;
   import idv.cjcat.stardustextended.twoD.geom.MotionData2DPool;
   
   public class SinglePoint extends Contour
   {
       
      
      public var x:Number;
      
      public var y:Number;
      
      public function SinglePoint(param1:Number = 0, param2:Number = 0)
      {
         super();
         this.x = param1;
         this.y = param2;
      }
      
      override public function contains(param1:Number, param2:Number) : Boolean
      {
         if(this.x == param1 && this.y == param2)
         {
            return true;
         }
         return false;
      }
      
      override public function calculateMotionData2D() : MotionData2D
      {
         return MotionData2DPool.get(this.x,this.y);
      }
      
      override protected function updateArea() : void
      {
         area = virtualThickness * virtualThickness * Math.PI;
      }
      
      override public function getXMLTagName() : String
      {
         return "SinglePoint";
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
