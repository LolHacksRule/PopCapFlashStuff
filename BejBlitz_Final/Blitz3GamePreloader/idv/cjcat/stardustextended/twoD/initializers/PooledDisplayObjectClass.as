package idv.cjcat.stardustextended.twoD.initializers
{
   import flash.display.DisplayObject;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.display.IStardustSprite;
   import idv.cjcat.stardustextended.twoD.utils.DisplayObjectPool;
   
   public class PooledDisplayObjectClass extends Initializer2D
   {
       
      
      private var _constructorParams:Array;
      
      private var _pool:DisplayObjectPool;
      
      private var _displayObjectClass:Class;
      
      public function PooledDisplayObjectClass(param1:Class = null, param2:Array = null)
      {
         super();
         priority = 1;
         this._pool = new DisplayObjectPool();
         this._displayObjectClass = param1;
         this._constructorParams = param2;
         if(this._displayObjectClass)
         {
            this._pool.reset(this._displayObjectClass,this._constructorParams);
         }
      }
      
      override public function initialize(param1:Particle) : void
      {
         if(this._displayObjectClass)
         {
            param1.target = this._pool.get();
         }
      }
      
      public function get displayObjectClass() : Class
      {
         return this._displayObjectClass;
      }
      
      public function set displayObjectClass(param1:Class) : void
      {
         this._displayObjectClass = param1;
         if(this._displayObjectClass)
         {
            this._pool.reset(this._displayObjectClass,this._constructorParams);
         }
      }
      
      public function get constructorParams() : Array
      {
         return this._constructorParams;
      }
      
      public function set constructorParams(param1:Array) : void
      {
         this._constructorParams = param1;
         if(this._displayObjectClass)
         {
            this._pool.reset(this._displayObjectClass,this._constructorParams);
         }
      }
      
      override public function recycleInfo(param1:Particle) : void
      {
         var _loc2_:DisplayObject = DisplayObject(param1.target);
         if(_loc2_)
         {
            if(_loc2_ is IStardustSprite)
            {
               IStardustSprite(_loc2_).disable();
            }
            if(_loc2_ is this._displayObjectClass)
            {
               this._pool.recycle(_loc2_);
            }
         }
      }
      
      override public function get needsRecycle() : Boolean
      {
         return true;
      }
      
      override public function getXMLTagName() : String
      {
         return "PooledDisplayObjectClass";
      }
      
      override public function toXML() : XML
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc1_:XML = super.toXML();
         if(this._displayObjectClass)
         {
            _loc1_.@displayObjectClass = getQualifiedClassName(this._displayObjectClass);
         }
         if(this._constructorParams && this._constructorParams.length > 0)
         {
            _loc2_ = "";
            _loc3_ = 0;
            while(_loc3_ < this._constructorParams.length)
            {
               _loc2_ += this._constructorParams[_loc3_] + ",";
               _loc3_++;
            }
            _loc2_ = _loc2_.substr(0,_loc2_.length - 1);
            _loc1_.@constructorParameters = _loc2_;
         }
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@constructorParameters.length())
         {
            this.constructorParams = String(param1.@constructorParameters).split(",");
         }
         if(param1.@displayObjectClass.length())
         {
            this.displayObjectClass = getDefinitionByName(param1.@displayObjectClass) as Class;
         }
      }
   }
}
