package idv.cjcat.stardustextended.common.actions
{
   import idv.cjcat.stardustextended.common.easing.EasingFunctionType;
   import idv.cjcat.stardustextended.common.easing.Linear;
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   
   public class ScaleCurve extends Action
   {
       
      
      public var inScale:Number;
      
      public var outScale:Number;
      
      public var inLifespan:Number;
      
      public var outLifespan:Number;
      
      private var _inFunction:Function;
      
      private var _outFunction:Function;
      
      private var _inFunctionExtraParams:Array;
      
      private var _outFunctionExtraParams:Array;
      
      public function ScaleCurve(param1:Number = 0, param2:Number = 0, param3:Function = null, param4:Function = null)
      {
         super();
         this.inScale = 0;
         this.outScale = 0;
         this.inLifespan = param1;
         this.outLifespan = param2;
         this.inFunction = param3;
         this.outFunction = param4;
         this.inFunctionExtraParams = [];
         this.outFunctionExtraParams = [];
      }
      
      override public final function update(param1:Emitter, param2:Particle, param3:Number, param4:Number) : void
      {
         if(param2.initLife - param2.life < this.inLifespan)
         {
            if(this._inFunction != null)
            {
               param2.scale = this._inFunction.apply(null,[param2.initLife - param2.life,this.inScale,param2.initScale - this.inScale,this.inLifespan].concat(this._inFunctionExtraParams));
            }
            else
            {
               param2.scale = Linear.easeIn(param2.initLife - param2.life,this.inScale,param2.initScale - this.inScale,this.inLifespan);
            }
         }
         else if(param2.life < this.outLifespan)
         {
            if(this._outFunction != null)
            {
               param2.scale = this._outFunction.apply(null,[this.outLifespan - param2.life,param2.initScale,this.outScale - param2.initScale,this.outLifespan].concat(this._outFunctionExtraParams));
            }
            else
            {
               param2.scale = Linear.easeOut(this.outLifespan - param2.life,param2.initScale,this.outScale - param2.initScale,this.outLifespan);
            }
         }
         else
         {
            param2.scale = param2.initScale;
         }
      }
      
      public function get inFunctionExtraParams() : Array
      {
         return this._inFunctionExtraParams;
      }
      
      public function set inFunctionExtraParams(param1:Array) : void
      {
         if(!param1)
         {
            param1 = [];
         }
         this._inFunctionExtraParams = param1;
      }
      
      public function get outFunctionExtraParams() : Array
      {
         return this._outFunctionExtraParams;
      }
      
      public function set outFunctionExtraParams(param1:Array) : void
      {
         if(!param1)
         {
            param1 = [];
         }
         this._outFunctionExtraParams = param1;
      }
      
      public function get inFunction() : Function
      {
         return this._inFunction;
      }
      
      public function set inFunction(param1:Function) : void
      {
         this._inFunction = param1;
      }
      
      public function get outFunction() : Function
      {
         return this._outFunction;
      }
      
      public function set outFunction(param1:Function) : void
      {
         this._outFunction = param1;
      }
      
      override public function getXMLTagName() : String
      {
         return "ScaleCurve";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@inScale = this.inScale;
         _loc1_.@outScale = this.outScale;
         _loc1_.@inLifespan = this.inLifespan;
         _loc1_.@outLifespan = this.outLifespan;
         if(this._inFunction != null)
         {
            _loc1_.@inFunction = EasingFunctionType.functions[this._inFunction];
         }
         if(this._outFunction != null)
         {
            _loc1_.@outFunction = EasingFunctionType.functions[this._outFunction];
         }
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@inScale.length())
         {
            this.inScale = parseFloat(param1.@inScale);
         }
         if(param1.@outScale.length())
         {
            this.outScale = parseFloat(param1.@outScale);
         }
         if(param1.@inLifespan.length())
         {
            this.inLifespan = parseFloat(param1.@inLifespan);
         }
         if(param1.@outLifespan.length())
         {
            this.outLifespan = parseFloat(param1.@outLifespan);
         }
         if(param1.@inFunction.length())
         {
            this.inFunction = EasingFunctionType.functions[param1.@inFunction.toString()];
         }
         if(param1.@outFunction.length())
         {
            this.outFunction = EasingFunctionType.functions[param1.@outFunction.toString()];
         }
      }
   }
}
