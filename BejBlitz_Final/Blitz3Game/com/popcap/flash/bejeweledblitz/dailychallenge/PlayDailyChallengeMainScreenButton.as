package com.popcap.flash.bejeweledblitz.dailychallenge
{
   import flash.display.MovieClip;
   
   public class PlayDailyChallengeMainScreenButton
   {
       
      
      private var _parentMovieClip:MovieClip;
      
      private var _starCatMC1:MovieClip;
      
      private var _starCatMC2:MovieClip;
      
      private var _starCatMC3:MovieClip;
      
      public function PlayDailyChallengeMainScreenButton(param1:MovieClip)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Parent movie clip is null.");
         }
         this._parentMovieClip = param1;
         this._starCatMC1 = this._parentMovieClip.starMC0;
         this._starCatMC2 = this._parentMovieClip.starMC1;
         this._starCatMC3 = this._parentMovieClip.starMC2;
      }
      
      public function SetNumberOfStarCatsWon(param1:int) : void
      {
         this._starCatMC1.gotoAndStop("BronzeEmpty");
         this._starCatMC2.gotoAndStop("SilverEmpty");
         this._starCatMC3.gotoAndStop("GoldEmpty");
         if(param1 >= 1)
         {
            this._starCatMC1.gotoAndStop("Bronze");
         }
         if(param1 >= 2)
         {
            this._starCatMC2.gotoAndStop("Silver");
         }
         if(param1 == 3)
         {
            this._starCatMC3.gotoAndStop("Gold");
         }
      }
      
      public function TrySetDailyChallengeTimeRemaining(param1:String) : Boolean
      {
         if(this._parentMovieClip.txtEnds == null)
         {
            return false;
         }
         this._parentMovieClip.txtEnds.text = param1;
         return true;
      }
   }
}
