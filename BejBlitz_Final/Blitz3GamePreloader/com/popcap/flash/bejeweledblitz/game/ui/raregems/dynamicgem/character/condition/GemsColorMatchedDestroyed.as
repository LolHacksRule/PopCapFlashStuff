package com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.character.condition
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.DecisionHelper;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.character.CharacterCondition;
   import com.popcap.flash.bejeweledblitz.logic.GemColors;
   
   public class GemsColorMatchedDestroyed extends CharacterCondition
   {
       
      
      private var gemColorIndex:int;
      
      public function GemsColorMatchedDestroyed(param1:Object)
      {
         super(param1);
      }
      
      override public function Parse(param1:Object) : void
      {
         super.Parse(param1);
         var _loc2_:String = Utils.getStringFromObjectKey(param1,"gemColor","NONE");
         var _loc3_:GemColors = new GemColors();
         this.gemColorIndex = _loc3_.getIndex(_loc2_) - 1;
      }
      
      override public function GetValue() : int
      {
         return DecisionHelper.Get().GetGemColorDestroyedCount(this.gemColorIndex);
      }
   }
}
