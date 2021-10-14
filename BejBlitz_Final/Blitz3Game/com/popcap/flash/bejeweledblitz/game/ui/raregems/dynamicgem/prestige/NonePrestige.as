package com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.prestige
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import flash.display.MovieClip;
   
   public class NonePrestige extends PrestigeBase implements IPrestige
   {
       
      
      public function NonePrestige(param1:Blitz3App)
      {
         super(param1);
      }
      
      public function getPrizeSelector(param1:String) : MovieClip
      {
         return getGenericPrizeSelector(param1);
      }
      
      public function runsPrizes() : Boolean
      {
         return false;
      }
   }
}
