package idv.cjcat.stardustextended.twoD.initializers
{
   import idv.cjcat.stardustextended.common.initializers.Alpha;
   import idv.cjcat.stardustextended.common.initializers.CollisionRadius;
   import idv.cjcat.stardustextended.common.initializers.CompositeInitializer;
   import idv.cjcat.stardustextended.common.initializers.Initializer;
   import idv.cjcat.stardustextended.common.initializers.InitializerCollection;
   import idv.cjcat.stardustextended.common.initializers.Life;
   import idv.cjcat.stardustextended.common.initializers.Mask;
   import idv.cjcat.stardustextended.common.initializers.Mass;
   import idv.cjcat.stardustextended.common.initializers.Scale;
   import idv.cjcat.stardustextended.common.math.UniformRandom;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.sd;
   import idv.cjcat.stardustextended.twoD.zones.SinglePoint;
   import idv.cjcat.stardustextended.twoD.zones.Zone;
   
   public class LazyInitializer extends CompositeInitializer
   {
       
      
      private var _posInit:Position;
      
      private var _rotationInit:Rotation;
      
      private var _rotationInitRand:UniformRandom;
      
      private var _displayObjectClassInit:DisplayObjectClass;
      
      private var _displayObjectClassParams:Array;
      
      private var _lifeInit:Life;
      
      private var _lifeInitRand:UniformRandom;
      
      private var _velocityInit:Velocity;
      
      private var _velocityInitSector:SinglePoint;
      
      private var _omegaInit:Omega;
      
      private var _omegaInitRand:UniformRandom;
      
      private var _inScaleit:Scale;
      
      private var _inScaleitRand:UniformRandom;
      
      private var _massInit:Mass;
      
      private var _massInitRand:UniformRandom;
      
      private var _maskInit:Mask;
      
      private var _collisionRadiusInit:CollisionRadius;
      
      private var _alphaInit:Alpha;
      
      private var _alphaInitRand:UniformRandom;
      
      private var additionalInitializers:InitializerCollection;
      
      public function LazyInitializer(param1:Class = null, param2:Zone = null)
      {
         this.additionalInitializers = new InitializerCollection();
         super();
         if(!param2)
         {
            param2 = new SinglePoint();
         }
         this._displayObjectClassInit = new DisplayObjectClass(param1);
         this._posInit = new Position(param2);
         this._rotationInitRand = new UniformRandom(0,180);
         this._rotationInit = new Rotation(this._rotationInitRand);
         this._lifeInitRand = new UniformRandom(50,0);
         this._lifeInit = new Life(this._lifeInitRand);
         this._velocityInitSector = new SinglePoint(0,3);
         this._velocityInit = new Velocity(this._velocityInitSector);
         this._omegaInitRand = new UniformRandom(0,0);
         this._omegaInit = new Omega(this._omegaInitRand);
         this._inScaleitRand = new UniformRandom(1,0);
         this._inScaleit = new Scale(this._inScaleitRand);
         this._massInitRand = new UniformRandom(1,0);
         this._massInit = new Mass(this._massInitRand);
         this._maskInit = new Mask(1);
         this._collisionRadiusInit = new CollisionRadius(0);
         this._alphaInitRand = new UniformRandom(1,0);
         this._alphaInit = new Alpha(this._alphaInitRand);
         this.superAddInitializer(this._displayObjectClassInit);
         this.superAddInitializer(this._posInit);
         this.superAddInitializer(this._rotationInit);
         this.superAddInitializer(this._lifeInit);
         this.superAddInitializer(this._velocityInit);
         this.superAddInitializer(this._omegaInit);
         this.superAddInitializer(this._inScaleit);
         this.superAddInitializer(this._massInit);
         this.superAddInitializer(this._maskInit);
         this.superAddInitializer(this._collisionRadiusInit);
         this.superAddInitializer(this._alphaInit);
      }
      
      public function get displayObjectClass() : Class
      {
         return this._displayObjectClassInit.displayObjectClass;
      }
      
      public function set displayObjectClass(param1:Class) : void
      {
         this._displayObjectClassInit.displayObjectClass = param1;
      }
      
      public function get displayObjectClassParams() : Array
      {
         return this._displayObjectClassInit.constructorParams;
      }
      
      public function set displayObjectClassParams(param1:Array) : void
      {
         this._displayObjectClassInit.constructorParams = param1;
      }
      
      public function get position() : Zone
      {
         return this._posInit.zone;
      }
      
      public function set position(param1:Zone) : void
      {
         this._posInit.zone = param1;
      }
      
      public function get rotation() : Number
      {
         return this._rotationInitRand.center;
      }
      
      public function set rotation(param1:Number) : void
      {
         this._rotationInitRand.center = param1;
      }
      
      public function get rotationVar() : Number
      {
         return this._rotationInitRand.radius;
      }
      
      public function set rotationVar(param1:Number) : void
      {
         this._rotationInitRand.radius = param1;
      }
      
      public function get life() : Number
      {
         return this._lifeInitRand.center;
      }
      
      public function set life(param1:Number) : void
      {
         this._lifeInitRand.center = param1;
      }
      
      public function get lifeVar() : Number
      {
         return this._lifeInitRand.radius;
      }
      
      public function set lifeVar(param1:Number) : void
      {
         this._lifeInitRand.radius = param1;
      }
      
      public function get omega() : Number
      {
         return this._omegaInitRand.center;
      }
      
      public function set omega(param1:Number) : void
      {
         this._omegaInitRand.center = param1;
      }
      
      public function get omegaVar() : Number
      {
         return this._omegaInitRand.radius;
      }
      
      public function set omegaVar(param1:Number) : void
      {
         this._omegaInitRand.radius = param1;
      }
      
      public function get scale() : Number
      {
         return this._inScaleitRand.center;
      }
      
      public function set scale(param1:Number) : void
      {
         this._inScaleitRand.center = param1;
      }
      
      public function get scaleVar() : Number
      {
         return this._inScaleitRand.radius;
      }
      
      public function set scaleVar(param1:Number) : void
      {
         this._inScaleitRand.radius = param1;
      }
      
      public function get mass() : Number
      {
         return this._massInitRand.center;
      }
      
      public function set mass(param1:Number) : void
      {
         this._massInitRand.center = param1;
      }
      
      public function get massVar() : Number
      {
         return this._massInitRand.radius;
      }
      
      public function set massVar(param1:Number) : void
      {
         this._massInitRand.radius = param1;
      }
      
      public function get mask() : int
      {
         return this._maskInit.mask;
      }
      
      public function set mask(param1:int) : void
      {
         this._maskInit.mask = param1;
      }
      
      public function get collisionRadius() : Number
      {
         return this._collisionRadiusInit.radius;
      }
      
      public function set collisionRadius(param1:Number) : void
      {
         this._collisionRadiusInit.radius = param1;
      }
      
      public function get alpha() : Number
      {
         return this._alphaInitRand.center;
      }
      
      public function set alpha(param1:Number) : void
      {
         this._alphaInitRand.center = param1;
      }
      
      public function get alphaVar() : Number
      {
         return this._alphaInitRand.radius;
      }
      
      public function set alphaVar(param1:Number) : void
      {
         this._alphaInitRand.radius = param1;
      }
      
      protected function superAddInitializer(param1:Initializer) : void
      {
         super.addInitializer(param1);
      }
      
      override public function addInitializer(param1:Initializer) : void
      {
         super.addInitializer(param1);
         this.additionalInitializers.addInitializer(param1);
      }
      
      override public function removeInitializer(param1:Initializer) : void
      {
         super.removeInitializer(param1);
         this.additionalInitializers.removeInitializer(param1);
      }
      
      override public function clearInitializers() : void
      {
         super.clearInitializers();
         this.additionalInitializers.clearInitializers();
      }
      
      override public function getRelatedObjects() : Array
      {
         return [this.position].concat(this.additionalInitializers.sd::initializers);
      }
      
      override public function getXMLTagName() : String
      {
         return "LazyInitializer";
      }
      
      override public function toXML() : XML
      {
         var _loc2_:Initializer = null;
         var _loc1_:XML = super.toXML();
         delete _loc1_.initializers;
         _loc1_.@position = this.position.name;
         _loc1_.@rotation = this.rotation;
         _loc1_.@rotationVar = this.rotationVar;
         _loc1_.@life = this.life;
         _loc1_.@lifeVar = this.lifeVar;
         _loc1_.@omega = this.omega;
         _loc1_.@omegaVar = this.omegaVar;
         _loc1_.@scale = this.scale;
         _loc1_.@scaleVar = this.scaleVar;
         _loc1_.@mass = this.mass;
         _loc1_.@mask = this.mask;
         _loc1_.@collisionRadius = this.collisionRadius;
         _loc1_.@alpha = this.alpha;
         _loc1_.@alphaVar = this.alphaVar;
         if(this.additionalInitializers.sd::initializers.length > 0)
         {
            _loc1_.appendChild(<initializers/>);
            for each(_loc2_ in this.additionalInitializers.sd::initializers)
            {
               _loc1_.initializers.appendChild(_loc2_.getXMLTag());
            }
         }
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         var _loc3_:XML = null;
         name = param1.@name;
         active = param1.@active == "true";
         if(param1.@position.length())
         {
            this.position = param2.getElementByName(param1.@position) as Zone;
         }
         if(param1.@rotation.length())
         {
            this.rotation = parseFloat(param1.@rotation);
         }
         if(param1.@rotationVar.length())
         {
            this.rotationVar = parseFloat(param1.@rotationVar);
         }
         if(param1.@life.length())
         {
            this.life = parseFloat(param1.@life);
         }
         if(param1.@lifeVar.length())
         {
            this.lifeVar = parseFloat(param1.@lifeVar);
         }
         if(param1.@omega.length())
         {
            this.omega = parseFloat(param1.@omega);
         }
         if(param1.@omegaVar.length())
         {
            this.omegaVar = parseFloat(param1.@omegaVar);
         }
         if(param1.@scale.length())
         {
            this.scale = parseFloat(param1.@scale);
         }
         if(param1.@scaleVar.length())
         {
            this.scaleVar = parseFloat(param1.@scaleVar);
         }
         if(param1.@mask.length())
         {
            this.mask = parseInt(param1.@mask);
         }
         if(param1.@mass.length())
         {
            this.mass = parseFloat(param1.@mass);
         }
         if(param1.@collisionRadius.length())
         {
            this.collisionRadius = parseFloat(param1.@collisionRadius);
         }
         if(param1.@alpha.length())
         {
            this.alpha = parseFloat(param1.@alpha);
         }
         if(param1.@alphaVar.length())
         {
            this.alphaVar = parseFloat(param1.@alphaVar);
         }
         this.additionalInitializers.clearInitializers();
         for each(_loc3_ in param1.initializers.*)
         {
            this.addInitializer(param2.getElementByName(_loc3_.@name) as Initializer);
         }
      }
   }
}
