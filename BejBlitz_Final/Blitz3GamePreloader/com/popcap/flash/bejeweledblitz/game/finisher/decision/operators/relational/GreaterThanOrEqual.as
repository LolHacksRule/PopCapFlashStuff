package com.popcap.flash.bejeweledblitz.game.finisher.decision.operators.relational
{
   public class GreaterThanOrEqual extends RelationalOperator
   {
       
      
      public function GreaterThanOrEqual()
      {
         super();
      }
      
      public static function GetType() : String
      {
         return ">=";
      }
      
      override public function Check() : Boolean
      {
         return valueGetter.GetValue().GreaterThan(compare) || valueGetter.GetValue().IsEqual(compare);
      }
   }
}
