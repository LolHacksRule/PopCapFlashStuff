package com.popcap.flash.bejeweledblitz.game.finisher.decision.operators.relational
{
   public class LessThanOrEqual extends RelationalOperator
   {
       
      
      public function LessThanOrEqual()
      {
         super();
      }
      
      public static function GetType() : String
      {
         return "<=";
      }
      
      override public function Check() : Boolean
      {
         return valueGetter.GetValue().LessThan(compare) || valueGetter.GetValue().IsEqual(compare);
      }
   }
}
