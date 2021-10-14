package idv.cjcat.stardustextended.twoD.zones
{
   import idv.cjcat.stardustextended.common.math.Random;
   import idv.cjcat.stardustextended.common.math.UniformRandom;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.geom.MotionData2D;
   
   public class RectZone extends Zone
   {
       
      
      public var x:Number;
      
      public var y:Number;
      
      private var _randomX:Random;
      
      private var _randomY:Random;
      
      private var _width:Number;
      
      private var _height:Number;
      
      public function RectZone(param1:Number = 0, param2:Number = 0, param3:Number = 640, param4:Number = 480, param5:Random = null, param6:Random = null)
      {
         super();
         if(!param5)
         {
            param5 = new UniformRandom();
         }
         if(!param6)
         {
            param6 = new UniformRandom();
         }
         this.x = param1;
         this.y = param2;
         this.width = param3;
         this.height = param4;
         this.randomX = param5;
         this.randomY = param6;
      }
      
      public function get width() : Number
      {
         return this._width;
      }
      
      public function set width(param1:Number) : void
      {
         this._width = param1;
         this.updateArea();
      }
      
      public function get height() : Number
      {
         return this._height;
      }
      
      public function set height(param1:Number) : void
      {
         this._height = param1;
         this.updateArea();
      }
      
      public function get randomX() : Random
      {
         return this._randomX;
      }
      
      public function set randomX(param1:Random) : void
      {
         if(!param1)
         {
            param1 = new UniformRandom();
         }
         this._randomX = param1;
      }
      
      public function get randomY() : Random
      {
         return this._randomY;
      }
      
      public function set randomY(param1:Random) : void
      {
         if(!param1)
         {
            param1 = new UniformRandom();
         }
         this._randomY = param1;
      }
      
      override protected function updateArea() : void
      {
         area = this._width * this._height;
      }
      
      override public function calculateMotionData2D() : MotionData2D
      {
         this.randomX.setRange(this.x,this.x + this._width);
         this.randomY.setRange(this.y,this.y + this._height);
         return new MotionData2D(this.randomX.random(),this.randomY.random());
      }
      
      override public function contains(param1:Number, param2:Number) : Boolean
      {
         if(param1 < this.x || param1 > this.x + this.width)
         {
            return false;
         }
         if(param2 < this.y || param2 > this.y + this.height)
         {
            return false;
         }
         return true;
      }
      
      override public function getRelatedObjects() : Array
      {
         return [this._randomX,this._randomY];
      }
      
      override public function getXMLTagName() : String
      {
         return "RectZone";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@x = this.x;
         _loc1_.@y = this.y;
         _loc1_.@width = this.width;
         _loc1_.@height = this.height;
         _loc1_.@randomX = this.randomX.name;
         _loc1_.@randomY = this.randomY.name;
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
         if(param1.@width.length())
         {
            this.width = parseFloat(param1.@width);
         }
         if(param1.@height.length())
         {
            this.height = parseFloat(param1.@height);
         }
         if(param1.@randomX.length())
         {
            this.randomX = param2.getElementByName(param1.@randomX) as Random;
         }
         if(param1.@randomY.length())
         {
            this.randomY = param2.getElementByName(param1.@randomY) as Random;
         }
      }
   }
}
