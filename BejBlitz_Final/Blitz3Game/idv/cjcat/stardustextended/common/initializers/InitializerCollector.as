package idv.cjcat.stardustextended.common.initializers
{
   public interface InitializerCollector
   {
       
      
      function addInitializer(param1:Initializer) : void;
      
      function removeInitializer(param1:Initializer) : void;
      
      function clearInitializers() : void;
   }
}
