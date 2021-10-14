package com.popcap.flash.bejeweledblitz.game.quests.rewardbuilder
{
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.quests.reward.IQuestRewardStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.reward.SimpleRareGemOfferRewardStrategy;
   
   public class RareGemOfferRewardBuilder extends BaseRewardBuilder
   {
      
      public static const ID:String = "rareGemOffer";
       
      
      public function RareGemOfferRewardBuilder(param1:Blitz3Game)
      {
         super(param1);
      }
      
      override public function BuildQuestRewardStrategy(param1:Object, param2:String) : IQuestRewardStrategy
      {
         var _loc5_:String = null;
         if(!CanHandle(param1,ID))
         {
            return null;
         }
         var _loc3_:String = param1[QuestConstants.KEY_REWARD_VAL1];
         var _loc4_:String;
         if((_loc4_ = param1[QuestConstants.KEY_REWARD_VAL2]) == "cost")
         {
            _loc5_ = "%gem% Offer";
         }
         else if(_loc4_ == "free")
         {
            _loc5_ = "Free %gem%";
         }
         else
         {
            _loc5_ = "%gem% Discount";
         }
         var _loc6_:int = parseInt(param1[QuestConstants.KEY_COMPLETION_VAL2]);
         return new SimpleRareGemOfferRewardStrategy(m_App,m_App.sessionData.rareGemManager,_loc3_,_loc5_,0,_loc6_);
      }
   }
}
