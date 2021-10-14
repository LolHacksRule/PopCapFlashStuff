package idv.cjcat.stardustextended.common.actions
{
   import idv.cjcat.stardustextended.sd;
   
   use namespace sd;
   
   public class ActionCollection implements ActionCollector
   {
       
      
      sd var actions:Array;
      
      public function ActionCollection()
      {
         super();
         this.actions = [];
      }
      
      public final function addAction(param1:Action) : void
      {
         if(this.actions.indexOf(param1) >= 0)
         {
            return;
         }
         this.actions.push(param1);
         param1.onPriorityChange.add(this.sortActions);
         this.sortActions();
      }
      
      public final function removeAction(param1:Action) : void
      {
         var _loc2_:int = 0;
         if((_loc2_ = this.actions.indexOf(param1)) >= 0)
         {
            param1 = Action(this.actions.splice(_loc2_,1)[0]);
            param1.onPriorityChange.remove(this.sortActions);
         }
      }
      
      public final function clearActions() : void
      {
         var _loc1_:Action = null;
         for each(_loc1_ in this.actions)
         {
            this.removeAction(_loc1_);
         }
      }
      
      public final function sortActions(param1:Action = null) : void
      {
         this.actions.sortOn("priority",Array.NUMERIC | Array.DESCENDING);
      }
   }
}
