package com.popcap.flash.bejeweledblitz.dailychallenge
{
   import com.popcap.flash.bejeweledblitz.game.session.raregem.RareGemManager;
   import com.popcap.flash.bejeweledblitz.logic.IDailyChallengeReward;
   import com.popcap.flash.bejeweledblitz.logic.IDailyChallengeRewardFactory;
   
   public class DailyChallengeRewardFactory implements IDailyChallengeRewardFactory
   {
       
      
      private var _rareGemManager:RareGemManager;
      
      public function DailyChallengeRewardFactory(param1:RareGemManager)
      {
         super();
         this._rareGemManager = param1;
      }
      
      public function createRewardFromArray(param1:Object) : IDailyChallengeReward
      {
         if(param1["type"] == "coins")
         {
            return new DailyChallengeCoinReward(param1);
         }
         if(param1["type"] == "rareGemGrant")
         {
            return new DailyChallengeRareGemReward(param1,this._rareGemManager);
         }
         return null;
      }
      
      public function createReward(param1:String, param2:String) : IDailyChallengeReward
      {
         var _loc3_:Object = {
            "type":param1,
            "value":param2
         };
         return this.createRewardFromArray(_loc3_);
      }
   }
}
