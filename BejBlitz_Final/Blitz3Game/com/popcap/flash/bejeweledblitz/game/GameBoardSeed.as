package com.popcap.flash.bejeweledblitz.game
{
   public class GameBoardSeed
   {
      
      private static var currentSeed:int = -1;
      
      private static var maxSeed:int = -1;
       
      
      public function GameBoardSeed()
      {
         super();
      }
      
      public static function SetSeed(param1:int) : void
      {
         currentSeed = param1;
      }
      
      public static function GetCurrentSeed() : Number
      {
         return currentSeed;
      }
   }
}
