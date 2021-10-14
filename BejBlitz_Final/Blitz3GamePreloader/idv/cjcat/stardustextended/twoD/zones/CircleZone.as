package idv.cjcat.stardustextended.twoD.zones
{
   import idv.cjcat.stardustextended.common.math.StardustMath;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.geom.MotionData2D;
   import idv.cjcat.stardustextended.twoD.geom.MotionData2DPool;
   
   public class CircleZone extends Zone
   {
       
      
      public var x:Number;
      
      public var y:Number;
      
      private var _radius:Number;
      
      private var _radiusSQ:Number;
      
      public function CircleZone(param1:Number = 0, param2:Number = 0, param3:Number = 100)
      {
         super();
         this.x = param1;
         this.y = param2;
         this.radius = param3;
      }
      
      public function get radius() : Number
      {
         return this._radius;
      }
      
      public function set radius(param1:Number) : void
      {
         this._radius = param1;
         this._radiusSQ = param1 * param1;
         this.updateArea();
      }
      
      override public function calculateMotionData2D() : MotionData2D
      {
         var _loc1_:Number = StardustMath.TWO_PI * Math.random();
         var _loc2_:Number = this._radius * Math.sqrt(Math.random());
         return MotionData2DPool.get(_loc2_ * Math.cos(_loc1_) + this.x,_loc2_ * Math.sin(_loc1_) + this.y);
      }
      
      override public function contains(param1:Number, param2:Number) : Boolean
      {
         var _loc3_:Number = this.x - param1;
         var _loc4_:Number = this.y - param2;
         return _loc3_ * _loc3_ + _loc4_ * _loc4_ <= this._radiusSQ ? true : false;
      }
      
      override protected function updateArea() : void
      {
         area = this._radiusSQ * Math.PI;
      }
      
      override public function getRelatedObjects() : Array
      {
         return [];
      }
      
      override public function getXMLTagName() : String
      {
         return "CircleZone";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@x = this.x;
         _loc1_.@y = this.y;
         _loc1_.@radius = this.radius;
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
         if(param1.@radius.length())
         {
            this.radius = parseFloat(param1.@radius);
         }
      }
   }
}
