package com.popcap.flash.bejeweledblitz.leaderboard
{
   public class TourneyData
   {
       
      
      public var id:int;
      
      public var score:Number;
      
      public var date:Date;
      
      public function TourneyData(param1:int = -1, param2:Number = 0, param3:Date = null)
      {
         super();
         this.id = param1;
         this.score = param2;
         this.date = param3;
         if(this.date == null)
         {
            this.date = new Date();
         }
      }
   }
}
