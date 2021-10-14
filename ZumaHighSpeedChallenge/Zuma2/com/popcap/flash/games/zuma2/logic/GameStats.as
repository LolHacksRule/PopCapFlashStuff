package com.popcap.flash.games.zuma2.logic
{
   public class GameStats
   {
       
      
      public var mTimePlayed:int;
      
      public var mDangerTimePlayed:int;
      
      public var mMaxInARow:int;
      
      public var mNumGaps:int;
      
      public var mMaxCombo:int;
      
      public var mNumMisses:int;
      
      public var mNumCombos:int;
      
      public var mTotalShots:int;
      
      public var mNumGemsCleared:int;
      
      public var mNumBallsCleared:int;
      
      public var mMaxComboScore:int;
      
      public var mMaxInARowScore:int;
      
      public function GameStats()
      {
         super();
      }
      
      public function Reset() : void
      {
         this.mTimePlayed = 0;
         this.mNumBallsCleared = 0;
         this.mNumGemsCleared = 0;
         this.mNumGaps = 0;
         this.mNumCombos = 0;
         this.mMaxCombo = -1;
         this.mMaxComboScore = 0;
         this.mMaxInARow = 0;
         this.mMaxInARowScore = 0;
         this.mDangerTimePlayed = 0;
         this.mTotalShots = this.mNumMisses = 0;
      }
   }
}
