package idv.cjcat.stardustextended.twoD.initializers
{
   import flash.geom.Point;
   import flash.net.registerClassAlias;
   import flash.utils.ByteArray;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.geom.MotionData2D;
   import idv.cjcat.stardustextended.twoD.geom.MotionData2DPool;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   import idv.cjcat.stardustextended.twoD.utils.Base64;
   import idv.cjcat.stardustextended.twoD.zones.SinglePoint;
   import idv.cjcat.stardustextended.twoD.zones.Zone;
   
   public class PositionAnimated extends Initializer2D
   {
       
      
      private var _zone:Zone;
      
      private var _positons:Vector.<Point>;
      
      private var currentPos:uint;
      
      public var inheritVelocity:Boolean = false;
      
      public function PositionAnimated(param1:Zone = null)
      {
         super();
         this.zone = param1;
      }
      
      override public function doInitialize(param1:Vector.<Particle>, param2:Number) : void
      {
         if(this._positons)
         {
            this.currentPos = param2 % this._positons.length;
         }
         super.doInitialize(param1,param2);
      }
      
      override public function initialize(param1:Particle) : void
      {
         var _loc4_:int = 0;
         var _loc2_:Particle2D = Particle2D(param1);
         var _loc3_:MotionData2D = this.zone.getPoint();
         if(this._positons)
         {
            _loc2_.x = _loc3_.x + this._positons[this.currentPos].x;
            _loc2_.y = _loc3_.y + this._positons[this.currentPos].y;
            if(this.inheritVelocity)
            {
               _loc4_ = this.currentPos > 0 ? int(this.currentPos - 1) : int(this._positons.length - 1);
               _loc2_.vx += this._positons[this.currentPos].x - this._positons[_loc4_].x;
               _loc2_.vy += this._positons[this.currentPos].y - this._positons[_loc4_].y;
            }
         }
         else
         {
            _loc2_.x = _loc3_.x;
            _loc2_.y = _loc3_.y;
         }
         MotionData2DPool.recycle(_loc3_);
      }
      
      public function get zone() : Zone
      {
         return this._zone;
      }
      
      public function set zone(param1:Zone) : void
      {
         if(!param1)
         {
            param1 = new SinglePoint(0,0);
         }
         this._zone = param1;
      }
      
      public function set positions(param1:Vector.<Point>) : void
      {
         this._positons = param1;
      }
      
      public function get positions() : Vector.<Point>
      {
         return this._positons;
      }
      
      public function get currentPosition() : Point
      {
         if(this._positons)
         {
            return this._positons[this.currentPos];
         }
         return null;
      }
      
      override public function getRelatedObjects() : Array
      {
         return [this._zone];
      }
      
      override public function getXMLTagName() : String
      {
         return "PositionAnimated";
      }
      
      override public function toXML() : XML
      {
         var _loc2_:ByteArray = null;
         var _loc1_:XML = super.toXML();
         _loc1_.@zone = this.zone.name;
         _loc1_.@inheritVelocity = this.inheritVelocity;
         if(this._positons && this._positons.length > 0)
         {
            registerClassAlias("String",String);
            registerClassAlias("Point",Point);
            registerClassAlias("VecPoint",Vector.<Point> as Class);
            _loc2_ = new ByteArray();
            _loc2_.writeObject(this._positons);
            _loc1_.@positions = Base64.encode(_loc2_);
         }
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         var _loc3_:ByteArray = null;
         super.parseXML(param1,param2);
         if(param1.@zone.length())
         {
            this.zone = param2.getElementByName(param1.@zone) as Zone;
         }
         if(param1.@positions.length())
         {
            registerClassAlias("String",String);
            registerClassAlias("Point",Point);
            registerClassAlias("VecPoint",Vector.<Point> as Class);
            _loc3_ = Base64.decode(param1.@positions);
            _loc3_.position = 0;
            this._positons = _loc3_.readObject();
         }
         if(param1.@inheritVelocity.length())
         {
            this.inheritVelocity = param1.@inheritVelocity == "true";
         }
      }
   }
}
