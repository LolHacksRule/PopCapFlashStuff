package idv.cjcat.stardustextended.twoD.actions
{
   import idv.cjcat.stardustextended.cjsignals.ISignal;
   import idv.cjcat.stardustextended.cjsignals.Signal;
   import idv.cjcat.stardustextended.common.easing.EasingFunctionType;
   import idv.cjcat.stardustextended.common.easing.Linear;
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.math.Random;
   import idv.cjcat.stardustextended.common.math.StardustMath;
   import idv.cjcat.stardustextended.common.math.UniformRandom;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   public class SnapshotRestore extends Action2D
   {
       
      
      private var _onComplete:ISignal;
      
      public var flags:int;
      
      private var _duration:Random;
      
      private var _curve:Function;
      
      private var _started:Boolean = false;
      
      private var _started2:Boolean = false;
      
      private var _counter:Number;
      
      private var _maxDuration:Number;
      
      private var _durationKey:Object;
      
      public function SnapshotRestore(param1:Random = null, param2:int = 1, param3:Function = null)
      {
         this._onComplete = new Signal(SnapshotRestore);
         this._durationKey = {};
         super();
         priority = -7;
         this.duration = param1;
         this.flags = param2;
         this.curve = param3;
      }
      
      public function get onComplete() : ISignal
      {
         return this._onComplete;
      }
      
      public function start() : void
      {
         this._started = true;
         this._started2 = true;
         this._counter = 0;
         this._maxDuration = this._duration.getRange()[1];
      }
      
      public function get duration() : Random
      {
         return this._duration;
      }
      
      public function set duration(param1:Random) : void
      {
         if(!param1)
         {
            param1 = new UniformRandom(0,0);
         }
         this._duration = param1;
      }
      
      override public function preUpdate(param1:Emitter, param2:Number) : void
      {
         this._counter += param2;
         this._counter = StardustMath.clamp(this._counter,0,this._maxDuration);
      }
      
      override public function update(param1:Emitter, param2:Particle, param3:Number, param4:Number) : void
      {
         if(!this._started)
         {
            skipThisAction = true;
            return;
         }
         var _loc5_:Particle2D;
         if(!(_loc5_ = Particle2D(param2)).dictionary[Snapshot])
         {
            return;
         }
         if(this._started2)
         {
            _loc5_.dictionary[SnapshotRestore] = new SnapshotData(_loc5_);
            _loc5_.dictionary[this._durationKey] = this._duration.random();
         }
         var _loc6_:SnapshotData = _loc5_.dictionary[SnapshotRestore] as SnapshotData;
         var _loc7_:SnapshotData = _loc5_.dictionary[Snapshot] as SnapshotData;
         var _loc8_:Number = _loc5_.dictionary[this._durationKey];
         var _loc9_:Number = StardustMath.clamp(this._counter,0,_loc8_);
         if(this.flags & SnapshotRestoreFlag.POSITION)
         {
            _loc5_.x = this.curve.apply(null,[_loc9_,_loc6_.x,_loc7_.x - _loc6_.x,_loc8_]);
            _loc5_.y = this.curve.apply(null,[_loc9_,_loc6_.y,_loc7_.y - _loc6_.y,_loc8_]);
         }
         if(this.flags & SnapshotRestoreFlag.ROTATION)
         {
            _loc5_.rotation = this.curve.apply(null,[_loc9_,_loc6_.rotation,_loc7_.rotation - _loc6_.rotation,_loc8_]);
         }
         if(this.flags & SnapshotRestoreFlag.SCALE)
         {
            _loc5_.scale = this.curve.apply(null,[_loc9_,_loc6_.scale,_loc7_.scale - _loc6_.scale,_loc8_]);
         }
         _loc5_.vx = _loc5_.vy = _loc5_.omega = 0;
      }
      
      override public function postUpdate(param1:Emitter, param2:Number) : void
      {
         if(this._started2)
         {
            this._started2 = false;
         }
         if(this._started)
         {
            if(this._counter >= this._maxDuration)
            {
               this._started = false;
               this.onComplete.dispatch(this);
            }
         }
      }
      
      public function get curve() : Function
      {
         return this._curve;
      }
      
      public function set curve(param1:Function) : void
      {
         if(param1 == null)
         {
            param1 = Linear.easeOut;
         }
         this._curve = param1;
      }
      
      override public function getRelatedObjects() : Array
      {
         return [this._duration];
      }
      
      override public function getXMLTagName() : String
      {
         return "SnapshotRestore";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@duration = this.duration.name;
         _loc1_.@flags = this.flags;
         _loc1_.@curve = EasingFunctionType.functions[this.curve];
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@duration.length())
         {
            this.duration = param2.getElementByName(param1.@duration) as Random;
         }
         if(param1.@flags.length())
         {
            this.flags = parseInt(param1.@flags);
         }
         if(param1.@curve.length())
         {
            this.curve = EasingFunctionType.functions[param1.@curve.toString()];
         }
      }
   }
}
