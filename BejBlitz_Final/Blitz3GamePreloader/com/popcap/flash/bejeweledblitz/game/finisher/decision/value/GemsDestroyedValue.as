package com.popcap.flash.bejeweledblitz.game.finisher.decision.value
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.DecisionHelper;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.value.datatype.IDataType;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.value.datatype.NumberDataType;
   
   public class GemsDestroyedValue extends ValueType
   {
       
      
      public function GemsDestroyedValue()
      {
         super();
      }
      
      public static function GetType() : String
      {
         return "rareGemsMatchedDestroyed";
      }
      
      override public function Parse(param1:Object) : IDataType
      {
         return new NumberDataType(Utils.getBoolFromObjectKey(param1,"value",false));
      }
      
      override public function GetValue() : IDataType
      {
         return new NumberDataType(DecisionHelper.Get().GetGemsDestroyed());
      }
   }
}
