package com.popcap.flash.bejeweledblitz.logic.finisher.picker
{
   import com.popcap.flash.bejeweledblitz.logic.BlitzRNGManager;
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   
   public class PatternGemPicker implements IGemPicker
   {
       
      
      private var _gameboard:Board;
      
      public function PatternGemPicker(param1:Board)
      {
         super();
         this._gameboard = param1;
      }
      
      public function addPattern(param1:Vector.<String>) : void
      {
      }
      
      public function PostAddingPattern() : void
      {
      }
      
      public function GetGem() : Gem
      {
         return this._gameboard.GetNonCornerRandomGem(BlitzRNGManager.RNG_BLITZ_FINISHER);
      }
      
      public function GetName() : String
      {
         return "PatternGemPicker";
      }
      
      public function Release() : void
      {
      }
   }
}
