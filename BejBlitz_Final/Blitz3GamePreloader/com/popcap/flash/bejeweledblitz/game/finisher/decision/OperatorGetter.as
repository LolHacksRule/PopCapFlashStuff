package com.popcap.flash.bejeweledblitz.game.finisher.decision
{
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.operators.IOperator;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.operators.logical.AndOperation;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.operators.logical.OrOperation;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.operators.relational.EqualTo;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.operators.relational.GreaterThan;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.operators.relational.GreaterThanOrEqual;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.operators.relational.LessThan;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.operators.relational.LessThanOrEqual;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.operators.relational.NotEqualTo;
   import flash.utils.Dictionary;
   
   public class OperatorGetter
   {
      
      private static var operators:Dictionary;
      
      {
         Register(EqualTo.GetType(),EqualTo);
         Register(NotEqualTo.GetType(),NotEqualTo);
         Register(GreaterThan.GetType(),GreaterThan);
         Register(GreaterThanOrEqual.GetType(),GreaterThanOrEqual);
         Register(LessThan.GetType(),LessThan);
         Register(LessThanOrEqual.GetType(),LessThanOrEqual);
         Register(AndOperation.GetType(),AndOperation);
         Register(OrOperation.GetType(),OrOperation);
      }
      
      public function OperatorGetter()
      {
         super();
      }
      
      public static function Register(param1:String, param2:Class) : void
      {
         if(operators == null)
         {
            operators = new Dictionary();
         }
         operators[param1] = param2;
      }
      
      public static function Get(param1:String) : IOperator
      {
         var _loc2_:Class = null;
         if(operators.hasOwnProperty(param1))
         {
            _loc2_ = operators[param1];
            return new _loc2_() as IOperator;
         }
         throw new Error("undefined operator type" + param1);
      }
   }
}
