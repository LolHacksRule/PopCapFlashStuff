package com.popcap.flash.bejeweledblitz.game.quests.rewardbuilder
{
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.quests.reward.IQuestRewardStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.reward.XPRewardStrategy;
   
   public class XPRewardBuilder extends BaseRewardBuilder
   {
      
      public static const ID:String = "xp";
       
      
      public function XPRewardBuilder(param1:Blitz3Game)
      {
         super(param1);
      }
      
      override public function BuildQuestRewardStrategy(param1:Object, param2:String) : IQuestRewardStrategy
      {
         if(!CanHandle(param1,ID))
         {
            return null;
         }
         var _loc3_:int = parseInt(param1[QuestConstants.KEY_REWARD_VAL1]);
         return new XPRewardStrategy(m_App.sessionData.userData,_loc3_,"%xp% XP");
      }
   }
}
