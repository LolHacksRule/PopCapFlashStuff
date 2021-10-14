package idv.cjcat.stardustextended.twoD.actions
{
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.math.Random;
   import idv.cjcat.stardustextended.common.math.UniformRandom;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.geom.Vec2D;
   import idv.cjcat.stardustextended.twoD.geom.Vec2DPool;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   public class NormalDrift extends Action2D
   {
       
      
      public var massless:Boolean;
      
      public var max:Number;
      
      private var _random:Random;
      
      public function NormalDrift(param1:Number = 0.2, param2:Random = null)
      {
         super();
         this.massless = true;
         this.max = param1;
         this.random = param2;
      }
      
      public function get random() : Random
      {
         return this._random;
      }
      
      public function set random(param1:Random) : void
      {
         if(!param1)
         {
            param1 = new UniformRandom();
         }
         this._random = param1;
      }
      
      override public function update(param1:Emitter, param2:Particle, param3:Number, param4:Number) : void
      {
         var _loc5_:Particle2D = Particle2D(param2);
         var _loc6_:Vec2D = Vec2DPool.get(_loc5_.vy,_loc5_.vx);
         this.random.setRange(-this.max,this.max);
         _loc6_.length = this.random.random();
         if(!this.massless)
         {
            _loc6_.length /= _loc5_.mass;
         }
         _loc5_.vx += _loc6_.x * param3;
         _loc5_.vy += _loc6_.y * param3;
         Vec2DPool.recycle(_loc6_);
      }
      
      override public function getRelatedObjects() : Array
      {
         return [this._random];
      }
      
      override public function getXMLTagName() : String
      {
         return "NormalDrift";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@massless = this.massless;
         _loc1_.@max = this.max;
         _loc1_.@random = this._random.name;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@massless.length())
         {
            this.massless = param1.@massless == "true";
         }
         if(param1.@max.length())
         {
            this.max = parseFloat(param1.@max);
         }
         if(param1.@random.length())
         {
            this.random = param2.getElementByName(param1.@random) as Random;
         }
      }
   }
}
