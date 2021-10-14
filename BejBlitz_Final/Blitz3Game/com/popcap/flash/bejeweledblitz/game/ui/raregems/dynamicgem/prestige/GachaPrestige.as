package com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.prestige
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.RareGemTokenPrizeSelector;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemSound;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemWidget;
   import flash.display.MovieClip;
   
   public class GachaPrestige extends PrestigeBase implements IPrestige
   {
       
      
      public function GachaPrestige(param1:Blitz3App)
      {
         super(param1);
      }
      
      public function getPrizeSelector(param1:String) : MovieClip
      {
         var _loc2_:RareGemTokenPrizeSelector = new RareGemTokenPrizeSelector(_app);
         _loc2_.showRain(param1);
         return _loc2_;
      }
      
      public function runsPrizes() : Boolean
      {
         return true;
      }
      
      override public function onShowPrizesFrame(param1:String) : void
      {
         if(DynamicRareGemWidget.isGrandPrize())
         {
            DynamicRareGemSound.play(param1,DynamicRareGemSound.PRIZEGRANDSELECT_ID);
         }
         else
         {
            DynamicRareGemSound.play(param1,DynamicRareGemSound.PRIZESELECT_ID);
         }
      }
   }
}
