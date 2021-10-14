package idv.cjcat.stardustextended.common.initializers
{
   import idv.cjcat.stardustextended.cjsignals.ISignal;
   import idv.cjcat.stardustextended.cjsignals.Signal;
   import idv.cjcat.stardustextended.common.StardustElement;
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.particles.InfoRecycler;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   
   public class Initializer extends StardustElement implements InfoRecycler
   {
       
      
      private var _onPriorityChange:ISignal;
      
      private var _onAdd:ISignal;
      
      private var _onRemove:ISignal;
      
      public var active:Boolean;
      
      private var _priority:int;
      
      protected var _supports2D:Boolean;
      
      protected var _supports3D:Boolean;
      
      public function Initializer()
      {
         this._onPriorityChange = new Signal(Initializer);
         this._onAdd = new Signal(Emitter,Initializer);
         this._onRemove = new Signal(Emitter,Initializer);
         super();
         this._supports3D = true;
         this._supports2D = true;
         this.priority = 0;
         this.active = true;
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
      
      public function doInitialize(param1:Vector.<Particle>, param2:Number) : void
      {
         var _loc3_:Particle = null;
         var _loc4_:int = 0;
         if(this.active)
         {
            _loc4_ = 0;
            while(_loc4_ < param1.length)
            {
               _loc3_ = param1[_loc4_];
               this.initialize(_loc3_);
               if(this.needsRecycle)
               {
                  _loc3_.recyclers[this] = this;
               }
               _loc4_++;
            }
         }
      }
      
      public function initialize(param1:Particle) : void
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
      
      public function recycleInfo(param1:Particle) : void
      {
      }
      
      public function get needsRecycle() : Boolean
      {
         return false;
      }
      
      public function reset() : void
      {
      }
      
      override public function getXMLTagName() : String
      {
         return "Initializer";
      }
      
      override public function getElementTypeXMLTag() : XML
      {
         return <initializers/>;
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@active = this.active;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@active.length())
         {
            this.active = param1.@active == "true";
         }
      }
   }
}
