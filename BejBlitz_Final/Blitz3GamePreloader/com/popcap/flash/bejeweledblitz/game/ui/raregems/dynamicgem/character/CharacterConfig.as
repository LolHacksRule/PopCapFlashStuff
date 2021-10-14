package com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.character
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.logic.raregems.character.ICharacterCondition;
   import com.popcap.flash.bejeweledblitz.logic.raregems.character.ICharacterConfig;
   
   public class CharacterConfig implements ICharacterConfig
   {
       
      
      private var id:String;
      
      private var condition:ICharacterCondition;
      
      private var repeat:int;
      
      public function CharacterConfig(param1:Object)
      {
         super();
         this.Parse(param1);
      }
      
      public function GetID() : String
      {
         return this.id;
      }
      
      public function GetRepeatCount() : int
      {
         return this.repeat;
      }
      
      public function GetPercentage(param1:int) : int
      {
         if(this.condition == null)
         {
            return 0;
         }
         return int(this.condition.GetPercentage());
      }
      
      public function ShouldShow(param1:int) : Boolean
      {
         return (param1 <= this.repeat || this.repeat < 0) && this.GetPercentage(param1) >= 100;
      }
      
      public function Reset() : void
      {
         if(this.condition != null)
         {
            this.condition.Reset();
         }
      }
      
      private function Parse(param1:Object) : void
      {
         this.id = Utils.getStringFromObjectKey(param1,"id","");
         this.repeat = Utils.getIntFromObjectKey(param1,"repeat",0);
         this.condition = CharacterConditionParser.Get().Parse(param1 != null ? param1["condition"] : null);
      }
   }
}
