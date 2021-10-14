package com.popcap.flash.bejeweledblitz.game.finisher.decision.operators.relational
{
   public class NotEqualTo extends EqualTo
   {
       
      
      public function NotEqualTo()
      {
         super();
      }
      
      public static function GetType() : String
      {
         return "!=";
      }
      
      override public function Check() : Boolean
      {
         return !super.Check();
      }
   }
}
