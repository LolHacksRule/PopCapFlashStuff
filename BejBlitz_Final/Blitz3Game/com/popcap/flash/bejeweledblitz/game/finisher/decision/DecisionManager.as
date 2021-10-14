package com.popcap.flash.bejeweledblitz.game.finisher.decision
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.operators.IOperator;
   
   public class DecisionManager
   {
       
      
      private var decider:IOperator;
      
      public function DecisionManager(param1:Object)
      {
         super();
         if(param1 == null)
         {
            return;
         }
         var _loc2_:String = Utils.getStringFromObjectKey(param1,"operation","AND");
         this.decider = OperatorGetter.Get(_loc2_);
         this.decider.Parse(param1);
      }
      
      public function CanShowFinisher() : Boolean
      {
         return this.decider == null || this.decider.Check();
      }
   }
}
