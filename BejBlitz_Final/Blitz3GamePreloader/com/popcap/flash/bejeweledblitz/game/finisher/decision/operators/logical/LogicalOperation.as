package com.popcap.flash.bejeweledblitz.game.finisher.decision.operators.logical
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.OperatorGetter;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.operators.IOperator;
   
   public class LogicalOperation extends IOperator
   {
       
      
      protected var operations:Vector.<IOperator>;
      
      public function LogicalOperation()
      {
         super();
      }
      
      override public function Parse(param1:Object) : void
      {
         var _loc3_:Object = null;
         var _loc4_:IOperator = null;
         this.operations = new Vector.<IOperator>();
         var _loc2_:Array = Utils.getArrayFromObjectKey(param1,"value");
         for each(_loc3_ in _loc2_)
         {
            (_loc4_ = OperatorGetter.Get(_loc3_.operation)).Parse(_loc3_);
            this.operations.push(_loc4_);
         }
      }
   }
}
