package com.popcap.flash.bejeweledblitz.dailychallenge
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.logic.DailyChallengeLogicConfig;
   import com.popcap.flash.games.blitz3.dailychallenge.DailyChallengeCoversMC;
   import flash.display.Sprite;
   
   public class DailyChallengeLeaderboardQuestsCoverView extends Sprite
   {
       
      
      private var _leaderBoardAndQuestsCoverMC:DailyChallengeCoversMC;
      
      private var _progressBarInitialHeight:Number;
      
      private var _configDailyChallenge:DailyChallengeLogicConfig;
      
      private var _maxScore:int;
      
      public function DailyChallengeLeaderboardQuestsCoverView()
      {
         super();
      }
      
      public function init() : void
      {
         this._leaderBoardAndQuestsCoverMC = new DailyChallengeCoversMC();
         this._progressBarInitialHeight = this._leaderBoardAndQuestsCoverMC.barMC.height;
         x = -Dimensions.LEFT_BORDER_WIDTH;
         y = -Dimensions.TOP_BORDER_WIDTH;
      }
      
      public function show(param1:DailyChallengeLogicConfig) : void
      {
         this._configDailyChallenge = param1;
         this._leaderBoardAndQuestsCoverMC.textT.text = this._configDailyChallenge.challengeBody;
         this._leaderBoardAndQuestsCoverMC.titleT.text = this._configDailyChallenge.challengeTitle;
         this.setStarCatPosition();
         addChild(this._leaderBoardAndQuestsCoverMC);
      }
      
      public function hide() : void
      {
         if(this._leaderBoardAndQuestsCoverMC)
         {
            if(contains(this._leaderBoardAndQuestsCoverMC))
            {
               removeChild(this._leaderBoardAndQuestsCoverMC);
            }
         }
      }
      
      public function UpdateScore(param1:int) : void
      {
         var _loc2_:Number = param1 / this._maxScore;
         if(_loc2_ > 1)
         {
            _loc2_ = 1;
         }
         this._leaderBoardAndQuestsCoverMC.barMC.height = _loc2_ * this._progressBarInitialHeight;
      }
      
      private function setStarCatPosition() : void
      {
         this._maxScore = this._configDailyChallenge.starCatGoals[this._configDailyChallenge.starCatGoals.length - 1];
         var _loc1_:Number = this._leaderBoardAndQuestsCoverMC.barMC.y;
         var _loc2_:Number = this._configDailyChallenge.starCatGoals[0] / this._maxScore;
         this._leaderBoardAndQuestsCoverMC.bronzeStarCatMarkerMC.y = _loc1_ - _loc2_ * this._progressBarInitialHeight;
         var _loc3_:Number = this._configDailyChallenge.starCatGoals[1] / this._maxScore;
         this._leaderBoardAndQuestsCoverMC.silverStarCatMarkerMC.y = _loc1_ - _loc3_ * this._progressBarInitialHeight;
         var _loc4_:Number = this._configDailyChallenge.starCatGoals[2] / this._maxScore;
         this._leaderBoardAndQuestsCoverMC.goldStarCatMarkerMC.y = _loc1_ - _loc4_ * this._progressBarInitialHeight;
      }
   }
}
