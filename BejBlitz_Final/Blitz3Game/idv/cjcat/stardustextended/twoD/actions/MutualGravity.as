package idv.cjcat.stardustextended.twoD.actions
{
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.geom.Vec2D;
   import idv.cjcat.stardustextended.twoD.geom.Vec2DPool;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   public class MutualGravity extends MutualAction
   {
       
      
      public var strength:Number;
      
      public var epsilon:Number;
      
      public var attenuationPower:Number;
      
      public var massless:Boolean;
      
      public function MutualGravity(param1:Number = 1, param2:Number = 100, param3:Number = 1)
      {
         super();
         priority = -3;
         this.strength = param1;
         this.maxDistance = param2;
         this.epsilon = 1;
         this.attenuationPower = param3;
         this.massless = true;
      }
      
      override protected function doMutualAction(param1:Particle2D, param2:Particle2D, param3:Number) : void
      {
         var _loc8_:Number = NaN;
         var _loc4_:Number = param1.x - param2.x;
         var _loc5_:Number = param1.y - param2.y;
         var _loc6_:Number;
         if((_loc6_ = Math.sqrt(_loc4_ * _loc4_ + _loc5_ * _loc5_)) < this.epsilon)
         {
            _loc6_ = this.epsilon;
         }
         var _loc7_:Vec2D = Vec2DPool.get(_loc4_,_loc5_);
         if(this.massless)
         {
            _loc7_.length = this.strength * Math.pow(_loc6_,-this.attenuationPower);
            param2.vx += _loc7_.x * param3;
            param2.vy += _loc7_.y * param3;
            param1.vx -= _loc7_.x * param3;
            param1.vy -= _loc7_.y * param3;
         }
         else
         {
            _loc8_ = this.strength * param1.mass * param2.mass * Math.pow(_loc6_,-this.attenuationPower);
            _loc7_.length = _loc8_ / param2.mass;
            param2.vx += _loc7_.x * param3;
            param2.vy += _loc7_.y * param3;
            _loc7_.length = _loc8_ / param1.mass;
            param1.vx -= _loc7_.x * param3;
            param1.vy -= _loc7_.y * param3;
         }
         Vec2DPool.recycle(_loc7_);
      }
      
      override public function getXMLTagName() : String
      {
         return "MutualGravity";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@strength = this.strength;
         _loc1_.@epsilon = this.epsilon;
         _loc1_.@attenuationPower = this.attenuationPower;
         _loc1_.@massless = this.massless;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@strength.length())
         {
            this.strength = parseFloat(param1.@strength);
         }
         if(param1.@epsilon.length())
         {
            this.epsilon = parseFloat(param1.@epsilon);
         }
         if(param1.@attenuationPower.length())
         {
            this.attenuationPower = parseFloat(param1.@attenuationPower);
         }
         if(param1.@massless.length())
         {
            this.massless = param1.@massless == "true";
         }
      }
   }
}
