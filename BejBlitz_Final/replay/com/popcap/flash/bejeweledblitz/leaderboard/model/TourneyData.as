package com.popcap.flash.bejeweledblitz.leaderboard.model
{
   public class TourneyData
   {
       
      
      public var id:int;
      
      public var score:int;
      
      public var date:Date;
      
      public function TourneyData(tID:int = -1, tScore:int = 0, tDate:Date = null)
      {
         super();
         this.id = tID;
         this.score = tScore;
         this.date = tDate;
         if(this.date == null)
         {
            this.date = new Date();
         }
      }
   }
}
