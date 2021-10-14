package idv.cjcat.stardustextended.twoD.actions
{
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   import idv.cjcat.stardustextended.twoD.zones.RectZone;
   import idv.cjcat.stardustextended.twoD.zones.Zone;
   
   public class DeathZone extends Action2D
   {
       
      
      private var _zone:Zone;
      
      public var inverted:Boolean;
      
      public function DeathZone(param1:Zone = null, param2:Boolean = false)
      {
         super();
         priority = -6;
         this.zone = param1;
         this.inverted = param2;
      }
      
      public function get zone() : Zone
      {
         return this._zone;
      }
      
      public function set zone(param1:Zone) : void
      {
         if(!param1)
         {
            param1 = new RectZone();
         }
         this._zone = param1;
      }
      
      override public function update(param1:Emitter, param2:Particle, param3:Number, param4:Number) : void
      {
         var _loc5_:Particle2D = Particle2D(param2);
         var _loc6_:* = Boolean(this._zone.contains(_loc5_.x,_loc5_.y));
         if(this.inverted)
         {
            _loc6_ = !_loc6_;
         }
         if(_loc6_)
         {
            param2.isDead = true;
         }
      }
      
      override public function getRelatedObjects() : Array
      {
         return [this._zone];
      }
      
      override public function getXMLTagName() : String
      {
         return "DeathZone";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@zone = this._zone.name;
         _loc1_.@inverted = this.inverted;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@zone.length())
         {
            this._zone = param2.getElementByName(param1.@zone) as Zone;
         }
         if(param1.@inverted.length())
         {
            this.inverted = param1.@inverted == "true";
         }
      }
   }
}
