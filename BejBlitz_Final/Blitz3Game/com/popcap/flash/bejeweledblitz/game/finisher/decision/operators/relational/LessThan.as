package com.popcap.flash.bejeweledblitz.game.finisher.decision.operators.relational
{
   public class LessThan extends RelationalOperator
   {
       
      
      public function LessThan()
      {
         super();
      }
      
      public static function GetType() : String
      {
         return "<";
      }
      
      override public function Check() : Boolean
      {
         return valueGetter.GetValue().LessThan(compare);
      }
   }
}
