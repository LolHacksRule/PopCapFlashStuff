package com.popcap.flash.bejeweledblitz.game.session.raregem
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   
   public class ViralOffer extends ForcedOffer
   {
       
      
      public function ViralOffer(app:Blitz3App)
      {
         super(app);
         isViral = true;
      }
      
      override function SaveState() : void
      {
      }
   }
}
