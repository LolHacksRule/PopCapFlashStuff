package com.popcap.flash.bejeweledblitz.game.finisher.decision.value
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.DecisionHelper;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.value.datatype.IDataType;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.value.datatype.StringDataType;
   
   public class PlatformValue extends ValueType
   {
       
      
      public function PlatformValue()
      {
         super();
      }
      
      public static function GetType() : String
      {
         return "platform";
      }
      
      override public function Parse(param1:Object) : IDataType
      {
         return new StringDataType(Utils.getStringFromObjectKey(param1,"value",""));
      }
      
      override public function GetValue() : IDataType
      {
         return new StringDataType(DecisionHelper.Get().CurrentPlatform());
      }
   }
}
