package idv.cjcat.stardustextended.common.emitters
{
   import idv.cjcat.stardustextended.cjsignals.ISignal;
   import idv.cjcat.stardustextended.cjsignals.Signal;
   import idv.cjcat.stardustextended.common.StardustElement;
   import idv.cjcat.stardustextended.common.actions.Action;
   import idv.cjcat.stardustextended.common.actions.ActionCollection;
   import idv.cjcat.stardustextended.common.actions.ActionCollector;
   import idv.cjcat.stardustextended.common.clocks.Clock;
   import idv.cjcat.stardustextended.common.clocks.ImpulseClock;
   import idv.cjcat.stardustextended.common.clocks.SteadyClock;
   import idv.cjcat.stardustextended.common.handlers.ParticleHandler;
   import idv.cjcat.stardustextended.common.initializers.Initializer;
   import idv.cjcat.stardustextended.common.initializers.InitializerCollector;
   import idv.cjcat.stardustextended.common.particles.InfoRecycler;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.particles.PooledParticleFactory;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.sd;
   
   use namespace sd;
   
   public class Emitter extends StardustElement implements ActionCollector, InitializerCollector
   {
       
      
      private const _onDischargeComplete:ISignal = new Signal();
      
      private const _onEmpty:ISignal = new Signal(Emitter);
      
      private const _onStepBegin:ISignal = new Signal(Emitter,Vector.<Particle>,Number);
      
      private const _onStepEnd:ISignal = new Signal(Emitter,Vector.<Particle>,Number);
      
      private const _actionCollection:ActionCollection = new ActionCollection();
      
      private const activeActions:Vector.<Action> = new Vector.<Action>();
      
      private var _blendMode:String = "normal";
      
      public var active:Boolean;
      
      public var needsSort:Boolean;
      
      public var currentTime:Number = 0;
      
      protected var factory:PooledParticleFactory;
      
      sd var _particles:Vector.<Particle>;
      
      private var _clock:Clock;
      
      private var _particleHandler:ParticleHandler;
      
      public function Emitter(param1:Clock = null, param2:ParticleHandler = null)
      {
         this._particles = new Vector.<Particle>();
         super();
         this.needsSort = false;
         this.clock = param1;
         this.active = true;
         this.particleHandler = param2;
      }
      
      public function get onEmpty() : ISignal
      {
         return this._onEmpty;
      }
      
      public function get onDischargeComplete() : ISignal
      {
         return this._onDischargeComplete;
      }
      
      public function get onStepBegin() : ISignal
      {
         return this._onStepBegin;
      }
      
      public function get onStepEnd() : ISignal
      {
         return this._onStepEnd;
      }
      
      public function get particles() : Vector.<Particle>
      {
         return this._particles;
      }
      
      public function get clock() : Clock
      {
         return this._clock;
      }
      
      public function set clock(param1:Clock) : void
      {
         if(!param1)
         {
            param1 = new SteadyClock(0);
         }
         this._clock = param1;
         this.setupDischargeSignal();
      }
      
      public function set ticksPerCall(param1:Number) : void
      {
         if(this.clock is SteadyClock)
         {
            SteadyClock(this.clock).ticksPerCall = param1;
         }
      }
      
      public function get ticksPerCall() : Number
      {
         if(this.clock is SteadyClock)
         {
            return SteadyClock(this.clock).ticksPerCall;
         }
         return 0;
      }
      
      public function get particleHandler() : ParticleHandler
      {
         return this._particleHandler;
      }
      
      public function set particleHandler(param1:ParticleHandler) : void
      {
         if(!param1)
         {
            param1 = ParticleHandler.getSingleton();
         }
         this._particleHandler = param1;
      }
      
      public final function get numParticles() : int
      {
         return this._particles.length;
      }
      
      override public function getRelatedObjects() : Array
      {
         return [this._clock].concat(this.initializers).concat(this.actions).concat([this.particleHandler]);
      }
      
      override public function getXMLTagName() : String
      {
         return "Emitter";
      }
      
      override public function getElementTypeXMLTag() : XML
      {
         return <emitters/>;
      }
      
      override public function toXML() : XML
      {
         var _loc2_:Action = null;
         var _loc3_:Initializer = null;
         var _loc1_:XML = super.toXML();
         _loc1_.@active = this.active.toString();
         _loc1_.@clock = this._clock.name;
         _loc1_.@particleHandler = this._particleHandler.name;
         if(this.actions.length)
         {
            _loc1_.appendChild(<actions/>);
            for each(_loc2_ in this.actions)
            {
               _loc1_.actions.appendChild(_loc2_.getXMLTag());
            }
         }
         if(this.initializers.length)
         {
            _loc1_.appendChild(<initializers/>);
            for each(_loc3_ in this.initializers)
            {
               _loc1_.initializers.appendChild(_loc3_.getXMLTag());
            }
         }
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         var _loc3_:XML = null;
         super.parseXML(param1,param2);
         this._actionCollection.clearActions();
         this.factory.clearInitializers();
         if(param1.@active.length())
         {
            this.active = param1.@active == "true";
         }
         if(param1.@clock.length())
         {
            this.clock = param2.getElementByName(param1.@clock) as Clock;
         }
         if(param1.@particleHandler.length())
         {
            this.particleHandler = param2.getElementByName(param1.@particleHandler) as ParticleHandler;
         }
         for each(_loc3_ in param1.actions.*)
         {
            this.addAction(param2.getElementByName(_loc3_.@name) as Action);
         }
         for each(_loc3_ in param1.initializers.*)
         {
            this.addInitializer(param2.getElementByName(_loc3_.@name) as Initializer);
         }
      }
      
      public function step(param1:Number = 1) : void
      {
         this.stepEmitter(param1);
         this.stepClock();
      }
      
      private function stepClock() : void
      {
         var _loc1_:ImpulseClock = null;
         if(this._clock is ImpulseClock)
         {
            _loc1_ = ImpulseClock(this._clock);
            if(this.currentTime >= _loc1_.nextBurstTime)
            {
               ImpulseClock(this._clock).impulse(this.currentTime);
            }
         }
      }
      
      public function stepEmitter(param1:Number = 1) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Action = null;
         var _loc5_:Particle = null;
         var _loc6_:* = undefined;
         var _loc9_:int = 0;
         var _loc10_:Vector.<Particle> = null;
         this.onStepBegin.dispatch(this,this.particles,param1);
         this._particleHandler.stepBegin(this,this.particles,param1);
         var _loc7_:Boolean = false;
         if(this.active)
         {
            _loc9_ = this.clock.getTicks(param1);
            _loc10_ = this.factory.createParticles(_loc9_,this.currentTime);
            this.addParticles(_loc10_);
         }
         this.activeActions.length = 0;
         _loc3_ = this.actions.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if((_loc4_ = this.actions[_loc2_]).active && _loc4_.mask)
            {
               this.activeActions.push(_loc4_);
            }
            _loc2_++;
         }
         _loc3_ = this.activeActions.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if((_loc4_ = this.activeActions[_loc2_]).needsSortedParticles)
            {
               this._particles.sort(Particle.compareFunction);
               _loc7_ = true;
               break;
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.activeActions[_loc2_].preUpdate(this,param1);
            _loc2_++;
         }
         var _loc8_:int = 0;
         while(_loc8_ < this._particles.length)
         {
            _loc5_ = this._particles[_loc8_];
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc4_ = this.activeActions[_loc2_];
               if(_loc5_.mask & _loc4_.mask)
               {
                  _loc4_.update(this,_loc5_,param1,this.currentTime);
               }
               _loc2_++;
            }
            if(_loc5_.isDead)
            {
               for(_loc6_ in _loc5_.recyclers)
               {
                  InfoRecycler(_loc6_).recycleInfo(_loc5_);
               }
               this._particleHandler.particleRemoved(_loc5_);
               _loc5_.destroy();
               this.factory.recycle(_loc5_);
               this._particles.splice(_loc8_,1);
               _loc8_--;
            }
            else
            {
               this._particleHandler.readParticle(_loc5_);
            }
            _loc8_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.activeActions[_loc2_].postUpdate(this,param1);
            _loc2_++;
         }
         this.onStepEnd.dispatch(this,this.particles,param1);
         this._particleHandler.stepEnd(this,this.particles,param1);
         if(!this.numParticles)
         {
            this.onEmpty.dispatch(this);
         }
         this.currentTime += param1;
      }
      
      public function addAction(param1:Action) : void
      {
         this._actionCollection.addAction(param1);
         param1.onAdd.dispatch(this,param1);
      }
      
      public final function removeAction(param1:Action) : void
      {
         this._actionCollection.removeAction(param1);
         param1.onRemove.dispatch(this,param1);
      }
      
      public final function clearActions() : void
      {
         var _loc4_:Action = null;
         var _loc1_:Array = this._actionCollection.actions;
         var _loc2_:int = 0;
         var _loc3_:int = _loc1_.length;
         while(_loc2_ < _loc3_)
         {
            (_loc4_ = _loc1_[_loc2_]).onRemove.dispatch(this,_loc4_);
            _loc2_++;
         }
         this._actionCollection.clearActions();
      }
      
      public function addInitializer(param1:Initializer) : void
      {
         this.factory.addInitializer(param1);
         param1.onAdd.dispatch(this,param1);
      }
      
      public final function removeInitializer(param1:Initializer) : void
      {
         this.factory.removeInitializer(param1);
         param1.onRemove.dispatch(this,param1);
      }
      
      public final function clearInitializers() : void
      {
         var _loc4_:Initializer = null;
         var _loc1_:Array = this.factory.initializerCollection.initializers;
         var _loc2_:int = 0;
         var _loc3_:int = _loc1_.length;
         while(_loc2_ < _loc3_)
         {
            (_loc4_ = _loc1_[_loc2_]).onRemove.dispatch(this,_loc4_);
            _loc2_++;
         }
         this.factory.clearInitializers();
      }
      
      public function reset() : void
      {
         this.currentTime = 0;
         this.clearParticles();
         var _loc1_:int = 0;
         while(_loc1_ < this.initializers.length)
         {
            Initializer(this.initializers[_loc1_]).reset();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.actions.length)
         {
            Action(this.actions[_loc1_]).reset();
            _loc1_++;
         }
         this.clock.reset();
      }
      
      public function set maxDischarges(param1:int) : void
      {
         if(this.clock is ImpulseClock)
         {
            (this.clock as ImpulseClock).dischargeLimit = param1;
         }
      }
      
      private function setupDischargeSignal() : void
      {
         if(this.clock is ImpulseClock)
         {
            (this.clock as ImpulseClock).dischargeComplete.add(this._onDischargeComplete.dispatch);
         }
      }
      
      public final function addParticles(param1:Vector.<Particle>) : void
      {
         var _loc2_:Particle = null;
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = param1[_loc4_];
            this._particles.push(_loc2_);
            this._particleHandler.particleAdded(_loc2_);
            _loc4_++;
         }
      }
      
      public final function clearParticles() : void
      {
         var _loc1_:Particle = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._particles.length)
         {
            _loc1_ = this._particles[_loc2_];
            this._particleHandler.particleRemoved(_loc1_);
            _loc1_.destroy();
            this.factory.recycle(_loc1_);
            _loc2_++;
         }
         this._particles = new Vector.<Particle>();
      }
      
      public function removeInitializersByClass(param1:Class) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < this.initializers.length)
         {
            if(this.initializers[_loc2_] is param1)
            {
               this.initializers.splice(_loc2_,1);
               _loc2_--;
            }
            _loc2_++;
         }
      }
      
      public function getInitializersByClass(param1:Class) : Vector.<Initializer>
      {
         var initializerClazz:Class = param1;
         return Vector.<Initializer>(this.initializers.filter(function(param1:Initializer, param2:int, param3:Array):Boolean
         {
            return param1 is initializerClazz;
         }));
      }
      
      public function getActionsByClass(param1:Class) : Vector.<Action>
      {
         var actionClazz:Class = param1;
         return Vector.<Action>(this.actions.filter(function(param1:Action, param2:int, param3:Array):Boolean
         {
            return param1 is actionClazz;
         }));
      }
      
      sd final function get actions() : Array
      {
         return this._actionCollection.actions;
      }
      
      sd final function get initializers() : Array
      {
         return this.factory.initializerCollection.initializers;
      }
      
      public function get blendMode() : String
      {
         return this._blendMode;
      }
      
      public function set blendMode(param1:String) : void
      {
         this._blendMode = param1;
      }
   }
}
