package com.popcap.flash.bejeweledblitz.game.session.raregem
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   
   public class StreakOffer extends ForcedOffer
   {
       
      
      public function StreakOffer(app:Blitz3App, gemId:String)
      {
         super(app);
         SetID(gemId);
      }
      
      override function LoadState() : void
      {
      }
      
      override function SaveState() : void
      {
      }
   }
}
