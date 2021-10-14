package com.popcap.flash.bejeweledblitz.game.session.raregem
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   
   public class ViralOffer extends ForcedOffer
   {
       
      
      public function ViralOffer(param1:Blitz3App)
      {
         super(param1);
         _isViral = true;
      }
      
      override function SaveState() : void
      {
      }
   }
}
