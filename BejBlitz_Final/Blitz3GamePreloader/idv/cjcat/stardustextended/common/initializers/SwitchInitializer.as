package idv.cjcat.stardustextended.common.initializers
{
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.utils.WeightedCollection;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   
   public class SwitchInitializer extends Initializer
   {
       
      
      private var collection:WeightedCollection;
      
      public function SwitchInitializer(param1:Array = null, param2:Array = null)
      {
         super();
         if(!param1 || !param2)
         {
            param1 = [];
            param2 = [];
         }
         this.setInitializers(param1,param2);
      }
      
      public function setInitializers(param1:Array, param2:Array) : void
      {
         this.collection = new WeightedCollection(param1,param2);
      }
      
      override public final function initialize(param1:Particle) : void
      {
         var _loc2_:Initializer = this.collection.get() as Initializer;
         _loc2_.initialize(param1);
      }
      
      override public function getRelatedObjects() : Array
      {
         return this.collection.contents;
      }
      
      override public function getXMLTagName() : String
      {
         return "SwitchInitializer";
      }
      
      override public function toXML() : XML
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:XML = null;
         var _loc1_:XML = super.toXML();
         var _loc2_:Array = this.collection.contents;
         if(_loc2_.length > 0)
         {
            _loc3_ = this.collection.weights;
            _loc1_.appendChild(<initializers/>);
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               (_loc5_ = Initializer(_loc2_[_loc4_]).getXMLTag()).@weight = _loc3_[_loc4_];
               _loc1_.initializers.appendChild(_loc5_);
               _loc4_++;
            }
         }
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         var _loc3_:XML = null;
         var _loc4_:Initializer = null;
         var _loc5_:Number = NaN;
         super.parseXML(param1,param2);
         this.collection.clear();
         for each(_loc3_ in param1.initializers.*)
         {
            _loc4_ = param2.getElementByName(_loc3_.@name) as Initializer;
            _loc5_ = parseFloat(_loc3_.@weight);
            this.collection.addContent(_loc4_,_loc5_);
         }
      }
   }
}
