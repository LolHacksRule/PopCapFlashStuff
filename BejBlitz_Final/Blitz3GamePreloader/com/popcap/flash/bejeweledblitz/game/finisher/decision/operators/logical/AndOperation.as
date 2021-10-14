package com.popcap.flash.bejeweledblitz.game.finisher.decision.operators.logical
{
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.operators.IOperator;
   
   public class AndOperation extends LogicalOperation
   {
       
      
      public function AndOperation()
      {
         super();
      }
      
      public static function GetType() : String
      {
         return "AND";
      }
      
      override public function Check() : Boolean
      {
         var _loc1_:IOperator = null;
         for each(_loc1_ in operations)
         {
            if(_loc1_.Check() == false)
            {
               return false;
            }
         }
         return true;
      }
   }
}
