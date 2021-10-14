package idv.cjcat.stardustextended.twoD.actions
{
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.math.StardustMath;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   public class Oriented extends Action2D
   {
       
      
      public var factor:Number;
      
      public var offset:Number;
      
      private var f:Number;
      
      private var os:Number;
      
      public function Oriented(param1:Number = 1, param2:Number = 0)
      {
         super();
         priority = -6;
         this.factor = param1;
         this.offset = param2;
      }
      
      override public function preUpdate(param1:Emitter, param2:Number) : void
      {
         this.f = Math.pow(this.factor,1 / param2);
         this.os = this.offset + 90;
      }
      
      override public function update(param1:Emitter, param2:Particle, param3:Number, param4:Number) : void
      {
         var _loc5_:Particle2D = Particle2D(param2);
         var _loc6_:Number = Math.atan2(_loc5_.vy,_loc5_.vx) * StardustMath.RADIAN_TO_DEGREE + this.os - _loc5_.rotation;
         _loc5_.rotation += this.f * _loc6_;
      }
      
      override public function getXMLTagName() : String
      {
         return "Oriented";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@factor = this.factor;
         _loc1_.@offset = this.offset;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@factor.length())
         {
            this.factor = parseFloat(param1.@factor);
         }
         if(param1.@offset.length())
         {
            this.offset = parseFloat(param1.@offset);
         }
      }
   }
}
