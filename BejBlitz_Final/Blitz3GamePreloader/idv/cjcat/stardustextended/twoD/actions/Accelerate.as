package idv.cjcat.stardustextended.twoD.actions
{
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.geom.Vec2D;
   import idv.cjcat.stardustextended.twoD.geom.Vec2DPool;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   public class Accelerate extends Action2D
   {
       
      
      public var acceleration:Number;
      
      public function Accelerate(param1:Number = 0.1)
      {
         super();
         this.acceleration = param1;
      }
      
      override public function update(param1:Emitter, param2:Particle, param3:Number, param4:Number) : void
      {
         var _loc6_:Vec2D = null;
         var _loc5_:Particle2D = Particle2D(param2);
         var _loc7_:Number;
         if((_loc7_ = (_loc6_ = Vec2DPool.get(_loc5_.vx,_loc5_.vy)).length) > 0)
         {
            _loc6_.length = _loc7_ + this.acceleration * param3;
            _loc5_.vx = _loc6_.x;
            _loc5_.vy = _loc6_.y;
         }
         Vec2DPool.recycle(_loc6_);
      }
      
      override public function getXMLTagName() : String
      {
         return "Accelerate";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@acceleration = this.acceleration;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@acceleration.length())
         {
            this.acceleration = parseFloat(param1.@acceleration);
         }
      }
   }
}
