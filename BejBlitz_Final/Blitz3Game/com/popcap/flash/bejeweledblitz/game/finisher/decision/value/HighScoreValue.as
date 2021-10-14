package com.popcap.flash.bejeweledblitz.game.finisher.decision.value
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.DecisionHelper;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.value.datatype.IDataType;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.value.datatype.NumberDataType;
   
   public class HighScoreValue extends ValueType
   {
       
      
      public function HighScoreValue()
      {
         super();
      }
      
      public static function GetType() : String
      {
         return "currentScore";
      }
      
      override public function Parse(param1:Object) : IDataType
      {
         return new NumberDataType(Utils.getIntFromObjectKey(param1,"value",0));
      }
      
      override public function GetValue() : IDataType
      {
         return new NumberDataType(DecisionHelper.Get().GetCurrentHighScore());
      }
   }
}
