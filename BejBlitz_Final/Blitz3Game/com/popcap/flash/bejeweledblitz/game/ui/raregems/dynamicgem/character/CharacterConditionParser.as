package com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.character
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.character.condition.GemsColorMatchedDestroyed;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.character.condition.MultiplierThreshold;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.character.condition.RareGemsMatchedDestroyed;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.character.condition.ThresholdScore;
   import com.popcap.flash.bejeweledblitz.logic.raregems.character.ICharacterCondition;
   import flash.utils.Dictionary;
   
   public class CharacterConditionParser
   {
      
      private static var Instance:CharacterConditionParser = new CharacterConditionParser();
       
      
      private var conditionParserMap:Dictionary;
      
      public function CharacterConditionParser()
      {
         super();
         this.conditionParserMap = new Dictionary();
         this.conditionParserMap["gemsColorMatchedDestroyed"] = GemsColorMatchedDestroyed;
         this.conditionParserMap["thresholdScore"] = ThresholdScore;
         this.conditionParserMap["multiplierThreshold"] = MultiplierThreshold;
         this.conditionParserMap["rareGemsMatchedDestroyed"] = RareGemsMatchedDestroyed;
      }
      
      public static function Get() : CharacterConditionParser
      {
         return Instance;
      }
      
      public function Parse(param1:Object) : ICharacterCondition
      {
         var _loc2_:String = Utils.getStringFromObjectKey(param1,"type","");
         if(!this.conditionParserMap.hasOwnProperty(_loc2_))
         {
            return null;
         }
         return new this.conditionParserMap[_loc2_](param1) as ICharacterCondition;
      }
   }
}
