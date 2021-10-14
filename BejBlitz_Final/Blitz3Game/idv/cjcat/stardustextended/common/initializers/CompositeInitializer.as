package idv.cjcat.stardustextended.common.initializers
{
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   
   public class CompositeInitializer extends Initializer implements InitializerCollector
   {
       
      
      protected var initializers:Array;
      
      public function CompositeInitializer()
      {
         super();
         this.initializers = [];
      }
      
      override public final function initialize(param1:Particle) : void
      {
         var _loc2_:Initializer = null;
         for each(_loc2_ in this.initializers)
         {
            _loc2_.initialize(param1);
         }
      }
      
      public function addInitializer(param1:Initializer) : void
      {
         if(this.initializers.indexOf(param1) < 0)
         {
            this.initializers.push(param1);
         }
         param1.onPriorityChange.add(this.sortInitializers);
         this.sortInitializers();
      }
      
      public function removeInitializer(param1:Initializer) : void
      {
         var _loc2_:int = 0;
         if((_loc2_ = this.initializers.indexOf(param1)) >= 0)
         {
            param1 = this.initializers.splice(_loc2_,1)[0] as Initializer;
            param1.onPriorityChange.remove(this.sortInitializers);
         }
      }
      
      public final function sortInitializers(param1:Initializer = null) : void
      {
         this.initializers.sortOn("priority",Array.NUMERIC | Array.DESCENDING);
      }
      
      public function clearInitializers() : void
      {
         var _loc1_:Initializer = null;
         for each(_loc1_ in this.initializers)
         {
            this.removeInitializer(_loc1_);
         }
      }
      
      override public final function recycleInfo(param1:Particle) : void
      {
         var _loc2_:Initializer = null;
         for each(_loc2_ in this.initializers)
         {
            _loc2_.recycleInfo(param1);
         }
      }
      
      override public final function get needsRecycle() : Boolean
      {
         var _loc1_:Initializer = null;
         for each(_loc1_ in this.initializers)
         {
            if(_loc1_.needsRecycle)
            {
               return true;
            }
         }
         return false;
      }
      
      override public function getRelatedObjects() : Array
      {
         return this.initializers;
      }
      
      override public function getXMLTagName() : String
      {
         return "CompositeInitializer";
      }
      
      override public function toXML() : XML
      {
         var _loc2_:Initializer = null;
         var _loc1_:XML = super.toXML();
         if(this.initializers.length > 0)
         {
            _loc1_.appendChild(<initializers/>);
            for each(_loc2_ in this.initializers)
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
         this.clearInitializers();
         for each(_loc3_ in param1.initializers.*)
         {
            this.addInitializer(param2.getElementByName(_loc3_.@name) as Initializer);
         }
      }
   }
}
