package com.popcap.flash.bejeweledblitz.dailychallenge
{
   import com.popcap.flash.bejeweledblitz.game.session.raregem.RareGemManager;
   import com.popcap.flash.bejeweledblitz.logic.IDailyChallengeReward;
   import com.popcap.flash.bejeweledblitz.logic.IDailyChallengeRewardDisplay;
   import com.popcap.flash.bejeweledblitz.logic.IDailyChallengeRewardDisplayFactory;
   
   public class DailyChallengeRareGemReward implements IDailyChallengeReward
   {
       
      
      public var _gemId:String = null;
      
      public var _gemName:String = null;
      
      public var _rareGemManager:RareGemManager;
      
      private var _rareGemRewardDisplay:IDailyChallengeRewardDisplay = null;
      
      public function DailyChallengeRareGemReward(param1:Object, param2:RareGemManager)
      {
         super();
         this._rareGemManager = param2;
         this._gemId = param1["value"];
         this._gemName = param2.GetTaglessRareGemNameWithTitleCasing(this._gemId);
      }
      
      public function SetDisplay(param1:IDailyChallengeRewardDisplayFactory) : void
      {
         param1.CreateRareGemRewardDisplay(this._gemId).Set();
      }
      
      public function GetCoinsEarned() : int
      {
         return 0;
      }
      
      public function GetMyRewardName() : String
      {
         return this._gemId;
      }
   }
}
