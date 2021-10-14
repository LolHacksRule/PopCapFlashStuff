package com.popcap.flash.bejeweledblitz.game.finisher.decision.value
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.DecisionHelper;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.value.datatype.IDataType;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.value.datatype.StringDataType;
   
   public class CurrentRareGemValue extends ValueType
   {
       
      
      public function CurrentRareGemValue()
      {
         super();
      }
      
      public static function GetType() : String
      {
         return "currentGem";
      }
      
      override public function Parse(param1:Object) : IDataType
      {
         return new StringDataType(Utils.getStringFromObjectKey(param1,"value",""));
      }
      
      override public function GetValue() : IDataType
      {
         return new StringDataType(DecisionHelper.Get().CurrentRareGemName());
      }
   }
}
