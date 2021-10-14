package com.popcap.flash.bejeweledblitz.game.finisher.decision.operators.logical
{
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.operators.IOperator;
   
   public class OrOperation extends LogicalOperation
   {
       
      
      public function OrOperation()
      {
         super();
      }
      
      public static function GetType() : String
      {
         return "OR";
      }
      
      override public function Check() : Boolean
      {
         var _loc1_:IOperator = null;
         for each(_loc1_ in operations)
         {
            if(_loc1_.Check() == true)
            {
               return true;
            }
         }
         return false;
      }
   }
}
