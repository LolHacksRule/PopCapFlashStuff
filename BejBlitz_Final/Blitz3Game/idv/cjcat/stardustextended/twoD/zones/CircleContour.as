package idv.cjcat.stardustextended.twoD.zones
{
   import idv.cjcat.stardustextended.common.math.StardustMath;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.geom.MotionData2D;
   
   public class CircleContour extends Contour
   {
       
      
      public var x:Number;
      
      public var y:Number;
      
      private var _radius:Number;
      
      private var _r1SQ:Number;
      
      private var _r2SQ:Number;
      
      private var _radiusSQ:Number;
      
      private var _area:Number;
      
      public function CircleContour(param1:Number = 0, param2:Number = 0, param3:Number = 100)
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
         var _loc2_:Number = param1 + 0.5 * virtualThickness;
         var _loc3_:Number = param1 - 0.5 * virtualThickness;
         this._r1SQ = _loc2_ * _loc2_;
         this._r2SQ = _loc3_ * _loc3_;
         this.updateArea();
      }
      
      override protected function updateArea() : void
      {
         area = (this._r1SQ - this._r2SQ) * Math.PI * virtualThickness;
      }
      
      override public function contains(param1:Number, param2:Number) : Boolean
      {
         var _loc3_:Number = this.x - param1;
         var _loc4_:Number = this.y - param2;
         var _loc5_:Number;
         if((_loc5_ = _loc3_ * _loc3_ + _loc4_ * _loc4_) > this._r1SQ || _loc5_ < this._r2SQ)
         {
            return false;
         }
         return true;
      }
      
      override public function calculateMotionData2D() : MotionData2D
      {
         var _loc1_:Number = StardustMath.TWO_PI * Math.random();
         return new MotionData2D(this._radius * Math.cos(_loc1_) + this.x,this._radius * Math.sin(_loc1_) + this.y);
      }
      
      override public function getRelatedObjects() : Array
      {
         return [];
      }
      
      override public function getXMLTagName() : String
      {
         return "CircleContour";
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
