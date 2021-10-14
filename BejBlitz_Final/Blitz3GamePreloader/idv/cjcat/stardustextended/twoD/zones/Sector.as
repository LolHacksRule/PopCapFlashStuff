package idv.cjcat.stardustextended.twoD.zones
{
   import idv.cjcat.stardustextended.common.math.Random;
   import idv.cjcat.stardustextended.common.math.StardustMath;
   import idv.cjcat.stardustextended.common.math.UniformRandom;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.geom.MotionData2D;
   
   public class Sector extends Zone
   {
       
      
      public var x:Number;
      
      public var y:Number;
      
      private var _randomT:Random;
      
      private var _minRadius:Number;
      
      private var _maxRadius:Number;
      
      private var _minAngle:Number;
      
      private var _maxAngle:Number;
      
      private var _minAngleRad:Number;
      
      private var _maxAngleRad:Number;
      
      public function Sector(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 100, param5:Number = 0, param6:Number = 360)
      {
         super();
         this._randomT = new UniformRandom();
         this.x = param1;
         this.y = param2;
         this._minRadius = param3;
         this._maxRadius = param4;
         this._minAngle = param5;
         this._maxAngle = param6;
         this.updateArea();
      }
      
      public function get minRadius() : Number
      {
         return this._minRadius;
      }
      
      public function set minRadius(param1:Number) : void
      {
         this._minRadius = param1;
         this.updateArea();
      }
      
      public function get maxRadius() : Number
      {
         return this._maxRadius;
      }
      
      public function set maxRadius(param1:Number) : void
      {
         this._maxRadius = param1;
         this.updateArea();
      }
      
      public function get minAngle() : Number
      {
         return this._minAngle;
      }
      
      public function set minAngle(param1:Number) : void
      {
         this._minAngle = param1;
         this.updateArea();
      }
      
      public function get maxAngle() : Number
      {
         return this._maxAngle;
      }
      
      public function set maxAngle(param1:Number) : void
      {
         this._maxAngle = param1;
         this.updateArea();
      }
      
      override public function calculateMotionData2D() : MotionData2D
      {
         if(this._maxRadius == 0)
         {
            return new MotionData2D(this.x,this.y);
         }
         this._randomT.setRange(this._minAngleRad,this._maxAngleRad);
         var _loc1_:Number = this._randomT.random();
         var _loc2_:Number = StardustMath.interpolate(0,this._minRadius,1,this._maxRadius,Math.sqrt(Math.random()));
         return new MotionData2D(_loc2_ * Math.cos(_loc1_) + this.x,_loc2_ * Math.sin(_loc1_) + this.y);
      }
      
      override protected function updateArea() : void
      {
         this._minAngleRad = this._minAngle * StardustMath.DEGREE_TO_RADIAN;
         this._maxAngleRad = this._maxAngle * StardustMath.DEGREE_TO_RADIAN;
         if(Math.abs(this._minAngleRad) > StardustMath.TWO_PI)
         {
            this._minAngleRad %= StardustMath.TWO_PI;
         }
         if(Math.abs(this._maxAngleRad) > StardustMath.TWO_PI)
         {
            this._maxAngleRad %= StardustMath.TWO_PI;
         }
         var _loc1_:Number = this._maxAngleRad - this._minAngleRad;
         var _loc2_:Number = this._minRadius * this._minRadius - this._maxRadius * this._maxRadius;
         area = Math.abs(_loc2_ * _loc1_);
      }
      
      override public function contains(param1:Number, param2:Number) : Boolean
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         _loc3_ = this.x - param1;
         _loc4_ = this.y - param2;
         var _loc5_:*;
         if(!(_loc5_ = _loc3_ * _loc3_ + _loc4_ * _loc4_ <= this._maxRadius * this._maxRadius))
         {
            return false;
         }
         var _loc6_:*;
         if(_loc6_ = _loc3_ * _loc3_ + _loc4_ * _loc4_ <= this._minRadius * this._minRadius)
         {
            return false;
         }
         var _loc7_:Number;
         if((_loc7_ = Math.atan2(_loc4_,_loc3_) + Math.PI) > this._maxAngleRad || _loc7_ < this._minAngleRad)
         {
            return false;
         }
         return true;
      }
      
      override public function getRelatedObjects() : Array
      {
         return [];
      }
      
      override public function getXMLTagName() : String
      {
         return "Sector";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@x = this.x;
         _loc1_.@y = this.y;
         _loc1_.@minRadius = this.minRadius;
         _loc1_.@maxRadius = this.maxRadius;
         _loc1_.@minAngle = this.minAngle;
         _loc1_.@maxAngle = this.maxAngle;
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
         if(param1.@minRadius.length())
         {
            this.minRadius = parseFloat(param1.@minRadius);
         }
         if(param1.@maxRadius.length())
         {
            this.maxRadius = parseFloat(param1.@maxRadius);
         }
         if(param1.@minAngle.length())
         {
            this.minAngle = parseFloat(param1.@minAngle);
         }
         if(param1.@maxAngle.length())
         {
            this.maxAngle = parseFloat(param1.@maxAngle);
         }
      }
   }
}
