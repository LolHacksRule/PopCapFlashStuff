package com.popcap.flash.bejeweledblitz.game.finisher.decision.value
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.DecisionHelper;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.value.datatype.IDataType;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.value.datatype.StringDataType;
   
   public class GameModeValue extends ValueType
   {
       
      
      public function GameModeValue()
      {
         super();
      }
      
      public static function GetType() : String
      {
         return "gameMode";
      }
      
      override public function Parse(param1:Object) : IDataType
      {
         return new StringDataType(Utils.getStringFromObjectKey(param1,"value",""));
      }
      
      override public function GetValue() : IDataType
      {
         return new StringDataType(DecisionHelper.Get().GetGameMode());
      }
   }
}
