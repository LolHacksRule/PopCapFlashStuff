package com.popcap.flash.bejeweledblitz.leaderboard
{
   public class BlitzChampionshipData
   {
       
      
      public var id:String;
      
      public var score:Number;
      
      public var secondary_score:Number;
      
      public var date:Date;
      
      public var isAccepted:Boolean;
      
      public var isHighScore:Boolean;
      
      public var isTie:Boolean;
      
      public var rareGemUsedForHighScore:String;
      
      public var boostsUsedForHighScore:Object;
      
      public function BlitzChampionshipData()
      {
         super();
         this.id = "";
         this.score = 0;
         this.secondary_score = 0;
         this.date = new Date();
         this.isAccepted = false;
         this.isHighScore = false;
         this.isTie = false;
         this.rareGemUsedForHighScore = "";
         this.boostsUsedForHighScore = new Object();
      }
   }
}
