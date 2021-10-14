package com.popcap.flash.bejeweledblitz.game.finisher.decision.operators.relational
{
   public class GreaterThan extends RelationalOperator
   {
       
      
      public function GreaterThan()
      {
         super();
      }
      
      public static function GetType() : String
      {
         return ">";
      }
      
      override public function Check() : Boolean
      {
         return valueGetter.GetValue().GreaterThan(compare);
      }
   }
}
