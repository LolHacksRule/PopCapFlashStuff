package com.popcap.flash.bejeweledblitz.game.session.raregem
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   
   public class StreakOffer extends ForcedOffer
   {
       
      
      public function StreakOffer(param1:Blitz3App, param2:String)
      {
         super(param1);
         SetID(param2);
      }
      
      override function LoadState() : void
      {
      }
      
      override function SaveState() : void
      {
      }
   }
}
