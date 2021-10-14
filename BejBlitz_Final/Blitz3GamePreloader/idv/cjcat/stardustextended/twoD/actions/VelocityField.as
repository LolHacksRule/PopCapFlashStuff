package idv.cjcat.stardustextended.twoD.actions
{
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.fields.Field;
   import idv.cjcat.stardustextended.twoD.geom.MotionData2D;
   import idv.cjcat.stardustextended.twoD.geom.MotionData2DPool;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   public class VelocityField extends Action2D
   {
       
      
      public var field:Field;
      
      public function VelocityField(param1:Field = null)
      {
         super();
         priority = -2;
         this.field = param1;
      }
      
      override public function update(param1:Emitter, param2:Particle, param3:Number, param4:Number) : void
      {
         var _loc5_:Particle2D = null;
         var _loc6_:MotionData2D = null;
         if(!this.field)
         {
            return;
         }
         _loc5_ = Particle2D(param2);
         _loc6_ = this.field.getMotionData2D(_loc5_);
         _loc5_.vx = _loc6_.x;
         _loc5_.vy = _loc6_.y;
         MotionData2DPool.recycle(_loc6_);
      }
      
      override public function getRelatedObjects() : Array
      {
         if(this.field != null)
         {
            return [this.field];
         }
         return [];
      }
      
      override public function getXMLTagName() : String
      {
         return "VelocityField";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         if(!this.field)
         {
            _loc1_.@field = "null";
         }
         else
         {
            _loc1_.@field = this.field.name;
         }
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@field == "null")
         {
            this.field = null;
         }
         else if(param1.@field.length())
         {
            this.field = param2.getElementByName(param1.@field) as Field;
         }
      }
   }
}
