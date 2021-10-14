package idv.cjcat.stardustextended.twoD.actions
{
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.geom.Vec2D;
   import idv.cjcat.stardustextended.twoD.geom.Vec2DPool;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   public class Explode extends Action2D
   {
       
      
      public var x:Number;
      
      public var y:Number;
      
      public var strength:Number;
      
      public var growSpeed:Number;
      
      public var maxDistance:Number;
      
      public var attenuationPower:Number;
      
      public var epsilon:Number;
      
      private var _discharged:Boolean;
      
      private var _currentInnerRadius:Number;
      
      private var _currentOuterRadius:Number;
      
      public function Explode(param1:Number = 0, param2:Number = 0, param3:Number = 5, param4:Number = 40, param5:Number = 200, param6:Number = 0.1, param7:Number = 1)
      {
         super();
         this.x = param1;
         this.y = param2;
         this.strength = param3;
         this.growSpeed = param4;
         this.maxDistance = param5;
         this.attenuationPower = param6;
         this.epsilon = param7;
         this._discharged = true;
      }
      
      public function explode() : void
      {
         this._discharged = false;
         this._currentInnerRadius = 0;
         this._currentOuterRadius = this.growSpeed;
      }
      
      override public function update(param1:Emitter, param2:Particle, param3:Number, param4:Number) : void
      {
         if(this._discharged)
         {
            return;
         }
         var _loc5_:Particle2D = Particle2D(param2);
         var _loc7_:Number;
         var _loc6_:Vec2D;
         if((_loc7_ = (_loc6_ = Vec2DPool.get(_loc5_.x - this.x,_loc5_.y - this.y)).length) < this.epsilon)
         {
            _loc7_ = this.epsilon;
         }
         if(_loc7_ >= this._currentInnerRadius && _loc7_ < this._currentOuterRadius)
         {
            _loc6_.length = this.strength * Math.pow(_loc7_,-this.attenuationPower);
            _loc5_.vx += _loc6_.x * param3;
            _loc5_.vy += _loc6_.y * param3;
         }
         Vec2DPool.recycle(_loc6_);
      }
      
      override public function postUpdate(param1:Emitter, param2:Number) : void
      {
         if(this._discharged)
         {
            return;
         }
         this._currentInnerRadius += this.growSpeed;
         this._currentOuterRadius += this.growSpeed;
         if(this._currentInnerRadius > this.maxDistance)
         {
            this._discharged = true;
         }
      }
      
      override public function getXMLTagName() : String
      {
         return "Explode";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@x = this.x;
         _loc1_.@y = this.y;
         _loc1_.@strength = this.strength;
         _loc1_.@growSpeed = this.growSpeed;
         _loc1_.@maxDistance = this.maxDistance;
         _loc1_.@attenuationPower = this.attenuationPower;
         _loc1_.@epsilon = this.epsilon;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@x.length())
         {
            this.x = parseFloat(param1.@x);
         }
         if(param1.@y.length())
         {
            this.y = parseFloat(param1.@y);
         }
         if(param1.@strength.length())
         {
            this.strength = parseFloat(param1.@strength);
         }
         if(param1.@growSpeed.length())
         {
            this.growSpeed = parseFloat(param1.@growSpeed);
         }
         if(param1.@maxDistance.length())
         {
            this.maxDistance = parseFloat(param1.@maxDistance);
         }
         if(param1.@attenuationPower.length())
         {
            this.attenuationPower = parseFloat(param1.@attenuationPower);
         }
         if(param1.@epsilon.length())
         {
            this.epsilon = parseFloat(param1.@epsilon);
         }
      }
   }
}
