package com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.character.condition
{
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.DecisionHelper;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.character.CharacterCondition;
   
   public class MultiplierThreshold extends CharacterCondition
   {
       
      
      public function MultiplierThreshold(param1:Object)
      {
         super(param1);
      }
      
      override public function GetValue() : int
      {
         return DecisionHelper.Get().GetCurrentMultiplier();
      }
   }
}
