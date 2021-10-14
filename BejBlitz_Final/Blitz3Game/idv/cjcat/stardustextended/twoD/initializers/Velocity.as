package idv.cjcat.stardustextended.twoD.initializers
{
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.geom.MotionData2D;
   import idv.cjcat.stardustextended.twoD.geom.MotionData2DPool;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   import idv.cjcat.stardustextended.twoD.zones.SinglePoint;
   import idv.cjcat.stardustextended.twoD.zones.Zone;
   
   public class Velocity extends Initializer2D
   {
       
      
      private var _zone:Zone;
      
      public function Velocity(param1:Zone = null)
      {
         super();
         this.zone = param1;
      }
      
      override public function initialize(param1:Particle) : void
      {
         var _loc3_:MotionData2D = null;
         var _loc2_:Particle2D = Particle2D(param1);
         _loc3_ = this.zone.getPoint();
         _loc2_.vx += _loc3_.x;
         _loc2_.vy += _loc3_.y;
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
      
      override public function getRelatedObjects() : Array
      {
         return [this._zone];
      }
      
      override public function getXMLTagName() : String
      {
         return "Velocity";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@zone = this.zone.name;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@zone.length())
         {
            this.zone = param2.getElementByName(param1.@zone) as Zone;
         }
      }
   }
}
