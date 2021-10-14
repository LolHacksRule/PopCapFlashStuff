package com.popcap.flash.bejeweledblitz.logic.finisher.modifier
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   
   public class GemModifierManager
   {
      
      public static const GEMMODIFIER_EXPLODE:int = 0;
      
      public static const GEMMODIFIER_SPECIAL:int = 1;
       
      
      private var modifier:IGemModifier;
      
      public function GemModifierManager()
      {
         super();
         this.modifier = null;
      }
      
      public function Create(param1:BlitzLogic, param2:int) : IGemModifier
      {
         if(param2 == GEMMODIFIER_EXPLODE)
         {
            this.modifier = new ExplodeGemModifier(param1);
         }
         else if(param2 == GEMMODIFIER_SPECIAL)
         {
            this.modifier = new SpecialGemModifier(param1);
         }
         return this.modifier;
      }
      
      public function Release() : void
      {
         if(this.modifier != null)
         {
            this.modifier.Release();
            this.modifier = null;
         }
      }
   }
}
