package idv.cjcat.stardustextended.twoD.actions.triggers
{
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   import idv.cjcat.stardustextended.twoD.zones.SinglePoint;
   import idv.cjcat.stardustextended.twoD.zones.Zone;
   
   public class ZoneTrigger extends ActionTrigger2D
   {
       
      
      private var _zone:Zone;
      
      public function ZoneTrigger(param1:Zone = null)
      {
         super();
         priority = -6;
         this.zone = param1;
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
      
      override public function testTrigger(param1:Emitter, param2:Particle, param3:Number) : Boolean
      {
         var _loc4_:Particle2D = Particle2D(param2);
         return this._zone.contains(_loc4_.x,_loc4_.y);
      }
      
      override public function getRelatedObjects() : Array
      {
         return [this._zone];
      }
      
      override public function getXMLTagName() : String
      {
         return "ZoneTrigger";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@zone = this._zone.name;
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
