package idv.cjcat.stardustextended.twoD.zones
{
   import idv.cjcat.stardustextended.common.math.Random;
   import idv.cjcat.stardustextended.common.math.StardustMath;
   import idv.cjcat.stardustextended.common.math.UniformRandom;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.geom.MotionData2D;
   
   public class Line extends Contour
   {
       
      
      private var _x1:Number;
      
      private var _y1:Number;
      
      private var _x2:Number;
      
      private var _y2:Number;
      
      private var _random:Random;
      
      public function Line(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Random = null)
      {
         super();
         this._x1 = param1;
         this._y1 = param2;
         this._x2 = param3;
         this._y2 = param4;
         this.random = param5;
         this.updateArea();
      }
      
      public function get x1() : Number
      {
         return this._x1;
      }
      
      public function set x1(param1:Number) : void
      {
         this._x1 = param1;
         this.updateArea();
      }
      
      public function get y1() : Number
      {
         return this._y1;
      }
      
      public function set y1(param1:Number) : void
      {
         this._y1 = param1;
         this.updateArea();
      }
      
      public function get x2() : Number
      {
         return this._x2;
      }
      
      public function set x2(param1:Number) : void
      {
         this._x2 = param1;
         this.updateArea();
      }
      
      public function get y2() : Number
      {
         return this._y2;
      }
      
      public function set y2(param1:Number) : void
      {
         this._y2 = param1;
         this.updateArea();
      }
      
      public function get random() : Random
      {
         return this._random;
      }
      
      public function set random(param1:Random) : void
      {
         if(!param1)
         {
            param1 = new UniformRandom();
         }
         this._random = param1;
      }
      
      override public function calculateMotionData2D() : MotionData2D
      {
         this._random.setRange(0,1);
         var _loc1_:Number = this._random.random();
         return new MotionData2D(StardustMath.interpolate(0,this._x1,1,this._x2,_loc1_),StardustMath.interpolate(0,this._y1,1,this._y2,_loc1_));
      }
      
      override public function contains(param1:Number, param2:Number) : Boolean
      {
         if(param1 < this._x1 && param1 < this._x2)
         {
            return false;
         }
         if(param1 > this._x1 && param1 > this._x2)
         {
            return false;
         }
         if((param1 - this._x1) / (this._x2 - this._x1) == (param2 - this._y1) / (this._y2 - this._y1))
         {
            return true;
         }
         return false;
      }
      
      override protected function updateArea() : void
      {
         var _loc1_:Number = this._x1 - this._x2;
         var _loc2_:Number = this._y1 - this._y2;
         area = Math.sqrt(_loc1_ * _loc1_ + _loc2_ * _loc2_) * virtualThickness;
      }
      
      override public function getXMLTagName() : String
      {
         return "Line";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@x1 = this._x1;
         _loc1_.@y1 = this._y1;
         _loc1_.@x2 = this._x2;
         _loc1_.@y2 = this._y2;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@x1.length())
         {
            this._x1 = parseFloat(param1.@x1);
         }
         if(param1.@y1.length())
         {
            this._y1 = parseFloat(param1.@y1);
         }
         if(param1.@x2.length())
         {
            this._x2 = parseFloat(param1.@x2);
         }
         if(param1.@y2.length())
         {
            this._y2 = parseFloat(param1.@y2);
         }
         this.updateArea();
      }
   }
}
