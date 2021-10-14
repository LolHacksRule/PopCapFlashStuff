package idv.cjcat.stardustextended.twoD.actions
{
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.initializers.Initializer;
   import idv.cjcat.stardustextended.common.initializers.InitializerCollector;
   import idv.cjcat.stardustextended.common.math.Random;
   import idv.cjcat.stardustextended.common.math.StardustMath;
   import idv.cjcat.stardustextended.common.math.UniformRandom;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.sd;
   import idv.cjcat.stardustextended.twoD.geom.Vec2D;
   import idv.cjcat.stardustextended.twoD.geom.Vec2DPool;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   import idv.cjcat.stardustextended.twoD.particles.PooledParticle2DFactory;
   
   public class Spawn extends Action2D implements InitializerCollector
   {
       
      
      public var inheritDirection:Boolean;
      
      public var inheritVelocity:Boolean;
      
      private var _countRandom:Random;
      
      private var _factory:PooledParticle2DFactory;
      
      private var p2D:Particle2D;
      
      private var particles:Vector.<Particle>;
      
      private var v:Vec2D;
      
      public function Spawn(param1:Random = null, param2:Boolean = true, param3:Boolean = false)
      {
         super();
         this.inheritDirection = param2;
         this.inheritVelocity = param3;
         this.countRandom = param1;
         this._factory = new PooledParticle2DFactory();
      }
      
      override public function update(param1:Emitter, param2:Particle, param3:Number, param4:Number) : void
      {
         var _loc5_:Particle2D = null;
         this.p2D = Particle2D(param2);
         this.particles = this._factory.createParticles(StardustMath.randomFloor(this._countRandom.random()),param4);
         var _loc6_:int = 0;
         while(_loc6_ < this.particles.length)
         {
            _loc5_ = Particle2D(this.particles[_loc6_]);
            _loc5_.x += this.p2D.x;
            _loc5_.y += this.p2D.y;
            if(this.inheritVelocity)
            {
               _loc5_.vx += this.p2D.vx;
               _loc5_.vy += this.p2D.vy;
            }
            if(this.inheritDirection)
            {
               this.v = Vec2DPool.get(_loc5_.vx,_loc5_.vy);
               this.v.rotateThis(Math.atan2(this.p2D.vx,-this.p2D.vy),true);
               _loc5_.vx = this.v.x;
               _loc5_.vy = this.v.y;
               Vec2DPool.recycle(this.v);
            }
            _loc6_++;
         }
         param1.addParticles(this.particles);
      }
      
      public function addInitializer(param1:Initializer) : void
      {
         this._factory.addInitializer(param1);
      }
      
      public function removeInitializer(param1:Initializer) : void
      {
         this._factory.removeInitializer(param1);
      }
      
      public function clearInitializers() : void
      {
         this._factory.clearInitializers();
      }
      
      public function get countRandom() : Random
      {
         return this._countRandom;
      }
      
      public function set countRandom(param1:Random) : void
      {
         if(!param1)
         {
            param1 = new UniformRandom(0,0);
         }
         this._countRandom = param1;
      }
      
      override public function getRelatedObjects() : Array
      {
         return [this._countRandom].concat(this._factory.sd::initializerCollection.sd::initializers);
      }
      
      override public function getXMLTagName() : String
      {
         return "Spawn";
      }
      
      override public function toXML() : XML
      {
         var _loc2_:Initializer = null;
         var _loc1_:XML = super.toXML();
         _loc1_.@inheritDirection = this.inheritDirection;
         _loc1_.@inheritVelocity = this.inheritVelocity;
         _loc1_.@countRandom = this._countRandom.name;
         if(this._factory.sd::initializerCollection.sd::initializers.length > 0)
         {
            _loc1_.appendChild(<initializers/>);
            for each(_loc2_ in this._factory.sd::initializerCollection.sd::initializers)
            {
               _loc1_.initializers.appendChild(_loc2_.getXMLTag());
            }
         }
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         var _loc3_:XML = null;
         super.parseXML(param1,param2);
         if(param1.@inheritDirection.length())
         {
            this.inheritDirection = param1.@inheritDirection == "true";
         }
         if(param1.@inheritVelocity.length())
         {
            this.inheritVelocity = param1.@inheritVelocity == "true";
         }
         if(param1.@countRandom.length())
         {
            this.countRandom = param2.getElementByName(param1.@countRandom) as Random;
         }
         this.clearInitializers();
         for each(_loc3_ in param1.initializers.*)
         {
            this.addInitializer(param2.getElementByName(_loc3_.@name) as Initializer);
         }
      }
   }
}
