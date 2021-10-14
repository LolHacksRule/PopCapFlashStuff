package com.popcap.flash.bejeweledblitz.game.quests.rewardbuilder
{
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.quests.reward.IQuestRewardStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.reward.SimpleSpinRewardStrategy;
   
   public class SpinRewardBuilder extends BaseRewardBuilder
   {
      
      public static const ID1:String = "freeSpin";
      
      public static const ID2:String = "freespin";
       
      
      public function SpinRewardBuilder(param1:Blitz3Game)
      {
         super(param1);
      }
      
      override public function BuildQuestRewardStrategy(param1:Object, param2:String) : IQuestRewardStrategy
      {
         if(!CanHandle(param1,ID1,ID2))
         {
            return null;
         }
         var _loc3_:int = parseInt(param1[QuestConstants.KEY_REWARD_VAL1]);
         var _loc4_:* = "%spins% Spin";
         if(_loc3_ > 1)
         {
            _loc4_ += "s";
         }
         return new SimpleSpinRewardStrategy(m_App.sessionData.userData,_loc3_,_loc4_,param1[QuestConstants.KEY_REWARD_TYPE]);
      }
   }
}
