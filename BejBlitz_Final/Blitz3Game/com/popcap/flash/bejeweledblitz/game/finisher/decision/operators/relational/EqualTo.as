package com.popcap.flash.bejeweledblitz.game.finisher.decision.operators.relational
{
   public class EqualTo extends RelationalOperator
   {
       
      
      public function EqualTo()
      {
         super();
      }
      
      public static function GetType() : String
      {
         return "==";
      }
      
      override public function Check() : Boolean
      {
         return valueGetter.GetValue().IsEqual(compare);
      }
   }
}
