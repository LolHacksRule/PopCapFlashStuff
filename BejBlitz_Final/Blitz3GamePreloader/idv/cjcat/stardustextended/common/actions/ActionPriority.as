package idv.cjcat.stardustextended.common.actions
{
   import flash.utils.Dictionary;
   
   public class ActionPriority
   {
      
      private static var _instance:ActionPriority;
       
      
      protected var priorities:Dictionary;
      
      public function ActionPriority()
      {
         super();
         this.priorities = new Dictionary();
         this.populatePriorities();
      }
      
      public static function getInstance() : ActionPriority
      {
         if(!_instance)
         {
            _instance = new ActionPriority();
         }
         return _instance;
      }
      
      public final function getPriority(param1:Class) : int
      {
         if(this.priorities[param1] == undefined)
         {
            return 0;
         }
         return this.priorities[param1];
      }
      
      protected function populatePriorities() : void
      {
      }
   }
}
