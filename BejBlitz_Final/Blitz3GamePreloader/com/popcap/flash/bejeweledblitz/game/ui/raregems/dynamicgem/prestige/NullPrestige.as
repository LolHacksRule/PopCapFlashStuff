package com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.prestige
{
   import flash.display.MovieClip;
   
   public class NullPrestige implements IPrestige
   {
       
      
      public function NullPrestige()
      {
         super();
      }
      
      public function getPrizeSelector(param1:String) : MovieClip
      {
         return new MovieClip();
      }
      
      public function runsPrizes() : Boolean
      {
         return false;
      }
      
      public function forceOutro() : Boolean
      {
         return true;
      }
      
      public function prizeTextUpdated() : Boolean
      {
         return false;
      }
      
      public function setPrizeTextUpdated() : void
      {
      }
      
      public function timePrizeTextUpdated() : Boolean
      {
         return false;
      }
      
      public function setTimePrizeTextUpdated() : void
      {
      }
      
      public function onShowPrizesFrame(param1:String) : void
      {
      }
   }
}
