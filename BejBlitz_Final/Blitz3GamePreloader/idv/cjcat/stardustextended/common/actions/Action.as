package idv.cjcat.stardustextended.common.actions
{
   import idv.cjcat.stardustextended.cjsignals.ISignal;
   import idv.cjcat.stardustextended.cjsignals.Signal;
   import idv.cjcat.stardustextended.common.StardustElement;
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   
   public class Action extends StardustElement
   {
       
      
      private var _onPriorityChange:ISignal;
      
      private var _onAdd:ISignal;
      
      private var _onRemove:ISignal;
      
      public var active:Boolean;
      
      public var skipThisAction:Boolean;
      
      private var _priority:int;
      
      protected var _supports2D:Boolean;
      
      protected var _supports3D:Boolean;
      
      public var mask:int;
      
      public function Action()
      {
         this._onPriorityChange = new Signal(Action);
         this._onAdd = new Signal(Emitter,Action);
         this._onRemove = new Signal(Emitter,Action);
         super();
         this._supports3D = true;
         this._supports2D = true;
         this.priority = 0;
         this.active = true;
         this.mask = 1;
      }
      
      public function get onPriorityChange() : ISignal
      {
         return this._onPriorityChange;
      }
      
      public function get onAdd() : ISignal
      {
         return this._onAdd;
      }
      
      public function get onRemove() : ISignal
      {
         return this._onRemove;
      }
      
      public function get supports2D() : Boolean
      {
         return this._supports2D;
      }
      
      public function get supports3D() : Boolean
      {
         return this._supports3D;
      }
      
      public final function doUpdate(param1:Emitter, param2:Vector.<Particle>, param3:Number, param4:Number) : void
      {
         var _loc5_:Particle = null;
         var _loc6_:int = 0;
         this.skipThisAction = false;
         if(this.active)
         {
            _loc6_ = 0;
            while(_loc6_ < param2.length)
            {
               _loc5_ = param2[_loc6_];
               if(this.mask & _loc5_.mask)
               {
                  this.update(param1,_loc5_,param3,param4);
               }
               if(this.skipThisAction)
               {
                  return;
               }
               _loc6_++;
            }
         }
      }
      
      public function preUpdate(param1:Emitter, param2:Number) : void
      {
      }
      
      public function update(param1:Emitter, param2:Particle, param3:Number, param4:Number) : void
      {
      }
      
      public function postUpdate(param1:Emitter, param2:Number) : void
      {
      }
      
      public function get priority() : int
      {
         return this._priority;
      }
      
      public function set priority(param1:int) : void
      {
         this._priority = param1;
         this.onPriorityChange.dispatch(this);
      }
      
      public function get needsSortedParticles() : Boolean
      {
         return false;
      }
      
      public function reset() : void
      {
      }
      
      override public function getXMLTagName() : String
      {
         return "Action";
      }
      
      override public function getElementTypeXMLTag() : XML
      {
         return <actions/>;
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@active = this.active;
         _loc1_.@mask = this.mask;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@active.length())
         {
            this.active = param1.@active == "true";
         }
         if(param1.@mask.length())
         {
            this.mask = parseInt(param1.@mask);
         }
      }
   }
}
