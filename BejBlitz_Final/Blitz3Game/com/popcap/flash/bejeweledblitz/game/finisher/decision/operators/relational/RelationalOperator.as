package com.popcap.flash.bejeweledblitz.game.finisher.decision.operators.relational
{
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.operators.IOperator;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.value.ValueGetter;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.value.ValueType;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.value.datatype.IDataType;
   
   public class RelationalOperator extends IOperator
   {
       
      
      protected var valueGetter:ValueType;
      
      protected var compare:IDataType;
      
      public function RelationalOperator()
      {
         super();
      }
      
      override public function Parse(param1:Object) : void
      {
         this.valueGetter = ValueGetter.Get(String(param1.key));
         this.compare = this.valueGetter.Parse(param1);
      }
   }
}
