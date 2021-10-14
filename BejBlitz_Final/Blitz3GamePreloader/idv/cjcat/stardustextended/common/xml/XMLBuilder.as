package idv.cjcat.stardustextended.common.xml
{
   import flash.errors.IllegalOperationError;
   import flash.utils.Dictionary;
   import idv.cjcat.stardustextended.Stardust;
   import idv.cjcat.stardustextended.common.StardustElement;
   import idv.cjcat.stardustextended.common.errors.DuplicateElementNameError;
   
   public class XMLBuilder
   {
       
      
      private var elementClasses:Dictionary;
      
      private var elements:Dictionary;
      
      public function XMLBuilder()
      {
         super();
         this.elementClasses = new Dictionary();
         this.elements = new Dictionary();
      }
      
      public static function buildXML(param1:StardustElement) : XML
      {
         var _loc5_:StardustElement = null;
         var _loc6_:XML = null;
         var _loc7_:XML = null;
         var _loc2_:XML = <StardustParticleSystem/>;
         _loc2_.@version = Stardust.VERSION;
         var _loc3_:Dictionary = new Dictionary();
         traverseRelatedObjects(param1,_loc3_);
         var _loc4_:Array = [];
         for each(_loc5_ in _loc3_)
         {
            _loc4_.push(_loc5_);
         }
         _loc4_.sort(elementTypeSorter);
         for each(_loc5_ in _loc4_)
         {
            _loc6_ = _loc5_.toXML();
            _loc7_ = _loc5_.getElementTypeXMLTag();
            if(_loc2_[_loc7_.name()].length() == 0)
            {
               _loc2_.appendChild(_loc7_);
            }
            _loc2_[_loc7_.name()].appendChild(_loc6_);
         }
         return _loc2_;
      }
      
      private static function elementTypeSorter(param1:StardustElement, param2:StardustElement) : Number
      {
         if(param1.getXMLTagName() > param2.getXMLTagName())
         {
            return 1;
         }
         if(param1.getXMLTagName() < param2.getXMLTagName())
         {
            return -1;
         }
         if(param1.name > param2.name)
         {
            return 1;
         }
         return -1;
      }
      
      private static function traverseRelatedObjects(param1:StardustElement, param2:Dictionary) : void
      {
         var _loc3_:StardustElement = null;
         if(!param1)
         {
            return;
         }
         if(param2[param1.name] != undefined)
         {
            if(param2[param1.name] != param1)
            {
               throw new DuplicateElementNameError("Duplicate element name: " + param1.name,param1.name,param2[param1.name],param1);
            }
         }
         else
         {
            param2[param1.name] = param1;
         }
         for each(_loc3_ in param1.getRelatedObjects())
         {
            traverseRelatedObjects(_loc3_,param2);
         }
      }
      
      public function registerClass(param1:Class) : void
      {
         var _loc2_:StardustElement = StardustElement(new param1());
         if(!_loc2_)
         {
            throw new IllegalOperationError("The class is not a subclass of the StardustElement class.");
         }
         if(this.elementClasses[_loc2_.getXMLTagName()] != undefined)
         {
            throw new IllegalOperationError("This element class name is already registered: " + _loc2_.getXMLTagName());
         }
         this.elementClasses[_loc2_.getXMLTagName()] = param1;
      }
      
      public function registerClasses(param1:Array) : void
      {
         var _loc2_:Class = null;
         for each(_loc2_ in param1)
         {
            this.registerClass(_loc2_);
         }
      }
      
      public function registerClassesFromClassPackage(param1:ClassPackage) : void
      {
         this.registerClasses(param1.getClasses());
      }
      
      public function unregisterClass(param1:String) : void
      {
         delete this.elementClasses[param1];
      }
      
      public function getElementByName(param1:String) : StardustElement
      {
         if(this.elements[param1] == undefined)
         {
            throw new IllegalOperationError("Element not found: " + param1);
         }
         return this.elements[param1];
      }
      
      public function getElementsByClass(param1:Class) : Vector.<StardustElement>
      {
         var _loc3_:* = undefined;
         var _loc2_:Vector.<StardustElement> = new Vector.<StardustElement>();
         for(_loc3_ in this.elements)
         {
            if(this.elements[_loc3_] is param1)
            {
               _loc2_.push(this.elements[_loc3_]);
            }
         }
         return _loc2_;
      }
      
      public function buildFromXML(param1:XML) : void
      {
         var _loc2_:StardustElement = null;
         var _loc3_:XML = null;
         var _loc4_:Class = null;
         this.elements = new Dictionary();
         for each(_loc3_ in param1.*.*)
         {
            _loc2_ = new (_loc4_ = this.elementClasses[_loc3_.name().localName])() as StardustElement;
            if(this.elements[_loc3_.@name] != undefined)
            {
               throw new DuplicateElementNameError("Duplicate element name: " + _loc3_.@name,_loc3_.@name,this.elements[_loc3_.@name],_loc2_);
            }
            this.elements[_loc3_.@name.toString()] = _loc2_;
         }
         for each(_loc3_ in param1.*.*)
         {
            _loc2_ = StardustElement(this.elements[_loc3_.@name.toString()]);
            _loc2_.parseXML(_loc3_,this);
         }
      }
   }
}
