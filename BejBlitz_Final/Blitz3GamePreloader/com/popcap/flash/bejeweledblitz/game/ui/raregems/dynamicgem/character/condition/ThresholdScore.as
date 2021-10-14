package com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.character.condition
{
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.DecisionHelper;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.character.CharacterCondition;
   
   public class ThresholdScore extends CharacterCondition
   {
       
      
      public function ThresholdScore(param1:Object)
      {
         super(param1);
      }
      
      override public function GetValue() : int
      {
         return DecisionHelper.Get().GetCurrentHighScore();
      }
   }
}
