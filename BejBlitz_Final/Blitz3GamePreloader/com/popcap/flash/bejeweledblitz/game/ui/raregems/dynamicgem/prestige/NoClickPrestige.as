package com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.prestige
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.RareGemTokenPrizeSelector;
   import flash.display.MovieClip;
   
   public class NoClickPrestige extends PrestigeBase implements IPrestige
   {
       
      
      public function NoClickPrestige(param1:Blitz3App)
      {
         super(param1);
      }
      
      public function getPrizeSelector(param1:String) : MovieClip
      {
         return new RareGemTokenPrizeSelector(_app);
      }
      
      public function runsPrizes() : Boolean
      {
         return true;
      }
   }
}
