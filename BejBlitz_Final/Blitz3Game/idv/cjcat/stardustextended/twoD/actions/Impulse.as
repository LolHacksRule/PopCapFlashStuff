package idv.cjcat.stardustextended.twoD.actions
{
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.fields.Field;
   import idv.cjcat.stardustextended.twoD.fields.UniformField;
   import idv.cjcat.stardustextended.twoD.geom.MotionData2D;
   import idv.cjcat.stardustextended.twoD.geom.MotionData2DPool;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   public class Impulse extends Action2D
   {
       
      
      private var _field:Field;
      
      private var _discharged:Boolean;
      
      public function Impulse(param1:Field = null)
      {
         super();
         this.field = param1;
         this._discharged = true;
      }
      
      public function get field() : Field
      {
         return this._field;
      }
      
      public function set field(param1:Field) : void
      {
         if(!param1)
         {
            param1 = new UniformField(0,0);
         }
         this._field = param1;
      }
      
      public function impulse() : void
      {
         this._discharged = false;
      }
      
      override public function update(param1:Emitter, param2:Particle, param3:Number, param4:Number) : void
      {
         if(this._discharged)
         {
            return;
         }
         var _loc5_:Particle2D = Particle2D(param2);
         var _loc6_:MotionData2D = this.field.getMotionData2D(_loc5_);
         _loc5_.vx += _loc6_.x * param3;
         _loc5_.vy += _loc6_.y * param3;
         MotionData2DPool.recycle(_loc6_);
      }
      
      override public function postUpdate(param1:Emitter, param2:Number) : void
      {
         this._discharged = true;
      }
      
      override public function getRelatedObjects() : Array
      {
         return [this._field];
      }
      
      override public function getXMLTagName() : String
      {
         return "Impulse";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@field = this.field.name;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@field.length())
         {
            this.field = param2.getElementByName(param1.@field) as Field;
         }
      }
   }
}
