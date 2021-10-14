package idv.cjcat.stardustextended.twoD.zones
{
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   
   public class RectContour extends Composite
   {
       
      
      private var _virtualThickness:Number;
      
      private var _x:Number;
      
      private var _y:Number;
      
      private var _width:Number;
      
      private var _height:Number;
      
      private var _line1:Line;
      
      private var _line2:Line;
      
      private var _line3:Line;
      
      private var _line4:Line;
      
      public function RectContour(param1:Number = 0, param2:Number = 0, param3:Number = 640, param4:Number = 480)
      {
         super();
         this._line1 = new Line();
         this._line2 = new Line();
         this._line3 = new Line();
         this._line4 = new Line();
         addZone(this._line1);
         addZone(this._line2);
         addZone(this._line3);
         addZone(this._line4);
         this.virtualThickness = 1;
         this.x = param1;
         this.y = param2;
         this.width = param3;
         this.height = param4;
      }
      
      public function get x() : Number
      {
         return this._x;
      }
      
      public function set x(param1:Number) : void
      {
         this._x = param1;
         this.updateContour();
         this.updateArea();
      }
      
      public function get y() : Number
      {
         return this._y;
      }
      
      public function set y(param1:Number) : void
      {
         this._y = param1;
         this.updateContour();
         this.updateArea();
      }
      
      public function get width() : Number
      {
         return this._width;
      }
      
      public function set width(param1:Number) : void
      {
         this._width = param1;
         this.updateContour();
         this.updateArea();
      }
      
      public function get height() : Number
      {
         return this._height;
      }
      
      public function set height(param1:Number) : void
      {
         this._height = param1;
         this.updateContour();
         this.updateArea();
      }
      
      public function get virtualThickness() : Number
      {
         return this._virtualThickness;
      }
      
      public function set virtualThickness(param1:Number) : void
      {
         this._virtualThickness = param1;
         this._line1.virtualThickness = param1;
         this._line2.virtualThickness = param1;
         this._line3.virtualThickness = param1;
         this._line4.virtualThickness = param1;
         this.updateArea();
      }
      
      private function updateContour() : void
      {
         this._line1.x1 = this.x;
         this._line1.y1 = this.y;
         this._line1.x2 = this.x + this.width;
         this._line1.y2 = this.y;
         this._line2.x1 = this.x;
         this._line2.y1 = this.y + this.height;
         this._line2.x2 = this.x + this.width;
         this._line2.y2 = this.y + this.height;
         this._line3.x1 = this.x;
         this._line3.y1 = this.y;
         this._line3.x2 = this.x;
         this._line3.y2 = this.y + this.height;
         this._line4.x1 = this.x + this.width;
         this._line4.y1 = this.y;
         this._line4.x2 = this.x + this.width;
         this._line4.y2 = this.y + this.height;
      }
      
      override protected function updateArea() : void
      {
         var _loc1_:Line = null;
         area = 0;
         for each(_loc1_ in zones)
         {
            area += _loc1_.getArea();
         }
      }
      
      override public function getRelatedObjects() : Array
      {
         return [];
      }
      
      override public function getXMLTagName() : String
      {
         return "RectContour";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         delete _loc1_.zones;
         _loc1_.@virtualThickness = this.virtualThickness;
         _loc1_.@x = this.x;
         _loc1_.@y = this.y;
         _loc1_.@width = this.width;
         _loc1_.@height = this.height;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@virtualThickness.length())
         {
            this.virtualThickness = parseFloat(param1.@virtualThickness);
         }
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
      }
   }
}
