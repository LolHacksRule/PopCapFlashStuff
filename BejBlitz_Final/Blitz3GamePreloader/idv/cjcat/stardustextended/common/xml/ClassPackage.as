package idv.cjcat.stardustextended.common.xml
{
   public class ClassPackage
   {
      
      private static var _instance:ClassPackage;
       
      
      protected var classes:Array;
      
      public function ClassPackage()
      {
         super();
         this.classes = [];
         this.populateClasses();
      }
      
      public static function getInstance() : ClassPackage
      {
         if(_instance)
         {
            _instance = new ClassPackage();
         }
         return _instance;
      }
      
      public final function getClasses() : Array
      {
         return this.classes.concat();
      }
      
      protected function populateClasses() : void
      {
      }
   }
}
