package com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.character
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.logic.raregems.character.ICharacterCondition;
   
   public class CharacterCondition implements ICharacterCondition
   {
       
      
      private var value:Number;
      
      private var startValue:Number;
      
      public function CharacterCondition(param1:Object)
      {
         super();
         this.Parse(param1);
         this.startValue = 0;
      }
      
      public function Parse(param1:Object) : void
      {
         this.value = Utils.getIntFromObjectKey(param1,"value",1);
      }
      
      public function GetValue() : int
      {
         return 0;
      }
      
      public function Reset() : void
      {
         this.startValue = Number(this.GetValue());
      }
      
      public function GetPercentage() : int
      {
         var _loc1_:Number = Number(this.GetValue());
         return int((_loc1_ - this.startValue) / this.value * 100);
      }
   }
}
