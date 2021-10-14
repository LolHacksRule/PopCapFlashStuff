package idv.cjcat.stardustextended.common.initializers
{
   import idv.cjcat.stardustextended.sd;
   
   use namespace sd;
   
   public class InitializerCollection implements InitializerCollector
   {
       
      
      sd var initializers:Array;
      
      public function InitializerCollection()
      {
         super();
         this.initializers = [];
      }
      
      public final function addInitializer(param1:Initializer) : void
      {
         if(this.initializers.indexOf(param1) >= 0)
         {
            return;
         }
         this.initializers.push(param1);
         param1.onPriorityChange.add(this.sortInitializers);
         this.sortInitializers();
      }
      
      public final function removeInitializer(param1:Initializer) : void
      {
         var _loc2_:int = 0;
         if((_loc2_ = this.initializers.indexOf(param1)) >= 0)
         {
            param1 = Initializer(this.initializers.splice(_loc2_,1)[0]);
            param1.onPriorityChange.remove(this.sortInitializers);
         }
      }
      
      public final function sortInitializers(param1:Initializer = null) : void
      {
         this.initializers.sortOn("priority",Array.NUMERIC | Array.DESCENDING);
      }
      
      public final function clearInitializers() : void
      {
         var _loc1_:Initializer = null;
         for each(_loc1_ in this.initializers)
         {
            this.removeInitializer(_loc1_);
         }
      }
   }
}
