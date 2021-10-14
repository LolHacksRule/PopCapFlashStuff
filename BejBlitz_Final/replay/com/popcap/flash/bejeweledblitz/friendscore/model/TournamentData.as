package com.popcap.flash.bejeweledblitz.friendscore.model
{
   public class TournamentData
   {
       
      
      public var tourneyTimeRemaining:Number;
      
      public var thresholds:Vector.<int>;
      
      public var payouts:Vector.<int>;
      
      public function TournamentData()
      {
         super();
         this.tourneyTimeRemaining = 0;
         this.thresholds = new Vector.<int>();
         this.payouts = new Vector.<int>();
      }
   }
}
