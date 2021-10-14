package com.popcap.flash.bejeweledblitz.game.finisher.decision.value
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.DecisionHelper;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.value.datatype.BooleanDataType;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.value.datatype.IDataType;
   
   public class IsSpenderValue extends ValueType
   {
       
      
      public function IsSpenderValue()
      {
         super();
      }
      
      public static function GetType() : String
      {
         return "isSpender";
      }
      
      override public function Parse(param1:Object) : IDataType
      {
         return new BooleanDataType(Utils.getBoolFromObjectKey(param1,"value",false));
      }
      
      override public function GetValue() : IDataType
      {
         return new BooleanDataType(DecisionHelper.Get().IsSpender());
      }
   }
}
