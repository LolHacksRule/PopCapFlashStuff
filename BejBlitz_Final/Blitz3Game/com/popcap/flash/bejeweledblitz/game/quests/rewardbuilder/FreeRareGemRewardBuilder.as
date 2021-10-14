package com.popcap.flash.bejeweledblitz.game.quests.rewardbuilder
{
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.quests.reward.IQuestRewardStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.reward.NullRewardStrategy;
   
   public class FreeRareGemRewardBuilder extends BaseRewardBuilder
   {
      
      public static const ID:String = "FREE_RARE_GEM";
       
      
      public function FreeRareGemRewardBuilder(param1:Blitz3Game)
      {
         super(param1);
      }
      
      override public function BuildQuestRewardStrategy(param1:Object, param2:String) : IQuestRewardStrategy
      {
         if(!CanHandle(param1,ID))
         {
            return null;
         }
         var _loc3_:String = param1[QuestConstants.KEY_REWARD_VAL1];
         var _loc4_:String = m_App.sessionData.rareGemManager.GetLocalizedRareGemNameForQuest(_loc3_);
         var _loc5_:String = "Free " + _loc4_;
         return new NullRewardStrategy(_loc5_);
      }
   }
}
