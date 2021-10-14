package idv.cjcat.stardustextended.twoD.zones
{
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.geom.MotionData2D;
   
   public class Composite extends Zone
   {
       
      
      private var _zones:Vector.<Zone>;
      
      public function Composite()
      {
         super();
         this._zones = new Vector.<Zone>();
      }
      
      override public function calculateMotionData2D() : MotionData2D
      {
         var _loc1_:Number = 0;
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < this._zones.length)
         {
            _loc1_ += Zone(this._zones[_loc3_]).getArea();
            _loc2_.push(_loc1_);
            _loc3_++;
         }
         var _loc4_:Number = Math.random() * _loc1_;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc4_ <= _loc2_[_loc3_])
            {
               return Zone(this._zones[_loc3_]).calculateMotionData2D();
            }
            _loc3_++;
         }
         return new MotionData2D();
      }
      
      override public function contains(param1:Number, param2:Number) : Boolean
      {
         var _loc3_:Zone = null;
         for each(_loc3_ in this._zones)
         {
            if(_loc3_.contains(param1,param2))
            {
               return true;
            }
         }
         return false;
      }
      
      public final function addZone(param1:Zone) : void
      {
         this._zones.push(param1);
      }
      
      public final function removeZone(param1:Zone) : void
      {
         var _loc2_:int = 0;
         while((_loc2_ = this._zones.indexOf(param1)) >= 0)
         {
            this._zones.splice(_loc2_,1);
         }
      }
      
      public final function clearZones() : void
      {
         this._zones = new Vector.<Zone>();
      }
      
      public function get zones() : Vector.<Zone>
      {
         return this._zones;
      }
      
      override protected function updateArea() : void
      {
      }
      
      override public function getRelatedObjects() : Array
      {
         var _loc1_:int = this._zones.length;
         var _loc2_:Array = new Array(_loc1_);
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_[_loc3_] = this._zones[_loc3_];
            _loc3_++;
         }
         return _loc2_;
      }
      
      override public function getXMLTagName() : String
      {
         return "CompositeZone";
      }
      
      override public function toXML() : XML
      {
         var _loc2_:Zone = null;
         var _loc1_:XML = super.toXML();
         if(this._zones.length > 0)
         {
            _loc1_.appendChild(<zones/>);
            for each(_loc2_ in this._zones)
            {
               _loc1_.zones.appendChild(_loc2_.getXMLTag());
            }
         }
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         var _loc3_:XML = null;
         super.parseXML(param1,param2);
         this.clearZones();
         for each(_loc3_ in param1.zones.*)
         {
            this.addZone(param2.getElementByName(_loc3_.@name) as Zone);
         }
      }
   }
}
