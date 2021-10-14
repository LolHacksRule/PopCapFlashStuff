package idv.cjcat.stardustextended.twoD.zones
{
   import flash.display.BitmapData;
   import flash.utils.ByteArray;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.geom.MotionData2D;
   import idv.cjcat.stardustextended.twoD.geom.MotionData2DPool;
   
   public class BitmapZone extends Zone
   {
       
      
      public var x:Number;
      
      public var y:Number;
      
      public var scaleX:Number;
      
      public var scaleY:Number;
      
      private var xCoords:Array;
      
      private var yCoords:Array;
      
      protected var bmpd:BitmapData;
      
      private var coordLength:int;
      
      public function BitmapZone(param1:BitmapData = null, param2:Number = 0, param3:Number = 0, param4:Number = 1, param5:Number = 1)
      {
         super();
         this.x = param2;
         this.y = param3;
         this.scaleX = param4;
         this.scaleY = param5;
         this.xCoords = [];
         this.yCoords = [];
         this.update(param1);
      }
      
      public function update(param1:BitmapData = null) : void
      {
         if(!param1)
         {
            param1 = new BitmapData(1,1,true,4286611584);
         }
         this.bmpd = param1.clone();
         var _loc2_:ByteArray = param1.getPixels(param1.rect);
         var _loc3_:* = _loc2_.length >> 2;
         this.xCoords.length = this.yCoords.length = _loc3_;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         this.coordLength = 0;
         var _loc6_:int = 0;
         while(_loc6_ < _loc3_)
         {
            if(_loc2_[_loc6_ * 4] > 0)
            {
               this.xCoords[this.coordLength] = _loc4_;
               this.yCoords[this.coordLength] = _loc5_;
               ++this.coordLength;
            }
            _loc4_++;
            if(_loc4_ == param1.width)
            {
               _loc4_ = 0;
               _loc5_++;
            }
            _loc6_++;
         }
      }
      
      override public function contains(param1:Number, param2:Number) : Boolean
      {
         param1 = int(param1 + 0.5);
         param2 = int(param2 + 0.5);
         if(uint(this.bmpd.getPixel32(param1,param2) >> 24))
         {
            return true;
         }
         return false;
      }
      
      override public function calculateMotionData2D() : MotionData2D
      {
         if(this.xCoords.length == 0)
         {
            return MotionData2DPool.get(this.x,this.y);
         }
         var _loc1_:int = int(this.coordLength * Math.random());
         return MotionData2DPool.get(this.xCoords[_loc1_] * this.scaleX + this.x,this.yCoords[_loc1_] * this.scaleY + this.y);
      }
      
      override public function getXMLTagName() : String
      {
         return "BitmapZone";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@x = this.x;
         _loc1_.@y = this.y;
         _loc1_.@scaleX = this.scaleX;
         _loc1_.@scaleY = this.scaleY;
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
         if(param1.@scaleX.length())
         {
            this.scaleX = parseFloat(param1.@scaleX);
         }
         if(param1.@scaleY.length())
         {
            this.scaleY = parseFloat(param1.@scaleY);
         }
      }
   }
}
