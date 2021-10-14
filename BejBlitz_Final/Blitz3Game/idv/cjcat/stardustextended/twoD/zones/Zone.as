package idv.cjcat.stardustextended.twoD.zones
{
   import idv.cjcat.stardustextended.common.StardustElement;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.geom.MotionData2D;
   import idv.cjcat.stardustextended.twoD.geom.Vec2D;
   import idv.cjcat.stardustextended.twoD.geom.Vec2DPool;
   
   public class Zone extends StardustElement
   {
       
      
      public var rotation:Number;
      
      protected var area:Number;
      
      public function Zone()
      {
         super();
         this.rotation = 0;
      }
      
      protected function updateArea() : void
      {
      }
      
      public function contains(param1:Number, param2:Number) : Boolean
      {
         return false;
      }
      
      public final function getPoint() : MotionData2D
      {
         var _loc2_:Vec2D = null;
         var _loc1_:MotionData2D = this.calculateMotionData2D();
         if(this.rotation != 0)
         {
            _loc2_ = Vec2DPool.get(_loc1_.x,_loc1_.y);
            _loc2_.rotateThis(this.rotation);
            _loc1_.x = _loc2_.x;
            _loc1_.y = _loc2_.y;
            Vec2DPool.recycle(_loc2_);
         }
         return _loc1_;
      }
      
      public function calculateMotionData2D() : MotionData2D
      {
         return null;
      }
      
      public final function getArea() : Number
      {
         return this.area;
      }
      
      public function clone() : Zone
      {
         return new Zone();
      }
      
      override public function getXMLTagName() : String
      {
         return "Zone";
      }
      
      override public function getElementTypeXMLTag() : XML
      {
         return <zones/>;
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@rotation = this.rotation;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         this.rotation = parseFloat(param1.@rotation);
      }
   }
}
